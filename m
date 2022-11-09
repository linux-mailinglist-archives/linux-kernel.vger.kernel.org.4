Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F64162304D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKIQii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKIQiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:38:05 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48C81AF39
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:38:04 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id be13so26525038lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 08:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpXTzzsTu20XPUGJ5DoFqQgTxzAySWmD/o0USIl4Q7c=;
        b=ZvmKRSgpm7xR3LbQLB9UZw/n530C2QqBOI/9v6N5LETt1ngFIBejP+mEzFJPgBhQaG
         paQ8cqq3p5gMPdWmRllFXhEjVe6pmT1cZZU7jMZIjJdgUEiHIMbzkJp6JbC0tOuZkQAN
         JQpvhqxk+L2rx2r3HKE4sI9tT2earIcgutXI02JEuXkpVDsoiAV5hr/odCSKuD5HYCsX
         EzYlHM9zUsx94X1xcMtDjkCcZCh+Ejn3AKVmnQiddR17VniiqLnnT9LJJKrT7ndsvIHV
         jt21gUslJDNK3+L5Vrzcf7HpqJJboiJ4GW7cDZxQM1TG7YNFFpqXFgFftVxZsCM6KNGi
         mYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpXTzzsTu20XPUGJ5DoFqQgTxzAySWmD/o0USIl4Q7c=;
        b=NDRnBH3IHxZkYx3FcUNMtFl7zA7Ba2rsgcW2VVgqNMexGLk9nk0xKGIsGU/uBvFC1n
         GadEA6Akobuv5OY4ro1L3vjzgK87dO70/MqfrbCU9mcxNhcP2KEBPa+OTZTfatexE2IJ
         yWckH2jC45NZ+lG+YsnXdPnW9G/rcwLVoJT91N9UmEMDbyck6gvaWJ0juMuzvjgUGb8l
         oiuzpIUId9cLCUrvATRn7k4/2G2BfwWK/UENicnh7ESgI++TuCuiS9AjocHWmmaWICKv
         Vi6ZIij8qxRkPTDOTHcgfCfPouxTJlwRr45cSEiVVmtIW8vDczh2aSkM7dWSgDkyYi1v
         tihQ==
X-Gm-Message-State: ACrzQf1+/8+HkJuco63sZWU4c32K2+VM+q91T4K+E06bVQbpef6qNOVs
        SK5C48RoFFykSNPl6a4sSJj9zQ==
X-Google-Smtp-Source: AMsMyM6lHI/BAB50y66c2DoUESOnTYahQFR5Sdkpi9AvD4quy2aQ56rWRYyg2G/0LB1fmfNmQXTI/g==
X-Received: by 2002:a05:6512:3086:b0:4a2:406d:47b8 with SMTP id z6-20020a056512308600b004a2406d47b8mr638107lfd.249.1668011883221;
        Wed, 09 Nov 2022 08:38:03 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512074f00b0049476667228sm2309168lfs.65.2022.11.09.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:38:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ASoC: codecs: wsa883x: Shutdown on error path
Date:   Wed,  9 Nov 2022 17:37:58 +0100
Message-Id: <20221109163759.1158837-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If probe fails, toggle shutdown via GPIO to save power and reverse
probe actions.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 77a7dd3cf495..4ad8b875eb8f 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1415,6 +1415,7 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 
 	wsa883x->regmap = devm_regmap_init_sdw(pdev, &wsa883x_regmap_config);
 	if (IS_ERR(wsa883x->regmap)) {
+		gpiod_direction_output(wsa883x->sd_n, 1);
 		dev_err(&pdev->dev, "regmap_init failed\n");
 		ret = PTR_ERR(wsa883x->regmap);
 		goto err;
-- 
2.34.1

