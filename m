Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2716E2512
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDNODn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjDNODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:03:34 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731FBA5DE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:01 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e8so783468ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1681480969; x=1684072969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BhiBeghWpmkkfmklnaJ7LFrAZ1yIM3t/W3PcrsTKic=;
        b=ZIvH3A0hDweRAj48aerjGTpcA9Lg0NU1e7NMCLoS5TAsG28rGY5S7MJJ7LbPV4gE60
         W3yYf12rm7y/sW/HEklbkSOvWJmDZWZQwiNpOVw7yVUoaxeeA7zFBZZ2zB5PR2zDlVC1
         Jzxwbywa7p9UNHh/9090nxIM5BcN7qcekxA/XokHqil/W1PBhRURVtoj6oU2VBK+otcw
         kw8969oMp59kuqP0RWc9XYTRRZzccaxfh74IrcxN4FN1C60ATu7fDzedKERcZi8/WvrA
         RwNOJP8JIaYO06sGP69Q2Ktqq3xpmsNOvXg03BYydaElGUOPwCRTFZOiF2qBZlKogThI
         ebPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480969; x=1684072969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BhiBeghWpmkkfmklnaJ7LFrAZ1yIM3t/W3PcrsTKic=;
        b=KUIWoRX/26/n0wCO+I12dA01Q3pXh3GC+BWEwdZ58EU8auNZ7ED9ZSRxLRqmxNG8MU
         R25V8e3S+XfdllK6c9EL+PU/Q7A7+YS6/scrOyeoSONmrrdPl+UsuNk2L0Nrw9J72gWK
         1KOcgGrHPwtN4mMkFkNL61WQndS7XYt1VRruulEkobGED9lWC6Xn2Uwdyh/PcIt8FUVb
         OazTV5ue7j51ih3JGwQGSL78BhLCQsNQT50yqd+bxgjD/JiIswoe37QQeyDez3Z5HVLn
         WZNQuzVk6OxbC+2WCza9sN0yIY2FhO7e3EV7dn+s7MdDGX0HyuE02QYzzIS/UDW3hMPl
         Rdpg==
X-Gm-Message-State: AAQBX9clQlZ6B6bKbcEhoDQ4/Rjx3IRHhpPvh+ShtYwnCP+OpkxcgVfy
        QA7UajeeFL5tt9m72cthK/b7Sg==
X-Google-Smtp-Source: AKy350aAUvPCStAOQkhJe5KNXKrPlT0yHPb0kYSRktYXq6/BaxKviwWfDLqFxScPxtJeHZ5xGmQ/WQ==
X-Received: by 2002:a2e:804b:0:b0:295:9906:64e4 with SMTP id p11-20020a2e804b000000b00295990664e4mr1768345ljg.2.1681480968304;
        Fri, 14 Apr 2023 07:02:48 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb2cf000000b002a76e2dedbcsm828684ljz.139.2023.04.14.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:02:47 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 5/9] ASoC: ssm2602: Add workaround for playback with external MCLK
Date:   Fri, 14 Apr 2023 16:01:59 +0200
Message-ID: <20230414140203.707729-6-pan@semihalf.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414140203.707729-1-pan@semihalf.com>
References: <20230414140203.707729-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply a workaround for what seems to be a hardware quirk: when using
an external MCLK signal, powering on Output and DAC for the first time
produces output distortions unless they're powered together with whole
chip power.

The workaround powers them on in probe for the first time, as doing it
later may be impossible (e.g. when starting playback while recording,
whole chip power will already be on).

Here are some initialization sequences run after all other control
registers were set (`ssmset reg val` sets the value of a register
via i2c):

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x07 # chip, out
  OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x87 # out, dac
  ssmset 0x06 0x07 # chip
  OK

  (disable MCLK)
  ssmset 0x09 0x01 # core
  ssmset 0x06 0x1f # chip
  ssmset 0x06 0x07 # out, dac
  (enable MCLK)
  OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x1f # chip
  ssmset 0x06 0x07 # out, dac
  NOT OK

  ssmset 0x06 0x1f # chip
  ssmset 0x09 0x01 # core
  ssmset 0x06 0x07 # out, dac
  NOT OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x0f # chip, out
  ssmset 0x06 0x07 # dac
  NOT OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x17 # chip, dac
  ssmset 0x06 0x07 # out
  NOT OK

Here are some sequences run at the very start before a sw reset (and
later using one of the NOT OK sequences from above):

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x07 # chip, out, dac
  OK

  (disable MCLK)
  ssmset 0x09 0x01 # core
  ssmset 0x06 0x07 # chip, out, dac
  (enable MCLK after reset)
  NOT OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x17 # chip, dac
  NOT OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x0f # chip, out
  NOT OK

  ssmset 0x06 0x07 # chip, out, dac
  NOT OK

This was tested on a Google Chameleon v3 board using an SSM2603 with an
external MCLK. This doesn't seem to just be a PCB issue, as this was
also observed on a ZYBO Z7-10:
https://ez.analog.com/audio/f/q-a/543726/solved-ssm2603-right-output-offset-issue/480229

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 sound/soc/codecs/ssm2602.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index cbbe83b85ada..021e0c860fa1 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -589,6 +589,17 @@ static int ssm260x_component_probe(struct snd_soc_component *component)
 		return ret;
 	}
 
+	/* Workaround for what seems to be a hardware quirk: when using an
+	 * external MCLK signal, powering on Output and DAC for the first
+	 * time produces output distortions unless they're powered together
+	 * with whole chip power. We power them here for the first time,
+	 * as doing it later may be impossible (e.g. when starting playback
+	 * while recording, whole chip power will already be on)
+	 */
+	regmap_write(ssm2602->regmap, SSM2602_ACTIVE, 0x01);
+	regmap_write(ssm2602->regmap, SSM2602_PWR,    0x07);
+	regmap_write(ssm2602->regmap, SSM2602_RESET,  0x00);
+
 	/* set the update bits */
 	regmap_update_bits(ssm2602->regmap, SSM2602_LINVOL,
 			    LINVOL_LRIN_BOTH, LINVOL_LRIN_BOTH);
-- 
2.40.0.634.g4ca3ef3211-goog

