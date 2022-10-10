Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A135A5FA3C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJJSy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJJSyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:54:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D11277D;
        Mon, 10 Oct 2022 11:54:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l8so7347981wmi.2;
        Mon, 10 Oct 2022 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVHRCzHetDvm9wFuZO6DUfd6buOnzVOKnDaUC6gkHgg=;
        b=jfbUGf2qG4IgfJsaHgHZk8iGMLIN7QzdQ/644DGpNwElmy8Ne41kJG5u6avyUwAw/e
         QkdXRLRFzTF3RA/3jIMsSU+zWhasOwQBYtt62fwn+qQiDcRaEPaNKn0zkkSy8jG/JnVD
         mQWkXSJG82oCEtGSutcz43dCXX4Pn86SrHAb/dr4tOCDe4Fborpfhu7uQcfZaoMLAn5u
         YsABV+V4e7bDt06q3JHnizc1nQtkMLiSjM3m6HlUwhUI97Gh57HrRdfkC5VoLdgzE0MA
         OILLU5nM5VKsgLd/CfaS1gGn0oFi7gBLY0GinTUjjMwW6cwib/zxvZRAViXo5Xr7Gg8s
         0xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVHRCzHetDvm9wFuZO6DUfd6buOnzVOKnDaUC6gkHgg=;
        b=2lBmrM+pWLX9VkvKAMWYDOX0x8c01l2s2/LpDDU3HsQL+d1YQDOagLvzqHXkIgGcVj
         vkV2L3NRz/m6On9/gHfejtD5r0yrn/ppOzKwxrAS/pvFZaT9QtsW0eHglmqLmFWfaytD
         lTidFqisSPP3/99jDkHQJMqfxQK5dhxExKU/Exl708RqpifCjA3uacszE+5RLmdqpF9N
         ZRT/2ejUynqB0xqYUV3ieqKzS5xos79LmuFYTdKq66QTLvWnFA2+fOy25//84NpPpQR7
         YzCggwjvAqx4OM+VbnG7shqClLo/MJQOZs06fhiNpxMuMNN3ZPkIC//ocJ22FmydJs9U
         eXTg==
X-Gm-Message-State: ACrzQf1rf0p1EmPRXbAIfhvRQ2itlj+G1haxzhCrDIwpxOeYC6n3GsHC
        oR4P1AUuRe6ZBfPZeP4Jpwo=
X-Google-Smtp-Source: AMsMyM4tdgFZLMNaM0VNDRNGTFwZOVm1CPhn49eMPbP9JTq/VNtHdoJKIa/pN5LXqjpWz6uZYjqq8Q==
X-Received: by 2002:a05:600c:4f01:b0:3b4:a8c8:2523 with SMTP id l1-20020a05600c4f0100b003b4a8c82523mr20678176wmq.199.1665428089025;
        Mon, 10 Oct 2022 11:54:49 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-126-34-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.34.126])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d6142000000b00230c9d427f9sm2082272wrt.53.2022.10.10.11.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:54:48 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] ASoC: codecs: jz4725b: Various improvements and fixes
Date:   Mon, 10 Oct 2022 21:54:17 +0300
Message-Id: <20221010185423.3167208-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <Y0P/u4pJT8rup8Za@sirena.org.uk>
References: <Y0P/u4pJT8rup8Za@sirena.org.uk>
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

Known issues:
 - Bypass path enablement isn't applied immediately, for make
   things going bit clock needs to be triggered for a bit,
   e.g. by aplay dummy.wav
   It might be a hardware bug, since the bit clock isn't
   declared as required for codec operation.

Tested on:
 - Ritmix RZX-27 (jz4725b).
 - Ritmix RZX-50 (jz4755).

Diff from v1:
 - each change in a separate patch

Tested-by: Siarhei Volkau <lis8215@gmail.com>
Signed-off-by: Siarhei Volkau <lis8215@gmail.com>

Siarhei Volkau (6):
  ASoC: codecs: jz4725b: add missed Line In power control bit
  ASoC: codecs: jz4725b: fix reported volume for Master ctl
  ASoC: codecs: jz4725b: use right control for Capture Volume
  ASoC: codecs: jz4725b: fix capture selector naming
  ASoC: codecs: jz4725b: use right control for Master Playback
  ASoC: codecs: jz4725b: add missed Mixer inputs

 sound/soc/codecs/jz4725b.c | 81 ++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 11 deletions(-)

-- 
2.36.1

