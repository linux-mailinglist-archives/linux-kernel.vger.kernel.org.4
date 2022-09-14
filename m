Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E726C5B8B82
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiINPNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiINPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:12:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A566E79A49;
        Wed, 14 Sep 2022 08:12:35 -0700 (PDT)
Received: from dimapc.. (109-252-122-187.nat.spd-mgts.ru [109.252.122.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F2E056601D89;
        Wed, 14 Sep 2022 16:12:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663168353;
        bh=ydjcQ1QOFS4WSgFT533j3Ns+CFkrINqmO/sGexuEFqg=;
        h=From:To:Cc:Subject:Date:From;
        b=Mx2EmglggWsdosfaVzyUtCqlosAam1q3Gq4svO37Op5pjDeyYwEDmhVtmVx/7cuSJ
         13oO3Hf7QXSKUvt3W5erP3NrKdF4k2E3VOtWHo7B/GlLe2d/J8IyfmXnmGvAIP3qtA
         nVq3nBzfZUDUshJW7Cp67Th75nIGt3frnLX4mnQls93RV7ti4L6/EnieZGdJyYLP2M
         0AcJ9i0SHY195qfrFLmCpCSV5reMg/cSYC/JQiFH6coRAjjQa7r9NlLLddWQpQC5yj
         XISb0U2l0LIEvoLer2JNrgXmejoeSkHacqL3pVrrmJAHKpPHRnUzEgBOoJ2PpmA0t6
         bjO/ku+XNqpLw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1] ARM: dts: sun8i: h3: orangepi-pc: Add CMA reserved memory node
Date:   Wed, 14 Sep 2022 18:11:25 +0300
Message-Id: <20220914151125.212876-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 256MB CMA node to the Orange Pi PC board. This fixes memory allocation
failures for Cedrus video decoder on trying to play a 1080p video with
gstreamer.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index b96e015f54ee..e655346a9fb4 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -60,6 +60,20 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma@40000000 {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0x40000000 0x40000000>;
+			size = <0x10000000>; /* 256MiB */
+			linux,cma-default;
+			reusable;
+		};
+	};
+
 	connector {
 		compatible = "hdmi-connector";
 		type = "a";
-- 
2.37.3

