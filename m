Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF795F64B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiJFK7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiJFK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:58:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE89B878
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:58:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u24so1347144plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOZI8SGXdjEDl/5cRiKBB/3ohsupX4oO9Re4g9HNDWE=;
        b=UajZwV8mWNElnB3627GtP97HZhzj0zo1scWikdcoZw1y/QJll/ClitWRvKQUVSh4hW
         2mSnK6Z+CLt2/GOc+BEY7KvM9j4/yOYYvPoTJx5680XIE7xwZP4V1WzV6OnJTQEsl9zT
         4DSr/H538JnJqSFjBjCCuqJ5rVsgiLIuA4Emq26c3kgpmkFbKktsSlonjIUFBNdNydEh
         VZfItGSEyXb+4zxdeUEC9uG04Q6W+n/5Ars5jQRs7g1bfliXCaa2l7K6Sdo6IIvSp+yH
         idOqrqH6SefFPnjY+xct8vI88Tr+ANW6sKOitKcwnAciE8+F6xxdhBVmJcj0VdLaWqBz
         euow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOZI8SGXdjEDl/5cRiKBB/3ohsupX4oO9Re4g9HNDWE=;
        b=laBiA8lc5ybZglJbJwwXO0uVUVpGMoi3xgv2s1B+BnyGOksFXmHH5lrfVo08cXq2xE
         2Wnlrb68deOLFmyxVV5B2+m5nlnqlbWmEfOb3cLYXYfPyITaId2DYq1ThcV3A8/apmJw
         UJ9+Aa5/Bh+wEK7RIRpAnKHFTLtzcG3yriLrdf4N4qhGkJ2lYr8D+lhtM8QbK/WBkxUv
         fEMHIOh+8zWFnW2/oK9KRrJrx6gcGPprUBjgZXFT6OS69Q6ak0gDo9LJsrdwiz/ffq7J
         jyP0sLx9nJnoAd9RX7ChvE8qyJUdFWlUp1AFiWuPmbWpDucUqBtmXfYfpyl6Bmn8PJ63
         RASw==
X-Gm-Message-State: ACrzQf1qhinIA8bMTzt7oGEeOqT3MVfqh5Qn0SkPNwGRE/O83y8N4lMu
        svLV35UFDrXUXvG0t1BDBlHcJPPGawvCyYNB
X-Google-Smtp-Source: AMsMyM5hVYB19NYs8RMrU+wMXWuCUOp0fns6L5LwE3MhmTdt8WJKRuHYX7lGe8E0Xymy2BzrcloQOQ==
X-Received: by 2002:a17:903:244e:b0:178:4f50:1ca0 with SMTP id l14-20020a170903244e00b001784f501ca0mr4111939pls.104.1665053922749;
        Thu, 06 Oct 2022 03:58:42 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id c13-20020a170903234d00b0017d12d86901sm10504297plh.187.2022.10.06.03.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:58:41 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 4/4] arm64: dts: qcom: Add touchscreen and touchpad support for evoker
Date:   Thu,  6 Oct 2022 18:58:23 +0800
Message-Id: <20221006185333.v7.4.I50d04dcbe735dda69995cf1078824d671501869e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006105823.532336-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20221006105823.532336-1-sheng-liang.pan@quanta.corp-partner.google.com>
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
---

Changes in v7:
- add compiatable for gt7986

Changes in v6:
- add removed pinctrl and align touchscreen label with herobrine board

Changes in v5:
- new patch for Touchscreen/trackpad in v5

 .../boot/dts/qcom/sc7280-herobrine-evoker.dtsi    | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
index e78072159d54b..d713750f81019 100644
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

