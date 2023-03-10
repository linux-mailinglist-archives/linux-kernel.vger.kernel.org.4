Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2516B5348
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjCJVqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjCJVqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:46:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C2BD53F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:44:23 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ay14so25988737edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtTDNGd4OKXSBNgUghpGOqMcCM6UWM1avWy8539QlKU=;
        b=aKwq/Onkzm1G69ixhhVQ9wEUply4dRoc6+jOvfU94SP6WWFKCmp4Nw3F+G+XgIS00R
         HYJselriPM1R3rR6D5ZlcKqsA8uEsQ1waZfG1G17qWj43d6MCZeuyWAVAhhQ5h10z1PD
         MhnVNyDszoR6wYbGeCI6G4T6dmjKTqZgXC+y4Xmwy9gKRrNaKmtgukc97tHxUkf51MDO
         X+hnrQLt3ACFfXnf+eS8ipaMMdZ9hjaH69oO8+hOD0uyzQy6zCHiHeLXyMjeA5CH/kpI
         KbOxukVTdBuqOCOZ4CdGK2yvHbgSZMXaCAoaKpUtTlaPl7RoRKDhqWCG65R+HjHGJZ8Q
         7v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtTDNGd4OKXSBNgUghpGOqMcCM6UWM1avWy8539QlKU=;
        b=DGcknYDtVBSrqCBKTGc6esImtY9mg+sj5E3B9NY9Ww8zQZ0HD6fP9vTGSxNE5riTF2
         uBx5Pzl/CjQt+pnQyhB97AadMLQRrFRd673rY9Ho6p58Pmm6YcsJPaz687b5WmHd42EF
         ZvFo+7+1t/nYB8JfbBepwb3JPBCr1Cee145NteZRQPv5FK532Ydoy7L9VtNeUqXSjA6Q
         nYjfJAouulvF7869i8h9SRfd192YTDgSrWdEZ0vJufEvBrERMIoQm7QZpkB6r1Mr4g+3
         uDYGugJce9wA/JMmSua6DzHXHFYkO2UdJzDoIvD9/BcbHD98IXGYEMcNzlq84g91REPJ
         KqBA==
X-Gm-Message-State: AO0yUKUodMTXi0P7Cwmi8+mNJYSvBkdW8y8pF2B8LrB5VUGEfP/5oiwF
        2kS9y5CTERiV7ojB0O8dYds9pw==
X-Google-Smtp-Source: AK7set8PHUQ6DL7eFsVXVoAnmstVTGwi3LR28x814KZUIny/qh75j7xE8KDu/r3osk5u+e4VTkuMlw==
X-Received: by 2002:aa7:ca41:0:b0:4ad:a70c:e010 with SMTP id j1-20020aa7ca41000000b004ada70ce010mr23647133edt.41.1678484631647;
        Fri, 10 Mar 2023 13:43:51 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id f2-20020a1709064dc200b008dcf89a72d7sm327228ejw.147.2023.03.10.13.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:43:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 9/9] ASoC: codecs: zl38060: Mark OF related data as maybe unused
Date:   Fri, 10 Mar 2023 22:43:33 +0100
Message-Id: <20230310214333.274903-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
References: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  sound/soc/codecs/zl38060.c:611:34: error: ‘zl38_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/zl38060.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/zl38060.c b/sound/soc/codecs/zl38060.c
index c3d0a2a7c36f..28c92d90299e 100644
--- a/sound/soc/codecs/zl38060.c
+++ b/sound/soc/codecs/zl38060.c
@@ -608,7 +608,7 @@ static int zl38_spi_probe(struct spi_device *spi)
 					       &zl38_dai, 1);
 }
 
-static const struct of_device_id zl38_dt_ids[] = {
+static const struct of_device_id zl38_dt_ids[] __maybe_unused = {
 	{ .compatible = "mscc,zl38060", },
 	{ /* sentinel */ }
 };
-- 
2.34.1

