Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4203660F97
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjAGOna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjAGOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:43:26 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E5A58FAB;
        Sat,  7 Jan 2023 06:43:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so5081662wml.0;
        Sat, 07 Jan 2023 06:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i3d+gOAD88oLabVtrIfzPXu7o2OZ8RNw65o7EHr8oIk=;
        b=PBWCnhEA0udMeH0tYHbUBalF84o9wZ5bM+etdc+3pGDNTYq5mI+4ECgwElxr7EHe4S
         cSY4QWGUJwJRUE/vuoEq9NEFfUqp6bIIu5bvwbPiOl+GCoDq6zuM7VQy1bRIiCzeqpSF
         1szcdZgeInDIZMHVAYx3TQQv5vzcunM7SUjDbRc3SPPk2rAuYi4Dan0TXRPhcQYMac3Z
         z9dNnfVqRhxYal6wXMGjGokXlGDHWYFcv6bLlH+BFVGASL91bEfeuF7zVaUUQ/wcfAwV
         wAAi2nuCQCTpUqWJFDr9Uhz4pyX4UU63xUuzZlDhaPV2Uu2jTTnV4ZUJGtD0ANVwIif+
         7Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3d+gOAD88oLabVtrIfzPXu7o2OZ8RNw65o7EHr8oIk=;
        b=ZuSKoezdMZ7bEgejKlKZvkAV8oKP80lErPLEcj5HniKNnq9GnvXrdDScU/HVI3RINH
         dliXBc0F/qI7dpsIEB6vyoIucnDtUBHKU1+ILcn/HVPi+xWPjglPrjsgeDyVaxRtDX9M
         lX802nme6Thf/2IYiHQi4gQ6PQ6q/g4ln/hZE9IBzdbCDcqcACbO/2ER6CV3syvN5bDI
         GpxQ+XGY0Rmrns9Uhdk8xD9bSPb2noRADI+yWF2it2mEiGh3LmxDWjthXAF1931bonfH
         l4OqaE4C+TQNmv/pHy+IyY4+q4irUHg3ZSrCy1vmWyrB2DAd5lvwH3CvuWoB/8MA+/+r
         Cykg==
X-Gm-Message-State: AFqh2kq4go7exAzAJK5lzYIiZR+Aor4LqDrIPlBPrwjeeQ448aui7lz8
        O7MxcLIMjE2tm534ageI+Xg=
X-Google-Smtp-Source: AMrXdXtjuk2eHtVbZ1/GbAcJYWTE31oco3Z7HMqTj3sRkYbZPzE34OyKpSR6LybAX/MszgSNQ7h53Q==
X-Received: by 2002:a1c:7410:0:b0:3cf:8957:806e with SMTP id p16-20020a1c7410000000b003cf8957806emr42935386wmc.5.1673102603226;
        Sat, 07 Jan 2023 06:43:23 -0800 (PST)
Received: from mars.. ([2a02:168:6806:0:40f6:41b6:8914:e80b])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003d9a86a13bfsm6056106wmq.28.2023.01.07.06.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 06:43:22 -0800 (PST)
From:   Klaus Kudielka <klaus.kudielka@gmail.com>
To:     "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Klaus Kudielka <klaus.kudielka@gmail.com>
Subject: [PATCH v2 1/2] Revert "ARM: dts: armada-38x: Fix compatible string for gpios"
Date:   Sat,  7 Jan 2023 15:41:48 +0100
Message-Id: <20230107144149.5743-1-klaus.kudielka@gmail.com>
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

This reverts commit c4de4667f15d04ef5920bacf41e514ec7d1ef03d, which causes
a regression on Turris Omnia (Armada 385): GPIO interrupts cease to work,
ending up in the DSA switch being non-functional.

The blamed commit is incorrect in the first place:
If compatible = "marvell,armadaxp-gpio", the second (address, size) pair
of the reg property must to point to the per-CPU interrupt registers
<0x18800 0x30> / <0x18840 0x30>, and not to the blink enable registers
<0x181c0 0x08> / <0x181c8 0x08>.

But even fixing that leaves the GPIO interrupts broken on the Omnia.

Furthermore:
Commit 5f79c651e81e explains very well, why the gpio-mvebu driver does not
work reliably with per-CPU interrupts.
Commit 988c8c0cd04d deprecates compatible = marvell,armadaxp-gpio for this
reason.

Fixes: c4de4667f15d ("ARM: dts: armada-38x: Fix compatible string for gpios")
Reported-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Link: https://lore.kernel.org/r/f24474e70c1a4e9692bd596ef6d97ceda9511245.camel@gmail.com/

Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
---
v1->v2: Be more explicit about the regression, and about the reg property.

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

