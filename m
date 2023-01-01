Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1D265A978
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 10:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjAAJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 04:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAAJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 04:21:27 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A92560CC;
        Sun,  1 Jan 2023 01:21:26 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso15411258wms.5;
        Sun, 01 Jan 2023 01:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pphMC7MPt/g+ZS1+ekkAwKQzB3YVITU74fxVYBxCRwI=;
        b=PJTVxJyPRDyyRREDT68dSenazqTuu/cTqUm0bT9B0RCMVj7co1DxRhw8Wp7FDPIqM6
         pCgsFKdGMb1K4IWruZTR6z2r2tzCA4rxKIqR0GkN0AxhlE7fZr6xY1xKfTr6dTnO4kmG
         C6BLTiEze/0srKdy6/6erKJwE8NLaeYPONW6pKZhsKOnn+EL10FtTlST2MUd+rMG/4Vb
         aUJlrHzT2ndPm33u+o/0TZFQS+RDeFD1rw+/mXtVimC0t2MgPNdYNbA26g+MKodzcbnN
         Ci6WeLcpI57Tz+CclLgWJnriGIJBuTAY75Q7dmGuUefe9nkkpI+2VTse0s1/3Vd34sXE
         HrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pphMC7MPt/g+ZS1+ekkAwKQzB3YVITU74fxVYBxCRwI=;
        b=PAEqk9praQHc1pxgxqdTGpYpqu9HPXTGhHNuzrihLJ7zmi1QRNlx61ujf2OUa4R6iI
         q24q557M8zv4MhMR6V+/M2ilnSakJ3cF67/rJmhBjfJSqitGcmYPzLKKqpmMEwCzT9oU
         tDasxKFxI8xaMi6nfVZ7Q44LtSWcv8jO+AKWsRYqGZWvFEQryLxBSHyT5AvtvHRRSO3H
         KX48ipntfIk04llF9EY/RspDf8DmaAUIJYq2qKI+j8yBmdbFN6Lt6USSuB6noBxvh5dF
         r/Jv32lM5ptCAx+UQKaSeY6uMqc7WYi/TQwZVvnHObsc4tT1viYTXL/9Z//m10EnXozn
         2/7Q==
X-Gm-Message-State: AFqh2krM+tOgko2fnv0dVXIFLeg42hfhodp5RU06ugO2QZdP2FuIHJer
        dkzeN4aURAxUFaRGalLB/+Y=
X-Google-Smtp-Source: AMrXdXsFVt6dcpq86gebin11qTsCBIgXeVIDK30AeeZpBtugm5hNMk8Da02UnTsgAdC9cU0r/pB1Nw==
X-Received: by 2002:a05:600c:1d89:b0:3d3:58cb:f6a6 with SMTP id p9-20020a05600c1d8900b003d358cbf6a6mr26191581wms.41.1672564884675;
        Sun, 01 Jan 2023 01:21:24 -0800 (PST)
Received: from mars.. ([2a02:168:6806:0:2624:83db:c4f6:846d])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c425100b003cffd3c3d6csm32763769wmm.12.2023.01.01.01.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 01:21:24 -0800 (PST)
From:   Klaus Kudielka <klaus.kudielka@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Klaus Kudielka <klaus.kudielka@gmail.com>
Subject: [PATCH 1/2] Revert "ARM: dts: armada-38x: Fix compatible string for gpios"
Date:   Sun,  1 Jan 2023 10:20:32 +0100
Message-Id: <20230101092033.45803-1-klaus.kudielka@gmail.com>
X-Mailer: git-send-email 2.39.0
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

This reverts commit c4de4667f15d04ef5920bacf41e514ec7d1ef03d.

On a Turris Omnia (Armada 385), GPIO interrupts ceased to work, ending
up in the DSA switch being non-functional.

The blamed commit seems to be incorrect in the first place, as the 2nd reg
property was not brought in line with the code. But even fixing that leaves
the GPIO interrupts broken on the Omnia.

Furthermore:
Commit 5f79c651e81e states armadaxp-gpio is broken in a non-trivial way.
Commit 988c8c0cd04d deprecates armadaxp-gpio for this reason.

Link: https://lore.kernel.org/r/f24474e70c1a4e9692bd596ef6d97ceda9511245.camel@gmail.com/
Fixes: c4de4667f15d ("ARM: dts: armada-38x: Fix compatible string for gpios")
Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 12933eff41..446861b6b1 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -304,7 +304,7 @@ spdif_pins: spdif-pins {
 			};
 
 			gpio0: gpio@18100 {
-				compatible = "marvell,armadaxp-gpio",
+				compatible = "marvell,armada-370-gpio",
 					     "marvell,orion-gpio";
 				reg = <0x18100 0x40>, <0x181c0 0x08>;
 				reg-names = "gpio", "pwm";
@@ -323,7 +323,7 @@ gpio0: gpio@18100 {
 			};
 
 			gpio1: gpio@18140 {
-				compatible = "marvell,armadaxp-gpio",
+				compatible = "marvell,armada-370-gpio",
 					     "marvell,orion-gpio";
 				reg = <0x18140 0x40>, <0x181c8 0x08>;
 				reg-names = "gpio", "pwm";
-- 
2.39.0

