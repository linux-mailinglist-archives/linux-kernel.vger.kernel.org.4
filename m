Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E772742CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjF2TCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjF2TBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFC730DF;
        Thu, 29 Jun 2023 12:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D8D615FD;
        Thu, 29 Jun 2023 19:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE73C433CD;
        Thu, 29 Jun 2023 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065281;
        bh=y9x06U1tVv44gNduxq6fUF2ydIzmA1HJ9n4cFuX6o94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hT0i0oUO3GoRSNLBQOLcb9uT0eSq6SOdAfa6RdEPhNeQyo04IHANlsEjR26n0n7Ut
         z39bk0MQBPFXpMyg5FsEKg+3B2lj/3pI0uSajeVgGBzxyXUPy/Ld1LE8rMjHUSUnmV
         nVJ9yY15nqheNtIcZsv9q9ccEnIVxuQSebnuDsCbPGPOuMH4EmlmGF4juvJwvuI3TI
         fWP5Gb85W4AnjWDPGfayjQ9Wi2iMbvB7nVz+B0MGPnOZPvVlZJLZ9bp/kl3Kw4bVHt
         SSl3y565mKIf8zMYQ7kzX6RlPAgragy+9G+D5yl4BvYQQkoFr79DC8BUOo7SG2d7Mq
         az0CXo9+6vinQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Luke D. Jones" <luke@ljones.dev>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, perex@perex.cz,
        tiwai@suse.com, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tcrawford@system76.com,
        tangmeng@uniontech.com, p.jungkamp@gmx.net, kasper93@gmail.com,
        yangyuchi66@gmail.com, yangyingliang@huawei.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 10/17] ALSA: hda/realtek: Add quirk for ASUS ROG G634Z
Date:   Thu, 29 Jun 2023 15:00:39 -0400
Message-Id: <20230629190049.907558-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190049.907558-1-sashal@kernel.org>
References: <20230629190049.907558-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
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

[ Upstream commit 555434fd5c6b3589d9511ab6e88faf50346e19da ]

Adds the required quirk to enable the Cirrus amp and correct pins
on the ASUS ROG G634Z series.

While this works if the related _DSD properties are made available, these
aren't included in the ACPI of these laptops (yet).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Link: https://lore.kernel.org/r/20230619060320.1336455-1-luke@ljones.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 920e44ba998a5..3889701bdb1c9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9552,6 +9552,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
+	SND_PCI_QUIRK(0x1043, 0x1caf, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
-- 
2.39.2

