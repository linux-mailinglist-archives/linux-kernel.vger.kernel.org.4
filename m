Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0CE5BCB80
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiISMK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiISMKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:10:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FAABE3B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B008B80B9F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A84C433D7;
        Mon, 19 Sep 2022 12:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663589436;
        bh=npGHN7HHyR8hLnEhBAAJizVKYBg45PPtv2ub8B2Q/sE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hhcd3oR6HcRVkAxarghcxLf7scxeIt7YnaIA/iIkbu48ruqUfVv1rZ2sA+9+5RfTk
         VIq9GXIE5KLBXfNVzNx4o3Js0R8xxtQQ7Guh1eRRod+sb1fn5o54aYMC6pZL06YZMr
         k+finZt7Ar7F/ahudUbiMO0bP6IzhApEmkyh4ZH4A0uCDUF8IgJeZAeKFZ9tkJCwUJ
         dEPMyTOU1Za8Uy46P7hSBKMn6jIijONShUlL6xXSHtp+WEY+CgjVtPl5rW48PNcGJM
         xMIJvBtvSPAczuCj86B6kZJALhIUEdkAT91xL+uHuCooc9S0l1o0t96pEEcPJS9lpD
         KlROrlk73OjxQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/2] habanalabs/gaudi2: allow user to flush PCIE by read
Date:   Mon, 19 Sep 2022 15:10:25 +0300
Message-Id: <20220919121025.58172-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919121025.58172-1-ogabbay@kernel.org>
References: <20220919121025.58172-1-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

In order for the user to flush PCIE he needs to read some register
from PCIE block. The chosen register is SPECIAL_GLBL_SPARE_0 and
hence needs to be unsecured.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/gaudi2/gaudi2_security.c  |   7 +-
 .../include/gaudi2/asic_reg/gaudi2_regs.h     |   1 +
 .../gaudi2/asic_reg/pcie_wrap_special_regs.h  | 185 ++++++++++++++++++
 3 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_wrap_special_regs.h

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2_security.c b/drivers/misc/habanalabs/gaudi2/gaudi2_security.c
index c4165db06db2..c6906fb14229 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2_security.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2_security.c
@@ -2559,6 +2559,10 @@ static const u32 gaudi2_pb_pcie[] = {
 	mmPCIE_WRAP_BASE,
 };
 
+static const u32 gaudi2_pb_pcie_unsecured_regs[] = {
+	mmPCIE_WRAP_SPECIAL_GLBL_SPARE_0,
+};
+
 static const u32 gaudi2_pb_thermal_sensor0[] = {
 	mmDCORE0_XFT_BASE,
 	mmDCORE0_TSTDVS_BASE,
@@ -3418,7 +3422,8 @@ static int gaudi2_init_protection_bits(struct hl_device *hdev)
 	rc |= hl_init_pb(hdev, HL_PB_SHARED, HL_PB_NA,
 			HL_PB_SINGLE_INSTANCE, HL_PB_NA,
 			gaudi2_pb_pcie, ARRAY_SIZE(gaudi2_pb_pcie),
-			NULL, HL_PB_NA);
+			gaudi2_pb_pcie_unsecured_regs,
+			ARRAY_SIZE(gaudi2_pb_pcie_unsecured_regs));
 
 	/* Thermal Sensor.
 	 * Skip when security is enabled in F/W, because the blocks are protected by privileged RR.
diff --git a/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h b/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
index bfda4223bdc8..6aa1b1412462 100644
--- a/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
+++ b/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
@@ -132,6 +132,7 @@
 #include "dcore0_mme_ctrl_lo_arch_tensor_a_regs.h"
 #include "dcore0_mme_ctrl_lo_arch_tensor_b_regs.h"
 #include "dcore0_mme_ctrl_lo_arch_tensor_cout_regs.h"
+#include "pcie_wrap_special_regs.h"
 
 #include "pdma0_qm_masks.h"
 #include "pdma0_core_masks.h"
diff --git a/drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_wrap_special_regs.h b/drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_wrap_special_regs.h
new file mode 100644
index 000000000000..46558e7a7f63
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_wrap_special_regs.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2020 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_PCIE_WRAP_SPECIAL_REGS_H_
+#define ASIC_REG_PCIE_WRAP_SPECIAL_REGS_H_
+
+/*
+ *****************************************
+ *   PCIE_WRAP_SPECIAL
+ *   (Prototype: SPECIAL_REGS)
+ *****************************************
+ */
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_0 0x4C01E80
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_1 0x4C01E84
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_2 0x4C01E88
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_3 0x4C01E8C
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_4 0x4C01E90
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_5 0x4C01E94
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_6 0x4C01E98
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_7 0x4C01E9C
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_8 0x4C01EA0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_9 0x4C01EA4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_10 0x4C01EA8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_11 0x4C01EAC
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_12 0x4C01EB0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_13 0x4C01EB4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_14 0x4C01EB8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_15 0x4C01EBC
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_16 0x4C01EC0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_17 0x4C01EC4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_18 0x4C01EC8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_19 0x4C01ECC
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_20 0x4C01ED0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_21 0x4C01ED4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_22 0x4C01ED8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_23 0x4C01EDC
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_24 0x4C01EE0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_25 0x4C01EE4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_26 0x4C01EE8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_27 0x4C01EEC
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_28 0x4C01EF0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_29 0x4C01EF4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_30 0x4C01EF8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_PRIV_31 0x4C01EFC
+
+#define mmPCIE_WRAP_SPECIAL_MEM_GW_DATA 0x4C01F00
+
+#define mmPCIE_WRAP_SPECIAL_MEM_GW_REQ 0x4C01F04
+
+#define mmPCIE_WRAP_SPECIAL_MEM_NUMOF 0x4C01F0C
+
+#define mmPCIE_WRAP_SPECIAL_MEM_ECC_SEL 0x4C01F10
+
+#define mmPCIE_WRAP_SPECIAL_MEM_ECC_CTL 0x4C01F14
+
+#define mmPCIE_WRAP_SPECIAL_MEM_ECC_ERR_MASK 0x4C01F18
+
+#define mmPCIE_WRAP_SPECIAL_MEM_ECC_GLBL_ERR_MASK 0x4C01F1C
+
+#define mmPCIE_WRAP_SPECIAL_MEM_ECC_ERR_STS 0x4C01F20
+
+#define mmPCIE_WRAP_SPECIAL_MEM_ECC_ERR_ADDR 0x4C01F24
+
+#define mmPCIE_WRAP_SPECIAL_MEM_RM 0x4C01F28
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_ERR_MASK 0x4C01F40
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_ERR_ADDR 0x4C01F44
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_ERR_CAUSE 0x4C01F48
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SPARE_0 0x4C01F60
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SPARE_1 0x4C01F64
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SPARE_2 0x4C01F68
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SPARE_3 0x4C01F6C
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_0 0x4C01F80
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_1 0x4C01F84
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_2 0x4C01F88
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_3 0x4C01F8C
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_4 0x4C01F90
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_5 0x4C01F94
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_6 0x4C01F98
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_7 0x4C01F9C
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_8 0x4C01FA0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_9 0x4C01FA4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_10 0x4C01FA8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_11 0x4C01FAC
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_12 0x4C01FB0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_13 0x4C01FB4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_14 0x4C01FB8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_15 0x4C01FBC
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_16 0x4C01FC0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_17 0x4C01FC4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_18 0x4C01FC8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_19 0x4C01FCC
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_20 0x4C01FD0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_21 0x4C01FD4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_22 0x4C01FD8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_23 0x4C01FDC
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_24 0x4C01FE0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_25 0x4C01FE4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_26 0x4C01FE8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_27 0x4C01FEC
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_28 0x4C01FF0
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_29 0x4C01FF4
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_30 0x4C01FF8
+
+#define mmPCIE_WRAP_SPECIAL_GLBL_SEC_31 0x4C01FFC
+
+#endif /* ASIC_REG_PCIE_WRAP_SPECIAL_REGS_H_ */
-- 
2.25.1

