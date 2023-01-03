Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF67B65C627
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbjACSZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbjACSZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:25:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AE413EB9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672770181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmfNQKi7WDA8MPZe5EsjwBN//ol6PieNKV7USkZFvAQ=;
        b=ZiYDqLyoQAng9FZgZ72XzavgQC8URkg1LbSZ2J00obyGePDzg1RTeRfStEyekpPslFNw7O
        t5lLIoWgtByn/88d2Tcge0QbHDX4RjfM7ZExUcwa8cS7PvjfqPCAMxA36g62aFBuIPHh5m
        hWlkZInmoS45gIwyXKQbXKJrYJVINg0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-455-mhmw44jXPsKhs07dRIqHag-1; Tue, 03 Jan 2023 13:23:00 -0500
X-MC-Unique: mhmw44jXPsKhs07dRIqHag-1
Received: by mail-qt1-f200.google.com with SMTP id e18-20020ac84912000000b003a96d6f436fso10741907qtq.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmfNQKi7WDA8MPZe5EsjwBN//ol6PieNKV7USkZFvAQ=;
        b=aVpw6avm4Qg21u3eVSX979YJi7PEvUBzraH42M7EUFy0nzx6LF0jmhDtpM6k8I2kpf
         PoXzDnfPvML1nBW/eGTiLh3qD0t+BBWSwKUt8oK4p5rxmJEFbgtla6gSdD4/1qoQ5kW7
         xJFIaYGuWrY9TlXdX5iTbOsJLSAcTOR2rqiaxmJ4ZVm43iR7WUFGJJeyom0vjGpojRid
         D8cv2SCY2eWpO34xYGPOFE7EwXYUYGOSK4jKnd27iikmY/5tvkoQYsFoV+4ehFjfFP5U
         fa//V6j0/1gGDCp2q3ePyPXFk25rvAWpNrOJCoJ0vYpQH95NbdECLx8HOY/YzTjbJouA
         tHDQ==
X-Gm-Message-State: AFqh2koWAetM3U4tsRLdGdt2uCQ8QDUN8xQdzleToFAU10kDKwMxyucU
        XsFtZ+21O8bZe6UAm6TIud4iCxmTZBm94COzCgX2HKGFFlvj+vj8UqeEL5hc3InngqAnu7LgPem
        53ZVilPV9sSsaRRXehVomLUxv
X-Received: by 2002:a0c:800d:0:b0:4c7:34b5:7993 with SMTP id 13-20020a0c800d000000b004c734b57993mr62648562qva.27.1672770180006;
        Tue, 03 Jan 2023 10:23:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs4J9OLsqajZLDV0Yx7yq5xoA/9vSMzt/g1J5ekoZ7w/MuRw3uNmk4jeuMPuMe7V84wbIMHkg==
X-Received: by 2002:a0c:800d:0:b0:4c7:34b5:7993 with SMTP id 13-20020a0c800d000000b004c734b57993mr62648543qva.27.1672770179793;
        Tue, 03 Jan 2023 10:22:59 -0800 (PST)
Received: from x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t13-20020a05620a450d00b006fba0a389a4sm22819675qkp.88.2023.01.03.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:22:58 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.co
Subject: [PATCH v4 09/10] arm64: dts: qcom: sc8280xp: add aliases for i2c4 and i2c21
Date:   Tue,  3 Jan 2023 13:22:28 -0500
Message-Id: <20230103182229.37169-10-bmasney@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103182229.37169-1-bmasney@redhat.com>
References: <20230103182229.37169-1-bmasney@redhat.com>
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

Add aliases for i2c4 and i2c21 to the crd and x13s DTS files so that
what's exposed to userspace doesn't change in the future if additional
i2c buses are enabled on these platforms.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
New patch introduced in v4

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                  | 2 ++
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index dfd8c42d8ca0..92d410af6cf3 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -17,6 +17,8 @@ / {
 	compatible = "qcom,sc8280xp-crd", "qcom,sc8280xp";
 
 	aliases {
+		i2c4 = &i2c4;
+		i2c21 = &i2c21;
 		serial0 = &uart17;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 2c360e52dae5..f9da3ee54545 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -21,6 +21,11 @@ / {
 	model = "Lenovo ThinkPad X13s";
 	compatible = "lenovo,thinkpad-x13s", "qcom,sc8280xp";
 
+	aliases {
+		i2c4 = &i2c4;
+		i2c21 = &i2c21;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pmc8280c_lpg 3 1000000>;
-- 
2.39.0

