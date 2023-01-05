Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9308D65E4C2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjAEEnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjAEEml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:42:41 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2BD186D1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 20:42:39 -0800 (PST)
Received: from localhost (36-226-179-107.dynamic-ip.hinet.net [36.226.179.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7F4C743586;
        Thu,  5 Jan 2023 04:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1672893757;
        bh=tuX7FpbuFjmLFyhbHFuS7lFvYiGSSpdrXN3U+7iok5A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=SPCZg9iCFDGxIP6lBzZS5J5+xaHIooUiz07XlAAaURlticpeCnSKFFneKLcvlTHer
         ZGt33Kpkv2mRJ/xQjjotseVkjGl/6Mh7s2qGiaUU32pxOGdtFdAy8N0FOCRXhfmfYg
         OWW5QINQN9YrJ1R2q6xOjUSeFwuFUeJQWqsniamfRL36fmbgh1JqekENLQj7u9yLE5
         yu3jR83/J9vMKfkbB3afaW+wVzvXn2XgCGZ+WAURG9nFuX8JJOxhrGU0eOtq0BzTkZ
         f0M5p7uV4XzG4UtAJVc3bYUyLqDXXoeOfyZS81Lwh19bDMMZDPN/VZ4NTuQ6jUw4Zf
         iAdKql2lZ5Gtg==
From:   Jeremy Szu <jeremy.szu@canonical.com>
To:     tiwai@suse.com
Cc:     Jeremy Szu <jeremy.szu@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Tim Crawford <tcrawford@system76.com>,
        Meng Tang <tangmeng@uniontech.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        =?UTF-8?q?Kacper=20Michaj=C5=82ow?= <kasper93@gmail.com>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs don't work for a HP platform
Date:   Thu,  5 Jan 2023 12:41:53 +0800
Message-Id: <20230105044154.8242-1-jeremy.szu@canonical.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a HP platform uses ALC236 codec which using GPIO2 to control
mute LED and GPIO1 to control micmute LED.
Thus, add a quirk to make them work.

Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index eda4914b8aeb..8362eb4642d8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9409,6 +9409,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b5d, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b5e, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8bf0, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.38.1

