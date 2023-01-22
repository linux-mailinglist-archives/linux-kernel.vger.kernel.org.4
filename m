Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CC067728E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjAVVHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAVVHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:07:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341C41F93A;
        Sun, 22 Jan 2023 13:07:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so7255018wmq.0;
        Sun, 22 Jan 2023 13:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kCboDqVUUsDGgqRY72gSPVjixyNxdK1vSMMQPv4p8+U=;
        b=Rrp4V89fMuHgqiVMQpLfX9L+gVN/BTlzKsOMTLGHxO64PcM80m8UGAdVQ8cZ5c/bQp
         /Sb2lyij/Yik7BMMrFfxW0P2IV2KQyuAGWzy4bOiEJTLT4WopzSnucHyyD2GpkMvR2KT
         5PNwcObQx7VMkdkeKOW60V4R/9+JjzxRzAPqzwRf92rE69PRTh66MpJO5lYdatMcYBUH
         be8wuku3jJmGyKXmMRdy/92j2sbVKXm1LEgQnK8GkejiYYhfYn60ht6Ee0jxVfPzzFMQ
         M5G0mdTcmWVQUboTwALFhSJ+02+g9aGVHOS8Nw185wSicZNWhW39fh4iLNg5ExPP28Ee
         dzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCboDqVUUsDGgqRY72gSPVjixyNxdK1vSMMQPv4p8+U=;
        b=LRcmrq1JMqwjg2mgi7QlFQAvHGzOIb+UAOBQIHw7Kzdg2ju9r5EipmDtEI/fbij6Ep
         0JO3xwqWYYK1wMQo9ISOb+4P0hT+vMsas1B3fjm6BzgDFXsxN3nnXh5ZNVF/uhMiFBZ9
         hpu0D40+9XA/d7SPEgLQbn0mZTLDZaPvYavMXgO1RMPOesgQjRidelyhmciORG6QLXWf
         BHUERe7ldLMAu6+LvgRecEcdqQLvbhq0ZbxaFrOK6GMDjQ6/Ygpsnu/lTSCJPbXumROs
         GSu88YshCwYAorh4R2qDmQzsmMAnnYxa+PwFl2SI1olwZnvAVfFW8fa5PU6re4GmK/DW
         leWg==
X-Gm-Message-State: AFqh2koXpGBcmd2W56WxluB+Bd8aHmgJDnlrPIVGBOLnI4YkJv5hO9Jj
        u27twNY+kROy09WurPIQYwM=
X-Google-Smtp-Source: AMrXdXvQBrFKD6GvoZiyZVRXF/33cCqAKT8qkp6S0xHaAhZoxpWRnjl+rlHCvaeLceU3E2GMR1K9GA==
X-Received: by 2002:a05:600c:4e0f:b0:3db:3695:11b4 with SMTP id b15-20020a05600c4e0f00b003db369511b4mr9093682wmq.33.1674421629518;
        Sun, 22 Jan 2023 13:07:09 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-43c0-f52a-beed-541b.rev.sfr.net. [2a02:8428:46a0:7c01:43c0:f52a:beed:541b])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b003c6f8d30e40sm9822404wmq.31.2023.01.22.13.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 13:07:09 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH] ASoC: codecs/jz4760: add digital gain controls
Date:   Sun, 22 Jan 2023 22:07:03 +0100
Message-Id: <20230122210703.2552384-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the DAC and ADC have digital gain controls available
for their mixers, which go from -31 to 0db by step of 1db.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 sound/soc/codecs/jz4760.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/jz4760.c b/sound/soc/codecs/jz4760.c
index d96a4f6c9183..9df58e23d360 100644
--- a/sound/soc/codecs/jz4760.c
+++ b/sound/soc/codecs/jz4760.c
@@ -287,6 +287,7 @@ static const DECLARE_TLV_DB_MINMAX_MUTE(dac_tlv, -3100, 100);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, 0, 100, 0);
 static const DECLARE_TLV_DB_MINMAX(out_tlv, -2500, 100);
 static const DECLARE_TLV_DB_SCALE(linein_tlv, -2500, 100, 0);
+static const DECLARE_TLV_DB_MINMAX(mixer_tlv, -3100, 0);
 
 /* Unconditional controls. */
 static const struct snd_kcontrol_new jz4760_codec_snd_controls[] = {
@@ -299,6 +300,14 @@ static const struct snd_kcontrol_new jz4760_codec_snd_controls[] = {
 			 JZ4760_CODEC_REG_GCR4, JZ4760_CODEC_REG_GCR3,
 			 REG_GCR_GAIN_OFFSET, REG_GCR_GAIN_MAX, 1, linein_tlv),
 
+	SOC_SINGLE_TLV("Mixer Capture Volume",
+		       JZ4760_CODEC_REG_MIX1,
+		       REG_GCR_GAIN_OFFSET, REG_GCR_GAIN_MAX, 1, mixer_tlv),
+
+	SOC_SINGLE_TLV("Mixer Playback Volume",
+		       JZ4760_CODEC_REG_MIX2,
+		       REG_GCR_GAIN_OFFSET, REG_GCR_GAIN_MAX, 1, mixer_tlv),
+
 	SOC_SINGLE("High-Pass Filter Capture Switch",
 		   JZ4760_CODEC_REG_CR4,
 		   REG_CR4_ADC_HPF_OFFSET, 1, 0),
-- 
2.39.0

