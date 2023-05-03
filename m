Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22B86F5D46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjECRuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjECRux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:50:53 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9555B5FDF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:50:52 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-760ec550833so401562139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683136252; x=1685728252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e7jQbQ2eUTO2h8zVdPJiBBhsIPjfggv9KTykUBwVf3E=;
        b=PvJUTiSE4ubhTBNHRTvDZ1sQJrHSex7/Rv5FqXOcaZgEiKnIN2tTkcvwQDq8BEW1Z3
         mp9w/+C3AwBdcUd7nG7XWC89X2+2L3Xz4xkPGUMUM09GB7c9Y5GthL9kQ7/MumK+Avfv
         +FzMDj4bK335vNFiDX1YVcdyf7BygKm1h0ft2vbotTvYbUIY1vkKY2YVejU3sNN1HjNT
         3vgPs2QfEytKA0rIp4Gpq50rWNJ8IAWCTKTr+U9pz/8ZZfP+nneSpVruSJTNU5YkvIGt
         2oQIeLpISD/znVO7R3cKuhdZJbtzCMcO/qPUP+wd5glBvcPzYvaQHN48jzo8V026CIbR
         hC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683136252; x=1685728252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7jQbQ2eUTO2h8zVdPJiBBhsIPjfggv9KTykUBwVf3E=;
        b=JEtKQykZ/mpg0NBVA4nyPJ3QobmXWVwu8IJAuZjQsMq0TEiIaDCsTnvSgN+Ie2Whzy
         jm+d8iCDnTEjvb7nJaDM9o1FTAxuRUdKSiTW+kjaMTbZzyEnhNknyHqnrQHBJbBbceKK
         Fw9vqfs1XBPD/W04hhJ5K3o2ulRkg0ffGCmiafPrbIfFHmfPhDlnFxTqdM4tmfjT7HQc
         jbR7D84Q6a9LMBIcJoiAyNQy9k/0B54QLuk2wwSpQkH3hZDmn00m9CfTJgtalaMDKC8q
         5KQ2k9z3o4J/zJIrcBGR4aCuQmX3p5DASxursicUC+PNNh5yFJ7P8VBWJAiyofx266Pg
         jYzQ==
X-Gm-Message-State: AC+VfDwfCJFZVTP27743/rErE0K09FUR9glzzLKxTgiT6ZS2wuceoZ0t
        i2lXFwqY8TleJIT03QB3QUQl5BH5HjkCt23Q
X-Google-Smtp-Source: ACHHUZ6ZiYm0NH798Vu2b6Lk/aAPFkYw/kDOndjNfYsHuM6BNYcu9QekT2opB6GKQzar16ekqEDqDA==
X-Received: by 2002:a92:c946:0:b0:331:5284:d6b3 with SMTP id i6-20020a92c946000000b003315284d6b3mr2820906ilq.7.1683136251904;
        Wed, 03 May 2023 10:50:51 -0700 (PDT)
Received: from mrcarrot-aero13.rtr.local (fw.rtr.mntm.org. [66.172.165.2])
        by smtp.gmail.com with ESMTPSA id h4-20020a92c084000000b003261b6acc8asm667139ile.79.2023.05.03.10.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 10:50:51 -0700 (PDT)
From:   Caleb Harper <calebharp2005@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Caleb Harper <calebharp2005@gmail.com>
Subject: [PATCH] alsa: support HP Pavilion Aero 13-be0xxx Mute LED
Date:   Wed,  3 May 2023 12:50:26 -0500
Message-Id: <20230503175026.6796-1-calebharp2005@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the mute LED on the HP Pavilion Aero Laptop
13-be0xxx. The current behavior is that the LED does not turn on at any
time and does not indicate to the user whether the sound is muted.

The solution is to add a PCI quirk to properly recognize and support the
LED on this device.

This change has been tested on the device in question using modified
versions of kernels 6.0.7-6.2.12 on Arch Linux.

Signed-off-by: Caleb Harper <calebharp2005@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f70d6a33421d..aeffe6bd8b98 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9428,6 +9428,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x8919, "HP Pavilion Aero Laptop 13-be0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x896d, "HP ZBook Firefly 16 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x896e, "HP EliteBook x360 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8971, "HP EliteBook 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
-- 
2.40.1

