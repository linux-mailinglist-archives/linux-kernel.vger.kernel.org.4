Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E3624732
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiKJQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiKJQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:39:05 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFDB40933;
        Thu, 10 Nov 2022 08:39:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5so1495449wmo.1;
        Thu, 10 Nov 2022 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vGKGpKWDMzYcbAUuUDkHFy/CbDqDYWCKkXDWqHYnr4=;
        b=Q4agGMu9FrZPtntxrQIAFveH0/JIGNUSfSyR4YNf+TmWoa1ZiwofC1eGe9KhUTGNBS
         KUEyBT+VMmIR0JySzGG3/9uromMiqWEGDIPH3AECyNe9D2lfHGzTkFYAeoAAj/wkzHU9
         YgMCGzN5CmuUHLMB7ntZekvR2fT7m0IC6AC6RuFunuNH/18UNLEkSCbu0abyr2nblKZA
         H9A8e+mc2Wnf9q9k9o3mHv4DRQeGqNA6Mz791EzN2Bltt8UQHLHyHUl13ElyUGP90Dem
         NuoDESrEBRTSp4spIaNpSSaPT3G3IKHNL1lzaYLV2HhjR0EQZZbeDrWU1w4s+UCKjpYq
         KMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vGKGpKWDMzYcbAUuUDkHFy/CbDqDYWCKkXDWqHYnr4=;
        b=zmHC3SBZuuHSOQF8uWLkrLCxaq/PZKQScltOZy/97wiq2vpH78wKw9gHJnqEPXSVPk
         b0EvCw87E3wH9kqnBv1gRzhLk7yxb26ENHytFvfo79J+BU3XoCBAYo3ZZd6C/Y2YDXrA
         iL09GfaEOzkjVVLDNvBzcGKwcH7tDPXpcBXrHtlOEEpHdqHfsRRodTLsVVj7x/4HdixB
         CO0x7FiQShZylRhoMfqyF+pi1sxSkg8hzDVHMtOYiq8vpWtcFpjYlj90IZI/jDITwItT
         vVhy7gG+lhlln8vTVDcZZFrQHWlqRXI+HMdXtSRvT1gyovocR42zA2ayhqEHBEA01te9
         k2/g==
X-Gm-Message-State: ACrzQf0YhLceyj2Aly/2487r36OxNmOpw7uE4ZhICanPvIypoVSEhFa3
        WEh2HCW88B9vjqLzymDX3H0=
X-Google-Smtp-Source: AMsMyM7ZwI2nFHRbTL3g9oJmoWUv32HD7HJGF2LyrnDeRqXDfUNZTPc5cT/JW+pTCQTJjlq0FLi4xw==
X-Received: by 2002:a05:600c:2287:b0:3cf:4dfb:c223 with SMTP id 7-20020a05600c228700b003cf4dfbc223mr50937020wmf.19.1668098341945;
        Thu, 10 Nov 2022 08:39:01 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id f24-20020a1cc918000000b003b4935f04a4sm128730wmb.5.2022.11.10.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:39:01 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: rockchip: Enable GPU on SOQuartz CM4
Date:   Thu, 10 Nov 2022 17:38:42 +0100
Message-Id: <20221110163845.42309-2-frattaroli.nicolas@gmail.com>
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

This enables the Mali-G52 GPU on the SOQuartz CM4 module.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index 5bcd4be32964..6e99f049501c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -143,6 +143,11 @@ &gmac1m0_clkinout
 	status = "disabled";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.38.1

