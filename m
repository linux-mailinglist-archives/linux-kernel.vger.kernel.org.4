Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA861626A68
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiKLQEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiKLQEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:04:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DEA193DA;
        Sat, 12 Nov 2022 08:04:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so4957675wmb.0;
        Sat, 12 Nov 2022 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vGKGpKWDMzYcbAUuUDkHFy/CbDqDYWCKkXDWqHYnr4=;
        b=IYzQLachq1UeQWjOp9MP41sPq/3P3dn1wJO8S2uJtaVvKsv+P2kyhjojqOJFWDXvgV
         BtcfWQHgRiEWQqayeE55fqM5mnUqNHMrUr+CRVvyWDJPK3maDec7v6B8At7M/7/Mx395
         giiE9mU2YfW1ZRCVpnpM8qyxTWzQucIluHA1L6UuLy8vxda1s3BSCYCcwD3yQPgiyYaQ
         E7s0he/Uoxs8RRQylD/qEVbKqXW5DnzxTN8cjLNWoTtP5QnwQpaUI5lsgI12vN+Bev08
         y8+pvPVRH2xOLTMJZ6ErHdQSW+SBYNhoN8gf8Gas+3JtCdBnvuuH10ky7wza2iZjsAfP
         KhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vGKGpKWDMzYcbAUuUDkHFy/CbDqDYWCKkXDWqHYnr4=;
        b=ABTkLMg1AFnc9nBDBjgW0Bib+anC8QGmEklmvbhP8HUwSeT1oOzZl1vFE0g6MaztJD
         86oqQbi4X3+XaR2864ygEtqqT8l0qqCPP6RBEhNQspKSSXd/YW8vj7MaTwPrdbZbaCQw
         tmSoPoDepD2lmuGxOq0qKso3pJRIO4FfZOrMdeCrfuTYb6BwhsyI25IM2ye1ARfuJlCn
         idC8Ow5PqJvjtPVdh7FuP28J2DC/GtfwbrvyXYLz5nwm2GZTHFVC0y8Q8SvI5ultoOmp
         f3UQTjWzKqSRLx148bnDGxd76MaXKIbqUJEMZ4qsOmcOEHpuw+SwRE43Hda6wfK3sikA
         D0Pw==
X-Gm-Message-State: ANoB5pltIPlqqcPoEHE7RQoawGKa54Gm7inTbWtgY9MkJnyH5by27gAz
        MfNHmkea7sUiXzgOSJvNA2k=
X-Google-Smtp-Source: AA0mqf7jKhJFAniMUxTPxswRa0WCU2lg7yLrMCY5yBd8xY2Xj5I1NFyoKqV/c20KSClTFveEa7svBQ==
X-Received: by 2002:a7b:c003:0:b0:3b4:abda:8b54 with SMTP id c3-20020a7bc003000000b003b4abda8b54mr4290977wmb.82.1668269067876;
        Sat, 12 Nov 2022 08:04:27 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003cf87623c16sm14605752wmb.4.2022.11.12.08.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 08:04:26 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] arm64: dts: rockchip: Enable GPU on SOQuartz CM4
Date:   Sat, 12 Nov 2022 17:03:58 +0100
Message-Id: <20221112160404.70868-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
References: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
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

