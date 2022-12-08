Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D864729B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiLHPOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiLHPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C9CABA3B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83A0A61F6B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24244C433C1;
        Thu,  8 Dec 2022 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512447;
        bh=z5+gFbi7QyqTQehzztxl1G4UjrcDzJw7IykCbAog4ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t9J3+IOq+xGe3DxdnCkYTHRXkIatT8U4U+QTOw9ulmQ9bHtaaCcy+xrfe4+A8thPu
         aqasXFMs2G9AYqdKqjDfIdWzOqyx2mf66RUAsLXv6Oz08y3zQjecpgDaEkAPXTSwOm
         kNKOycYRm4cirkN1Wd4UPLod6VaWBbZpdI5wWXZ/7d3G3xnDEZDZHbkdabcEJ+tLYr
         RDdkuC3umLlpukqEG19lskw5KTlnAI0pQn5DNQcpswSjNX0PpUNbW7rix3XD7XMgrW
         GuU72PgTLiSrg2qG4I/Q2qx+lENR6OHHlORhmKRKft6FVUv0OUZYgfwDJMliljwdLR
         oIBcQDTy+I2PQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 10/26] habanalabs: update DRAM props according to preboot data
Date:   Thu,  8 Dec 2022 17:13:34 +0200
Message-Id: <20221208151350.1833823-10-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

If the f/w reports the binning masks at the preboot stage, the driver
must align its DRAM properties according to the new information.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 4f364c3085fe..046866c673e2 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2582,6 +2582,10 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 			hdev->decoder_binning = le32_to_cpu(binning_info->dec_mask);
 			hdev->rotator_binning = le32_to_cpu(binning_info->rot_mask);
 
+			rc = hdev->asic_funcs->set_dram_properties(hdev);
+			if (rc)
+				goto out;
+
 			dev_dbg(hdev->dev,
 				"Read binning masks: tpc: 0x%llx, dram: 0x%llx, edma: 0x%x, dec: 0x%x, rot:0x%x\n",
 				hdev->tpc_binning, hdev->dram_binning, hdev->edma_binning,
-- 
2.25.1

