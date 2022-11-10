Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A140F624734
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiKJQjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiKJQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:39:08 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF813E0B5;
        Thu, 10 Nov 2022 08:39:06 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so4328602wmi.1;
        Thu, 10 Nov 2022 08:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijKNfiunV63AFU9RzYinLsQfMGW1tKqr0LKOgrxroKY=;
        b=EMqGCre5J9kfTG9I5KlsFPNleC+UqzrVFOs6xP66CfIIafZnrfYSvi6ATfpMfinQP4
         ilan3jK5keaNm+KMC8ZFADeyrmortKC4u3vkTRG4dzxYYrewbu4IWEa22PchUQswMfZ5
         643kK9HiTLor8JKeFuBeeEjY7lgJCWkMRaIbpMQ2yTJVaKHfhnHYWo8y1mXEpS4R/EfK
         NtL1acDDpJMqzbwGWF8pH3V9sZ4teyLaPkL+pSaIp+PpxMFPJ0amP0Zfc7Fngj0pQPVb
         nT42eo9r46YkmdBZx0mtNAXbrUzh/Mhoxdnb8VA7l38mG5M0CywYdae6szuLHWxvdJ0F
         qX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijKNfiunV63AFU9RzYinLsQfMGW1tKqr0LKOgrxroKY=;
        b=TKiOEvRqJubWvfUqy+z5Ah/ZoNOplOMnL6vbwX9+/OsKIG7SJ6iJZ1T7mo7ZwgiEiA
         /GgcwKanOmeCNWpPzgh/xJtSG6sts4A27NmGQ4Jg0oxCxVYCy4VBepWeEYuDGP7OfH6C
         of5tVHo+B922P3r3+KqXPz9H7tpm3QA7rxDqxoRhHiYhv0a4EYECyK4JcuP3N/fzMppj
         O9lE14yPp6S3sB3lPP5+CNDxZMoAvpIiWSvY2E3DWkAEMHcHe5F12XKCT+YExboiBBO7
         Kt51d6QS5Y96NmAc4r30v8EvsmvmyqlMBOjvFam41vaN+tDMQ2US+6ED36w2HZSD4NE/
         hN5g==
X-Gm-Message-State: ANoB5pnGlSVlXRq9TSQd6Lhof4idIiR454fGcHAIUimKKqnctn0o0kHq
        IKgG+DNyjRR11Tq7ZQxSQaE=
X-Google-Smtp-Source: AA0mqf7qZFMjGuzFJyQg70wgGaO2wLzSY5qmfNk3w9AcE5UxI5946LDXcwJeH+PwqOwjCzNbtV5wQA==
X-Received: by 2002:a05:600c:2d44:b0:3cf:aae0:8367 with SMTP id a4-20020a05600c2d4400b003cfaae08367mr14577034wmg.132.1668098344929;
        Thu, 10 Nov 2022 08:39:04 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id f24-20020a1cc918000000b003b4935f04a4sm128730wmb.5.2022.11.10.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:39:04 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: rockchip: Enable HDMI sound on SOQuartz
Date:   Thu, 10 Nov 2022 17:38:44 +0100
Message-Id: <20221110163845.42309-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110163845.42309-1-frattaroli.nicolas@gmail.com>
References: <20221110163845.42309-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the i2s0 node on SOQuartz, which is responsible
for hdmi audio, and adds an hdmi-sound node to enable said audio.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index 0bfb0cea7d6b..1b975822effa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -178,6 +178,10 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -446,6 +450,10 @@ &i2c4 {
 	status = "disabled";
 };
 
+&i2s0_8ch {
+	status = "okay";
+};
+
 /*
  * i2s1_8ch is exposed on CM1 / Module1A
  * pin 24 - i2s1_sdi1_m1
-- 
2.38.1

