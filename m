Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B116093E8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJWOdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJWOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:33:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D782B1032;
        Sun, 23 Oct 2022 07:33:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v11so5103188wmd.1;
        Sun, 23 Oct 2022 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUGeajMYAerRFQcOqcSIJ1LvScQ/5lPSyQp1+APgyBg=;
        b=NMxA7YjYwmFC7EMaBdm1k/rg1Sg6SL3DNDYSF9piNDMB26oEYDSuJPr9RZz2LI+IbX
         gzZBC/iDZIao94YxfWesLLKDqIQ2BOIoTfJFPBc8YDp3L+KYy4s+pjdpPIkBFLMGVbvP
         S8e4wGlNA1rKkMcCda7DtQsSmiy1dw0JjJEKiYuKdXualkP4PHSxhiNtEXVANHw1glo+
         pGIN6PhZyYAQkHwcHhDLO4RcRJMsOjjte5Z0Qsb2ehlJZkXM9mCsoPprItJkHWoplWTt
         h/AX24iKZ07DA33piY+5fHwqSxsoNnM4ExuXUgqejEX195YRO3faoVTSWANwFhpda/Us
         Au4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUGeajMYAerRFQcOqcSIJ1LvScQ/5lPSyQp1+APgyBg=;
        b=gGUctGQBHNH7dGBlFTno18MPSP4pWmH7Ea/lfNpJYn9sA773Nbpf9XPo9Groe4xXmK
         sJJhVrju8MI6JzVWoOdO2fhUjhD+UQmapSnL2Nu++1BbHRavWQuev3nPC1rcOn74zAlC
         cBF031HHa2L60vmmlkqBEiqoA+dcP2fPEBOLR7V6GU3dAqKnXF++IkRdEHkwxeaQBMFo
         /ss/x5L0o9EecayfcwcDiq1c9lzMz1oM2YXsHQ2xcAaNo5fBZoupjdWwCL6S+N5gAEzf
         WjSU76LbkB8OBFr/7sTfCMeNuueAfzzM9GSvZF4EOD7IUygAHPC6Pi3hZDex4ObFd8IN
         3O1A==
X-Gm-Message-State: ACrzQf1PXCyxFAf8I+FAHdSvnAgB6CZM7NHszQ83c7og62qwcud/na39
        lyoE1zXmcA/WaLAmDHGZFM2ntsea/bw=
X-Google-Smtp-Source: AMsMyM4lrHZdx1GnN4wpUqJBRPblfE99mI/Nrpbo9kMAbrO2up/+wV+u6FaSpxhHSqPJA3Pme44kxA==
X-Received: by 2002:a1c:770f:0:b0:3c8:33ba:150f with SMTP id t15-20020a1c770f000000b003c833ba150fmr7553451wmi.194.1666535611447;
        Sun, 23 Oct 2022 07:33:31 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id bu18-20020a056000079200b002302dc43d77sm10406023wrb.115.2022.10.23.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:33:30 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/9] ASoC: cleanups and improvements for jz4740-i2s
Date:   Sun, 23 Oct 2022 15:33:19 +0100
Message-Id: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a preparatory cleanup of the jz4740-i2s driver before
adding support for a new SoC. The two improvements are lifting
unnecessary restrictions on sample rates and formats -- the existing
ones appear to be derived from the limitations of the JZ4740's internal
codec and don't reflect the actual capabilities of the I2S controller.

I'm unable to test the series on any JZ47xx SoCs, but I have tested
on an X1000 (which is the SoC I'll be adding in a followup series).

Changes in v6:

* Added Cc: stable for flush bits fix.

Changes in v5:

* Drop 'mem' resource removal patch already upstream.
* Update FIFO flush bits fix to address Paul's review comments.
* Drop PLL clock name patch, that needs a different approach.

Link for v4: https://lore.kernel.org/alsa-devel/20220708160244.21933-1-aidanmacdonald.0x0@gmail.com/

Aidan MacDonald (9):
  ASoC: jz4740-i2s: Handle independent FIFO flush bits
  ASoC: jz4740-i2s: Convert to regmap API
  ASoC: jz4740-i2s: Simplify using regmap fields
  ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
  ASoC: jz4740-i2s: Align macro values and sort includes
  ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
  ASoC: jz4740-i2s: Support continuous sample rate
  ASoC: jz4740-i2s: Move component functions near the component driver
  ASoC: jz4740-i2s: Refactor DAI probe/remove ops as component ops

 sound/soc/jz4740/Kconfig      |   1 +
 sound/soc/jz4740/jz4740-i2s.c | 455 ++++++++++++++++++----------------
 2 files changed, 243 insertions(+), 213 deletions(-)

-- 
2.38.1

