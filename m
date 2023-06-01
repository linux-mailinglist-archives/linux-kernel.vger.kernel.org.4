Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB9471973E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjFAJk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjFAJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:40:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32841A5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:40:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30af0aa4812so640030f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685612401; x=1688204401;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NL+L8/FHuQ9uoVL4kapbhTgx7Wz/4aJPIXjWIUTJPys=;
        b=rfbu5MhI5SJZwGwmZefMjuQjN/CX6szJh8v9cQK/UNCJkjr71G9quJFz0CBT8ZXeWl
         zJFST8MT4Oehem4q3mr1xsmkONJ5X4rKjexmOOW049sg2EMe03tzPs57uDMeNxckgwfu
         pShInDs5KvDgiufZG1gOGYs5KjdW6J9o7eFI1lBK2ebWOnUEnQylLHa3iP+aMlOwTxMA
         7iuidBzaMZ3gJWtxOeBhIS+70O678j/xNbu/PEewDzEU+827IbndmbBZa0OX2CS9HqTr
         yJzouPqHI/U7rcwVfgxlBvdrpC8mSygmbnIXdVS5QQUUgzKKJ/PZHavxItmuq34tBTLE
         6oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685612401; x=1688204401;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NL+L8/FHuQ9uoVL4kapbhTgx7Wz/4aJPIXjWIUTJPys=;
        b=FqFvzUU+Sn+vbE0qoUsMG2F5K5nPhGsYUs5tgD60sR7rWUJO0hZI2vcN7d7t8h/9yy
         sdSmeLZhFm73eOg8E9l39WfhQ0NGJuPabcKO+6fnq5U65bR54kXFnqOrzhOYDHVL3U1X
         mRpqyKFqQ+sL0aZz1vEBS5A1BV2K+4Hru1WJ0gBWG+ZFNJGo9VMMOOFv4A065Q0MwHqO
         13oPVSSe5SgKMmD85a4/FEwSezYCO/V1/8HwpkpGjD7fgaD445fzR8StaUDLMl+2dl8S
         yWQKc7KcnoqJ1Ok4qFRouMk/ptg8HHjZ+0RKXZcT+SnO2/VfUjos1XeGB7m8CmvCbXHs
         aTRw==
X-Gm-Message-State: AC+VfDwCtJb502YYGryapAHVVH1lU7kyCMIwHJM9uTTVTcXDcLmIwMPW
        TyuLzvOixN0ajWyKEMYm1xRQz9Ll7JPm5edw0PeeLA==
X-Google-Smtp-Source: ACHHUZ6oDSwh4UKC2VFRKtNmzJ0AnUIjBft+jmlUJMYwT/NMeAoTW0C7brp4PnU10K+KDmWVN2jLUw==
X-Received: by 2002:a5d:44c9:0:b0:2f6:c5bd:ba13 with SMTP id z9-20020a5d44c9000000b002f6c5bdba13mr1367257wrr.42.1685612400757;
        Thu, 01 Jun 2023 02:40:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e16-20020adfe390000000b003048477729asm9686685wrm.81.2023.06.01.02.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:40:00 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 11:39:58 +0200
Subject: [PATCH] phy: qcom: qmp-combo: fix Display Port PHY configuration
 for SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-dp-phy-init-fix-v1-1-4e9da9f97991@linaro.org>
X-B4-Tracking: v=1; b=H4sIAG1neGQC/x2NQQrCMBBFr1Jm7cAkErFeRVykyWgG2jRkUlFK7
 25w+R6f93dQrsIKt2GHym9RWXMHcxogJJ9fjBI7gyV7pgsZbGuRgLpcnSPcirbKfsFYsKQvSpa
 GT/kgx5ECkXGjjdBbk1fGqfocUq/lbZ67LJX79n9+fxzHD/ALUGqMAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2612;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qUJ8E0K7Mcd3JCfr2Hf0q0TxIPEtiZBh2c1pXDlK3Tw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeGdvJi88UieHqnjwJzuk4VwsotiJLMMxCu1Z4H7Z
 raTeUXCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHhnbwAKCRB33NvayMhJ0d2FEA
 DPaE1VPiQY0zVef3F6SGiREhgpocDIT1nW7BxbtcL0BVh1w+oZMO0Svt8luh72cBmV7G8luzUbaB71
 vVzoFs0aSaiMCUoGqMWKwavC5J3xFwfZUdeQuQF40+RYhecbE1hO7o5QMXGZHx+nS9CLdXhHzf+xsR
 1B5rgO+IIakhmlaIgWZUSnqHasr/+3NUYGk5aEoGcabpbcJgo8KxCx9BmPGrb11/ITbAg09yQnQX5u
 2TfWY1HJoMHFYAuIbB+0ikX6frdeMWYJ7nSAVXn72tZNbf4JV6Q7Mpiwidt5GpDOQ24mamHeloefhL
 13a/xRJwRkVBNh9t6JswucwQmYdRBN/+XNp+LM+9cbDHmiFcFXV3AI8v7a1euIrX8si4SaoakGCYFF
 tYCQN3PM4WKT5vpl2/e6B7m5Ti8YOt34KdXCw7+7aXP2aCFUx8m77ET5FORkATwpEC++1ZaDr2zqvm
 C3LRxxY3I4BIeqbm/WffeNtAiqhk/soIHrCZrhevxN6gX1j7iSfdoakMYFkjOl03tyK9ru7dHgFgVj
 lIDr4P/oXtLmepVvZPPvRkadebXk98ISH/Fd718G0Dv9rPe+DFaxUEh0hwRa0PWTFW7Uv6eS4CWxcH
 9CzU7Ko3daNIW8QTRGcDAdYDmkFg21SxJs8Kt56LlziB9KOSNDxf4nD2qSYg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 PHY also uses a different offset for the CMN_STATUS reg,
use the right one for the v6 Display Port configuration.

Fixes: 49742e9edab3 ("phy: qcom-qmp-combo: Add support for SM8550")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 33cc99d9c77d..bebce8c591a3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2151,6 +2151,7 @@ static void qmp_v4_configure_dp_tx(struct qmp_combo *qmp)
 static int qmp_v456_configure_dp_phy(struct qmp_combo *qmp,
 				     unsigned int com_resetm_ctrl_reg,
 				     unsigned int com_c_ready_status_reg,
+				     unsigned int com_cmn_status_reg,
 				     unsigned int dp_phy_status_reg)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
@@ -2207,14 +2208,14 @@ static int qmp_v456_configure_dp_phy(struct qmp_combo *qmp,
 			10000))
 		return -ETIMEDOUT;
 
-	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
+	if (readl_poll_timeout(qmp->dp_serdes + com_cmn_status_reg,
 			status,
 			((status & BIT(0)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
+	if (readl_poll_timeout(qmp->dp_serdes + com_cmn_status_reg,
 			status,
 			((status & BIT(1)) > 0),
 			500,
@@ -2250,6 +2251,7 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
 
 	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V4_COM_RESETSM_CNTRL,
 					QSERDES_V4_COM_C_READY_STATUS,
+					QSERDES_V4_COM_CMN_STATUS,
 					QSERDES_V4_DP_PHY_STATUS);
 	if (ret < 0)
 		return ret;
@@ -2314,6 +2316,7 @@ static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp)
 
 	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V4_COM_RESETSM_CNTRL,
 					QSERDES_V4_COM_C_READY_STATUS,
+					QSERDES_V4_COM_CMN_STATUS,
 					QSERDES_V4_DP_PHY_STATUS);
 	if (ret < 0)
 		return ret;
@@ -2373,6 +2376,7 @@ static int qmp_v6_configure_dp_phy(struct qmp_combo *qmp)
 
 	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V6_COM_RESETSM_CNTRL,
 					QSERDES_V6_COM_C_READY_STATUS,
+					QSERDES_V6_COM_CMN_STATUS,
 					QSERDES_V6_DP_PHY_STATUS);
 	if (ret < 0)
 		return ret;

---
base-commit: d4cee89031c80066ec461bb77b5e13a4f37d5fd2
change-id: 20230601-topic-sm8550-upstream-dp-phy-init-fix-ed90c001592d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

