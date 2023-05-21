Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E31670AE5C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 16:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEUOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEUOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 10:52:27 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF0EB3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 07:52:26 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-62385de2d40so12109536d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684680745; x=1687272745;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHfNlUnA5VOqVbH0nZvarUxx1cresQDlwjUQUCtJ4Ng=;
        b=Uy4Vleh0fSgeZtVizYpMKq0rt/D5hjLIqvQHhipdTZM6bDYEEqK1vIDGB/sh+IXNn/
         pSfCIe/G/nQWWrdtYXDs6NaykfULKA5AmGUZyIEcO/Dm6sy1v+vTB9ruir7X8+Up79+5
         EzOxLd2cQB5ZCwyYb4UGTZzFCAIzhLLI1hlEpGpx2z49o8jV9KbMRP/bGcXKPL3kp7XV
         9uhHgaJcPeAAM7ZEvJq0OqmQ3qqFEHTELrePRYKg68Pp21gWYoaF8wv0bPFweLyoS4o3
         sr+jp5FKB4q3GQvNYBeL4mG5Y/7pbGGPBjCfnA3fN1coR4W9suoyPbBL3wtv5m6OPY8P
         D0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684680745; x=1687272745;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHfNlUnA5VOqVbH0nZvarUxx1cresQDlwjUQUCtJ4Ng=;
        b=ecgMaIhM2IYrOw/HDwKbwVt9fe4nVE5aIBPXbWvzfvEku7pxCuGDT8IhcjUTtLHqru
         e7GCafMpQUT5ZH+LajDq9NsGB9Q12euwUHasgmswJ7MUtwRD6kmGYYVuSBtJqqeENoxa
         yB7BZkZ5dTIrW23paYZIvIVg6WyJF0lLJFrIFU+Fxomqzw45qfv8wbzgGGoCpAJBLgcL
         dlrfsw5sgT3qaML+atCjQlYJSFTmr58YYDHf1NFwA4idmupEou62kHm+w5AYAGJCVFPH
         xZttOE3omXcYxkwkC2lMd6TlzgD/8Rqu7qYZxa7OqI8r/JMPgQhrmclHn47HnAvud1Lj
         LPLA==
X-Gm-Message-State: AC+VfDz0EBrXfcDGMeWeCGZ+UWIbAy0zD9SaJXX2DHUqFBOhFFToNKIj
        BQsn9v1zfVIrbioS6h6zMXRCdR0mn6o=
X-Google-Smtp-Source: ACHHUZ7aFPG/gLrEqGAo9tE6GZXUDttgdN6u2HGMO35j76BzFueWZBKNwrMiJF70xAXP+2GRuB3gHw==
X-Received: by 2002:a05:6214:29ec:b0:5fd:93b7:5a96 with SMTP id jv12-20020a05621429ec00b005fd93b75a96mr13081290qvb.26.1684680745520;
        Sun, 21 May 2023 07:52:25 -0700 (PDT)
Received: from thinkpad ([72.49.160.91])
        by smtp.gmail.com with ESMTPSA id cz10-20020a056214088a00b0062120b054easm1298345qvb.20.2023.05.21.07.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 07:52:25 -0700 (PDT)
Date:   Sun, 21 May 2023 10:52:23 -0400
From:   Adam Stylinski <kungfujesus06@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/ca0132: add quirk for EVGA X299 DARK
Message-ID: <ZGopOe19T1QOwizS@eggsbenedict.adamsnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This quirk is necessary for surround and other DSP effects to work
with the onboard ca0132 based audio chipset for the EVGA X299 dark
mainboard.

Signed-off-by: Adam Stylinski <kungfujesus06@gmail.com>

---
 sound/pci/hda/patch_ca0132.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 099722ebaed8..748a3c40966e 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1306,6 +1306,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1038, "EVGA X99 Classified", QUIRK_R3DI),
+	SND_PCI_QUIRK(0x3842, 0x104b, "EVGA X299 Dark", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1055, "EVGA Z390 DARK", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0018, "Recon3D", QUIRK_R3D),
-- 
2.40.1
