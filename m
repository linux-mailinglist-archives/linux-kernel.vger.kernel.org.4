Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B7F639F70
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiK1C3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiK1C3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:29:43 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269EAE0A6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 18:29:42 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.197.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7C1FC41EDF;
        Mon, 28 Nov 2022 02:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669602578;
        bh=KWB8E+5B5kOpEDikUKzA61AjtftG8lmxhbq5+kiKMUw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=t2DVMFGqCGUMIl/YWfJ91ivWXu2abd804y9e5cxBZar0Wko1MPWP8LnP4ob6f1b9y
         ex3Vba31lxK7gSjrkMHc6PzBPmbOLLNExHdikDhgcmY19TXoDoxKkjaAIQV9DWiWko
         CPnK6gweu48q3S53vX/V8walzkRWVudtc5jikptk08YqQgCoI0nbpIwTd0JdlSON4r
         kShWqHrIB+Dllc1FUvCir2PBCbs7o/6/sq7nw4ytxipIXndm2u0sD35Sxglhg06pKm
         68M22eVAGXx1d5SrlNFBrwCCy1L2PoBRkqIqv58umHLYQOvvXNxpb70REbgiERSeM9
         z4FdX650mJH6g==
From:   Andy Chi <andy.chi@canonical.com>
Cc:     Andy Chi <andy.chi@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Tim Crawford <tcrawford@system76.com>,
        Meng Tang <tangmeng@uniontech.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        Kailang Yang <kailang@realtek.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for a HP ProBook
Date:   Mon, 28 Nov 2022 10:28:47 +0800
Message-Id: <20221128022849.13759-1-andy.chi@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a HP ProBook which using ALC236 codec and need the
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make mute LED and
micmute LED work.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e5c036385666..cf7c825078dc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9354,6 +9354,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	 SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b5d, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8b5e, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.34.1

