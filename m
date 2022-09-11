Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29C5B4F85
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIKO5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIKO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:57:39 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3531D2B60D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 07:57:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z23so7793404ljk.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I8h6IKACxQlXXVq1OeWv2JZIqExd2BXra4rChfH99Xk=;
        b=QQcsfunSn1opiSC+tGIBb/82hXMfbk8jt/xhW4pgbxegftG1gG0ErLsBhw79+MXAab
         smwr36fp7WOYftAeRvzqTtLTMoRTkY1RlwVkBKd4o2vxpLJWOe6ozb5P9ntM2HKwLiQO
         GYLCCugpsnnPcWVXPpZ9hqYklyBCpuNGAEn6I068BtEtVIlQuXOuE92+cCtaZLsgd2Q9
         vHqz6HIPJ0iVXR3aVsjFVzhDoXPDESwUnytu1VtqmKOzdeqj8to/HMfWG8SwYEFRc3kC
         minkouqdBBusqivhJeR7GzMNItSHRSlnYUXzV+I953LQkCUVrD0dPPH/AyeIL8cKSHJn
         Q5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I8h6IKACxQlXXVq1OeWv2JZIqExd2BXra4rChfH99Xk=;
        b=BU9cF6g3R+zSwe8tAHWn6pGyMaChYyy/WCVkrHrfKa5SIXu/cSqhyUgd2F2dcFYNo1
         8U9Bx4RsnOTy8IEh86UJZ4A8WyotV3Ln2A+lvqUfSJ+LmQapHNKOOxoMbeyMQTdj3Xnj
         z2wqkWq7M3bCaUb0xBTlnxOu9aNGtg/LH1PUkyg8NmzPh21U5PtqieweQQ3rA1zOIedv
         xsP5dS+6lk8RWlqPJNh12GydJorOYWtxDumGByBOYqLddfG0MjsiOOuA9MIzFgFjM+4l
         3vyJMqHPv+4nS5gcDgY5Afg7OGtHcfS7LgSNmLpx4Ft9VooxLZVIErJ74OMIo8a03WMo
         n8LQ==
X-Gm-Message-State: ACgBeo0Ic/qG8ge7CiBkfzCqyZUf/1ThNRK2IHdRmNxjn17FHlj0r/dC
        uKoKk6nzzrseOryrbsmavkE=
X-Google-Smtp-Source: AA6agR6KZCWm2WPTqfmyxsXJXyYXPDtajUhuPpJYX5iMpEbTFfpkYbV2J5gKHD8BN9cp+Wh+DQVtCA==
X-Received: by 2002:a2e:a9a9:0:b0:261:bf5a:8ff3 with SMTP id x41-20020a2ea9a9000000b00261bf5a8ff3mr6654761ljq.252.1662908256454;
        Sun, 11 Sep 2022 07:57:36 -0700 (PDT)
Received: from localhost (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id p39-20020a05651213a700b0048a9e18ae67sm636891lfa.84.2022.09.11.07.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 07:57:35 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: sunxi: sun4i-codec: set debugfs_prefix for CPU DAI component
Date:   Sun, 11 Sep 2022 17:57:12 +0300
Message-Id: <20220911145713.55199-2-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911145713.55199-1-mike.rudenko@gmail.com>
References: <20220911145713.55199-1-mike.rudenko@gmail.com>
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

At present, succesfull probing of H3 Codec results in an error

    debugfs: Directory '1c22c00.codec' with parent 'H3 Audio Codec' already present!

This is caused by a directory name conflict between codec
components. Fix it by setting debugfs_prefix for the CPU DAI
component.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 01b461c64d68..4d118f271e8c 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1253,6 +1253,7 @@ static const struct snd_soc_component_driver sun8i_a23_codec_codec = {
 
 static const struct snd_soc_component_driver sun4i_codec_component = {
 	.name = "sun4i-codec",
+	.debugfs_prefix = "dai",
 };
 
 #define SUN4I_CODEC_RATES	SNDRV_PCM_RATE_CONTINUOUS
-- 
2.37.3

