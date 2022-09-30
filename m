Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C705F0BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiI3Mj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiI3MjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD4CBF1D9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59DAB6232B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842DAC433D6;
        Fri, 30 Sep 2022 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664541560;
        bh=tEozaHb1EwOmstcpCIwRRiZp1C/9JrsLwcpTdb1k3X8=;
        h=From:To:Cc:Subject:Date:From;
        b=T0EDgfQgvmYBLSv9OrSpIhvmkwN+cWf/8vnijeB9huu7k23C/E2npmMu5p0yqlJDv
         7zbLhr/LsNqRWQTGiwiffhTTay64/BnX5D1QgpKMUiSP7mt/IzNqs+lVptZ6UsS/rq
         pBl4lccFcMZgFH/egtOFkxwL49p2szeq16mQDZlkNc1JoF1DzOs2CKvZbhOuF67Ubw
         nXkFFnDSlEjsNwbgxxRZYe4LyTtxxzPtprtEsNi4iBkZFym/8D/0FKhQHEBODt0pGS
         b2oATA/+7srrbyvYnUbW811ftd0J/tq8c14dH2PZzPlUJbga04YvjcaniyUtW7wEMF
         K+eYli43Ks7DA==
Received: by pali.im (Postfix)
        id A685D93F; Fri, 30 Sep 2022 14:39:17 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Josef Schlehofer <josef.schlehofer@nic.cz>
Subject: [PATCH] powerpc: dts: turris1x.dts: Add channel labels for temperature sensor
Date:   Fri, 30 Sep 2022 14:39:01 +0200
Message-Id: <20220930123901.10251-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Channel 0 of SA56004ED chip refers to internal SA56004ED chip sensor (chip
itself is located on the board) and channel 1 of SA56004ED chip refers to
external sensor which is connected to temperature diode of the P2020 CPU.

Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
With this change userspace 'sensors' applications prints labels:

    $ sensors
    sa56004-i2c-0-4c
    Adapter: MPC adapter (i2c@3000)
    board:        +34.2°C  (low  =  +0.0°C, high = +70.0°C)
                           (crit = +85.0°C, hyst = +75.0°C)
    cpu:          +58.9°C  (low  =  +0.0°C, high = +70.0°C)
                           (crit = +85.0°C, hyst = +75.0°C)

And without this change it prints just generic tempX names:

    $ sensors
    sa56004-i2c-0-4c
    Adapter: MPC adapter (i2c@3000)
    temp1:        +43.0°C  (low  =  +0.0°C, high = +70.0°C)
                           (crit = +85.0°C, hyst = +75.0°C)
    temp2:        +63.4°C  (low  =  +0.0°C, high = +70.0°C)
                           (crit = +85.0°C, hyst = +75.0°C)
---
 arch/powerpc/boot/dts/turris1x.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index 4033c554b06a..5b5278c32e43 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -69,6 +69,20 @@
 				interrupt-parent = <&gpio>;
 				interrupts = <12 IRQ_TYPE_LEVEL_LOW>, /* GPIO12 - ALERT pin */
 					     <13 IRQ_TYPE_LEVEL_LOW>; /* GPIO13 - CRIT pin */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* Local temperature sensor (SA56004ED internal) */
+				channel@0 {
+					reg = <0>;
+					label = "board";
+				};
+
+				/* Remote temperature sensor (D+/D- connected to P2020 CPU Temperature Diode) */
+				channel@1 {
+					reg = <1>;
+					label = "cpu";
+				};
 			};
 
 			/* DDR3 SPD/EEPROM */
-- 
2.20.1

