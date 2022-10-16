Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ACB5FFF92
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 15:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJPN1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJPN1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 09:27:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7152AC4;
        Sun, 16 Oct 2022 06:27:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e18so12653690edj.3;
        Sun, 16 Oct 2022 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0pRjLS8S0PBxvIWJSoyY51V6LZOLpxOkz9SWeH8SHE=;
        b=NCMNDhejEEGVm1W69lUOCI+DchetA+MgaOx5qqbVKe3kee03N9vBT8pYLlTixJD/9C
         Yq8m8iZx3A5WzJfc5ll79p9U29FVKFQYGLcqFYsr6RvOQOJmyIfTbOR0MEDRsDCsbGqj
         WUROdLUIdlHEwhng4cjnd8+XTYT486X8EjhpQaVeLQ3qQX0YiSY0uzETlA38HK6Y7ufl
         Icc/Lxgo0htF5D96lu9fzo/Of/VZDkZO1ZIWbJHy5xK4fijJ9Go0/wa7yDY3F87zKCQq
         svQ1Sf4aoTCrSnL7lMWs+oiARRhbDxddsa2Fh3UnCbad63h1M+5C9/IGNZAmKl7EXvwJ
         YxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0pRjLS8S0PBxvIWJSoyY51V6LZOLpxOkz9SWeH8SHE=;
        b=d9lJbBegXIUbLQ8l5AFNuDn0ar6oMkA1cdh+irCPpaaIugVa/qQrsZVYbjezcoYjDV
         bxsPGHy6vsBMSO0nfGTCaDedP8Msk9zqm5qeKm3VMHcAeLwExSMy+h97avpCjKVMcRfV
         a835qKUUb0f6+3/KW4ITTij0aNU174w16HOgiBr/2z0OJIst6k1DTzXQ8jAf6Mlli9l7
         9wJ46KnecymG7KjDTJ9DK4aNGwGa3wnTJ3cxFFnxyoP7fQvmAGUlTLRgwd1dAU61P2GP
         nHgbngPe9iQF6X42kYw/reaYr5I49W1wDE00RZQBLj3pFf5hFNsnMNA8Qvss5d5XNcZ+
         ubow==
X-Gm-Message-State: ACrzQf0FI5Qa0pPguPh8cntbCIqfa1WDgwFwQDh5P0KXmkn/4g1VO5j9
        vpj63xZWAujQhIMvgyeOFAhhAvGajPQ=
X-Google-Smtp-Source: AMsMyM4fSSRavTWL7SmHWcMKtrO3qApNIGTTdSzzFZPUnCfbxlbFWcRRVR9HBztsSUqXDWRt0O+w7g==
X-Received: by 2002:a05:6402:3806:b0:450:bad8:8cd5 with SMTP id es6-20020a056402380600b00450bad88cd5mr6315125edb.305.1665926863106;
        Sun, 16 Oct 2022 06:27:43 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7ce85000000b0045c72bba0bfsm5572057edv.4.2022.10.16.06.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 06:27:42 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] ASoC: codecs: jz4725b: Various improvements and fixes
Date:   Sun, 16 Oct 2022 16:26:41 +0300
Message-Id: <20221016132648.3011729-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The patchset fixes:
 - Line In path stays powered off during capturing or
   bypass to mixer.
 - incorrectly represented dB values in alsamixer, et al.
 - incorrect represented Capture input selector in alsamixer
   in Playback tab.
 - wrong control selected as Capture Master

The patchset improves:
 - Exposes output stage (post mixer) gain control and makes it new
   Master playback gain, DAC gain was the previous master.
   However, no Master mute now.
 - Exposes all mixer inputs (both Mics, LineIn and DAC) with their
   gain controls.
 - Exposes microphones widgets: single/differential input, boost.

Known issues:
 - Bypass path enablement isn't applied immediately, for make
   things going bit clock needs to be triggered for a bit,
   e.g. by aplay dummy.wav
   It might be a hardware bug, since the bit clock isn't
   declared as required for codec operation.

Tested on:
 - Ritmix RZX-27 (jz4725b).
 - Ritmix RZX-50 (jz4755).

Diff from v2:
 - add microphone widgets

Diff from v1:
 - each change in a separate patch

Tested-by: Siarhei Volkau <lis8215@gmail.com>
Signed-off-by: Siarhei Volkau <lis8215@gmail.com>

Siarhei Volkau (7):
  ASoC: codecs: jz4725b: add missed Line In power control bit
  ASoC: codecs: jz4725b: fix reported volume for Master ctl
  ASoC: codecs: jz4725b: use right control for Capture Volume
  ASoC: codecs: jz4725b: fix capture selector naming
  ASoC: codecs: jz4725b: use right control for Master Playback
  ASoC: codecs: jz4725b: add missed Mixer inputs
  ASoC: codecs: jz4725b: add missed microphone widgets

 sound/soc/codecs/jz4725b.c | 109 +++++++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 17 deletions(-)

-- 
2.36.1

