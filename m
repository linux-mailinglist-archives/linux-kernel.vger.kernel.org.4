Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD972A425
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjFIUMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjFIUMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:12:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF9D3A8D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:12:03 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b1576c2f6eso933714a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686341523; x=1688933523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHOOZo7bsVeX3U79OiwET6jS96iIboJPZYyWUC4/j+E=;
        b=p61QjFaP9ZAH/Nkc2mA3UZNgcGMnrxatk+VqJllLTay/gfH/IiN+UOlfzrWQM5fs2A
         CBBBSao+kN14lEYepG7MZvMdnZEruZQoQCa/SKlp83NBJ4e81+OyWfD5SkwYog5zx60d
         UJiNY3GiSWp4IiEL4sIBgZFwcSOmBU28PE2fdRnVPJnUb5JuoVZfEZ2qTacyoC1LbBsS
         wdIq00UxfExOi6portLFMBT/QZTb8JjmvNEPisvo9Sa3Ib3/8UjCVww4GpcQkrxnePMx
         9Dj2Bs+R1lgAEzjo/37GelsDHzGr73D93ScbrEzRXEFZk7fGIKQJi50BwosW66mKGeWc
         kRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341523; x=1688933523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHOOZo7bsVeX3U79OiwET6jS96iIboJPZYyWUC4/j+E=;
        b=Mlrido9nBAYfCV3LCCJqZp4bqyS6DUU8vNspb5i6zedO3alDW2mCGKDlpgb0eugAz/
         6MPsoxIPhtLBBrHpKHCF59QZbeVfl0oZVnQq+DQb6dFw+vTbxdXkVbITcjYhsVOunRrn
         YXBwGubZMhT3ACvNE3YrxDWUpzwre8a2AKno2F6kJ1tXKLDz8qoNHYEEOIAr+faJMb5u
         hUFjOi11lLQxLrQlFDoCuzFzpRYprqNr4L+AHBap1XC8uEl0DwJBljnE1AHYKvjRfpyn
         x5H9LX24XCyPMl3wapI0KJ4LBj/yOhaUkvE8DP3PqGFwP9RqDuh9y287Rt0uG5gVzGh0
         T6+Q==
X-Gm-Message-State: AC+VfDwKgQmVmKPiu2m5sHL/zG1y6WST1qFiHfwTOOB5dLsiOPHMVGZ0
        fiwQAwPdO/bGlZYQaPnLMHU=
X-Google-Smtp-Source: ACHHUZ6w2AeU6XOEt8Km+cVTa5N3vHjD1cMgl0AqBRWsDhyXLJYZfZzFnvrTLIUhoAbV2yLsTFnevQ==
X-Received: by 2002:a9d:7acb:0:b0:6b0:73fe:cf10 with SMTP id m11-20020a9d7acb000000b006b073fecf10mr2380235otn.5.1686341522933;
        Fri, 09 Jun 2023 13:12:02 -0700 (PDT)
Received: from policorp.cardume.local (177.207.112.13.dynamic.adsl.gvt.net.br. [177.207.112.13])
        by smtp.gmail.com with ESMTPSA id w15-20020a9d674f000000b006adda5cddb7sm1713402otm.62.2023.06.09.13.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:12:02 -0700 (PDT)
From:   Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, sbinding@opensource.cirrus.com,
        tcrawford@system76.com, andy.chi@canonical.com, luke@ljones.dev,
        tangmeng@uniontech.com, p.jungkamp@gmx.net, kasper93@gmail.com,
        yangyuchi66@gmail.com, yangyingliang@huawei.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        edson.drosdeck@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Add a quirk for Compaq N14JP6
Date:   Fri,  9 Jun 2023 17:10:58 -0300
Message-Id: <20230609201058.523499-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Add a quirk for Compaq N14JP6 to fixup ALC897 headset MIC no sound.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a5d55a7063d3..308ec7034cc9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11740,6 +11740,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b0a, 0x01b8, "ACER Veriton", ALC662_FIXUP_ACER_VERITON),
 	SND_PCI_QUIRK(0x1b35, 0x1234, "CZC ET26", ALC662_FIXUP_CZC_ET26),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
+	SND_PCI_QUIRK(0x1c6c, 0x1239, "Compaq N14JP6-V2", ALC897_FIXUP_HP_HSMIC_VERB),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
-- 
2.30.2

