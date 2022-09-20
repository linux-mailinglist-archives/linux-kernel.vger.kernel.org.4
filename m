Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88525BE70F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiITN1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiITN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BEE2E6AB;
        Tue, 20 Sep 2022 06:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51478629A6;
        Tue, 20 Sep 2022 13:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896EBC43142;
        Tue, 20 Sep 2022 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663680451;
        bh=j3AJ+gvrSPJXkwy4uwzUn+Y5wSHluaeR3mpbyFCwTGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzwC/fMpcZHK84uKl1WNEWXfZiWlnD4YDAVv6EFoTILb4768oyWqSVjTBD6QHuVK5
         xB/Q/fsYK5DxTNoJkfKSwBDNNiuwrFLB8YmCMXAVQtwWk9N20TNplX60AUapFg+ONQ
         ul6/vQRAB99CN2s6op8JgR0AxQNGhwNmbLqonH3JJluEZSZK97kDfRtuKdFPibwaKj
         06Boyk+oJ1B55V+WA/4GHIl9GKFWIXMgWD7FLE7RYAWlXQNRBDTLoEzO40zrYGAacS
         WVsGGLhnCPVzpwd0WDw+lxu+ZjAm5CrkMxsWaaFZAu5xS/rYcmpOg6tGrnvYb8ahii
         qDc2/z+ljCZkw==
Received: by pali.im (Postfix)
        id 08B1B2D7D; Tue, 20 Sep 2022 15:27:29 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] ARM: mvebu: add audio support to Armada 385 DB
Date:   Tue, 20 Sep 2022 15:26:46 +0200
Message-Id: <20220920132648.2008-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220920132648.2008-1-pali@kernel.org>
References: <20220920132648.2008-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>

This commit adds the necessary Device Tree information to enable
audio support on the Armada 385 DB platform. In details it:

 * Instantiates the CS42L51 audio codec on the I2C0 bus

 * Adds simple-card DT binding for audio on Armada 385 DB

 * Adds description for both analog I2S and S/PDIF I/O

 * Disabled by default

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Tested-by: Star_Automation <star@marvell.com>
Tested-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/boot/dts/armada-388-db.dts | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index 5130eccc32af..2bcec5419b66 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -36,6 +36,11 @@
 			i2c@11000 {
 				status = "okay";
 				clock-frequency = <100000>;
+				audio_codec: audio-codec@4a {
+					#sound-dai-cells = <0>;
+					compatible = "cirrus,cs42l51";
+					reg = <0x4a>;
+				};
 			};
 
 			i2c@11100 {
@@ -99,6 +104,12 @@
 				no-1-8-v;
 			};
 
+			audio-controller@e8000 {
+				pinctrl-0 = <&i2s_pins>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
 			usb3@f0000 {
 				status = "okay";
 			};
@@ -128,6 +139,64 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "Armada 385 DB Audio";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,widgets =
+			"Headphone", "Out Jack",
+			"Line", "In Jack";
+		simple-audio-card,routing =
+			"Out Jack", "HPL",
+			"Out Jack", "HPR",
+			"AIN1L", "In Jack",
+			"AIN1R", "In Jack";
+		status = "disabled";
+
+		simple-audio-card,dai-link@0 {
+			format = "i2s";
+			cpu {
+				sound-dai = <&audio_controller 0>;
+			};
+
+			codec {
+				sound-dai = <&audio_codec>;
+			};
+		};
+
+		simple-audio-card,dai-link@1 {
+			format = "i2s";
+			cpu {
+				sound-dai = <&audio_controller 1>;
+			};
+
+			codec {
+				sound-dai = <&spdif_out>;
+			};
+		};
+
+		simple-audio-card,dai-link@2 {
+			format = "i2s";
+			cpu {
+				sound-dai = <&audio_controller 1>;
+			};
+
+			codec {
+				sound-dai = <&spdif_in>;
+			};
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
+
+	spdif_in: spdif-in {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dir";
+	};
 };
 
 &spi0 {
-- 
2.20.1

