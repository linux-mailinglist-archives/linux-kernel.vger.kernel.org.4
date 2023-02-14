Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839196957A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBND7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBND7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:59:04 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79095CDC6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:59:03 -0800 (PST)
Received: from andch-XPS-15-9520.. (118-163-61-247.hinet-ip.hinet.net [118.163.61.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 06ACA41FD7;
        Tue, 14 Feb 2023 03:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676347141;
        bh=xJrwXvOvxe8komFXsQJneyvX69+3l58+HMj2dD2umuw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=d5EIozJQTXvA3DTiIYR3JsW3zSDnxwHVfqQ2sDWIV2XH95YCcLd1djIQpHa04DSQj
         1AD9PSmKh3FV7ljziuzXYwAFVWUX/06S396uNSG/HfMny+RySpN80dvs+N5GxXZNdY
         dFZdXFZY7snBHDNyzZhDyd0EgOoUgDIrYq0HcfDWojYhtBGIZ/DtJ6tVESFWE0qIc/
         88a8Dafl6LsaqFJhWLkI6jYHDngH6J8LejPfA1ht0M5BRukF0AwdaKLUuCw7ahpng9
         heShRNCjIXBUlpvvSDt9s5bSW2ASBRKA8lALyvgGFF6FKcYHnqnUopTUYQ6TU6u38h
         tMo4lX+1fQVfA==
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
Subject: [PATCH 1/2] ALSA: hda/realtek: fix mute/micmute LEDs don't work for a HP platform.
Date:   Tue, 14 Feb 2023 11:58:51 +0800
Message-Id: <20230214035853.31217-1-andy.chi@canonical.com>
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

There is a HP platform needs ALC236_FIXUP_HP_GPIO_LED quirk to
make mic-mute/audio-mute working.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1134a493d225..7b9fb38ff732 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9436,6 +9436,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b5e, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b7a, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b7d, "HP", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b87, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8a, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8b, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8d, "HP", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.34.1

