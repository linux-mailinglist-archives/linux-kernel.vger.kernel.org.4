Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AE55FA3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJJSzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJJSzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:55:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C2D1FCE6;
        Mon, 10 Oct 2022 11:54:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv10so14760967wrb.4;
        Mon, 10 Oct 2022 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgjnL3yJFZCJQlhIdQSv+6Wq7/0/ChyARgbD78LiZt8=;
        b=SXLeDxlZKzSU20+a1UbGy9WlYL5HM66nyKdRI3rS8adCzdjWbQjdfSM6pFIjOKxC3K
         Hw3SOxN6gkB4nN8G3h64shQfIxCmFuICQPh23XefWS0K81lMRqK4TAHi47C9XXM17/lo
         nSvEuS8q8yx+Hx6SGD34zXeoy/rRI/NsEA2u1TvUDvV8DbhV8RaMIUlaCa6UJUoA3lVw
         5ukssilKa8N5j3Jt+rFFtDlap8le9+q/wjJsS8aKw9gyHLLTgTDBRKz8ecS3FOfj5kPK
         4TO358e85so4OdepYeEqlmgKrEk245q1BpAfRzqLcQVvSbAva59OA/mu1Zg3WQEblfnq
         JZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgjnL3yJFZCJQlhIdQSv+6Wq7/0/ChyARgbD78LiZt8=;
        b=AXQEeuBhKKY9y6WQdN+zsSvAPuPvW2jBaG8xAofG/qnlG63QPYT51VoNtZt7HCrBy+
         UFwI7FWMOi7joj2ejwSiEUjOhijVmZjBUNDCnE+GXCJdNMRmAX+1VpxsuiiwlcFuFlsm
         zUYqM6+4he0/6QZhVy/Ibv9PIgcSdrjzb80jc5+pYbFv9e38877ezaxegFVA2pUNQhjX
         24MQQ0DdNJvCBmAxV50ORnMUtA+xKPNrwE7sw6GxofeEjEcJApfy6GZ3YOn/t6e4NNH/
         rWiAP/mLRiNWT5fttRhmJ0Tb1v+6xARitS3j4JLOc2mPTnhmCoruwFikrZuM12n5uQ7E
         eoxA==
X-Gm-Message-State: ACrzQf2rZGPm/MXVfBZbb8Vv63b5ygdPrEAaJ0Sog8sOg7AXbg0zzHJ2
        Gv30yaI9hv/KYmqFos6JBf+7Db5bFILTQg==
X-Google-Smtp-Source: AMsMyM5WpCK09mLrSkdRSBj2tSAXxmmJ0WSK7QFNuuMenex8WRursQD9ixHa29Ngvj2NqkAWQBju3A==
X-Received: by 2002:a5d:588f:0:b0:22a:fe0c:afb8 with SMTP id n15-20020a5d588f000000b0022afe0cafb8mr13243806wrf.431.1665428098355;
        Mon, 10 Oct 2022 11:54:58 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-126-34-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.34.126])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d6142000000b00230c9d427f9sm2082272wrt.53.2022.10.10.11.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:54:57 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ASoC: codecs: jz4725b: use right control for Master Playback
Date:   Mon, 10 Oct 2022 21:54:22 +0300
Message-Id: <20221010185423.3167208-6-lis8215@gmail.com>
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

At the moment DAC control is used as Master Playback control, this is
incorrect as DAC's output goes to a Mixer.

The Mixer couples analog input from 4 sources (DAC, Line In, Mic 1,
 Mic 2) each input has its own gain & mute controls.

Output of the Mixer goes to Output Stage control which is the best suite
for the new Playback Master. However, it doesn't have mute capability.

The patch implements Output Stage control as a new master and renames
old Master to DAC. Rest of mixer inputs will be implemented in the next
patch in the series.

Manual states that Output stage control (16.6.3.5 Programmable output
amplifier: PGAT) gain varies from -33.5dB to +4.5dB, gain step isn't
fixed and has 3 opts.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 3f9bbd79d..6614c5e37 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -136,6 +136,12 @@ enum {
 #define REG_CGR3_GO1L_OFFSET		0
 #define REG_CGR3_GO1L_MASK		(0x1f << REG_CGR3_GO1L_OFFSET)
 
+#define REG_CGR8_GOR_OFFSET		0
+#define REG_CGR8_GOR_MASK		(0x1f << REG_CGR8_GOR_OFFSET)
+
+#define REG_CGR9_GOL_OFFSET		0
+#define REG_CGR9_GOL_MASK		(0x1f << REG_CGR9_GOL_OFFSET)
+
 #define REG_CGR10_GIL_OFFSET		0
 #define REG_CGR10_GIR_OFFSET		4
 
@@ -147,9 +153,14 @@ struct jz_icdc {
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_adc_tlv,     0, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_dac_tlv, -2250, 150, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(jz4725b_out_tlv,
+	 0, 11, TLV_DB_SCALE_ITEM(-3350, 200, 0),
+	12, 23, TLV_DB_SCALE_ITEM(-1050, 100, 0),
+	24, 31, TLV_DB_SCALE_ITEM(  100,  50, 0),
+);
 
 static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
-	SOC_DOUBLE_TLV("Master Playback Volume",
+	SOC_DOUBLE_TLV("DAC Playback Volume",
 		       JZ4725B_CODEC_REG_CGR1,
 		       REG_CGR1_GODL_OFFSET,
 		       REG_CGR1_GODR_OFFSET,
@@ -160,7 +171,13 @@ static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 		       REG_CGR10_GIR_OFFSET,
 		       0xf, 0, jz4725b_adc_tlv),
 
-	SOC_SINGLE("Master Playback Switch", JZ4725B_CODEC_REG_CR1,
+	SOC_DOUBLE_R_TLV("Master Playback Volume",
+			 JZ4725B_CODEC_REG_CGR9,
+			 JZ4725B_CODEC_REG_CGR8,
+			 REG_CGR8_GOR_OFFSET,
+			 0x1f, 1, jz4725b_out_tlv),
+
+	SOC_SINGLE("DAC Playback Switch", JZ4725B_CODEC_REG_CR1,
 		   REG_CR1_DAC_MUTE_OFFSET, 1, 1),
 
 	SOC_SINGLE("Deemphasize Filter Playback Switch",
-- 
2.36.1

