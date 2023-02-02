Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFD2688367
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjBBPzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjBBPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:55:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2960F63841;
        Thu,  2 Feb 2023 07:54:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBE7F61C30;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF96C433B4;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353285;
        bh=Y6hQ4z8OREr8VZpyQDiq2a1MkhG2QzkUzUjGr8t059g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwBDf6m4tG5/O2zDxwnlOeL4W2IMr9EqWOfRdAnPgZI0w0Kp34O8Gu8ncjWvNvHMJ
         kZTjUQolFTewsh78uvD4eG4cguMYQtMdszxFBgiAR9GRm0Yn4cX8/DAEZvtBCdw897
         bcow3t5fMp1yKOwheEayk1ebGHm4zn6yOh8eb4+ta7/HJjCzcmqIgc+FpJm/No03/4
         Rgp8XrOGy+z5sOIiwJZolSnsAlCctHuHilGZeG5H60gW5T/co4aarYkNyTMdFk00Fb
         OXuPJEd9BwF7PblxQMJ5VSx1/OlNtHGpNDL//0rdxeNFCXvjWkW24JeGWBQ6kHHLH+
         KXNGvE+FLuqbw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbva-0001ma-5d; Thu, 02 Feb 2023 16:55:10 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 19/22] arm64: dts: qcom: sc8280xp-pmics: add pmk8280 rtc
Date:   Thu,  2 Feb 2023 16:54:45 +0100
Message-Id: <20230202155448.6715-20-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202155448.6715-1-johan+linaro@kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMK8280 has an RTC which can also be used as a wakeup source.

Note that the RTC can not be disabled and updating the time is not
permitted either. Instead an offset can be stored in some other machine-
specific non-volatile memory which a driver can take into account.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index f2c0b71b5d8e..c62262b88810 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -95,6 +95,15 @@ pmk8280_adc_tm: adc-tm@3400 {
 			#thermal-sensor-cells = <1>;
 			status = "disabled";
 		};
+
+		pmk8280_rtc: rtc@6100 {
+			compatible = "qcom,pmk8350-rtc";
+			reg = <0x6100>, <0x6200>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+			wakeup-source;
+			status = "disabled";
+		};
 	};
 
 	pmc8280_1: pmic@1 {
-- 
2.39.1

