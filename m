Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1482774252D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjF2Lvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF2Lvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:51:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413ECE4B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 04:51:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-668730696a4so352458b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 04:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688039501; x=1690631501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SFIiYNtlNSqroNrtzmhagRxkFdGItjtQCdhKlFJnDHI=;
        b=AUt4AOWqIZhyyE2jfbneDnBYp3HZG8BwQ23vXh0EAR6che7HBdUfK+ipMNCJGKasZt
         CNfeJFhmoXBdM/lvqxjBX3OKLo+2zUJ+ymaS3UL0Hk/nmAsZKyX9EZX7QFPU9guiIa6W
         7CMdypSTdKwKmKOwg4TZ1WKPgBbpyrTetUtLBpGDVEESniINQD7fWZ2k+mDdBULlfMrD
         o1omRvmLC/lc+wjb+kl8SL7+Kjo+B8wQwXcL1MF0mRuqxXyuXQM9Wg9Cn6OKMvLm5Ncg
         3ztjs0cDXwQJ46wHnWKmQQz6JQG/AA9sBn33ZEgUisUAzpgFuZGP4s7j08HClTtlBRvg
         hCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688039501; x=1690631501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFIiYNtlNSqroNrtzmhagRxkFdGItjtQCdhKlFJnDHI=;
        b=c6aJ+lX8cqr2jvIY6bqt88ZBoY5tEz+R6QzbGeNbNqcQHg4lbw1lH0B4BQbNIwb64p
         wxqDV3NjTyf/D0hsOCOFmCPYSN9xzvtohRSfhkZTDfyrJZNrLSEdeLDK/9p2BhKR8RGX
         zQjyah2ltdKzcpWbyx+W9uJCRuNVOBoQ2LaLvcMZuIZhCV5K6ISZs7O/11RMw2e1dKY+
         JwJAxcwdEGqeD3yqouNEd1qY0ermGWdcU1DQrqZv0j/XikE74QxD4djBMGQhl8SoiWRF
         aEaC+XjFFed82DKr88YT8vbLC6Pmy5vYRRwFqMSpxS2YOt0hYdTSnfXftowefHs9WTno
         SqLw==
X-Gm-Message-State: AC+VfDwTr9unSqtfmOw2U0KoyVsXwdetE42fokDO7ATDA5afhiTKsTrU
        VgobSDeERpJ1eySM17xoqik=
X-Google-Smtp-Source: ACHHUZ7t8UNxjnFrQAOU+cnS6LGNdmLAjkfaeYPGQc9MCu7fsWNBcvZqQCOQI9KbPkH0qh6rDLKwpw==
X-Received: by 2002:a05:6a00:3996:b0:67e:bf65:ae61 with SMTP id fi22-20020a056a00399600b0067ebf65ae61mr6239403pfb.28.1688039500624;
        Thu, 29 Jun 2023 04:51:40 -0700 (PDT)
Received: from localhost.localdomain ([107.148.241.191])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78485000000b00671eb039b23sm7050492pfn.58.2023.06.29.04.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 04:51:40 -0700 (PDT)
From:   Huang Rui <vowstar@gmail.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        vitalyr@opensource.cirrus.com, Huang Rui <vowstar@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook G10
Date:   Thu, 29 Jun 2023 19:50:33 +0800
Message-ID: <20230629115033.2719876-1-vowstar@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit 3e10f6ca76c4 ("ALSA: hda/realtek: Add quirk for
HP EliteBook G10 laptops"), speakers are fixed but mute/micmute
LEDs does not lit. Need the ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED
to get all mute/micmute LEDs working.

Signed-off-by: Huang Rui <vowstar@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dabfdecece26..425c87733e79 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9491,7 +9491,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b65, "HP ProBook 455 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b66, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b70, "HP EliteBook 835 G10", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8b72, "HP EliteBook 845 G10", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8b72, "HP EliteBook 845 G10", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b74, "HP EliteBook 845W G10", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8b77, "HP ElieBook 865 G10", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8b7a, "HP", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.41.0

