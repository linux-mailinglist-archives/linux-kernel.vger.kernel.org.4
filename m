Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C797645B66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiLGNvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLGNu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:50:26 -0500
Received: from mail.edward-p.xyz (mail.edward-p.xyz [103.150.8.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBDA5B842
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:50:25 -0800 (PST)
DKIM-Signature: a=rsa-sha256; bh=6jsHNyzS4Eh+VmABET0Qlk1NGmAhNmu3M916IuPxh1I=;
 c=relaxed/relaxed; d=edward-p.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@edward-p.xyz; s=default; t=1670420054; v=1; x=1670852054;
 b=Z18MGrQQd2OrZuAR4SP11U5vVwOURqrKa9kQbWwthiGuk1dNmmPt/NGVWLagdoLTtDq9IcHC
 wqCqW9uoUhUf6UKNtYyxkAGIUxMTAjw6LmT6bKJiRUG3ymHWzhDG7Ux48YJvXKwYJwffsinYJxU
 8fOCpWluawwBrk1K4GTYB+aeyI/EbgFCeM3m1v+MisJAIzGvrmCjQVjif2+HDbPJZCQOGNCH7Kz
 LZw3+N1vBx+D6i6PE9qfyvEFbOc/8mF6OT0h6FebwJn9I6jriNFlsv7r5hVHLGZb7id/rx7nAIb
 RItYiy/EmLN/BEZst6A7QYZ09EuiYIf98d9v2qVsopbgw==
Received: by mail.edward-p.xyz (envelope-sender <edward@edward-p.xyz>) with
 ESMTPS id a8bf764e; Wed, 07 Dec 2022 21:34:14 +0800
From:   Edward Pacman <edward@edward-p.xyz>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, edward@edward-p.xyz,
        kai.heng.feng@canonical.com, kailang@realtek.com,
        linux-kernel@vger.kernel.org, p.jungkamp@gmx.net, perex@perex.cz,
        sbinding@opensource.cirrus.com, tangmeng@uniontech.com,
        tanureal@opensource.cirrus.com, tcrawford@system76.com,
        tiwai@suse.com
Subject: [PATCH v1] ALSA: hda/realtek: Add quirk for Lenovo TianYi510Pro-14IOB
Date:   Wed,  7 Dec 2022 21:32:18 +0800
Message-Id: <20221207133218.18989-1-edward@edward-p.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <87edtb8ksb.wl-tiwai@suse.de>
References: <87edtb8ksb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_SOFTFAIL,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo TianYi510Pro-14IOB (17aa:3742)
require quirk for enabling headset-mic

Signed-off-by: Edward Pacman <edward@edward-p.xyz>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216756
---
 sound/pci/hda/patch_realtek.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e5c036385666..a2e1bdc06468 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10960,6 +10960,17 @@ static void alc897_fixup_lenovo_headset_mic(struct hda_codec *codec,
 	}
 }
 
+static void alc897_fixup_lenovo_headset_mode(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+		spec->gen.hp_automute_hook = alc897_hp_automute_hook;
+	}
+}
+
 static const struct coef_fw alc668_coefs[] = {
 	WRITE_COEF(0x01, 0xbebe), WRITE_COEF(0x02, 0xaaaa), WRITE_COEF(0x03,    0x0),
 	WRITE_COEF(0x04, 0x0180), WRITE_COEF(0x06,    0x0), WRITE_COEF(0x07, 0x0f80),
@@ -11043,6 +11054,8 @@ enum {
 	ALC897_FIXUP_LENOVO_HEADSET_MIC,
 	ALC897_FIXUP_HEADSET_MIC_PIN,
 	ALC897_FIXUP_HP_HSMIC_VERB,
+	ALC897_FIXUP_LENOVO_HEADSET_MODE,
+	ALC897_FIXUP_HEADSET_MIC_PIN2,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -11469,6 +11482,19 @@ static const struct hda_fixup alc662_fixups[] = {
 			{ }
 		},
 	},
+	[ALC897_FIXUP_LENOVO_HEADSET_MODE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc897_fixup_lenovo_headset_mode,
+	},
+	[ALC897_FIXUP_HEADSET_MIC_PIN2] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x01a11140 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC897_FIXUP_LENOVO_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -11521,6 +11547,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32f7, "Lenovo ThinkCentre M90", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3742, "Lenovo TianYi510Pro-14IOB", ALC897_FIXUP_HEADSET_MIC_PIN2),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x1849, 0x5892, "ASRock B150M", ALC892_FIXUP_ASROCK_MOBO),
-- 
2.38.1

