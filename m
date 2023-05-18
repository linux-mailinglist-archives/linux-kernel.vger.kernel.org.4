Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C272E7082C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjERNb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjERNbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:31:45 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956D6125;
        Thu, 18 May 2023 06:31:43 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QMW8r4Wwpz9sls;
        Thu, 18 May 2023 15:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1684416700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqMwt/DZCklMg+3nHPyvT4HWki93CaLYFSuTlzM7b7k=;
        b=NGg1+0syX9nn5bw6Mn+b5XiMq22i0EH2SlXY1ivv76hD9CijdpyNbD5qaFUzTEuB9fWhk2
        K3S6/e1HL5gjbBcsvzcGKruKLqqgDKRK9BHVL6iRi+R5B89gsoSrzH0aUnWZPKVhP1a18S
        +OCQRolFyghE5gPm066V+KeWOtkTOp7Ijg+GJwFFiddcdoS3n6m7OhnYFkkhTzH7s+YJz/
        BDnP2TOhPSeSmHMZgQui2NarHKvkFhLr1t1RpdNZOYOUT7yJVK4z+FSrJq8gmG1myQRkOo
        rcywyj9sII1PQJGBXVz3MXyNzqa6071lTdfnlvKp0WBe97VsF8tMWO+8s5x6AA==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_fenglinw@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        amartinz@shiftphones.com, Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v3 3/3] arm64: dts: qcom: sdm845-shift-axolotl: enable flash LEDs
Date:   Thu, 18 May 2023 15:31:13 +0200
Message-Id: <20230518133113.273880-4-me@dylanvanassche.be>
In-Reply-To: <20230518133113.273880-1-me@dylanvanassche.be>
References: <20230518133113.273880-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SHIFT6mq (axolotl) is an SDM845-based smartphone with 2 flash LEDs.
One LED is white, the other one is yellow. Define both LEDs in the DTS
so they can be used as flash or torch and enable the flash LED
controller to control them in PMI8998.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 0ad891348e0c..1eaff964b202 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -554,6 +554,28 @@ led@5 {
 	};
 };
 
+&pmi8998_flash {
+	status = "okay";
+
+	led-0 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
+		led-sources = <1>;
+		led-max-microamp = <100000>;
+		flash-max-microamp = <1100000>;
+		flash-max-timeout-us = <1280000>;
+	};
+
+	led-1 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_YELLOW>;
+		led-sources = <2>;
+		led-max-microamp = <100000>;
+		flash-max-microamp = <1100000>;
+		flash-max-timeout-us = <1280000>;
+	};
+};
+
 &qup_uart9_rx {
 	drive-strength = <2>;
 	bias-pull-up;
-- 
2.40.1

