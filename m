Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3718B6367DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiKWR53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbiKWR5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:57:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC776C6629
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:57:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B38EB81FE3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE2DC433D7;
        Wed, 23 Nov 2022 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669226224;
        bh=wxKRNQqmydSopaq3yHKk8toN/2zOQmC1pkaLy1+Ehkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSSGDzQiXa2ILS4WGGBSKvACOhV6QvQI9xRgiwSxlGfkV2yyeixoS4SdtPoL7s7bf
         8TNDr2zLF14QRyI88mOpNJ6huU5kny68Y06DWco4M2iFrnoj6jpTfmdFybwo2nKNWE
         f2aotYGVayYV7QAkW/uHhH97x+fDPIzVGm9NDGyzV7+66P0TXPJ68+bshMVPVj5sc1
         fd3SN6HOzG4ir2BQsfuMa2WrVKl7k/r8JBOYCJc4Jd+MPZcBeG3IDcoa6p/0DOJz6b
         Bcvf8za3qfB52rQWxtOumI6d4ykEtiT5MZMpfM54MBvrE1zTlrPw4N0SmpJmdMrOMd
         QjbBln1SVarEA==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] soc: microchip: mpfs: handle failed system service requests
Date:   Wed, 23 Nov 2022 17:56:51 +0000
Message-Id: <20221123175652.327859-2-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123175652.327859-1-conor@kernel.org>
References: <20221123175652.327859-1-conor@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

If a service request fails, a non-zero, per-service error code will be
set. Since the individual service drivers may wish to handle things
differently, there's little point trying to do anything intelligent in
the system controller driver. Let the caller know that things went wrong
& leave the details of handling the error to it.

Fixes: d0054a470c33 ("soc: add microchip polarfire soc system controller")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 6e20207b5756..539fc24b397d 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -52,6 +52,12 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct
 
 	mutex_unlock(&transaction_lock);
 
+	if (ret)
+		return ret;
+
+	if (msg->response->resp_status)
+		ret = -EIO;
+
 	return ret;
 }
 EXPORT_SYMBOL(mpfs_blocking_transaction);
-- 
2.38.1

