Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36CD5FA3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJJSzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJJSyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:54:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D0012AC1;
        Mon, 10 Oct 2022 11:54:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id fn10-20020a05600c688a00b003c6c44a1c8eso32891wmb.1;
        Mon, 10 Oct 2022 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4lAtcWLfky+loGkaKS25dVBzZnDMU5TT8sW9dTlDsw=;
        b=DjPiYRx1jqF9zOBa71/gdoTtdLEdU7glIyyTjeakCGpkWNkuc4wy94WyWUGh/q8FoD
         ui9Hg6+XbKtxxDIsh5NBQBup/GzI1kW+UXe+ADWJamL4odQbQa6Igp5uZv5QclzqQpt1
         oxCywDlpFuU49l9HcYomPOIqn/HFNPPMNYJpnwdUcnjlMrl4iA9RIo58NVpuYsSFiMtv
         dR9Fl1Rl+6JqWmVamRWyJ+TeSaRygYLeEOTDGK25z+4SdO8SzNWi1MwNfthDCNGNiGFK
         29lh63UZeEMCoiJ8czejuo6sfz5H7DczHdudVhpNGuw+8LC9c+vfJvPQZe+D7Gcr/cKQ
         l+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4lAtcWLfky+loGkaKS25dVBzZnDMU5TT8sW9dTlDsw=;
        b=R5Dy8cS+M2cOaNKHs/zw/kMnB5LA/r+yXX5OG1xp6+hyYha4suKzmvMpEQ/HfrC9b8
         2i8CRIaRNPjBBhCrvMNXuQfVOdcnOGAChnWq0wWfx/ZybAIRfrcSXPAnGe3atRpeKFNW
         G1FabD64JCBpnX9j0L6OAiEnrThTxrlMUJsbx5i0LtYwQ4PtoIBG/CRQZVwsMKsaQWXF
         +ZFC8+vu/O/cOzbtN8mBunbYfH41r7KhpdNLHxKU0BMd5FVA2emp1o2UR+vEf80sYidQ
         l6H6MSQGS1hB3shptfevA6mawJXJGUoM258Ya20lgpfJLHqs3b7stMbOkisb9MBz5E79
         4ERQ==
X-Gm-Message-State: ACrzQf37dM5VfAlHec+p1mv8jnCRnrBhUUEjc6YVRR8iEhnW+t865jFk
        wAwduqEfhnfj3QDnVBjr7nE=
X-Google-Smtp-Source: AMsMyM7l142bKzQq12LOkJeEgnf2eLCqUiQks1Hj80BdQCSYahgVajaEYVsJK2OXu8L+YWEetQQpsQ==
X-Received: by 2002:a05:600c:1c22:b0:3b4:b2bc:15e4 with SMTP id j34-20020a05600c1c2200b003b4b2bc15e4mr14092275wms.69.1665428090962;
        Mon, 10 Oct 2022 11:54:50 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-126-34-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.34.126])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d6142000000b00230c9d427f9sm2082272wrt.53.2022.10.10.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:54:50 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] ASoC: codecs: jz4725b: add missed Line In power control bit
Date:   Mon, 10 Oct 2022 21:54:18 +0300
Message-Id: <20221010185423.3167208-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221010185423.3167208-1-lis8215@gmail.com>
References: <Y0P/u4pJT8rup8Za@sirena.org.uk>
 <20221010185423.3167208-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

