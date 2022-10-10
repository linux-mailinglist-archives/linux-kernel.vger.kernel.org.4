Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810035FA3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJJSzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiJJSy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:54:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEE4140DE;
        Mon, 10 Oct 2022 11:54:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t4so7336507wmj.5;
        Mon, 10 Oct 2022 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQsANxIEHACjEO789UfrDxMr8VcVkScq/x+QZ4UQMEA=;
        b=M2lcS4W4Ayc82LkYpVaSwvYZAZi4M6rTJJir8n6eoqpzupOocFLYVDUD1+L0ZNjzoL
         3RaYcedtmQWxAw3etNibpFWoaJAfni9QKplGvxrNSU54eNMWhNH5/Hk00IMZrH11PiVx
         Ma+cwMrvKB17NMjncuJAS41vALYCHn1tNFZv/OiRZEQZOOscv+emg2zdVSaoX7aP8fh7
         rCifucpvsvhVDmj2NiTDS3almzXQjtL1+/0KwMK3HNggsor/nI91u9ox13yXi0BDNkyM
         fXKmKprd1vU2mGDt6aT0mC+G5743ZVnChUpcnWN8I4iKt+ObhOQKO3p7rr6lA0qF1euF
         mqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQsANxIEHACjEO789UfrDxMr8VcVkScq/x+QZ4UQMEA=;
        b=MiwWPo8SdNVW4YHj++yn/lnkZJHdaDbjiJfw5ZSSx5Nq8hw4AQ/3tPR4QlGBdlRLUp
         QNZ2CvVKk8v2c6M41JjzB9MxVNowfcgrkDkjkwzIk92XDyKbiya7bZR5dsZas4X9MRx+
         8JSmi2PU4B1v6ElbrZJwcUEb5nj6G+GBlEGoqQ/w3vVwW4bZnQSxVk9JznX3YoBjKxbC
         BYfdtMhx6NOmZpVQeDhmcM3wIn45HUhVcWGeujtP1gQccAzl/zAJvEaAz/JM5aRJZ9Vn
         m9h+xFj9KxjGJVUmKp0saLlagMCHXr7I9g/2cfWwTgL9TBfsKRbXIBoYZHMHkBEaxdWw
         m7EQ==
X-Gm-Message-State: ACrzQf1mSAj+r1VKGvn1FmrKPgz0y+K6QXUXXpUy7RRKUE7Airajb2sJ
        LX03axhB/ZoYlZ42lqvmcbI=
X-Google-Smtp-Source: AMsMyM4Eg+rIBg02ermXJ7veLFiSgPsQEYs79TtnhGmlvLP0QxQURlSFQ0aB1Mc26GrwiCcF8pcuIA==
X-Received: by 2002:a05:600c:a18b:b0:3c5:22c0:d0bd with SMTP id id11-20020a05600ca18b00b003c522c0d0bdmr8226941wmb.74.1665428092537;
        Mon, 10 Oct 2022 11:54:52 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-126-34-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.34.126])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d6142000000b00230c9d427f9sm2082272wrt.53.2022.10.10.11.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:54:52 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] ASoC: codecs: jz4725b: fix reported volume for Master ctl
Date:   Mon, 10 Oct 2022 21:54:19 +0300
Message-Id: <20221010185423.3167208-3-lis8215@gmail.com>
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

DAC volume control is the Master Playback Volume at the moment
and it reports wrong levels in alsamixer and other alsa apps.

The patch fixes that, as stated in manual on the jz4725b SoC
(16.6.3.4 Programmable attenuation: GOD) the ctl range varies
from -22.5dB to 0dB with 1.5dB step.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index cc7a48c96..72549ee2e 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -142,8 +142,8 @@ struct jz_icdc {
 	struct clk *clk;
 };
 
-static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(jz4725b_dac_tlv, -2250, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(jz4725b_line_tlv, -1500, 600);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_dac_tlv, -2250, 150, 0);
 
 static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 	SOC_DOUBLE_TLV("Master Playback Volume",
-- 
2.36.1

