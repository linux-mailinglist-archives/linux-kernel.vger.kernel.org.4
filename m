Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0330671F79E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjFBBRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjFBBRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:17:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95361A8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:17:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b021cddb74so8493635ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685668628; x=1688260628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir5X+hrjLj8tJUZLFfQMjdGxm5OmVBEPulIdjucSf10=;
        b=Uy9nI8m2lqsVBKSn7u1GojrPlvaeb78BhlUt+Ol+jOFoQApwidUwDoPdZ1FfwD8VDL
         29jlch9nzYU9/8DVoUHFzDULj/6TwE98XOQS8A6pBguXqPTzmSJoFCCVcdomCJHyBu32
         BdbpAqwlEPVHc/vaDn3FJyHAevB700NuKhCfMjOt2tfxYc4H96r9XerXpw4sDrToVyvJ
         nm+pnesK41lHWW7mP2mmJk8OfVsK6HfMJRaYbpIRUdt8Mnvacv76jIK1paVIZQAvG/uf
         1Oettze84M2WiBpepMSKn1vFZYtQChNJkY6hiJCl8g4H3WXLNR7ok2cY6DPdPX/ioARt
         XJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668628; x=1688260628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ir5X+hrjLj8tJUZLFfQMjdGxm5OmVBEPulIdjucSf10=;
        b=e68IB8TjsoNjBcw8zvw4B7H0ULPm4eA1e0TjJA4pAe/st8O5x2CCOrzH9CM2pEmSwC
         pdH9sp4f+g2QrYlfDjwDOTUJiWwHm5wxsMM9lGHuXHanKmxrcizW0LmBxCNB5RU+sl56
         070gFEX63SobtVY8eljQ+gOc5JWpYidWTPmkYIpweIDD/imLle92j9jUKI8iIqxKhfTf
         mzNZwAwfbm30wwbCbmhzaBDpochMiLygyoglu9DwNA16nHBp/o40nS4Fs1p5TDy6wUD3
         H/k6zElVRgCdz8jVnLBlKMN/sACAbNFgU/vpbooxj9gXdtMAq/8Y+l5JauKpTIl4een5
         W22g==
X-Gm-Message-State: AC+VfDzYUoBA/IbpJgN7d7fOq4Wa6zfOXjh3afvh2geaMjr0YwwJLE2n
        LkKmmQ2fRCDZZ+N4JgcXkHm6i+4qpNDJBQ==
X-Google-Smtp-Source: ACHHUZ7H8t4Ft3SijtFC7xfhH98U5gbGT+43CWfxbwQTqyPB2zw/t2uvBa8Qo0YZqa4pPRqnBmYsTg==
X-Received: by 2002:a17:902:930a:b0:1ad:f407:37d1 with SMTP id bc10-20020a170902930a00b001adf40737d1mr650016plb.52.1685668628174;
        Thu, 01 Jun 2023 18:17:08 -0700 (PDT)
Received: from kean-Lenovo-Product.lenovo.com ([103.30.235.251])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902ee5300b001a9581d3ef5sm28933plo.97.2023.06.01.18.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 18:17:07 -0700 (PDT)
From:   RenHai <kean0048@gmail.com>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        mpearson-lenovo@squebb.ca, RenHai <kean0048@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add Lenovo P3 Tower platform
Date:   Fri,  2 Jun 2023 09:16:45 +0800
Message-Id: <20230602011645.976816-1-kean0048@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Headset microphone on this platform does not work without
ALC897_FIXUP_HEADSET_MIC_PIN fixup.

Signed-off-by: RenHai <kean0048@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7b5f194513c7..d0b44cb6f41f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11715,6 +11715,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x14cd, 0x5003, "USI", ALC662_FIXUP_USI_HEADSET_MODE),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC662_FIXUP_LENOVO_MULTI_CODECS),
 	SND_PCI_QUIRK(0x17aa, 0x1057, "Lenovo P360", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x1064, "Lenovo P3 Tower", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32ca, "Lenovo ThinkCentre M80", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
-- 
2.25.1

