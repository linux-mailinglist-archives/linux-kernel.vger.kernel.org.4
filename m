Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED03F67359E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjASKfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjASKeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:34:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF006F32B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:33:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C707B61511
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD1CC433D2;
        Thu, 19 Jan 2023 10:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674124435;
        bh=FSTb7ps69bklSNTl2tXp872NF4+kDIeeWJq6EUM+gQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqDqPevZQ4XSsi7+3j4KXbs/udOIaV72oY3M/upUjyTkZVRyb8Svnwr3nY1nRv5E2
         DptSYerO5xOVbpK3gXlz+pkd9ItIywRQ8CRlyjNfIdn3Hn9dP5mbaMiiRmNB8rnxrr
         YqBbDf2XjaKav81W1Us7rdYVdWc424fwSuTBBudRXIjlOmWcMccxm5ejjKsF9WNxyG
         D3Sv12PzfflJENNniy5NwIZ0SEUEsi0+Rw9xooSUgezbku9n2iJ7mpLsZE563G7w5B
         0wwLkKKO1fqLNbOceGikTfJkIkoXeqq8P17mOlu+jiyAWOqnoLn2Q/jlIzEw9U0Dw/
         jq75wUiw7iURA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 08/10] habanalabs: run error handling if scrub_device_mem fails after reset
Date:   Thu, 19 Jan 2023 12:33:37 +0200
Message-Id: <20230119103339.718430-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119103339.718430-1-ogabbay@kernel.org>
References: <20230119103339.718430-1-ogabbay@kernel.org>
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

If device memory scrubbing from hl_device_reset() fails, we return with
an error code but not perform error handling code.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 9a9c494b08a4..edeec35fd9c6 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1738,7 +1738,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	rc = hdev->asic_funcs->scrub_device_mem(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "scrub mem failed from device reset (%d)\n", rc);
-		return rc;
+		goto out_err;
 	}
 
 	spin_lock(&hdev->reset_info.lock);
-- 
2.25.1

