Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305CC6B21A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjCIKiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCIKiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:38:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658189004
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:38:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l1so1340767wry.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678358280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8KzYFaNC31XGy3z1a5fC/b9IAo0DBq/FXy8tjU946A=;
        b=DO8k7fPNDDmPBblcD1EQBHtrAcYkuYotdqK/W83NPqgPruh4/jqz7zPv6SzqmC48Nt
         MWVylCIKxpVklFOabPti8pPq/nzbK7ANAcZyWJBa+syuIgujaOB52eW95D1QguD/F2Ix
         /H+rZ0TMUATREoe51WKSjDO6xpoFg/Fyi9gPbubq1eK5Kq3f+pm0URO+vGld5DyomKjm
         61r6Dx5E7XjfkMgOiXpS1vLoFWW0fdCZsV1uVsixEwiFdfAZLkH23eEPHdvwtHN99d/w
         PL1UsF2cjGKT7rMqhXi1+1iI+jejaA3dOSKt0d5c6JnJXgIV+vORRh3P8LZxIvF+jAcD
         WULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8KzYFaNC31XGy3z1a5fC/b9IAo0DBq/FXy8tjU946A=;
        b=R9IPp9PtgifRVBvHP4LWxZZmBaIzJDycJNfVTWSFGC90lf9ZRnv7LWLjDEhBkytqAU
         MdMtpk7h5/G/njRA2NiWrvCF/J8au+bA9uOSAzq1/WTGfGI4fZJyEBpSOfFzw++RRE8u
         1r866UakT69dyNLwfWf7jlsXmxazOLV3BXyjWvEL8sDA8jXQ7uLYY2jHTi37+U5FVK7g
         HHxVnLWbYE8JoHrmaJnp2Wk2tV4G0s4aVe91WS0Gnpj1T99zqdtbxOYu5v2Xor/S1jeE
         Hp3zAAQo+sJQheTMbnhCRdjbjQilO7rYYq4C+aqYk7WvMUgVl5LV7Aj+MAfQlRRmIskl
         8cSw==
X-Gm-Message-State: AO0yUKUORCoQfRh2xc/RKIdMmwjUM6mctUJ0iobJjVXggWPmVyZDY86t
        DIKn7yR9IEXgqncNWOZ+io0h9w==
X-Google-Smtp-Source: AK7set8BdnsQOqBxFxXWZdPGWFHZzTyInEswB0CiSMdMY5dlkRWdYfwHJJfD+luucG+/pU6eISbopg==
X-Received: by 2002:a5d:5689:0:b0:2c7:1b3e:362c with SMTP id f9-20020a5d5689000000b002c71b3e362cmr13091572wrv.42.1678358279886;
        Thu, 09 Mar 2023 02:37:59 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f14c:2275:50fc:c056])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d58e2000000b002c56af32e8csm17638119wrd.35.2023.03.09.02.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:37:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 4/9] arm64: dts: qcom: sa8775p-ride: enable i2c18
Date:   Thu,  9 Mar 2023 11:37:47 +0100
Message-Id: <20230309103752.173541-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230309103752.173541-1-brgl@bgdev.pl>
References: <20230309103752.173541-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This enables the I2C interface on the sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index a538bb79c04a..5fdce8279537 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -13,6 +13,7 @@ / {
 
 	aliases {
 		serial0 = &uart10;
+		i2c18 = &i2c18;
 	};
 
 	chosen {
@@ -20,6 +21,13 @@ chosen {
 	};
 };
 
+&i2c18 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&qup_i2c18_default>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
@@ -37,6 +45,13 @@ qup_uart10_default: qup-uart10-state {
 		pins = "gpio46", "gpio47";
 		function = "qup1_se3";
 	};
+
+	qup_i2c18_default: qup-i2c18-state {
+		pins = "gpio95", "gpio96";
+		function = "qup2_se4";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
 
 &uart10 {
-- 
2.37.2

