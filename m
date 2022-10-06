Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6493C5F627D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiJFIXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiJFIXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EB02D1EF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9140C61890
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7A8C433D7;
        Thu,  6 Oct 2022 08:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044595;
        bh=tAHgYHGtEjwsbKdW4U0nQ8N6ZS4ou7A0pd1b/ztkWhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iufkJPf8ml3dkBC5saYV6q5sNb1gv8xZRKalSU3ewA3az07f5QsT8rGGYojkjLdwT
         avYSE8uexSmQ8P4hFDQV2SfJv9K6Gb6NfEDg6Foh5NoEGW5VsvgjLRHECJc6TNY1wl
         Pg4CZNmvGKLsOK+Ff4qGBNPwn/+/cILN5R5KlgNAB+N1dbj8B804qMcfCTafWfsiMY
         N48uBJBxthhmDoG5HwJTaSDZc1Taicfe0C5sLPYG+AlBs11FCi1nLEReGpSftjFlEm
         GlJ3mnj1xvYCDrN3OjFCKQ9vV6wpTqUUWYTwNXWwqGhYzTOvE234riyKCSO+1vPO4n
         dPx06nV3Ehwzg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 02/13] habanalabs/gaudi2: fix module ID for RAZWI handling
Date:   Thu,  6 Oct 2022 11:22:57 +0300
Message-Id: <20221006082308.1266716-2-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

RAZWI is optionally handled as part of the generic QM SEI error
handling, but it always uses PDMA as the module ID.
Fix it to use the suitable module ID according to the specific event.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 75c4bef7841c..a7eccc41d508 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -7602,6 +7602,7 @@ static void _gaudi2_handle_qm_sei_err(struct hl_device *hdev, u64 qman_base)
 static void gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
 					struct hl_eq_razwi_info *razwi_info)
 {
+	enum razwi_event_sources module;
 	u64 qman_base;
 	u8 index;
 
@@ -7611,9 +7612,11 @@ static void gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
 		qman_base = mmDCORE0_TPC0_QM_BASE +
 				(index / NUM_OF_TPC_PER_DCORE) * DCORE_OFFSET +
 				(index % NUM_OF_TPC_PER_DCORE) * DCORE_TPC_OFFSET;
+		module = RAZWI_TPC;
 		break;
 	case GAUDI2_EVENT_TPC24_AXI_ERR_RSP:
 		qman_base = mmDCORE0_TPC6_QM_BASE;
+		module = RAZWI_TPC;
 		break;
 	case GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE:
 	case GAUDI2_EVENT_MME1_CTRL_AXI_ERROR_RESPONSE:
@@ -7623,16 +7626,19 @@ static void gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
 				(GAUDI2_EVENT_MME1_CTRL_AXI_ERROR_RESPONSE -
 						GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE);
 		qman_base = mmDCORE0_MME_QM_BASE + index * DCORE_OFFSET;
+		module = RAZWI_MME;
 		break;
 	case GAUDI2_EVENT_PDMA_CH0_AXI_ERR_RSP:
 	case GAUDI2_EVENT_PDMA_CH1_AXI_ERR_RSP:
 		index = event_type - GAUDI2_EVENT_PDMA_CH0_AXI_ERR_RSP;
 		qman_base = mmPDMA0_QM_BASE + index * PDMA_OFFSET;
+		module = RAZWI_PDMA;
 		break;
 	case GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE:
 	case GAUDI2_EVENT_ROTATOR1_AXI_ERROR_RESPONSE:
 		index = event_type - GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE;
 		qman_base = mmROT0_QM_BASE + index * ROT_OFFSET;
+		module = RAZWI_ROT;
 		break;
 	default:
 		return;
@@ -7647,7 +7653,7 @@ static void gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
 
 	/* check if RAZWI happened */
 	if (razwi_info)
-		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_PDMA, 0, 0, razwi_info);
+		gaudi2_ack_module_razwi_event_handler(hdev, module, 0, 0, razwi_info);
 }
 
 static void gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type)
-- 
2.25.1

