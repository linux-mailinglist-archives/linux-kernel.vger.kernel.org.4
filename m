Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDD76B533E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjCJVqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjCJVpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:45:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95665144BF1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:44:18 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id da10so26157773edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnYq1zeLkuGP06fgrJTup4yOJApLpMSwWcWTUqrcgj4=;
        b=h8Q4NOjPl5R/WiIaAMHaK8PQKHkgJFxVXq8er9dUXTEb8Qxr+L09aiP7GPhzregD6W
         AQOdeFCk9UrCUrhNz6fg10wdRXMjIaYNWbdEmveho99cZ6dcDq8HlC/Dh0hjyei/JSqI
         8MpC93/Qz/cK4xwvixdyiajxszYgj68Hr6MPxaZU58xzx+0C+R2MFi+qOaIJXTLj5iVC
         DHeGQHu5TMMDHr3N6XPjlxWg1ws2o5VzYPGrAqVip5ixR5jlb+9ubDA4K7ZM4xRrBDZx
         PeFp0amXoCAgDfrywhfu+B/7m/1xYzMgQwfpYHtd5018ENWEr8AyBwSotrVt95xzcvZs
         GljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnYq1zeLkuGP06fgrJTup4yOJApLpMSwWcWTUqrcgj4=;
        b=Y9nIvsp2+l4ws3lRy3y/JDby1tRxXIMWqW3XqFB+zS19v2ELAb1IVe9ZX++kCEmFs3
         P8MbM7IoJhlVTX/pS0NGpO+LpjrrF+FuuPLFT4xqs1HLhAcMKG1ZfYz2QDuzZX4Rk1im
         0D65BR4xuBx4EikvozAP8Hy3tfEznKKoLCOm/NN7XG8gGdhqLpAcJ4F8+sCvCYf63LCd
         xH9uqPur5Pob+ZzIRsiXAT5skEAMP185Ct+fnNfopfcp9Qt4D55tRzT+m86YRgu8Ei+/
         G4ejgO+YDPcYbBJ9uHaPxEtDY0FFVYvs6mmsPYN7Xs3MZkm118J/Qbn8dF2Zo8nX8RTQ
         b7eg==
X-Gm-Message-State: AO0yUKXxyMNlSFVVsfjO763UJy4fVYvC5w10al59H1xLlZCZY+HSbpCV
        AE5vcxP1EA3UptxQIVKMo869QA==
X-Google-Smtp-Source: AK7set8Q/apGzf5fRe9BKFf2BS/DHloQQwv+CX45f7pu7bcAkpBEYK89UNKobe0bpL8f4xQIHE7HQA==
X-Received: by 2002:a17:907:c20a:b0:8b1:781d:f9a2 with SMTP id ti10-20020a170907c20a00b008b1781df9a2mr26168137ejc.32.1678484626567;
        Fri, 10 Mar 2023 13:43:46 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id f2-20020a1709064dc200b008dcf89a72d7sm327228ejw.147.2023.03.10.13.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:43:46 -0800 (PST)
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
Subject: [PATCH 6/9] ASoC: codecs: pcm179x-spi: Mark OF related data as maybe unused
Date:   Fri, 10 Mar 2023 22:43:30 +0100
Message-Id: <20230310214333.274903-7-krzysztof.kozlowski@linaro.org>
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

  sound/soc/codecs/pcm179x-spi.c:32:34: error: ‘pcm179x_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/pcm179x-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm179x-spi.c b/sound/soc/codecs/pcm179x-spi.c
index ebf63ea90a1c..192fee90c971 100644
--- a/sound/soc/codecs/pcm179x-spi.c
+++ b/sound/soc/codecs/pcm179x-spi.c
@@ -29,7 +29,7 @@ static int pcm179x_spi_probe(struct spi_device *spi)
 	return pcm179x_common_init(&spi->dev, regmap);
 }
 
-static const struct of_device_id pcm179x_of_match[] = {
+static const struct of_device_id pcm179x_of_match[] __maybe_unused = {
 	{ .compatible = "ti,pcm1792a", },
 	{ }
 };
-- 
2.34.1

