Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C27F6957A4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjBND7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjBND7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:59:09 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C0D16336
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:59:08 -0800 (PST)
Received: from andch-XPS-15-9520.. (118-163-61-247.hinet-ip.hinet.net [118.163.61.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C91F041FDA;
        Tue, 14 Feb 2023 03:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676347146;
        bh=1XieuJDvVh/qHz7SDSlKiMy2zNt+9X4WxUsZwQNf5Tk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MKi4o3RCFf/qbEKWM4BjbXApAlzeeiTS8Y2PWgth7CT9TfOY5Zs48rE+FDDF6MwLl
         9j4yMEQmgDSJ9XVfq0Uy61aHHjUaZI0HnkuZIeBbVUb87TmIZ5y1aLYPheWiu5vJmf
         axp+ykMldCvi1VBXOa6impjvAuUOnLlZuFYsueuJ8BQsPk67u/QzNEO513JoQHVGxp
         dT8gbt7vg0UwaFUgTbZIHz9NDY1XPi/tvqVimfd5PEojOcvNC5bd3zJWZUKs9+BIul
         2yvnmGea6lklGHOSIL1DyKKRFSL39NdVhifCF8vd4MlnZSo5EUg811Ln9dHFD/3ZuB
         EjI5K5WFoHkzQ==
From:   Andy Chi <andy.chi@canonical.com>
Cc:     andy.chi@canonical.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tim Crawford <tcrawford@system76.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Meng Tang <tangmeng@uniontech.com>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        =?UTF-8?q?Kacper=20Michaj=C5=82ow?= <kasper93@gmail.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ALSA: hda/realtek: Enable mute/micmute LEDs support for HP Laptops
Date:   Tue, 14 Feb 2023 11:58:52 +0800
Message-Id: <20230214035853.31217-2-andy.chi@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214035853.31217-1-andy.chi@canonical.com>
References: <20230214035853.31217-1-andy.chi@canonical.com>
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

On HP Laptops, requires the same ALC285_FIXUP_HP_GPIO_LED quirk to
make its audio LEDs work.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7b9fb38ff732..e2cd5456f2a6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9432,6 +9432,12 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	 SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b42, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b43, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b44, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b45, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b46, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b47, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b5d, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b5e, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b7a, "HP", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.34.1

