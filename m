Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E7868E168
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjBGTqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjBGTqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:46:17 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3640C3BDB2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:46:14 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-16a27344a17so11040807fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 11:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W57wzZYsbIJZQpPVkemrOHsbaIu0hnor4kfOcH0Od4c=;
        b=qQLwVhZ270H3VGVANdcjtqqRppTerXYZ6I40r+1bS9MWm1u73znQl4be/O4+sRGhkl
         Ce35RngMI2NJZsHTbjqmF1nrYBbSc3Cu5JvJOHqP0dfOM9e8aR36jlj5e4Z5uQ8IhLQn
         k5b5AircWsWO3B4DrR9mSrxsITztRhtFKjkVJNFgLoIZrlgbCYiV0T62L11TeRh+fCTQ
         /69D1GLmS65UqVL937ee3EVEfbxTEhGZ/qybf+uJujuY5c9VNaRe3wkqB9od37qWI6Xi
         tGgx2cdvOgLw7/vcn/wuFGK7PfFW3H1XwUO/BVQMCeLDZKd9BFQa6UQUgUK1iGXPHA/f
         vgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W57wzZYsbIJZQpPVkemrOHsbaIu0hnor4kfOcH0Od4c=;
        b=1bv6UlqTJka4q2bpi0O6TJWLLzU5ESCuXqt7qBWTWPINqYkrej/a8UXgAxgEugluUc
         LwdNk11OKuEW9joIaQKYVdmUlqTEDjtga+gUouw4vkk+HGpco8WELmdDm+CmfDLqHLe4
         nCEPVyQe9M4DW0/piIOpnSOo4Ph6huCcxzrhp0ns0GQrnrb2mqX/RifKlKhGQDi/K16M
         SnxBO07Zkxj263PoS/gXsWQ6cvDT/lqAQ+h1cTYll6ECf+FF0a22DSYbjgfPonen0HDW
         TWuBVpFGi/1cbmKU9VQShF40XqtTI8U2M2cRrh+JmrmB6HdiXsrAi6bGK7JH2zrH7GER
         kgGw==
X-Gm-Message-State: AO0yUKVCF+P1eh+RK7coT91DnvPWOcxGvxiT2IKwASTKD3NV+pRJ2Knd
        LklZWIlV2kilf0K/Z++uK7Q=
X-Google-Smtp-Source: AK7set8EQJJrF3sqkkw6+s06OzoOlz8vfZY+v0BYwKhl+DAPy0UmiD+hZ1iTgYzy5ldhZ+BBuk7oLQ==
X-Received: by 2002:a05:6870:328b:b0:166:fc4a:aec7 with SMTP id q11-20020a056870328b00b00166fc4aaec7mr1880532oac.41.1675799172607;
        Tue, 07 Feb 2023 11:46:12 -0800 (PST)
Received: from policorp.cardume.local (177.207.126.10.dynamic.adsl.gvt.net.br. [177.207.126.10])
        by smtp.gmail.com with ESMTPSA id c5-20020a056870a58500b0010c727a3c79sm1027497oam.26.2023.02.07.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 11:46:12 -0800 (PST)
From:   drosdeck <edson.drosdeck@gmail.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, tcrawford@system76.com,
        sbinding@opensource.cirrus.com, tangmeng@uniontech.com,
        kai.heng.feng@canonical.com, p.jungkamp@gmx.net,
        kasper93@gmail.com, gabriele.mzt@gmail.com, yangyuchi66@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        edson.drosdeck@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Add Positivo N14KP6-TG
Date:   Tue,  7 Feb 2023 15:37:20 -0300
Message-Id: <20230207183720.2519-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Positivo N14KP6-TG (1c6c:1251)
require quirk for enabling headset-mic

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index db9518de9343..ee5d3347354c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9701,6 +9701,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 	SND_PCI_QUIRK(0x1c06, 0x2013, "Lemote A1802", ALC269_FIXUP_LEMOTE_A1802),
 	SND_PCI_QUIRK(0x1c06, 0x2015, "Lemote A190X", ALC269_FIXUP_LEMOTE_A190X),
+	SND_PCI_QUIRK(0x1c6c, 0x1251, "Positivo N14KP6-TG", ALC288_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d05, 0x1132, "TongFang PHxTxX1", ALC256_FIXUP_SET_COEF_DEFAULTS),
 	SND_PCI_QUIRK(0x1d05, 0x1096, "TongFang GMxMRxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x1100, "TongFang GKxNRxx", ALC269_FIXUP_NO_SHUTUP),
-- 
2.30.2

