Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB11B64D1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiLNVLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLNVLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8420A31DE2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671052257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82WGFX/rYKzALk9v7CgNyszozeS1XVTfYVeFFpIG25o=;
        b=ixO4dSZ0rS+JhlzoTflo2ZyW5DC3kjgICLSFV8PxnvIp8FQveezNryJb7VnugsawMPbrYS
        zu7YsV31W0mbdLIyhxw8amvbikUikwPshrNktD54IpAZqPDWKjPmyFyFp3OZYyna2gsF7Y
        Iwt8GBhGIEeC4XaHi5w6LpNMrWVVXHw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-281-3s4eanjPOE-dNLENbjYXnw-1; Wed, 14 Dec 2022 16:10:55 -0500
X-MC-Unique: 3s4eanjPOE-dNLENbjYXnw-1
Received: by mail-yb1-f199.google.com with SMTP id x188-20020a2531c5000000b00716de19d76bso1173232ybx.19
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82WGFX/rYKzALk9v7CgNyszozeS1XVTfYVeFFpIG25o=;
        b=0+/FBSZ5xHYB4yU8Gb0VB6DJzswjhYC/ULYGfJyh+Eigrk+5JQbv88GQYDXwz4F7UA
         4kNiH1Rxrklx+x3dylNwgr0O4zyNWyB3+ZGRzNYpPRxd9JeN3HeEH/M6xfzjJ/TFjDn/
         RUywomewcpZ/HDbGZJfZPwPPgljh2RrFhQwn+JhjqxzrpQyKde8YhUVJdp3dN1GJM0aI
         UsbG/ktP7xZyLG8JyU9ziksr3t7/A91Zf1rOCZWgpfGHMYIInJJqANoO0epzr9ZSaFXH
         pS1E5KpTFVWb6Z57ELMLNyP8DDT1N/fNRQaE2UpASwTZxlNgO8efuQaDTHvfBrlmsDvA
         sKMA==
X-Gm-Message-State: ANoB5pkklHK7d0cXSYrP0laku1YYaq7Il6S40lUDyvIeIqC7RbsOuHl9
        9rw3nAgSvkE+hYTHOAzluyEMcP5LUDXgTkl7a/FN1DO4HjaMe8FHNqoQB4xH1NOyGtvVDn4ANxT
        iQreoZvnOkaiyASfaD+Nj1YTa
X-Received: by 2002:a25:6042:0:b0:6fa:2ab6:99f6 with SMTP id u63-20020a256042000000b006fa2ab699f6mr19774168ybb.52.1671052255346;
        Wed, 14 Dec 2022 13:10:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7cN4CsEfM8+26Us798nflNn9Zdv9XYNIy96LO+VWQoN1qlI/GuTp53GRDTWGQqz0E9+sE4BQ==
X-Received: by 2002:a25:6042:0:b0:6fa:2ab6:99f6 with SMTP id u63-20020a256042000000b006fa2ab699f6mr19774149ybb.52.1671052255141;
        Wed, 14 Dec 2022 13:10:55 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a440500b006f474e6a715sm10782833qkp.131.2022.12.14.13.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 13:10:54 -0800 (PST)
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
Subject: [PATCH v2 3/3] arm64: dts: qcom: pm8941-rtc add alarm register
Date:   Wed, 14 Dec 2022 16:09:08 -0500
Message-Id: <20221214210908.1788284-3-echanude@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214210908.1788284-1-echanude@redhat.com>
References: <20221214210908.1788284-1-echanude@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few descriptions including a qcom,pm8941-rtc describe two reg-names
for the "rtc" and "alarm" register banks, but only one offset. For
consistency with reg-names, add the "alarm" register offset. No
functional change is expected from this.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
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

