Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642D072471B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbjFFO7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbjFFO7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:59:16 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854BE173D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:58:34 -0700 (PDT)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0655D3F149
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 14:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686063478;
        bh=MUN7viTHu6QALabQ1fR3s2tYxllzkOaxkPFGC1T37tc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=DvRBxhJLlH8z5Y/rG/x86HYS4LXK64QtLRHLQVQkwAt8o8nr8wk2eQrJ49DvQKpi7
         D6gF66Wl2KTpvNOGN0RMgsrDSCRYlUlb+ce0/aykvYFDuVzu7EsldOq0s0YfKPpNZD
         vKNefu06/MLquLzKJYMGCbq/pPeCqq4KHjncT55Z8m14jYuxlZj2yH4taifzmDE1jA
         sJEIECXRMKRqmPpBOh7OybBLCuKmJmb8JaXvTb4O7jnPlvXl/TtPDtUybu5I3Xfbuo
         /YBqNwJvugGSpiWPJJhtrk8NfJWEVWw7kE3k/DtTvs+sXOF531qAiwzZYtpsUmLc9o
         pqTXskdVWYBNw==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-558bcbb9172so2222759eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063475; x=1688655475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUN7viTHu6QALabQ1fR3s2tYxllzkOaxkPFGC1T37tc=;
        b=i4hrdl2UDH2l6D3Jh+/zjXw2oXUB8t6QOGIrNaY+GRuHpJJdaLqIrH1bH7npzViDny
         eAAp4JoKqhfbRJ3lyPN7Cv7BFi8Rs9hulQSUK6oqEqG9MzpAnoB1y4036f3Asct7MZEI
         hdHjaaI32fPeSIB7Ybrbu4a88RB/6FSonVo2YOdW0ObkzMOZBIhTYEk5xE/2oxPac5G5
         E0k1OWHmpN21JMLgxfNwpG5WugLFjR6rV4AL5eXtcRHWBScAxrOxk8i8Tt3YqsAjzyMA
         75SJFVRC3Csgzq+TZoFrnqPoTeMGQ6MsUM4BzKJDmfwxH+WOI+bNH5IdOX5lI7l9dpAe
         nnNg==
X-Gm-Message-State: AC+VfDzbHCempkWant0F3vPCtzGGWPBt3x0HwSTmT4202mQh/94c0FmA
        IKx6ffH9DxchDWGwe5HF7k6vjvLITCeQDVkedNi0izX86xbuIS21dwom1R+doGm73y9iE7tEfrp
        sXPrl40WZ7Ihjsr2xdrNjPRM7XdNPWDex0FGh4yfRGlhJbjGanw==
X-Received: by 2002:a05:6808:694:b0:39a:58b3:4ad8 with SMTP id k20-20020a056808069400b0039a58b34ad8mr2536580oig.38.1686063475325;
        Tue, 06 Jun 2023 07:57:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4WZdeJsUeKKOpuRDQxfcI2Fq707bGmB1acq4YojYhtIC94BcdcosdyOqjKlOzEkTIRyyy9bw==
X-Received: by 2002:a05:6808:694:b0:39a:58b3:4ad8 with SMTP id k20-20020a056808069400b0039a58b34ad8mr2536565oig.38.1686063475032;
        Tue, 06 Jun 2023 07:57:55 -0700 (PDT)
Received: from u-Precision-5560.mymeshdevice.home (2001-b011-3817-b688-4e3d-edc0-b3ad-88dd.dynamic-ip6.hinet.net. [2001:b011:3817:b688:4e3d:edc0:b3ad:88dd])
        by smtp.gmail.com with ESMTPSA id x7-20020aa79187000000b0064ccfb73cb8sm249824pfa.46.2023.06.06.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:57:54 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     perex@perex.cz, tiwai@suse.com, sbinding@opensource.cirrus.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] ALSA: hda/realtek: Enable 4 amplifiers instead of 2 on a HP platform
Date:   Tue,  6 Jun 2023 22:57:47 +0800
Message-Id: <20230606145747.135966-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit 7bb62340951a ("ALSA: hda/realtek: fix speaker, mute/micmute
LEDs not work on a HP platform"), speakers and LEDs are fixed but only 2
CS35L41 amplifiers on SPI bus connected to Realtek codec are enabled. Need
the ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED to get all amplifiers working.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f10790ace5c1..0e76938f56df 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9500,7 +9500,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b8a, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8b, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8d, "HP", ALC236_FIXUP_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x8b8f, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b8f, "HP", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b92, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
-- 
2.25.1

