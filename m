Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2612C5BBF0C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 19:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIRRNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 13:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRRNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 13:13:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D2560D6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:13:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c11so43664602wrp.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bdLlsx0qQ1Tq/c9TtyrU7bglWcYLVdx93s3ZyR2mNek=;
        b=PXZoODrWWaLFGLzul2SpL4FoFQqldoksZAr/vJFof7HuQIzgKUUdKLt99iNtorWfEK
         Hot+zzxZPWavt2jfR9wWwB3A+mVPaySmXMqY/Q9xn9Sn3O0CJLdE92g9i7IMn7i9Jauf
         C9PZZrEIqgXVDJ4+GbfmuH9874zUOaFZQ8+H0NHej23K3vgnbZ2llbLRrMosg677whCI
         Mre3kwK/1/vc32psbeXusEIvHtWNyPq/oFZgKsLB+2qO/tHeb1yhMc1BP0etCi8GO7MG
         ZjbiXlvKilhCjfL4CAcwgt7zXA4LgpjK1YK/MIIEGbxmiqV8p9YsQjXa3YB3SSpSCaj0
         D2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bdLlsx0qQ1Tq/c9TtyrU7bglWcYLVdx93s3ZyR2mNek=;
        b=LKpqb1vCGJVpHxeUjmmWVuzDxg91khRmFo1HYjw1qDP9xbb+cBg5o/lKE/dfbs77F3
         hC714p0+Cm4dZMwwWBm1qv5nDedHLVuz0agWqx4wGlaWxfyQbviJI/r6COZzY4kErfpm
         I72KxYijL3jLuqVVw697zieJE2FCVZSVgxKBBK8AiFZsG5ZmsfWTp5J0T70Zg/IlPNO3
         jarxzi/e7Xb01RjLwDO3VbeCk2MP2dLQn5qCkVNw5rRebkgLfld242gXdMcdFUtNNNwc
         +5xOTPtG1J4eSzPBQ6JP1POaiEQ1bz5b2mlz1gk+8cMCWJC+RaR75z1ZtlO4LfeCCVXJ
         RrdA==
X-Gm-Message-State: ACrzQf3MtCxXzMP//ri1+P8knBHTmmDNBk/RZV70daMxSqXgIke8jXFt
        tz/zZY5C+apPIs+S/lisFI4axtwHnW1fyXbB
X-Google-Smtp-Source: AMsMyM5eysqyw2DfBkBD8jpTovlJciF+4EwS3auvmkvId45xusVDC7Ymd+wMpux8I+UcVs9GNo4T6w==
X-Received: by 2002:a05:6000:552:b0:228:6296:3b33 with SMTP id b18-20020a056000055200b0022862963b33mr8945415wrf.615.1663521195986;
        Sun, 18 Sep 2022 10:13:15 -0700 (PDT)
Received: from daptop.. (host86-156-148-202.range86-156.btcentralplus.com. [86.156.148.202])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b003b340f00f10sm10375728wmq.31.2022.09.18.10.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 10:13:14 -0700 (PDT)
From:   Daniel Houldsworth <dhould3@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     dhould3@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add a quirk for HP OMEN 16 (8902) mute LED
Date:   Sun, 18 Sep 2022 18:13:00 +0100
Message-Id: <20220918171300.24693-1-dhould3@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similair to the HP OMEN 15, the HP OMEN 16 also needs
ALC285_FIXUP_HP_MUTE_LED for the mute LED to work.

Signed-off-by: Daniel Houldsworth <dhould3@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 38930cf5a..c7d07d6df 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9265,6 +9265,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8786, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8787, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.37.3

