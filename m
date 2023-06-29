Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40CE742D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjF2TGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjF2TDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B525D3C15;
        Thu, 29 Jun 2023 12:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5EAD61601;
        Thu, 29 Jun 2023 19:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856C6C433AB;
        Thu, 29 Jun 2023 19:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065315;
        bh=lXAIcOYJ04rYnjX1H6sNHonDK/FOgyHGfIdz8ibt4dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5kTwmBC+Kka84XwhYog5FoWO1QKuoixZBynw9VE8VaYowv6d/D0AjKKA4YNLVs41
         L/CAh833EPaRQYWqIQmy18iGbsY/nBnHeaE2ru9FB3U7gt1OlvLJW7PAmVcxUDnEFZ
         wFRJ9HOqxJ1d6TPQfqT3Y4hSYsnPHzrvszOCMfZFCLNh01E4F7rqR9syZRYGcNXNdc
         kQ2fULasF1d4Av/VOrkKp14g+JplvS7WPF5WcLaiPoiF9PLN6mW00NT6LCgSgcorG+
         YqJpNGYRAYsEznXZsaH7Fa8woVIqHtuBCNrpi3O6NO1XMTOQzKjBfkUE4OPcPE3AOU
         gkD/OLQZRudaw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Luke D. Jones" <luke@ljones.dev>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, perex@perex.cz,
        tiwai@suse.com, sbinding@opensource.cirrus.com,
        tangmeng@uniontech.com, andy.chi@canonical.com, p.jungkamp@gmx.net,
        kasper93@gmail.com, yangyuchi66@gmail.com,
        yangyingliang@huawei.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 11/12] ALSA: hda/realtek: Add quirk for ASUS ROG GV601V
Date:   Thu, 29 Jun 2023 15:01:31 -0400
Message-Id: <20230629190134.907949-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190134.907949-1-sashal@kernel.org>
References: <20230629190134.907949-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Luke D. Jones" <luke@ljones.dev>

[ Upstream commit 82edd1bd7f98567928871e2a2a317724d35f0085 ]

Adds the required quirk to enable the Cirrus amp and correct pins
on the ASUS ROG GV601V series.

While this works if the related _DSD properties are made available, these
aren't included in the ACPI of these laptops (yet).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Link: https://lore.kernel.org/r/20230621085715.5382-1-luke@ljones.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3889701bdb1c9..0547f60a400e7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9527,6 +9527,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1473, "ASUS GU604V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1483, "ASUS GU603V", ALC285_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.39.2

