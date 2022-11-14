Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8602C627AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbiKNKnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiKNKmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:42:45 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8101F2E2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:42:44 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id r12so18577593lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIxBbSjNtdNlSWQ1P+SfGBLDhzhPep7hpCHZEsAxTUk=;
        b=cZew1Zo/v+y0TYowOujeDuQ6IMFAccM4Fk4rgARNNELs8jbhX9zOOlAMT6fP0UV0Qg
         UBssnbX7FVkEnWgEwY4pAFPOb5NhBcjV96Mznq6b14alBUC7hjbBewJBWBCcjE64T60z
         VBska7KI4+ixo/F17+RxzTECpjja5fZDgRhp9ZO2OLXy45Q7riSAKcNtBcj10OH7imKd
         pjZXb98tmeYGiVaylNHiXZSDFiobM5NdSgr9e0Ymyn92g7GdRWjG8sL9XTG/0erzLHPi
         S3gQ5sxYDM26bBjgUS2P2+Nsg1YOuSpxSGYmvfDEIMImDQaKdaf4EYWWQbZZA2iziDR2
         kdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIxBbSjNtdNlSWQ1P+SfGBLDhzhPep7hpCHZEsAxTUk=;
        b=MqZqdwUdxS9tduxB2TkRvEOkTBUf7d28yv+/G9qJte32iY0sTyjc7x+sHFmflBnR+V
         PwL+sBeTe+YMQ40II2SGq6IXSeDGv9Vaf1rF0H4J6c/ke5gHhfq/ezBExYr5p9rcPnWh
         9N9MzAS23F4JpPAMi/IorP4RIT55RMKoKxz1DuYTiFGF/zRo/+oYHAVwmX9H9SOACQm2
         gyYo83B9/lEb/kVUYSpZHJegFErv5S8f0YH1EwqHOeqgvU9JxoI4g3mV6nWYV8cmkdpj
         uYEkXN/fljy/gM0eK6GcSFO/+cbjCzFCR7Z56A7LTGLEfZFRXrPjxJxFTIY8yEhGwdUq
         daLQ==
X-Gm-Message-State: ANoB5pnGuE8BE1gMlakg0yW1eGkZSz3pooP2+3IuSnyYjGrZXKo4nOGh
        zw2/nQxUup2lPcZc6Z63qjf4xQ==
X-Google-Smtp-Source: AA0mqf79KXLBqXhHHaUBl+c9s+DAYlYJocR1z2m9OZukhhoQomWB738w3lzBIlcN3tIBWFZ5EO+tjw==
X-Received: by 2002:a19:5e01:0:b0:4ab:4241:80c2 with SMTP id s1-20020a195e01000000b004ab424180c2mr3675107lfb.207.1668422563165;
        Mon, 14 Nov 2022 02:42:43 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id bs21-20020a05651c195500b0026c4e922fb2sm1946486ljb.48.2022.11.14.02.42.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 02:42:42 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] arm64: dts: qcom: sm6375-pdx225: Add PMIC peripherals
Date:   Mon, 14 Nov 2022 11:42:20 +0100
Message-Id: <20221114104222.36329-8-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221114104222.36329-1-konrad.dybcio@linaro.org>
References: <20221114104222.36329-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and enable PMIC peripherals for PM6125, PMR735a and PMK8350 on
the Xperia 10 IV.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes since v1:
- configure PMK8350 SID

 .../qcom/sm6375-sony-xperia-murray-pdx225.dts | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index 6a0f4c0bf7ad..c830124cb483 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -5,10 +5,18 @@
 
 /dts-v1/;
 
+/* PMK8350 is configured to use SID6 instead of 0 */
+#define PMK8350_SID 6
+
 #include <dt-bindings/gpio/gpio.h>
 #include "sm6375.dtsi"
+#include "pm6125.dtsi"
+#include "pmk8350.dtsi"
 #include "pmr735a.dtsi"
 
+/* PM6125 PON is used and we can't have duplicate labels */
+/delete-node/ &pmk8350_pon;
+
 / {
 	model = "Sony Xperia 10 IV";
 	compatible = "sony,pdx225", "qcom,sm6375";
@@ -73,6 +81,23 @@ &gpi_dma1 {
 	status = "okay";
 };
 
+&pmk8350_adc_tm {
+	status = "okay";
+};
+
+&pmk8350_rtc {
+	status = "okay";
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEUP>;
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.38.1

