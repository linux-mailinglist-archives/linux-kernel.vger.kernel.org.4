Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25257651283
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiLSTN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiLSTNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:13:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A1410070
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671477134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fr7p8fpHA5Trb/dyTG65t7CBlRLQovl5uUrytTknIzY=;
        b=A3kgo62j8dBZdT/3DQ4WmP89J3UayD/vM6wAMBUlz+z5tthv1kg8Y1IJB1rs4r/8e46LIx
        LRb+Z9GHRR4LMtdW+w9xZy+uYpJe5jFsq5uCxO7bbXrE0Ls1cXgj4GOMo6UUm81STg+kMA
        Oq24nbD+nezEAZ97c3ox5YKjmSI3/fo=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-2wIrfT60P0SmmV4OzUrJHA-1; Mon, 19 Dec 2022 14:12:10 -0500
X-MC-Unique: 2wIrfT60P0SmmV4OzUrJHA-1
Received: by mail-vk1-f197.google.com with SMTP id v128-20020a1f2f86000000b003d1df04626cso1063975vkv.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr7p8fpHA5Trb/dyTG65t7CBlRLQovl5uUrytTknIzY=;
        b=IoAGenZ+XriAJ2+1XjehlHpj1btnFpVdMKmobkYMn1CdRARfcvEmzSD7fX0boJ8Bma
         hJotdfLfLtkf6/WEp6k71XdKlKDeepDwMncaZfgz4y4cZE7HnM9K1SRjLTMr1gGf2da6
         tLL9LfbNie9yYU+k+rzm9XPqJYZdhbUQMYWzVKVZftKR7YG8DRfgxhdCbj7KT7mkpkoS
         DZLeJP1daKpzTIaLEmzyd6kx13yVS7u5YOVJQkG4wb6nK/ED8Y5VYxzXiqBFE9eusGrQ
         jR6WrCgUxSNLc0r7v/DDcRXqud/beue9cLQbPXgRmxRb9BaCBBNDDt7wxePC20chjmqd
         xGpw==
X-Gm-Message-State: ANoB5pm3LiO1O8NI9uNCq1XxJqKb/yTuuQtt+/8NDR4rv7lo8xXwcYrJ
        aWa6Yg2DYVeo15QZpypA89MEbGcjPug+8da5DtrREpTzzouf1e+QaBCxAEe0tOnVJBVLD9Ik15T
        msHCzm/aQQYo8gRaFQ08mDNl5
X-Received: by 2002:a67:fe45:0:b0:3b2:e77e:14c7 with SMTP id m5-20020a67fe45000000b003b2e77e14c7mr23340453vsr.28.1671477129445;
        Mon, 19 Dec 2022 11:12:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5pUNSoUoQzQJepfFfeqF7QY2OEKtrCJZNiPLSlvBZAJLPayNaZ+BLa1C8OnC+WIuJ8vG8iXQ==
X-Received: by 2002:a67:fe45:0:b0:3b2:e77e:14c7 with SMTP id m5-20020a67fe45000000b003b2e77e14c7mr23340434vsr.28.1671477129195;
        Mon, 19 Dec 2022 11:12:09 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id h21-20020a05620a401500b006fc6529abaesm7634145qko.101.2022.12.19.11.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:12:08 -0800 (PST)
From:   Eric Chanudet <echanude@redhat.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>
Subject: [PATCH v4 4/4] arm64: dts: qcom: pm8941-rtc add alarm register
Date:   Mon, 19 Dec 2022 14:10:01 -0500
Message-Id: <20221219191000.2570545-5-echanude@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219191000.2570545-1-echanude@redhat.com>
References: <20221219191000.2570545-1-echanude@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few descriptions including a qcom,pm8941-rtc describe two reg-names
for the "rtc" and "alarm" register banks, but only one offset.
For consistency with reg-names, add the "alarm" register offset.
No functional change is expected from this.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi      | 3 ++-
 arch/arm64/boot/dts/qcom/pm8950.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/pmp8074.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi      | 2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index 574fa95a2871..db90c55fa2cf 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -121,7 +121,7 @@ pm8150_adc_tm: adc-tm@3500 {
 
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
-			reg = <0x6000>;
+			reg = <0x6000>, <0x6100>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index 08f9ca006e72..e2a6b66d8847 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -93,7 +93,8 @@ adc-chan@f {
 
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
-			reg = <0x6000>;
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
index 07c3896bd36f..d7df4ad60509 100644
--- a/arch/arm64/boot/dts/qcom/pm8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
@@ -126,7 +126,7 @@ xo-therm-buf@3c {
 
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
-			reg = <0x6000>;
+			reg = <0x6000>, <0x6100>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
index 20c5d60c8c2c..ee1e428d3a6e 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
@@ -108,7 +108,7 @@ pmm8155au_1_adc_tm: adc-tm@3500 {
 
 		pmm8155au_1_rtc: rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
-			reg = <0x6000>;
+			reg = <0x6000>, <0x6100>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
 
diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
index ceb2e6358b3d..580684411d74 100644
--- a/arch/arm64/boot/dts/qcom/pmp8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
@@ -74,7 +74,7 @@ vph-pwr@131 {
 
 		pmp8074_rtc: rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
-			reg = <0x6000>;
+			reg = <0x6000>, <0x6100>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
 			allow-set-time;
diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index ffe9e33808d0..22edb47c6a84 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -125,7 +125,7 @@ xo_therm: xo_temp@76 {
 
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
-			reg = <0x6000>;
+			reg = <0x6000>, <0x6100>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
 		};
-- 
2.38.1

