Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140A15FFF95
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJPN1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 09:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJPN1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 09:27:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C577654;
        Sun, 16 Oct 2022 06:27:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q19so12638347edd.10;
        Sun, 16 Oct 2022 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4lAtcWLfky+loGkaKS25dVBzZnDMU5TT8sW9dTlDsw=;
        b=niUCUg052VYXiWOHFjdQZ5sJJ4MktbIJOqHDhc//ExUZsYJCWATv5g0cUCpcRddUFx
         r99ae361bpw48kxj10mQS4I40GFhDQ1OONdzTIODgj1/YmP8aoTFAJroCRPozPvZRNhn
         VW/EuAhnTrQ/A9VTzHwqZegJu+uLfZiG0vnAdg/LLy3NJXOXhsE5byfMjFafSEk2Y9lL
         1fAO4U/pOLupTdD7Z2bpskOBp7RxogyW0HPf7X04LtjzlSly38ZKrv4ByBSlykCe+JY/
         2MiC80GxqxV7B5EMagddK/sZpnOQeWmQ5+6gW3tC4cAXtW+1P069RwevO6KtyUC4nGyL
         MyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4lAtcWLfky+loGkaKS25dVBzZnDMU5TT8sW9dTlDsw=;
        b=J0LhiXvHy4viq9GEZi6vmmTYyt3QgX2jsv71hyvn0WTXdkA0UVcvWp4T+U0Sjip7LD
         m1UW3J45u0HYkRO0H3/jWsnlYPyshv1DqBHtxN1xek+eGAbPaXqT1/tmsAy1W84g5QwJ
         MxWE93KavXXmHPt6Yb5m86VeYd6Q2UaR6Hbi4OpJRpUuGBOv+Jv2lAG2jC3/x48g/gpZ
         6TuSOEfwI/II79uJ5OGH2bhfoFgc51QRfeiaHT1WfUKIAcaO8zHmwpcpowB/xsTtHdyQ
         v4atFXVcXTsvh3MAfKVtx1MvvYg1ZlKdl8oQlgagMKVpCAeLokslrj1nfWh9DMAysA+n
         ++Gg==
X-Gm-Message-State: ACrzQf3QWn2yxZAKP82AoCNra1mkYbSi40yOQPjPV5rOqbw4FvnfvcEs
        iRM7dgZP5bbuC98HwlPHx8E=
X-Google-Smtp-Source: AMsMyM4oPte+j5nh3opt0lyMXuFVe7wHIcXq5jHuN7oNH72qrvZnHH9WahPiRurqO7hOrJMsGwTcBg==
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id ev6-20020a056402540600b004521560f9d4mr6185254edb.333.1665926864759;
        Sun, 16 Oct 2022 06:27:44 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7ce85000000b0045c72bba0bfsm5572057edv.4.2022.10.16.06.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 06:27:44 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] ASoC: codecs: jz4725b: add missed Line In power control bit
Date:   Sun, 16 Oct 2022 16:26:42 +0300
Message-Id: <20221016132648.3011729-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221016132648.3011729-1-lis8215@gmail.com>
References: <20221016132648.3011729-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line In path stayed powered off during capturing or
bypass to mixer.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 5201a8f6d..cc7a48c96 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -236,7 +236,8 @@ static const struct snd_soc_dapm_widget jz4725b_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("DAC to Mixer", JZ4725B_CODEC_REG_CR1,
 			   REG_CR1_DACSEL_OFFSET, 0, NULL, 0),
 
-	SND_SOC_DAPM_MIXER("Line In", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Line In", JZ4725B_CODEC_REG_PMR1,
+			   REG_PMR1_SB_LIN_OFFSET, 1, NULL, 0),
 	SND_SOC_DAPM_MIXER("HP Out", JZ4725B_CODEC_REG_CR1,
 			   REG_CR1_HP_DIS_OFFSET, 1, NULL, 0),
 
-- 
2.36.1

