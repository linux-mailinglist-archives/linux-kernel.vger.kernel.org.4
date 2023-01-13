Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB60866A4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjAMVMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAMVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:12:10 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884244D4B3;
        Fri, 13 Jan 2023 13:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6wh/LvHiAV+cBnCS2OWc1a/uyl4L/FHgVxOEFcPbsNs=; b=+QCUBDwNzM+PirmCEw8yQTQJhi
        IEe2NVdTM+cA4w+1TeqBoy9kD7/3p7bi7e+11uMHQu/m7ns0cqUmz5VosWZ1f+T0EMoog0sh+/0KJ
        CFCD/QchLgm+UTUi7KbYFAVvXb6a2IY6/60/KByuXYz/qjJKj2cWq0wYCYsqUGAK2JuT7KfmYTht1
        GfD1TOPpusSlgBSnlN2kw+qEzRivkyfVtBIO7MHRyyiJSVTdyvYBc4APt/iYrOZ3hMyHxL7ILB1v4
        cwSXgPkkkhNEqc+LsYiiCS8OcE0viplmn7GTEeVCxKiFGxSTIWSr+YnPvu63A3DPWhJlATjwU+9cJ
        EZ9qAiiw==;
Received: from p200300ccff089e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:9e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pGRLD-0005C3-4A; Fri, 13 Jan 2023 22:11:59 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pGRLC-009iDU-JV; Fri, 13 Jan 2023 22:11:58 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, aford173@gmail.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: gta04: fix excess dma channel usage
Date:   Fri, 13 Jan 2023 22:11:51 +0100
Message-Id: <20230113211151.2314874-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

OMAP processors support 32 channels but there is no check or
inspect this except booting a device and looking at dmesg reports
of not available channels.

Recently some more subsystems with DMA (aes1+2) were added filling
the list of dma channels beyond the limit of 32 (even if other
parameters indicate 96 or 128 channels). This leads to random
subsystem failures i(e.g. mcbsp for audio) after boot or boot
messages that DMA can not be initialized.

Another symptom is that

/sys/kernel/debug/dmaengine/summary

has 32 entries and does not show all required channels.

Fix by disabling unused (on the GTA04 hardware) mcspi1...4.
Each SPI channel allocates 4 DMA channels rapidly filling
the available ones.

Disabling unused SPI modules on the OMAP3 SoC may also save
some energy (has not been checked).

Fixes: c312f066314e ("ARM: dts: omap3: Migrate AES from hwmods to sysc-omap2")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
[re-enabled aes2, improved commit subject line]
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 87e0ab1bbe95..e0be0fb23f80 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -612,6 +612,22 @@ &i2c3 {
 	clock-frequency = <100000>;
 };
 
+&mcspi1 {
+	status = "disabled";
+};
+
+&mcspi2 {
+	status = "disabled";
+};
+
+&mcspi3 {
+	status = "disabled";
+};
+
+&mcspi4 {
+	status = "disabled";
+};
+
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;
-- 
2.30.2

