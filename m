Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCCD6968E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjBNQM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjBNQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:12:22 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D4B358E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:12:20 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qw12so41400070ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7FmuUYV4i+tUiEr3sQgj1FjRrcMIeNDDjtwxcnomOg=;
        b=ChWsQKERNUzcd/oJs7wTTCOMWypEqtx1FKjgOWz7kJ+kkTcf4QMZwOsyT4AmKiepR1
         wmxrLJ4iRxvFe0J1XGA2Z3esLkJoV7N3DC8zgmX0k29BYLjTY/Ai2/kwEJhGVOCreKAR
         yMGNAxkWetCgLSo4NI2y2Ba1GE+hwP3q2eDmOrC0f3ytM/gZaoK14SdcyfaWtnudMzOD
         RlwTWR3t6HnEyuw05f6HCN5WDFn9wi+EeeZj/Cq9Tt3N+ahT2cnQunaABSIXajZLoYdH
         o97szoafzgzU6RlKejoU8n1dWmjfGPFSVfFLoQtuOpJwAx698Mw6iZ7NC2NDQiiYZqlb
         rjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7FmuUYV4i+tUiEr3sQgj1FjRrcMIeNDDjtwxcnomOg=;
        b=ksStWb3PP5jHTAq/riVihfu6IIHjjv3ocz6oaMLjj80Th/Ti2eSnlPGtFrzkX1Re+i
         Yah2DnhA/gVl7h592Goie91hHvx8qYWvGyykLSgPaxiFUe/vbZtr+YQfYccjHLknb5A4
         0h3xIb2/cerzA2OHcJ4pxHDodCIdGsTb+rg/WKFuULCqPaQkOhzbc5hWzgjj4VWv9m7+
         FdXYQIWQwzDVVeiaGAOx5puBUHlMB8XoCuwEoiskB7l9sXYvGjady6nOCkU2EvhUdkkL
         9usGE2VC4zEFvcsBTWCC6pj0PZxY1bMeSUGps7JsTDRxBY4RxrSmzDyL4mSxVlCA0ktf
         uelA==
X-Gm-Message-State: AO0yUKV/Aob2hd4L9L5/Otap5/4QDp9pTQ2jsN4wzcKHR3fd23UKMAaj
        T6PFvEFPB7fU/VwJ9rr0bJ8lXA==
X-Google-Smtp-Source: AK7set8I/5R1R2ISxCMl/lGAba1E4D5oDFL02UTwyH1kszy4po+MhCYWuX1EWAPCSKb5IDTUW9p5Zg==
X-Received: by 2002:a17:906:8410:b0:8ac:f02b:7ea8 with SMTP id n16-20020a170906841000b008acf02b7ea8mr175787ejx.6.1676391139426;
        Tue, 14 Feb 2023 08:12:19 -0800 (PST)
Received: from fedora.. (cpezg-94-253-130-165-cbl.xnet.hr. [94.253.130.165])
        by smtp.googlemail.com with ESMTPSA id de56-20020a1709069bf800b00878530f5324sm8564376ejc.90.2023.02.14.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:12:19 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 4/4] ARM: dts: qcom: ipq4018-ap120c-ac: use NVMEM for ath10k caldata
Date:   Tue, 14 Feb 2023 17:12:11 +0100
Message-Id: <20230214161211.306462-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214161211.306462-1-robert.marko@sartura.hr>
References: <20230214161211.306462-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ath10k now supports loading the pre-cal via NVMEM instead of having
to use userspace scripts, lets use it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
index bb0c888b048ec..d90b4f4c63afe 100644
--- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
@@ -170,6 +170,17 @@ partition@170000 {
 				label = "ART";
 				reg = <0x00170000 0x00010000>;
 				read-only;
+				compatible = "nvmem-cells";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				precal_art_1000: precal@1000 {
+					reg = <0x1000 0x2f20>;
+				};
+
+				precal_art_5000: precal@5000 {
+					reg = <0x5000 0x2f20>;
+				};
 			};
 
 			partition@180000 {
@@ -233,10 +244,14 @@ &mdio {
 
 &wifi0 {
 	status = "okay";
+	nvmem-cell-names = "pre-calibration";
+	nvmem-cells = <&precal_art_1000>;
 };
 
 &wifi1 {
 	status = "okay";
+	nvmem-cell-names = "pre-calibration";
+	nvmem-cells = <&precal_art_5000>;
 	qcom,ath10k-calibration-variant = "ALFA-Network-AP120C-AC";
 };
 
-- 
2.39.1

