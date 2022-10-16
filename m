Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B0A5FFFF1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJPOsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJPOsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:48:05 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 881B42EF02;
        Sun, 16 Oct 2022 07:48:04 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 3CAFF140236;
        Sun, 16 Oct 2022 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1665931682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qykf9cobLBLPVoVdRp46OEJmyRQZ5GGRqXYXF3AhMqQ=;
        b=c8kihdYuOdk+wvDvnRIOYzfEP/CE3sto28l9Tg2PdRQGotNs+L1vXsXBBpWALBBLZWnaGO
        kn7UecA9sqhpj3EDqtB+p70ydLJjL4G5iPfdIJIaSaHbGBHpxteJKPzwOBwoxItg+OLLtH
        1Tfq917jRP9lLTFRgoJOckX2J/LP088=
From:   Caleb Connolly <kc@postmarketos.org>
To:     caleb@connolly.tech
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [RESEND PATCH 1/7] arm64: dts: qcom: sdm845: commonize bluetooth UART pinmux
Date:   Sun, 16 Oct 2022 15:47:07 +0100
Message-Id: <20221016144714.1742824-2-kc@postmarketos.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221016144714.1742824-1-kc@postmarketos.org>
References: <20221016144714.1742824-1-kc@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caleb Connolly <caleb@connolly.tech>

The 4-pin configuration for UART6 is used for all or almost all SDM845
devices with built in Bluetooth. Move the pinmux configuration to
sdm845.dtsi in preparation to be removed from individual devices in
future patches.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f0e286715d1b..8c69942b969b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2971,6 +2971,29 @@ pinmux {
 				};
 			};
 
+			qup_uart6_4pin: qup-uart6-4pin {
+				pinmux {
+					pins = "gpio45", "gpio46", "gpio47", "gpio48";
+					function = "qup6";
+				};
+
+				cts {
+					pins = "gpio45";
+					bias-pull-down;
+				};
+
+				rts-tx {
+					pins = "gpio46", "gpio47";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				rx {
+					pins = "gpio48";
+					bias-pull-up;
+				};
+			};
+
 			qup_uart7_default: qup-uart7-default {
 				pinmux {
 					pins = "gpio95", "gpio96";
-- 
2.38.0

