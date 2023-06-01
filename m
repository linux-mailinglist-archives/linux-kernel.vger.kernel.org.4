Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C3F719CED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjFANGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjFANGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:06:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89069124
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:06:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2568fc3d8a9so240430a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685624779; x=1688216779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+80VYIfhjZ5fSjcUibNsG+b2Hi4A7lyy0lDCFEbZBs=;
        b=RdSP/OEUyw387gUXs4br35uVFKo5guW8++Hou3cYfb7YCLhJMNQHx0nY5w8nffjBkM
         DddJF2l7xiFfCvYAErVvbOKXfXK87LvjsJyA1Wn1/uGZEg6vADkS6jE+tfwI+Yp9H3Jw
         2pkiNKyMxdsBS+3ZLMANxPjzX0Pm/VO4EJkb9FGd2St73BTQStxSN1CXVYXLWE50MBsB
         fwYmcu2bUrLeWKCerok1e7fFLabA58hrgW56dnTDv6ls37XYC1yS7V/fVcMMkbLS9u3h
         qYOP+U4DY3n3gNtJavEp19/1aICn9Y/ZtpQf2jdHQE8+ylIove6pIe9U6hVMfZEbRSN7
         1oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685624779; x=1688216779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+80VYIfhjZ5fSjcUibNsG+b2Hi4A7lyy0lDCFEbZBs=;
        b=BdAxgT/umuOsGo2W8LhJaZi4PshpzWTNbsTcgCAVgTsr8Tb/7GL6mgrvZu8MUITNzM
         BW1LAOEUq4nI+X2CNLo3MgN6Hlq49e3pfqqNmI9HwAsGFOYapFKnhGq031XWQqGvutMA
         60rGI7t7Os+qYlfurHucZt1ac4XWR8idp1L2ZlFdF0ff786Mh8kPFZR/M7CkcVqir6Ot
         tzcksaI+hUM0rkot65hQlmRk4hKPDf7fWGYx0yccUox7oEsUnQEnuyK65TGtm1XnFXwP
         cqgq4DAgh/jhzULThnjcRsAtb7tT9/XVyBOLqrXkXGPfMG5NnQp+mHwgEOUcl9hRt04f
         I7zQ==
X-Gm-Message-State: AC+VfDye4LHlJFhPuLy2sCa8ksnRd5kzuTtKdKPg/DGmPmCv9x5WunHG
        gWHHFXp0KqmiV1oh5amIRuo=
X-Google-Smtp-Source: ACHHUZ4/y8r7bunqlmbBydPYg4Y2Y9+zIUnPo4YaUaKfFxXcl6U6oJWx60TAFQel2zyVw3KAkTfULw==
X-Received: by 2002:a17:90b:17ca:b0:253:572f:79b2 with SMTP id me10-20020a17090b17ca00b00253572f79b2mr6352859pjb.36.1685624778892;
        Thu, 01 Jun 2023 06:06:18 -0700 (PDT)
Received: from ryan-ThinkPad-T470.. (c-24-6-63-212.hsd1.ca.comcast.net. [24.6.63.212])
        by smtp.gmail.com with ESMTPSA id s34-20020a17090a2f2500b0024df6bbf5d8sm1430096pjd.30.2023.06.01.06.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 06:06:18 -0700 (PDT)
From:   =?UTF-8?q?=E2=80=9CRyan?= <ryan.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ryans.lee@analog.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     jairaj.arava@intel.com
Subject: [PATCH 2/2] ASoC: max98363: limit the number of channel to 1
Date:   Thu,  1 Jun 2023 06:06:00 -0700
Message-Id: <20230601130600.25344-2-ryan.lee.analog@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601130600.25344-1-ryan.lee.analog@gmail.com>
References: <20230601130600.25344-1-ryan.lee.analog@gmail.com>
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

From: Ryan Lee <ryans.lee@analog.com>

MAX98363 is a mono amplifier. The number of channel needs to be always 1.

Signed-off-by: Ryan Lee <ryans.lee@analog.com>
---
 sound/soc/codecs/max98363.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98363.c b/sound/soc/codecs/max98363.c
index 8aa9d9c67aa2..7f5062ac4523 100644
--- a/sound/soc/codecs/max98363.c
+++ b/sound/soc/codecs/max98363.c
@@ -246,7 +246,7 @@ static int max98363_sdw_dai_hw_params(struct snd_pcm_substream *substream,
 	stream_config.frame_rate = params_rate(params);
 	stream_config.bps = snd_pcm_format_width(params_format(params));
 	stream_config.direction = direction;
-	stream_config.ch_count = params_channels(params);
+	stream_config.ch_count = 1;
 
 	if (stream_config.ch_count > runtime->hw.channels_max) {
 		stream_config.ch_count = runtime->hw.channels_max;
-- 
2.34.1

