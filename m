Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314395F37CD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJCVbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJCV37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:29:59 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19957113
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:24:34 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 068B52C055E;
        Mon,  3 Oct 2022 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1664832269;
        bh=sXKUcNWmbkNitj74uCkwwHI0mWKxvClLDL2BzNTjc7M=;
        h=From:To:Cc:Subject:Date:From;
        b=WmGuEyBjIenIi/zm0UBlH+hNlXRITvpP/U810M22ujrr3nFi75lZ3DZNV/jvsESl/
         h+2X6r+0qKLC4qFOnGDyQSyQrXlg/DeiTtr+9/IazxGTQxJyZJUalUe2ZMEoOtlGvM
         JYs4wLVpv8n7z3PpH81652gyPcBnB3mVwunO2+GlnXWUUWutHbY+4rkz3zJIMqiMqy
         N6t4xCnpA8tM5//Oaz6eOtIiyO0eoxAaDACcgE6cxrThwm6nzapTiWvRCn9cQxScty
         eK75HTXLKywqf1fpWqUlF46vEGHTgJdQkDCrXJhFs5XfXZNcf/SZKPbNwnnCfx4uJ4
         ziXfnUHWWaCaQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B633b530c0000>; Tue, 04 Oct 2022 10:24:28 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id D4A9C13EE52;
        Tue,  4 Oct 2022 10:24:28 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id CC9862A00A4; Tue,  4 Oct 2022 10:24:28 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] ARM: dts: armada-xp-98dx3236: add interrupts for watchdog
Date:   Tue,  4 Oct 2022 10:24:19 +1300
Message-Id: <20221003212419.1280860-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=UKij4xXy c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=Qawa6l4ZSaYA:10 a=TWcOaBxz1rIbdekP54sA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first interrupt is for the regular watchdog timeout. Normally the
RSTOUT line will trigger a reset before this interrupt fires but on
systems with a non-standard reset it may still trigger.

The second interrupt is for a timer1 which is used as a pre-timeout for
the watchdog.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dt=
s/armada-xp-98dx3236.dtsi
index 38a052a0312d..0e561dfc0ca9 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -286,6 +286,7 @@ &watchdog {
 	compatible =3D "marvell,armada-xp-wdt";
 	clocks =3D <&coreclk 2>, <&refclk>;
 	clock-names =3D "nbclk", "fixed";
+	interrupts =3D <93>, <38>;
 };
=20
 &cpurst {
--=20
2.37.3

