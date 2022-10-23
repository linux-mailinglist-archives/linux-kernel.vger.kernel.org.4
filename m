Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3886093F2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiJWOd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiJWOdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:33:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861FB61B37;
        Sun, 23 Oct 2022 07:33:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l14so4849148wrw.2;
        Sun, 23 Oct 2022 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgkOKKf/r2OGCWExBVS97xfrlAiQor24qr6UWM7ySCA=;
        b=d5znD320WrBQPpNajiAV1FbaEXpWVRYEuHhL6yMAAcFsweM463/MFJk4or+SFApB8W
         R3ixebCz8X1OHntpr3Vm7QMSPfrmEnggUU9JJfYAQg5YugGPKFrcnKh0YE9roeMppJhr
         lRzOBdqBraKyILIm1OebYLb8G6Cqj7U32oXA+lkgB1R9IubrISzsnxT9heUFKhbYkzNf
         NqcgAxvuzmz1HIDabVBEZt25X8JKO8D1fj5ZK5lO3OrzD/9TPu7bDHskcy68HL8Lj5ev
         +kZliRjd2mxF5GOuKgmU70wn0aLY1kRFcYfA6Vuxbcq8jVXhKcbuv5GmEDCh3U5Urpkn
         ElvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgkOKKf/r2OGCWExBVS97xfrlAiQor24qr6UWM7ySCA=;
        b=WL/UmEByH2tdEMwacejNvBZ0OiZBkx9fu1aqljM0UTejMwK3E5yhnNuVz48ckHeKH9
         3jCMhKrjFBnAIUpZcrmnyWl7GUubj+uoEg0+yzKeP7Ya69pAsBT+L6lLKKwxoBjLjdQB
         +Jb+0Oae1NDRqCa9AnW4vW3+7n17fZ09zv14WKZZGoMe8m8Rn+ek/rgQhUGlDrkZUCGa
         yJrIqGVEPs1OvqGQD+pwacUCKTBH9EMC0PGrwdqZs6EcI7m5i53h2J19+Bp9psIP/T8q
         8NxLn34lOyKLOfmAas7Kgaaqjl1m2mz3JT+CL5jWxekGWsKOUR4NZ3ckuZf4xDb/ql6I
         xgbg==
X-Gm-Message-State: ACrzQf2SOj28nLpYFBx6jYzzRM7F7ztRVH7v7mYGKW0kVyCH9MMi+QQb
        ufRdS9oDgdFx9Hm0s0b8Z0K1cbh90FA=
X-Google-Smtp-Source: AMsMyM5bcQM2MKqwoGS/BPzoGUyPJkJL/qm7XXjx4Drf1ovMAqYQs6V6EvnEXdbxs2i99jVt/6FWqg==
X-Received: by 2002:a5d:4bcd:0:b0:236:6b67:a5be with SMTP id l13-20020a5d4bcd000000b002366b67a5bemr1858078wrt.81.1666535619095;
        Sun, 23 Oct 2022 07:33:39 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id f18-20020adff452000000b0022584c82c80sm23726047wrp.19.2022.10.23.07.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:33:38 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/9] ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
Date:   Sun, 23 Oct 2022 15:33:25 +0100
Message-Id: <20221023143328.160866-7-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
References: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
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

The audio controller on JZ47xx SoCs can transfer 20- and 24-bit
samples in the FIFO, so allow those formats to be used with the
I2S driver. Although the FIFO doesn't care about the in-memory
sample format, we only support 4-byte format variants because the
DMA controller on these SoCs cannot transfer in 3-byte multiples.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index c3235e993ffb..fd35a8a51f60 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -237,9 +237,15 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S8:
 		sample_size = 0;
 		break;
-	case SNDRV_PCM_FORMAT_S16:
+	case SNDRV_PCM_FORMAT_S16_LE:
 		sample_size = 1;
 		break;
+	case SNDRV_PCM_FORMAT_S20_LE:
+		sample_size = 3;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		sample_size = 4;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -374,7 +380,9 @@ static const struct snd_soc_dai_ops jz4740_i2s_dai_ops = {
 };
 
 #define JZ4740_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | \
-		SNDRV_PCM_FMTBIT_S16_LE)
+			 SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
 
 static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
-- 
2.38.1

