Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCDF6F3AD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 01:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEAXN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 19:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEAXN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 19:13:58 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6582D63
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 16:13:54 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-61b10b35540so16243856d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682982834; x=1685574834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gai0ALSwFWNu4dVILpSqC3jihApx19m036xQ8pT5cRc=;
        b=dIKpfA3uFcoo9uCFn0G6Lx96JwdxhYB3VSkTKjvLjKEHic6uCnDdn1ODdVv4qb7fXe
         1mVHYruvYGv2++K4ysQqNFCwxtnqqqz1EuzqAlqwwdJoaY7pp1ckebjyNEDeNaXyOy7V
         fFkYycHyQssr/mXSa7MK9vm6ujCSoc3p+xEHtqZEMumw5+bbm7NMLULoLzUUDXcERhKi
         fIEx6CJlLtieNfj5mHJpQDkqjile4Tc/ptGfbbTImH0bMNuBoAPmA8bjpGPMh+nzU2nP
         0tFLg4+PFYts1pMiL55+FBPS9cCBZIpR9MK+UHRHIdTkahpXWPXLqjV9iKceDmy8nNVb
         rbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682982834; x=1685574834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gai0ALSwFWNu4dVILpSqC3jihApx19m036xQ8pT5cRc=;
        b=J2xB31t18dA9iGEqpZcN7FfLuLUl1o3sz924T+On1Ng12A3g+sdBCWWJo1c7Dp18nv
         rJ6Uo66kuV+L8J0twTLtotvtaPSEKBVoxUKz1rCYq/HEpUDlUervaHIvTvXhwPT58Ndw
         wsw7XFVoObjpTd9e4rpByqDrDd3/+DDDGbOIw2uWeiTgYbQZhIiBaBYxpD+N2ZQjEkIq
         /MdKCey7ytkUBoiOVgurw2RlYiMj/HIhkYRc7YfWVZT/HIXP3ndO5Q0SpB3i4PzEh65I
         xtxvq8jeIxwQvhFo7A/LcpRyPoBQvIyYPEeRZxvBXA2bNmRjunnTKn+PJdVGcsj4FpWX
         Ztmg==
X-Gm-Message-State: AC+VfDzTC4hN/HgR/FITM3lwoDrqYbNC0A4Zgbi/n37Ib43/OAyTSpRY
        NBocXipxjNyJoxIKunlhago=
X-Google-Smtp-Source: ACHHUZ4na7lHJ4rk0S6AG4im+EHw94F0oFT/OjzFTVsLffyRnmcimwqkGynHMR7JjeV1iw9cyZ7X2w==
X-Received: by 2002:a05:6214:29cb:b0:5ef:46a9:15d2 with SMTP id gh11-20020a05621429cb00b005ef46a915d2mr2062917qvb.7.1682982833889;
        Mon, 01 May 2023 16:13:53 -0700 (PDT)
Received: from localhost.localdomain (198-84-181-245.cpe.teksavvy.com. [198.84.181.245])
        by smtp.gmail.com with ESMTPSA id d4-20020a05620a204400b0074e389245e6sm8420740qka.41.2023.05.01.16.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 16:13:53 -0700 (PDT)
From:   Mark Asselstine <asselsm@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     sbinding@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ASUS UM3402YAR using CS35L41
Date:   Mon,  1 May 2023 19:13:46 -0400
Message-Id: <20230501231346.54979-1-asselsm@gmail.com>
X-Mailer: git-send-email 2.40.1
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

This Asus Zenbook laptop uses Realtek HDA codec combined with
2xCS35L41 Amplifiers using I2C with External Boost.

Signed-off-by: Mark Asselstine <asselsm@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f70d6a33421d..905acd66ea01 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9500,6 +9500,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
+	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA", ALC295_FIXUP_ASUS_DACS),
-- 
2.40.1

