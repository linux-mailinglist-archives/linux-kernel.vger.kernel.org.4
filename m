Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0956639985
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 08:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiK0H3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 02:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiK0H3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 02:29:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1EA13D28
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 23:29:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so10344723pjt.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 23:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+15f3T3+S3cU3nRipNryZJ4svWYzk/FzguyIiKQo5Y=;
        b=R+W/2Kk0/vwErqgTCVnwyJdA+49fCvdEw5R4Q3NlZCWvbQpbNIZWfbGScngPYJ6Eub
         Qkku9e2Vc6FV7h1ctudVvvNrEYrC6amRep79WGs311zLkdsynZP0QPGHEf4ND0mmzpFj
         C25yztKS7BnZWheWndZBqvYVDNmuC5NalsYophyEaY3KTnIbBKIwtWKRLFqtHFpP0Xk8
         yjBlszs/AQ60Wiv86BNIFnwm02bc0/U9U1IIww4LXexFiJw5HVb2ZsZyx5nghOWcO0DA
         Vq1T5ZZ5Hey9UlsTVw+K70nak6h95uM1Z2pxqLcp4J/zU4oBwhFj8ykn6kIUTUOQPdxJ
         bADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+15f3T3+S3cU3nRipNryZJ4svWYzk/FzguyIiKQo5Y=;
        b=x4obaADdqMBlVCHLulcsdVCiSEdBJkgkMsJKjpPoY57P1UatEZU47roCHjOcxZ6979
         aN1W9Kj3JzrY/5hFdLxrdnFxk2ZGEsk1hb+UG2W0qmUcI06MYXK5HNCeuWTIkqMXRgGg
         e8cZOtCflH8gZ6S/W1Qr5rJMVWJqva8/3KCSRXMXYpH82Q0wmI5NcNHD/mU2DVa29/OU
         60JY103VJcBc2DummvSyZoK7Men8daD21/CrN+usyudbKzjadfG2HcaW5Qx6gRXy8bec
         IBfCkWU99lON9Hi5EVRjaGTEi3SwYsyFvMtYueraCxAvAaE+N9jaYJmzaA6X59gEpgdF
         vUTA==
X-Gm-Message-State: ANoB5pl9JOEGXC+wM2dYQRvT0uIiuXN0AkQalbtYvnxqbAfpSOYNhjg/
        DUapU1HcfW1PEWLXelssRoAohKQfVnqLBw==
X-Google-Smtp-Source: AA0mqf6InhROC4XL8bT1IanMdMMMCSjQhLQ2R8kuioKvNmGLuRhHLl78r8THfEvxaQYvDKhb1R4iyg==
X-Received: by 2002:a17:902:a718:b0:189:7722:99d7 with SMTP id w24-20020a170902a71800b00189772299d7mr5479382plq.96.1669534151792;
        Sat, 26 Nov 2022 23:29:11 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id b23-20020aa79517000000b00574d7111c99sm2794396pfp.195.2022.11.26.23.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 23:29:11 -0800 (PST)
Message-ID: <638311c7.a70a0220.4e021.3abe@mx.google.com>
From:   Daniel Beer <daniel.beer@igorinstitute.com>
Date:   Thu, 27 Oct 2022 21:38:38 +1300
Subject: [PATCH 2/2] ASoC: tas5805m: add missing page switch.
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
index d720c67b9675..5cf7726904c2 100644
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

