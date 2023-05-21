Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BA570B0C2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 23:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEUVXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 17:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjEUVXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 17:23:20 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B9ED
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 14:23:15 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E52B23F34E;
        Sun, 21 May 2023 23:23:12 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Date:   Sun, 21 May 2023 23:23:06 +0200
Subject: [PATCH RFC 04/10] arm64: dts: qcom: sdm845-akatsuki: Configure
 OLED panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230521-drm-panels-sony-v1-4-541c341d6bee@somainline.org>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
In-Reply-To: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Caleb Connolly <caleb@connolly.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the right compatible and reset-gpios for the LG Display 1440x2880
OLED panel found on the Xperia XZ3.  All other properties (e.g. vddio
regulator and pinctrl) remain the valid from the base DTSI.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
index 5d2052a0ff69f..87095520d5842 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
@@ -37,11 +37,20 @@ &lab {
 };
 
 &panel {
+	compatible = "sony,akatsuki-lgd";
+
 	/* Akatsuki uses an OLED panel. */
 	/delete-property/ backlight;
 	/delete-property/ vsp-supply;
 	/delete-property/ vsn-supply;
 	/delete-property/ touch-reset-gpios;
+
+	/*
+	 * Correct misnamed property in board DTSI, which cannot be
+	 * renamed for backwards compatibility with sony,td4353-jdi.
+	 */
+	/delete-property/ panel-reset-gpios;
+	reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
 };
 
 &pmi8998_wled {

-- 
2.40.1

