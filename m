Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5736E2516
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjDNODq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjDNODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:03:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5981EAD36
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bx15so17066511ljb.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1681480970; x=1684072970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/pTs4z9rhsBzBw4ml9qs5JBHN4WLKpluPzA9XU/6Jk=;
        b=OXpk08I1AC9etobtye7i60c27lC4lj7/SZW9B5ttLpNUFKqf0S6rQ6xjLnu0O6h2DD
         rSG1RCCO6BeNy6NOLso/6J68yWcbnJ4MCO0bFEEK07LPLj66vlhIql0CIAKOAdAb9GMf
         /mNuvuM+bh5rghs6+bfmEU/hQmU6MFLUkIopX7dNWDZ6k3DniD+TkQlzdYDFlPRKdMRM
         VVi4SQyrVEx3XqVLJdWk9o2XfkRdnTfEoxMRjBRchUg5BfUo55RQiZHWx9feBm8xe4C1
         rbpklvVxxNTe6IeiPG1crcrDS90TCgdjp2ZjVW3NeU8bR+s7SwN0MdYEJuGEgYZNRO7B
         LujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480970; x=1684072970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/pTs4z9rhsBzBw4ml9qs5JBHN4WLKpluPzA9XU/6Jk=;
        b=g4Uy6qQP0pdfKQ/I0/zags5oMREYKnOgNXwmWewjqsswWNvQId6ql74mmTiJ/jqhc3
         CGuU5HRWtCaYGK4qUHZvQog7lGWr60qnKrqYm7EapkRyz/cux9B9zbzQ2TvgwQESQy7g
         nmsw2IG3zAc9q5Wy+UuX74+5KZBLSiC7xVMPylv+NUNBGPqLukieNhwQM8Bue6TodhAR
         UIEda2bKRe3kYRi5ZmfshAoSfkHljtcVEUwf5wD637HIVqAOeer/s1trdxR5POfgkCjc
         HGkpRWXqz60AZqeVi5m4Ewkn0OxKUYU5K1cd9FIV62eBkFrFfkm/IclKMPFnCyF3P6tZ
         lSvA==
X-Gm-Message-State: AAQBX9carFQscbVqFD7HesQDEC+71Ao9uHrcw3tRhbjtYtqIQYIDeNUN
        +HCdiSOFIReGTySV4uuzxGHWXg==
X-Google-Smtp-Source: AKy350a2jetYlrjNvabc9jILg3C4DgASyuZ+RZVm6baefXeSjrRJTfnzHFRX467sNw55w+dKiuBNqg==
X-Received: by 2002:a2e:978a:0:b0:2a8:ad32:3d59 with SMTP id y10-20020a2e978a000000b002a8ad323d59mr770788lji.9.1681480970216;
        Fri, 14 Apr 2023 07:02:50 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb2cf000000b002a76e2dedbcsm828684ljz.139.2023.04.14.07.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:02:49 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 6/9] ASoC: ssm2602: Add support for CLKDIV2
Date:   Fri, 14 Apr 2023 16:02:00 +0200
Message-ID: <20230414140203.707729-7-pan@semihalf.com>
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

The SSM260x chips have an internal MCLK /2 divider (bit D7 in register
R8). Add logic that allows for more MCLK values using this divider.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 sound/soc/codecs/ssm2602.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 021e0c860fa1..35c4743e756e 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -280,9 +280,12 @@ static inline int ssm2602_get_coeff(int mclk, int rate)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(ssm2602_coeff_table); i++) {
-		if (ssm2602_coeff_table[i].rate == rate &&
-			ssm2602_coeff_table[i].mclk == mclk)
-			return ssm2602_coeff_table[i].srate;
+		if (ssm2602_coeff_table[i].rate == rate) {
+			if (ssm2602_coeff_table[i].mclk == mclk)
+				return ssm2602_coeff_table[i].srate;
+			if (ssm2602_coeff_table[i].mclk == mclk / 2)
+				return ssm2602_coeff_table[i].srate | SRATE_CORECLK_DIV2;
+		}
 	}
 	return -EINVAL;
 }
@@ -365,18 +368,24 @@ static int ssm2602_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		switch (freq) {
 		case 12288000:
 		case 18432000:
+		case 24576000:
+		case 36864000:
 			ssm2602->sysclk_constraints = &ssm2602_constraints_12288000;
 			break;
 		case 11289600:
 		case 16934400:
+		case 22579200:
+		case 33868800:
 			ssm2602->sysclk_constraints = &ssm2602_constraints_11289600;
 			break;
 		case 12000000:
+		case 24000000:
 			ssm2602->sysclk_constraints = NULL;
 			break;
 		default:
 			return -EINVAL;
 		}
+
 		ssm2602->sysclk = freq;
 	} else {
 		unsigned int mask;
-- 
2.40.0.634.g4ca3ef3211-goog

