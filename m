Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B038064D26F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLNWhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNWhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:37:51 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D4036C62;
        Wed, 14 Dec 2022 14:37:49 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 5F54620376;
        Wed, 14 Dec 2022 23:37:47 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "phy: qualcomm: usb28nm: Add MDM9607 init sequence"
Date:   Wed, 14 Dec 2022 23:37:32 +0100
Message-Id: <20221214223733.648167-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 557a28811c7e0286d3816842032db5eb7bb5f156.

This commit introduced an init sequence from downstream DT [1] in the
driver.  As mentioned by the comment above the HSPHY_INIT_CFG macro for
this sequence:

    /*
     * The macro is used to define an initialization sequence.  Each tuple
     * is meant to program 'value' into phy register at 'offset' with 'delay'
     * in us followed.
     */

Instead of corresponding to offsets into the phy register, the sequence
read by the downstream driver [2] is passed into ulpi_write [3] which
crafts the address-value pair into a new value and writes it into the
same register at USB_ULPI_VIEWPORT [4].  In other words, this init
sequence is programmed into the hardware in a totally different way than
downstream and is unlikely to achieve the desired result, if the hsphy
is working at all.

An alternative method needs to be found to write these init values at
the desired location.  Fortunately mdm9607 did not land upstream yet [5]
and should have its compatible revised to use the generic one, instead
of a compatible that writes wrong data to the wrong registers.

[1]: https://android.googlesource.com/kernel/msm/+/android-7.1.0_r0.2/arch/arm/boot/dts/qcom/mdm9607.dtsi#585
[2]: https://android.googlesource.com/kernel/msm/+/android-7.1.0_r0.2/drivers/usb/phy/phy-msm-usb.c#4183
[3]: https://android.googlesource.com/kernel/msm/+/android-7.1.0_r0.2/drivers/usb/phy/phy-msm-usb.c#468
[4]: https://android.googlesource.com/kernel/msm/+/android-7.1.0_r0.2/drivers/usb/phy/phy-msm-usb.c#418
[5]: https://lore.kernel.org/linux-arm-msm/20210805222812.40731-1-konrad.dybcio@somainline.org/

Reported-by: Michael Srba <Michael.Srba@seznam.cz>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../devicetree/bindings/phy/qcom,usb-hs-28nm.yaml   |  1 -
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c         | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
index abcc4373f39e..ca6a0836b53c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
@@ -16,7 +16,6 @@ properties:
   compatible:
     enum:
       - qcom,usb-hs-28nm-femtophy
-      - qcom,usb-hs-28nm-mdm9607
 
   reg:
     maxItems: 1
diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c b/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
index 8807e59a1162..a52a9bf13b75 100644
--- a/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
+++ b/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
@@ -401,26 +401,13 @@ static const struct hsphy_init_seq init_seq_femtophy[] = {
 	HSPHY_INIT_CFG(0x90, 0x60, 0),
 };
 
-static const struct hsphy_init_seq init_seq_mdm9607[] = {
-	HSPHY_INIT_CFG(0x80, 0x44, 0),
-	HSPHY_INIT_CFG(0x81, 0x38, 0),
-	HSPHY_INIT_CFG(0x82, 0x24, 0),
-	HSPHY_INIT_CFG(0x83, 0x13, 0),
-};
-
 static const struct hsphy_data hsphy_data_femtophy = {
 	.init_seq = init_seq_femtophy,
 	.init_seq_num = ARRAY_SIZE(init_seq_femtophy),
 };
 
-static const struct hsphy_data hsphy_data_mdm9607 = {
-	.init_seq = init_seq_mdm9607,
-	.init_seq_num = ARRAY_SIZE(init_seq_mdm9607),
-};
-
 static const struct of_device_id qcom_snps_hsphy_match[] = {
 	{ .compatible = "qcom,usb-hs-28nm-femtophy", .data = &hsphy_data_femtophy, },
-	{ .compatible = "qcom,usb-hs-28nm-mdm9607", .data = &hsphy_data_mdm9607, },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, qcom_snps_hsphy_match);
-- 
2.39.0

