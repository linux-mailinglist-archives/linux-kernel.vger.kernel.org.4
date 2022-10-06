Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E88F5F6280
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiJFIXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiJFIXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE088FD41
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE4E61890
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83692C433C1;
        Thu,  6 Oct 2022 08:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044599;
        bh=zn6xgPfpFBceryjiF5nUj5pjRW7vlrHNFNPRFYAE4pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyzIV7PKiFefOwY4NYTtqKa/t5YVfcFjyClaHOufylHGzT2kApk0pvomzU6LXWUwL
         XuE4rdjWse/MDoB24VGPxuQ74DnHupWYQu0FtttIDftpe0gBPIg/RUqvpcvbBTWf7g
         zLg4+DDcvRfsaPz2k8xZ5oUI8MIWkKKwv8xzeEt8X88EHFeFZz1N3gWRr9TxG8NAMa
         4l8BAKq+i8Ws1vDx5ooFtNawer+2IYImcxgIPRDgzeG9JqIeUoGHCiZOIFZLsdstL0
         qElyCVu8OmPLNXv/juCHwTT9b2VGO84T6qPSMufoPBRR1QcZGKxwJuhugJcjCUVTpH
         kai9jDv3kEXcQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 05/13] habanalabs/gaudi2: remove privileged MME clock configuration
Date:   Thu,  6 Oct 2022 11:23:00 +0300
Message-Id: <20221006082308.1266716-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006082308.1266716-1-ogabbay@kernel.org>
References: <20221006082308.1266716-1-ogabbay@kernel.org>
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

From: Koby Elbaz <kelbaz@habana.ai>

Privileged MME clock configuration is removed as it is done by the f/w.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index a7eccc41d508..90e1d7fcb17a 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -4535,7 +4535,7 @@ static void gaudi2_init_mme_acc(struct hl_device *hdev, u32 reg_base)
 static void gaudi2_init_dcore_mme(struct hl_device *hdev, int dcore_id,
 							bool config_qman_only)
 {
-	u32 queue_id_base, reg_base, clk_en_addr = 0;
+	u32 queue_id_base, reg_base;
 
 	switch (dcore_id) {
 	case 0:
@@ -4543,23 +4543,18 @@ static void gaudi2_init_dcore_mme(struct hl_device *hdev, int dcore_id,
 		break;
 	case 1:
 		queue_id_base = GAUDI2_QUEUE_ID_DCORE1_MME_0_0;
-		clk_en_addr = mmDCORE1_MME_CTRL_LO_QM_SLV_CLK_EN;
 		break;
 	case 2:
 		queue_id_base = GAUDI2_QUEUE_ID_DCORE2_MME_0_0;
 		break;
 	case 3:
 		queue_id_base = GAUDI2_QUEUE_ID_DCORE3_MME_0_0;
-		clk_en_addr = mmDCORE3_MME_CTRL_LO_QM_SLV_CLK_EN;
 		break;
 	default:
 		dev_err(hdev->dev, "Invalid dcore id %u\n", dcore_id);
 		return;
 	}
 
-	if (clk_en_addr && !(hdev->fw_components & FW_TYPE_BOOT_CPU))
-		WREG32(clk_en_addr, 0x1);
-
 	if (!config_qman_only) {
 		reg_base = gaudi2_mme_acc_blocks_bases[dcore_id];
 		gaudi2_init_mme_acc(hdev, reg_base);
-- 
2.25.1

