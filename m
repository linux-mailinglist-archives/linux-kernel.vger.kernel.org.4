Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92716B532C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjCJVpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjCJVpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:45:02 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F57135533
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:44:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ec29so26084714edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OodZcTc1W904hklpN17tVTAGqTvpntmH7F34q8bSVFI=;
        b=haEy2ydI/93VirwC68PAqDgHfgBgaRW9fuhmEo4FHbTnT+yd+hfaTXZ2DQO8024uiN
         rWA8Kvp/QQWUQxqwnmRVNVUdVkBNsBNm/R3F42PX6N9xTLFBfkFcbLFc3Em7FI4JCVzE
         IZY0NLK/6Kk4QOBWVs3bAZXdaDhlKocwUO8buNpplD1R4rZd6ad55XRrs8jj2zxs+Efh
         Ih/R245AA36qMuC8DCIH67+2qCrbLHkdtgKjvnW+33k0uPRavZhwdPjZPk0z4zc7FHVj
         PKJRfSAEVssfGirw5H7phcxVZ1zj8McSSjuzfSpJfU3lZmO1O0s8OECUceYiEISEONiN
         SF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OodZcTc1W904hklpN17tVTAGqTvpntmH7F34q8bSVFI=;
        b=SpJi4dzwiHyz8bqmX4vZPMfPFcSU3waabi079muhUZEsWekg2rGJcMbliMpxFY6gqf
         ENO8nKDp+PTetyXhcok4+DJXM+doldIteGWgPD5guCDy3oyVNhC3XmaqudgvqBM16eAX
         D0Ebx0Nt82XzNTBdJgPOCiK06onfwesnNBCw9DNbJeHlLXpxNLXk2VXUlVyIBlxI56mv
         HFavrvwAc6deg3LmtRPc91pbns/tQUJ6Iutz+m7Oh/FS0yaPIinIrLlc9YMMI02kHuZv
         RLt/gq64+ETPNJI32/+nQSWYJgzFjwRbIEfQiFLRNINKGzaZIyWQyhKIRqBSKnojEaJd
         t1Ug==
X-Gm-Message-State: AO0yUKXwPJwSfp21cNh3pPuXEQSQBxpE86r9/rM1zVKysjamHp9lEY+J
        XelKgh0JInpgkVYIR6que0a2Qw==
X-Google-Smtp-Source: AK7set8rdSwuJIZjVXbyv0eXXG6ZQ8Z4Y3OpjtXysYZ6r1dQ5W/2Lf4cBRGLcMFVT5dX8XLJ864avA==
X-Received: by 2002:a17:907:9b03:b0:8f0:9566:c1ff with SMTP id kn3-20020a1709079b0300b008f09566c1ffmr28443272ejc.69.1678484620243;
        Fri, 10 Mar 2023 13:43:40 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id f2-20020a1709064dc200b008dcf89a72d7sm327228ejw.147.2023.03.10.13.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:43:39 -0800 (PST)
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
Subject: [PATCH 2/9] ASoC: atmel: sam9x5_wm8731: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 22:43:26 +0100
Message-Id: <20230310214333.274903-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
References: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  sound/soc/atmel/sam9x5_wm8731.c:189:34: error: ‘sam9x5_wm8731_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/atmel/sam9x5_wm8731.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index 99310e40e7a6..2bc622e86376 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -195,7 +195,7 @@ MODULE_DEVICE_TABLE(of, sam9x5_wm8731_of_match);
 static struct platform_driver sam9x5_wm8731_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(sam9x5_wm8731_of_match),
+		.of_match_table = sam9x5_wm8731_of_match,
 	},
 	.probe = sam9x5_wm8731_driver_probe,
 	.remove = sam9x5_wm8731_driver_remove,
-- 
2.34.1

