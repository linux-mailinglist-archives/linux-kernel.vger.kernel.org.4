Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B485F05DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiI3Hij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiI3HiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:38:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215CD1FBC83
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:38:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w20so3263296ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zWEvlra4GjNL5eCGG7TXBBCm7IbK8/TQSlxVjMYvHcE=;
        b=MrqqEkHjYffZJPu5KTLjApA/BfrcUAlXTUqdI2o2BoduWleD89du9S7cEDKVNYeGvi
         msZbuTHzYT6jNWo7BxZRMSNEX+zIoAQ1BFSCIagja5iRkH4C3irqqfd/+NFtByRyY2Zk
         A1C6zb9+L1JmXlr1GUMqnmc8v/niOzv81nv45jmlezc2eXJQf3+ePESlHDBxpJmTL5M0
         ea3Jnd8APPjbjLh7Z4SrXQgbfuSucTOYEHxJtse9pgkJXwk7DX5Q18wVGDSSp3b8tE2H
         5FW1BjZFvwvKpgV8uxhXUFnFZhpOdj1jopzzK5zcGqmR7fLLiRbG1lf1ZQqydukoVP2P
         PazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zWEvlra4GjNL5eCGG7TXBBCm7IbK8/TQSlxVjMYvHcE=;
        b=vwyqIDBFT2wSN4y21dy8DxbSL1/rk8I74EhYRx4AxG4Ou0AzwFHdrLAo6rIe6099qp
         AuhLFYIlcMbgiq5Mg5/c6p3+9qhzUKvbuosuBabtNN0jTJU/lwNipJAkB5deC2aJ2Mr7
         d2XmgQnQ7bUGydTW6T7r7/9XcnMQF1WdQkvUaEErbvmlzAj1AewHMIR55VAriWWQohzA
         NDhaFtSveNtCLDRVlbz7DyCz35JGzoCWemVaftJBCwlE4wW9UjhhfKMnc+iSUecnGsdD
         UWefX05cAR8GRqJ4nT6DR2Khj75h0I9aSbYrnllKx0jVTFYNrAorAg8E/vxFDKZY5rG8
         okrg==
X-Gm-Message-State: ACrzQf2RRiVtVh3lZW9OoWi/j0/cWtlNKvgy6BlnIT4u3EAbO4ek+QGw
        rji6zDFspjoK30DLJUQ8uUkC6G2hOhGL/8UQ
X-Google-Smtp-Source: AMsMyM7BMtKM9UrI9uh0L7T2sOUR1TImyRjbwdevY2h9dTMppxLBBMHUpFHBRqhvdENil/tT3mcanw==
X-Received: by 2002:a17:902:bc42:b0:17c:e3db:e6ca with SMTP id t2-20020a170902bc4200b0017ce3dbe6camr7386plz.10.1664523492521;
        Fri, 30 Sep 2022 00:38:12 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902ef4800b0017ba371b0a9sm1166132plx.167.2022.09.30.00.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 00:38:12 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 3/3] arm64: dts: qcom: Add touchscreen and touchpad support for evoker
Date:   Fri, 30 Sep 2022 15:37:54 +0800
Message-Id: <20220930153538.v5.3.I50d04dcbe735dda69995cf1078824d671501869e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930073754.1391044-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20220930073754.1391044-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

(no changes since v1)

 .../boot/dts/qcom/sc7280-herobrine-evoker.dtsi  | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
index e78072159d54b..c26f19371c8bc 100644
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
@@ -43,18 +42,16 @@ ts_i2c: &i2c13 {
 	status = "okay";
 	clock-frequency = <400000>;
 
-	ap_ts: touchscreen@10 {
-		compatible = "elan,ekth6915";
-		reg = <0x10>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
+	touchscreen: touchscreen@5d {
+		compatible = "goodix,gt7375p";
+		reg = <0x5d>;
 
 		interrupt-parent = <&tlmm>;
 		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
 
 		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
 
-		vcc33-supply = <&ts_avdd>;
+		vdd-supply = <&ts_avdd>;
 	};
 };
 
-- 
2.34.1

