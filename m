Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6706E8FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjDTKSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjDTKRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:17:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E61E5587
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a34a0b9e2so51210166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681985785; x=1684577785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ7NFOY+m136Tpa7a3Lvd2KVX0E55mkuZub+f9mfMPg=;
        b=AmBkVOglK6tDRnpf5e1CjE9fZ783z5mKL+8fZ2ZovSKfIEaRbZG2hMsl/KZYx0GutP
         I4eilLey7aFQzEn7ekVDO8KmseLtE5PTAZDRLwn2BMgyGrZC7FEDBt/Dp4xCbjrM4nMX
         PExtibBF1phO8lOFATg7A1Vtim0z+UT6NDLufqy2uoALruXfdu+d+TPVALxWzqlWUzA6
         T+GyHuG0AT4R7Gz3SSQotOWrU+a4WRBC/uMDUwxK18phb9KmLz2WNzbTxwMlB5A5NfNH
         Ets4NSbdZxAlxiComw5hFcoxnnqZUExblUbtNFza39VeKttRMXgdMGu3NppRYjhA4g+x
         /fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985785; x=1684577785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJ7NFOY+m136Tpa7a3Lvd2KVX0E55mkuZub+f9mfMPg=;
        b=j1zHdr5DhSCvre1R8wkV2jHFDLfB9bzcUghnZFRixZXh2Q+UY1Kc8JMoTsFNDUjgBN
         tmWDqqrRBnCGAQlLsmTEjPdDo1huy3sgJnPux51XyHiaOHMRpNJGkzm87majaYLgsPN+
         I6cRxX/A8m5Jj/kvUOn0Dh857S3aUW995OdcQLumEIh0+E2KQELtw5SVu2hmqKzi3PHr
         8cMyFST+EgLuy9vpfTW7ZdOPvh0tgQwGERCaPkY1vB9wND2Juduo5yIhxif4nCfQfC0v
         9vThVye80JKtbdRIczyUEUPEr0JZIsws2bxzwQ4db8a9G7j/MmG5mtuytCf1GKi3VojS
         L1/A==
X-Gm-Message-State: AAQBX9eeQ3QV6M0nUFa2HWhsMZI1LALOmtrVgtK9Wix6PhTOVmuOmGZi
        ROgNFrH5KO02MbF8pUC/Qgsd+g==
X-Google-Smtp-Source: AKy350a9gCInOAQuMSUpXUGkll+ReqZrf7KjiUJPh73j3eJ9QX2mTKFQOiDbJcquHEnVTHtJWjfuwQ==
X-Received: by 2002:a05:6402:1616:b0:504:9c59:7b8f with SMTP id f22-20020a056402161600b005049c597b8fmr1251270edv.36.1681985785537;
        Thu, 20 Apr 2023 03:16:25 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id l22-20020aa7c3d6000000b00506be898998sm588954edr.29.2023.04.20.03.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:16:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Patrick Lai <quic_plai@quicinc.com>
Subject: [PATCH 2/6] ASoC: codecs: wcd938x: Keep device in reset till bind
Date:   Thu, 20 Apr 2023 12:16:13 +0200
Message-Id: <20230420101617.142225-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

The Soundwire master expects that bus devices will be kept in reset
state and brought out of it in their Soundwire probe() or bind().
Keeping it in reset state avoids early new Soundwire device interrupts
in the master.  Fix this in WCD938x platform driver by moving the reset
toggle code from platform probe() to component bind().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I wasn't sure whether this deserves a Fixes tag. It looks like a fix,
but OTOH, I don't think Soundwire master expectation is documented
anywhere.

Cc: Patrick Lai <quic_plai@quicinc.com>
---
 sound/soc/codecs/wcd938x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 33fd8fdde9fd..212667a7249c 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -4236,7 +4236,8 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 	struct wcd_mbhc_config *cfg = &wcd938x->mbhc_cfg;
 	int ret;
 
-	wcd938x->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);
+	/* Keep device in reset status till wcd938x_bind() */
+	wcd938x->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	ret = PTR_ERR_OR_ZERO(wcd938x->reset_gpio);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get reset gpio\n");
@@ -4407,6 +4408,8 @@ static int wcd938x_bind(struct device *dev)
 		return -EINVAL;
 	}
 
+	wcd938x_reset(wcd938x);
+
 	wcd938x->regmap = devm_regmap_init_sdw(wcd938x->tx_sdw_dev, &wcd938x_regmap_config);
 	if (IS_ERR(wcd938x->regmap)) {
 		dev_err(dev, "%s: tx csr regmap not found\n", __func__);
@@ -4508,8 +4511,6 @@ static int wcd938x_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	wcd938x_reset(wcd938x);
-
 	ret = component_master_add_with_match(dev, &wcd938x_comp_ops, match);
 	if (ret)
 		return ret;
-- 
2.34.1

