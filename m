Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01EF647298
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLHPOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiLHPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FA7ABA10
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4529661F7C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB280C433B5;
        Thu,  8 Dec 2022 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512438;
        bh=vduhEwTqUmujvyUHIEbNfHylxhRM+/iHi4mF+4Bpzvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMj7fYoYcAgR54QWLbYw3liejLnN8HA6KDMScCtz9FJk5qcN++cjhgJuiMCQL+xeq
         kOEZKQouFylF4gf9rays11mytgr+5KrYX11784qb++HpuEBrx+lJSzt17DGl2OcRd4
         UGM7WAsVcYt0VeKp7de8mFeJ5c+zPPnPCFkwvExc1wioqghdQ8nYmc6a2pJ/oqYlsk
         5vSpshRAVJlCVlvhObIsiuxo/7wDYHDOGvKoW6ByssCvii4w1TxIO1zL61ELTzHQPr
         snepxKposuX7bZeTvTcIOGWD3XarroyzjeKkfxCvQx/21duQTEbcOUXxuw+mhKImT3
         OB9b6qaqAA86g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 03/26] habanalabs: remove releasing of user threads from device release
Date:   Thu,  8 Dec 2022 17:13:27 +0200
Message-Id: <20221208151350.1833823-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The device file is not in use when hl_device_release() is called,
and there aren't any user threads that use IOCTLs to wait for
interrupts. Therefore there is no need to release them at this point.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 87ab329e65d4..1453f2ec72d9 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -511,11 +511,6 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 		return 0;
 	}
 
-	/* Each pending user interrupt holds the user's context, hence we
-	 * must release them all before calling hl_ctx_mgr_fini().
-	 */
-	hl_release_pending_user_interrupts(hpriv->hdev);
-
 	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
 	hl_mem_mgr_fini(&hpriv->mem_mgr);
 
-- 
2.25.1

