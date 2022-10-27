Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42A0641B5F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 08:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiLDHw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 02:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiLDHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 02:52:25 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E4D1741F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 23:52:20 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s7so8233477plk.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 23:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy74VsRO4WDPI6duqo1jqOxf/w5vgZYHdL8GT2SYMKg=;
        b=Jw4FnLuJ+jHl0BSAyl3TtY86/dftI5rnmt/qMEW1qO5gY8ZDQk3b57YXQQRFj5oUCz
         eAgTSCgK4/tmZfi5MGIHXtTlWKXF2GaH/Oxg2FUUm2dAMhP1nvrZ6QP9F/QA2ZaeuvWT
         pJu/mnQ3o/JPwRqtovDvZXGkSEIIRHlHFVT+p+8skpKD+5tvNAwX+IN4aNU407LjJh4B
         t7phY5mX+5UIcKWzxtuUUVDMQ1T0dsOouuihhxjqvET5Ecp/4186JcNWijIxk87kyWiv
         oaLo+RZ2grrBm0K8JibwpwX4TflORxUCM+w/O7s66w3qNDEZhawqTSWypR4dhLdMQzck
         5VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iy74VsRO4WDPI6duqo1jqOxf/w5vgZYHdL8GT2SYMKg=;
        b=iSScgYPFssei7OniA9e8rszuUTYvxl3ZOFzTM2oipFedlbepH8VYoXNIEsqhZaW0WT
         QgwMHDGuR/hIDk8rn+KuNiuycdib8yXXrgIRIB/jQMqkEZrFgQNddQapYAzorWW4AjXz
         54ZLO9i1DBhvLBCkK1F6W1pxjGJHiVwrcQXIyxeNUcSn1wqnS69OWnXu0RxOljb9NHSZ
         HAIabds9bkLZGe9ykVpA1PAPtkKFlnkwZnCHngPKDbDnm4nutKIDzqmlKxN1jw9WNosx
         wDZ0IwwFMOxuflDXBSngR9jovk8wND6gcab2utGnTLstl+WDVPjB5psR0z0tAvtYa0tb
         1pQg==
X-Gm-Message-State: ANoB5pk7paY7QftjGEaUuxzJ2DgYygt6++TQzCiJLzqj2QPFXhaCO9be
        gG24YAviPCzLS1J4pWVKp3FJ3g==
X-Google-Smtp-Source: AA0mqf4zSRaazgQAKjeUr6basv8jmHb6EMNYytiMvHs1gkkIZuSqDhopNiFXwoNfP1YQ/VQOsZt1Tg==
X-Received: by 2002:a17:902:9889:b0:186:5f82:3812 with SMTP id s9-20020a170902988900b001865f823812mr67403855plp.51.1670140339513;
        Sat, 03 Dec 2022 23:52:19 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b00218abadb6a8sm7160900pjb.49.2022.12.03.23.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 23:52:18 -0800 (PST)
Message-ID: <638c51b2.170a0220.49853.d549@mx.google.com>
From:   Daniel Beer <daniel.beer@igorinstitute.com>
Date:   Thu, 27 Oct 2022 21:38:38 +1300
Subject: [PATCH v2 2/2] ASoC: tas5805m: add missing page switch.
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Andy Liu <andy-liu@ti.com>, Mark Brown <broonie@kernel.org>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tas5805m_refresh, we switch pages to update the DSP volume control,
but we need to switch back to page 0 before trying to alter the
soft-mute control. This latter page-switch was missing.

Fixes: ec45268467f4 ("ASoC: add support for TAS5805M digital amplifier")
Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
---
 sound/soc/codecs/tas5805m.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tas5805m.c b/sound/soc/codecs/tas5805m.c
index 6e2edf045446..4e38eb7acea1 100644
--- a/sound/soc/codecs/tas5805m.c
+++ b/sound/soc/codecs/tas5805m.c
@@ -203,6 +203,9 @@ static void tas5805m_refresh(struct tas5805m_priv *tas5805m)
 	set_dsp_scale(rm, 0x24, tas5805m->vol[0]);
 	set_dsp_scale(rm, 0x28, tas5805m->vol[1]);
 
+	regmap_write(rm, REG_PAGE, 0x00);
+	regmap_write(rm, REG_BOOK, 0x00);
+
 	/* Set/clear digital soft-mute */
 	regmap_write(rm, REG_DEVICE_CTRL_2,
 		(tas5805m->is_muted ? DCTRL2_MUTE : 0) |
-- 
2.38.1

