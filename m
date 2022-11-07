Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A971061EF70
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiKGJpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiKGJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:45:41 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B632F1403E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:45:40 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e129so9968599pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI8bag7CRDrcM5vY6bidsgJO6YZAPPNb6mhinAYmcpo=;
        b=UTcvf666EPrKmS/7NEochTvJqLQejMzRbvhyzCswuhBMdAoDA7zaZXFPor8wd9chY4
         qOukA+2qkfcqSBFAO9hy5Lzb3YXQuLhBHdXS/3b8Q/nLzTsb6xJ99wS9DM05TEQkaRgm
         QeNQtqH2YduwsxVeWJeN8KgIC6nbSxH05QqFMEQB1FRWYf2yIlBqR3QpR93DxTq2j/37
         ir13/9VQMC7IoMmtwVgcA4YYT/7zas8WElmWzVT6pVic8v+4eqAGIdnx7UT32Yqa7qWM
         lj7Lci2y94pv9Lll3PYeRG4nJ0856kS83vF5uW2EL1ZdGGPszHk2HC584yXhnH7ORK/v
         v4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vI8bag7CRDrcM5vY6bidsgJO6YZAPPNb6mhinAYmcpo=;
        b=mKyJBtV/hLL2u+8E7P1fpASzq7GB1XcbhcCSOEln02L3d49l8uInALRvTQT57SVxYy
         ig81SqpH3cBpHApmu8TuBqEPrbArlxorke5GRQautRESTEkiSZpIHxT1cRbtVhdpBbU+
         7R9IchW9wjm5zq4dA/R/flkstdZ5wWTuGsiZG74P8ite5Bpx17wBDgOz8hfE6YVKjEBw
         DqZRFQWquIwg3ig8vRHueCoVvoInHJn6VStzS9p3Vbf3uKO8z6nbIIKhjviPoCKf3+lH
         YxrAQ7Gz4agFhFbLhLfMEE+RSG5D1LtvJ2s/RWvBkQBRHxT++CHy3VjXbi/AVLL9jWzm
         LvyQ==
X-Gm-Message-State: ACrzQf2lxluas0memmBg+n/ne8aeQDRHpyCNzCwN2ZKpKc0T8Gji5WIb
        GZJLktekJmaQ/9Ql/fpzcftAE9R+mOl72Nzn
X-Google-Smtp-Source: AMsMyM5hx3+QrIK4mCNnqm1+SQ190XiEOcQHxpJ/600nbzkHxGQLTDMmtaYFk06RJeST+AXZH3VjcA==
X-Received: by 2002:a05:6a00:4c16:b0:56d:2634:c28e with SMTP id ea22-20020a056a004c1600b0056d2634c28emr46616714pfb.8.1667814340019;
        Mon, 07 Nov 2022 01:45:40 -0800 (PST)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b00186dcc37e17sm4564936pla.210.2022.11.07.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:45:39 -0800 (PST)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v11 3/5] arm64: dts: qcom: sc7280: Add touchscreen and touchpad support for evoker
Date:   Mon,  7 Nov 2022 17:43:43 +0800
Message-Id: <20221107173954.v11.3.I3ac715e729f6f9b5a3e3001b155df4f9d14e6186@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107094345.2838931-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20221107094345.2838931-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change touchpad and touchscreen node for evoker
Touchpad: SA461D-1011
Touchscreen: GT7986U

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---

Changes in v8:
- updated patch subjects

Changes in v7:
- add compiatable for gt7986

Changes in v6:
- add removed pinctrl and align touchscreen label with herobrine board

Changes in v5:
- new patch for Touchscreen/trackpad in v5

 .../boot/dts/qcom/sc7280-herobrine-evoker.dtsi    | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
index a6015491c6082..706dd82a70138 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
@@ -23,16 +23,15 @@ ap_tp_i2c: &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
 
-	trackpad: trackpad@2c {
-		compatible = "hid-over-i2c";
-		reg = <0x2c>;
+	trackpad: trackpad@15 {
+		compatible = "elan,ekth3000";
+		reg = <0x15>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tp_int_odl>;
 
 		interrupt-parent = <&tlmm>;
 		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 
-		hid-descr-addr = <0x20>;
 		vcc-supply = <&pp3300_z1>;
 
 		wakeup-source;
@@ -43,9 +42,9 @@ ts_i2c: &i2c13 {
 	status = "okay";
 	clock-frequency = <400000>;
 
-	ap_ts: touchscreen@10 {
-		compatible = "elan,ekth6915";
-		reg = <0x10>;
+	ap_ts: touchscreen@5d {
+		compatible = "goodix,gt7986u", "goodix,gt7375p";
+		reg = <0x5d>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
 
@@ -54,7 +53,7 @@ ap_ts: touchscreen@10 {
 
 		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
 
-		vcc33-supply = <&ts_avdd>;
+		vdd-supply = <&ts_avdd>;
 	};
 };
 
-- 
2.34.1

