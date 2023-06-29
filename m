Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265B4742693
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjF2Mg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjF2MgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:36:07 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF842690
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:36:06 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-262e81f6154so308560a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688042166; x=1690634166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ewkyga5jWrBIrRzjRNQ0kt+SnJFF9Xml4dXQcN2EQhs=;
        b=a/n7a52bRuhn9upZsTqFpiSSaog/awsdPngQx0nRwLqb939pQwSEsDJRilUUJKCAVT
         2xHWQaB2i6CuNCU3S5BR3p8oyW9Fqshw+2mINi+ONwP/goFY48iWt6Dlq6o66k5GmU/b
         OPt9z8Z7mGKLqKJHm+ZwUitOohXovc1AiXY+KJBcIP9HQKT8VD3oeuN2MmMecFbKFwzT
         Dn6stxqJ3x3tMe8CtiCcwgTZaJg8SI71zTOFKfzy/Ptp7qnRAv5lRf1t8RNIh3IpB4cK
         vSbh+dWr08SrIkKZ7rcT6Kl6A/EKMMUzvhhDZU0kkmd+W7dl4fNSN4mNx0i7RMA7xZYp
         6u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042166; x=1690634166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ewkyga5jWrBIrRzjRNQ0kt+SnJFF9Xml4dXQcN2EQhs=;
        b=j6mMNzWDu5cVDPN8ZA2uLHRmoehnMpj3DcMLCZkEN5CC5ShsIxbcb/Xohy13FXhFl9
         3PAUosIrJlLqpCEFWKIgvkBwZ0Mx268yT8NZ/PDGDBOAaM9dZP8kVZyYY4OpS6IMw6Lg
         EuH89IvBOOvXtosdhy8E91h2fWuZDLbYBVGGI15EOncax5VHwexfo/BKCd+Ot0Pc6Zfl
         Dexw7sMBzJihWFSqQZRns3yGJuFF2npWqA+rz15TqtIgQDOXubgGvV9JZpUg/gKeRbIQ
         bqPb25Q/53TOhLbwXWO/fZVY28x8u49qWnpb2Yw0oDQsvRCSPuXERHTDF8j4y7I5brlK
         f2dA==
X-Gm-Message-State: ABy/qLY0nQ6kNo6hhfUPhssyCu+WyrsrY3NoY7P8kjsWQA0gyHx58uBk
        LwIyn7B4/UQGMkNSevAqbizNh2c0mPN+9w==
X-Google-Smtp-Source: APBJJlGBLnd7gjJdm87WA4wCa8zgoc8Ra7eNct8HOvxnpQ+i5cMra8J6Yw56T+FsknWe7Oak1nSamw==
X-Received: by 2002:a17:902:c94f:b0:1b8:5541:9d32 with SMTP id i15-20020a170902c94f00b001b855419d32mr1374018pla.68.1688042165758;
        Thu, 29 Jun 2023 05:36:05 -0700 (PDT)
Received: from localhost.localdomain ([107.148.241.191])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902760c00b001b246dcffb7sm9026181pll.300.2023.06.29.05.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:36:05 -0700 (PDT)
From:   Huang Rui <vowstar@gmail.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        vitalyr@opensource.cirrus.com, Huang Rui <vowstar@gmail.com>
Subject: [PATCHv2] ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook G10
Date:   Thu, 29 Jun 2023 20:35:57 +0800
Message-ID: <20230629123557.3627401-1-vowstar@gmail.com>
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
Fixes: 3e10f6ca76c4 ("ALSA: hda/realtek: Add quirk for HP EliteBook G10 laptops")
---
V1 -> V2: Add fixes to link a previously committed issue
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

