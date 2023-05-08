Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489326FAD30
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbjEHLcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbjEHLbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:31:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A007E3D211
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:31:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac7462d9f1so49314451fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1683545461; x=1686137461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymKooIYpnS0yXmXMVqwK3LSKOegi+Ec1cIWEbDw6jNE=;
        b=EkbqMgpAbp9yuEgOG1A3wXusm0aFuxDIqSVict33dumhnUUCzPqZz/659moGrwOhHF
         pPFk+3yCI4QXcUi01EhSOBw6VaAiHtQPM+YIMzA/2+qi7olUCEk3u6uDy6A2v+8NQ2zK
         ZnZ8RpyT9XAfSuCIsajRwnGBkA/LT9BBPy2uK+9KuAlJZ70s0z/DkhmcR/+MLKSseZ39
         3WZg6CT0HDHuiKqwgjwg7prejSMg5M1t4v+TP+dat13Mf0wDnfP2JIzfd9rgkmr24x63
         G8P6wTgwuIp/0vi7wl2VIM5kk47T2Xj7Cka51IRwAm6KoWVs4p1sfhGcV93fJMslV/tE
         +rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545461; x=1686137461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymKooIYpnS0yXmXMVqwK3LSKOegi+Ec1cIWEbDw6jNE=;
        b=GAA/lRWrz+rX03QA78yOT88Ma6ixcD+AY1xCp0RbDEU6K55ah0hIwzdzn3sGiZT/41
         Lw53sTvJ2UpqlfWHlE8XgedL32HWn/7UUWxihlc6+aG1HCIcykH9wFCa8/1++xN9QL8e
         jTbtiiX25Eh31L0GVwwEtr0ybWNEQrgAO7E+8SHDTCdwLA1/k3UolowpCRurHERTeLZb
         ++mPB9yNyDBJFoD/DWp5/5KZ1xI/ahp6vPdgep1jUMjeE98rs1qVoho98B6Ahz+9Fxs3
         euF37s8Eb1udvdvdoth6FY8UxecwpAYxNPGF4dKTv+Ix4r9m5+AgPwJqm+FB0+W3laYF
         yEyQ==
X-Gm-Message-State: AC+VfDyTXFafs1FexwF1C3/7uW3CkxZAF9YgXhLkmuuJ1oGDgECEQIuL
        Ha44Dark6hMqwD7zmo1EwiJ9ZA==
X-Google-Smtp-Source: ACHHUZ7Xo1m77SC9+1H52SaylyUjEYosNnuWegDfTXW98eJ0YFRyE7rIxq+OofISewu6mn1JhUksog==
X-Received: by 2002:a2e:9d87:0:b0:2a8:a629:c203 with SMTP id c7-20020a2e9d87000000b002a8a629c203mr2801101ljj.32.1683545461381;
        Mon, 08 May 2023 04:31:01 -0700 (PDT)
Received: from panikiel.office.semihalf.net ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id k8-20020a2e2408000000b002a8b9353338sm1144406ljk.117.2023.05.08.04.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:31:01 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        amstan@chromium.org,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v2 7/7] ASoC: ssm2602: Add workaround for playback distortions
Date:   Mon,  8 May 2023 13:30:37 +0200
Message-ID: <20230508113037.137627-8-pan@semihalf.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230508113037.137627-1-pan@semihalf.com>
References: <20230508113037.137627-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply a workaround for what appears to be a hardware quirk.

The problem seems to happen when enabling "whole chip power" (bit D7
register R6) for the very first time after the chip receives power. If
either "output" (D4) or "DAC" (D3) aren't powered on at that time,
playback becomes very distorted later on.

This happens on the Google Chameleon v3, as well as on a ZYBO Z7-10:
https://ez.analog.com/audio/f/q-a/543726/solved-ssm2603-right-output-offset-issue/480229
I suspect this happens only when using an external MCLK signal (which
is the case for both of these boards).

Here are some experiments run on a Google Chameleon v3. These were run
in userspace using a wrapper around the i2cset utility:
ssmset() {
        i2cset -y 0 0x1a $(($1*2)) $2
}

For each of the following sequences, we apply power to the ssm2603
chip, set the configuration registers R0-R5 and R7-R8, run the selected
sequence, and check for distortions on playback.

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x07 # chip, out, dac
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

For each of the following sequences, we apply power to the ssm2603
chip, run the selected sequence, issue a reset with R15, configure
R0-R5 and R7-R8, run one of the NOT OK sequences from above, and check
for distortions.

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

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 sound/soc/codecs/ssm2602.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 00b60369b029..c29324403e9d 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -53,6 +53,18 @@ static const struct reg_default ssm2602_reg[SSM2602_CACHEREGNUM] = {
 	{ .reg = 0x09, .def = 0x0000 }
 };
 
+/*
+ * ssm2602 register patch
+ * Workaround for playback distortions after power up: activates digital
+ * core, and then powers on output, DAC, and whole chip at the same time
+ */
+
+static const struct reg_sequence ssm2602_patch[] = {
+	{ SSM2602_ACTIVE, 0x01 },
+	{ SSM2602_PWR,    0x07 },
+	{ SSM2602_RESET,  0x00 },
+};
+
 
 /*Appending several "None"s just for OSS mixer use*/
 static const char *ssm2602_input_select[] = {
@@ -598,6 +610,9 @@ static int ssm260x_component_probe(struct snd_soc_component *component)
 		return ret;
 	}
 
+	regmap_register_patch(ssm2602->regmap, ssm2602_patch,
+			      ARRAY_SIZE(ssm2602_patch));
+
 	/* set the update bits */
 	regmap_update_bits(ssm2602->regmap, SSM2602_LINVOL,
 			    LINVOL_LRIN_BOTH, LINVOL_LRIN_BOTH);
-- 
2.40.1.521.gf1e218fcd8-goog

