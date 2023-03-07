Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D5D6AE16F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCGNyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjCGNyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:54:15 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5B05597
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:54:11 -0800 (PST)
Received: from localhost (36-226-179-130.dynamic-ip.hinet.net [36.226.179.130])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DCFDF3F0E1;
        Tue,  7 Mar 2023 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678197249;
        bh=xPBz9N8CBbExdFLBr+cIY26Ubw3p0nhKguR8fCGx6Bo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=sxPyZqxYpvT5V/SvqJs4re/xSBdUyBZjgTlqgWOX+6X3VjN7EUHd3OI4AuJGcAel8
         yzoxJdYCcnW+QyCJtr2ekZr0NNc33/vq1WtGHTdNvcJaSqjJBxYQsgUy4kvPmSt9uz
         RMxYOikwxBm1oyVUUcpGz+oUnDemv2dq7cD1i749VKUr6FlfHmIIP/wQfqEhd4Utoa
         flJwo8L3PACFbYZwaOV3Lnv4CtWTg6bXWve17VCc9l6ElotDfNAWS8rprTR55DPDtc
         LEVXqkW57kpE/2V21BJnd+eSKOWG7Be2MuZzr4XNr184cE6xywcM9In5vAXjvusogD
         7HCqhyWxg7oZQ==
From:   Jeremy Szu <jeremy.szu@canonical.com>
To:     tiwai@suse.com
Cc:     Jeremy Szu <jeremy.szu@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Tim Crawford <tcrawford@system76.com>,
        Andy Chi <andy.chi@canonical.com>,
        Meng Tang <tangmeng@uniontech.com>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        =?UTF-8?q?Kacper=20Michaj=C5=82ow?= <kasper93@gmail.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: fix speaker, mute/micmute LEDs not work on a HP platform
Date:   Tue,  7 Mar 2023 21:53:16 +0800
Message-Id: <20230307135317.37621-1-jeremy.szu@canonical.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a HP platform needs ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED quirk to
make mic-mute/audio-mute/speaker working.

Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3c629f4ae080..5d530b489c48 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9447,6 +9447,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b8a, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8b, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8d, "HP", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b8f, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b92, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8bf0, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
-- 
2.38.1

