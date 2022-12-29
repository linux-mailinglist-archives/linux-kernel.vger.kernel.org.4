Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229EA658A22
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiL2IED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiL2IEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:04:01 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADA1D2DA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:04:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id fy4so18543137pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KIiQNFKqzc7opQJ8ok0FfP39sLd9x5gpUsGJ8JTvp0=;
        b=fxENY/WxTKg7eKS46UKKzjcaEgaZMSAIt+Ys0flXSHONKVVDibA7JqN54SUBJLdBQW
         V5RCs11JLQz/M4GNr81/8s4fRvLBIgQeIpHfXHNMUgRAcRp4Kj8Nwg5n32JP41kTCk+p
         unFP7fkQA797WjqhRok4wwHbqejpy7xzm/4f0MjXR3S8jHGaM1CFnEbnckhDr4ULyBb7
         pN4RzdniMZXFgDM3+XED28/fKuvdn7Vg2gHlygbmglLe4Ro9h822/ACLAKlHH+tX8vTX
         lg+83a9cQpOE/nc+t3tcbnhTQ/S8ZOJ+5XMqVZ4XPR1+Gw0+6gxmVrNMxrTRhgPb6a2k
         CuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KIiQNFKqzc7opQJ8ok0FfP39sLd9x5gpUsGJ8JTvp0=;
        b=qQEXViiiporgelJ9CfUkuICvlpFxdV43Fe0C3zFcj+wKI2bJYp3NHl8LBwjuWsy0RI
         DU5T84nog3YEJ7FeZX5mDi0yiOGutYM8Z187MG6RYlqp4WrD8uJT5F5qP+Gqa0yBC+8H
         jpabifSzOPgO13QJy92e6pBCpDOPMdJ0ADCCrZmcHY2QOK99pIJjW08eisG8GLjWOCFs
         2YdN84q80+gf9CDW+DXma4ch1Cg7619KE7E4h1vKr53w8k6INiCeB/XJ1/E5HpUj+BcB
         IruUinTsiwqhsrZKsxvQnZf01Js6Z45gvlKgOAhsyznRlZXC+wvgDc2yZ/uKW+Q7IJLP
         NrCg==
X-Gm-Message-State: AFqh2kpaOE+uM2o8yErF1bDagdK7MZyb+whg7NRy3KXJYF1gAxkan9Au
        5cNdUisfDmhgbzFDs74USno=
X-Google-Smtp-Source: AMrXdXs3S5oDblrRByIPHLBud9vtobVm0v+3RvFHKnj/1tUpoKvkA+II3DVZ10IefiUKE71/a55T0g==
X-Received: by 2002:a17:902:edc3:b0:189:5ef4:6ae9 with SMTP id q3-20020a170902edc300b001895ef46ae9mr26746572plk.45.1672301040510;
        Thu, 29 Dec 2022 00:04:00 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:587:a2f0:9dda:bb2d:720c:85e8])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b001895b2c4cf6sm12146987pln.297.2022.12.29.00.03.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2022 00:04:00 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     cy_huang@richtek.com, jeff_chang@richtek.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt9120: Make dev PM runtime bind AsoC component PM
Date:   Thu, 29 Dec 2022 16:03:53 +0800
Message-Id: <1672301033-3675-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

RT9120 uses PM runtime autosuspend to decrease the frequently on/off
spent time. This exists one case, when pcm is closed and dev PM is
waiting for autosuspend time expired to enter runtime suspend state.
At the mean time, system is going to enter suspend, dev PM runtime
suspend won't be called. It makes the rt9120 suspend consumption
current not as expected.

This patch can fix the rt9120 dev PM issue during runtime autosuspend
and system suspend by binding dev PM runtime and ASoC component PM.

Fixes: 80b949f332e3 ("ASoC: rt9120: Use pm_runtime and regcache to optimize 'pwdnn' logic")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rt9120.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/rt9120.c b/sound/soc/codecs/rt9120.c
index 644300e..fcf4fba 100644
--- a/sound/soc/codecs/rt9120.c
+++ b/sound/soc/codecs/rt9120.c
@@ -177,8 +177,20 @@ static int rt9120_codec_probe(struct snd_soc_component *comp)
 	return 0;
 }
 
+static int rt9120_codec_suspend(struct snd_soc_component *comp)
+{
+	return pm_runtime_force_suspend(comp->dev);
+}
+
+static int rt9120_codec_resume(struct snd_soc_component *comp)
+{
+	return pm_runtime_force_resume(comp->dev);
+}
+
 static const struct snd_soc_component_driver rt9120_component_driver = {
 	.probe = rt9120_codec_probe,
+	.suspend = rt9120_codec_suspend,
+	.resume = rt9120_codec_resume,
 	.controls = rt9120_snd_controls,
 	.num_controls = ARRAY_SIZE(rt9120_snd_controls),
 	.dapm_widgets = rt9120_dapm_widgets,
-- 
2.7.4

