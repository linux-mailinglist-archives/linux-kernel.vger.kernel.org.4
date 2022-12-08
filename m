Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48934647293
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLHPOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLHPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF0E7B565
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D31EACE24B1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDEAC433C1;
        Thu,  8 Dec 2022 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512436;
        bh=DWeduHE5LG/ZZm2EpXZg/Tyocb4hcbZCucorTSOe254=;
        h=From:To:Cc:Subject:Date:From;
        b=gBtwtUPWqcqyPAIlJJPbzSrTmEAtaZk8PN3p7V0GGLeGDJMQEBxxZkVhjEdnJ8pWP
         0CgjzgwxxDaCn65tZPCdTAokRjq5RRgDH2QMmfBeyOAxl4s3N97q+XL5daN8cq8B37
         fVIYe2gNsD/hb9zaBdnxsUx8luTQn98B1Q1pFe3NgA86TYGw+V2+2YTpc3pA6QKoll
         zoWopz6CsPBf4l1bJtgpWVth4T23DLm2D1JBsNodQxjMfoRfkBYlcQ1K/yUOhpuB+f
         fuOPFfk1fm/R+fSWVlAYegM9DAeHUW0SPO1AujaWhNMa9T6oO1p4FJNPhc4k1jw3I8
         qdq03fw4IBgMw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     tal albo <talbo@habana.ai>
Subject: [PATCH 01/26] habanalabs/gaudi2: fix BMON 3rd address range
Date:   Thu,  8 Dec 2022 17:13:25 +0200
Message-Id: <20221208151350.1833823-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: tal albo <talbo@habana.ai>

Fix programming incorrect value of address range

Signed-off-by: tal albo <talbo@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c b/drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c
index 56c6ab692482..1df7a59e4101 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c
@@ -2376,10 +2376,10 @@ static int gaudi2_config_bmon(struct hl_device *hdev, struct hl_debug_params *pa
 		WREG32(base_reg + mmBMON_ADDRH_S2_OFFSET, upper_32_bits(input->start_addr2));
 		WREG32(base_reg + mmBMON_ADDRL_E2_OFFSET, lower_32_bits(input->end_addr2));
 		WREG32(base_reg + mmBMON_ADDRH_E2_OFFSET, upper_32_bits(input->end_addr2));
-		WREG32(base_reg + mmBMON_ADDRL_S3_OFFSET, lower_32_bits(input->start_addr2));
-		WREG32(base_reg + mmBMON_ADDRH_S3_OFFSET, upper_32_bits(input->start_addr2));
-		WREG32(base_reg + mmBMON_ADDRL_E3_OFFSET, lower_32_bits(input->end_addr2));
-		WREG32(base_reg + mmBMON_ADDRH_E3_OFFSET, upper_32_bits(input->end_addr2));
+		WREG32(base_reg + mmBMON_ADDRL_S3_OFFSET, lower_32_bits(input->start_addr3));
+		WREG32(base_reg + mmBMON_ADDRH_S3_OFFSET, upper_32_bits(input->start_addr3));
+		WREG32(base_reg + mmBMON_ADDRL_E3_OFFSET, lower_32_bits(input->end_addr3));
+		WREG32(base_reg + mmBMON_ADDRH_E3_OFFSET, upper_32_bits(input->end_addr3));
 
 		WREG32(base_reg + mmBMON_IDL_OFFSET, 0x0);
 		WREG32(base_reg + mmBMON_IDH_OFFSET, 0x0);
-- 
2.25.1

