Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3800706E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjEQQho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjEQQhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:37:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E27A95
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:37:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96aae59bbd6so181103566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684341458; x=1686933458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b954nCKecTYMejuBU5d05EyR3pjeZ5krgvkIBhNJrGA=;
        b=K2OAfGcnnNxTSK7pCXewhokszq4t+03nWW11pLL4ffsPmX5XRkTae0vlRk4qhgnWBu
         wYoCtcLaKftCu8MAdWIcNI9ohFnb9j2GbaEYPolML2LHrH6LIAPsaGeOSSKAMWo/tl22
         vpjZEOgsMusJqo17gVpK8pW26q+qMM7hB4zjI+W39IRbe9ckN+pqS7bxQYwUO/WJ0J60
         uk5RPLie9zCUALkMh71D3SMcPH0ltRvgDXfDGQ/vf/PztPbmSmQKR86JeipiW5DDDKKz
         DZJS5YJfyqnhKpcqVCB07Nq7/smeTzhFzRIVgqCzd16HV9E12+nId6MiULdmjMAQmm+8
         lJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341458; x=1686933458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b954nCKecTYMejuBU5d05EyR3pjeZ5krgvkIBhNJrGA=;
        b=PGUk87zyboF9rooZKFC8iUtl06IfnoSqRG8vlEzKSZ+Hr/zeRgLRhUxo9X2oLJOuWO
         EVh0C0dnYj7e1OrCB4QzSZivKZTLInaA5ko/huPQKlMyXKiCDjW4e1Cn9brdcm6KhM8c
         7Bi8vVMArzcyqQZtOT82AvUndiCofgY3hy0WpZOR2NrDy+jBt0qePRh63YuLc+T+aLXr
         5XGRHPu1LkL/pkVLfQneEGdOSf3+BWb7PLbJQHB65XfOTdjFjvJdu5MecDGT6qp93Es7
         c0HqqNYiuWo52DKRMuDI52aUA9lpYlfPx2fTizgD8M4stMg9asC5V3k1fAMpCGS6qK1v
         66Yg==
X-Gm-Message-State: AC+VfDz+xUGgk281rPurt0qToOdV6CrNdqbTP7J27gtgqGruwn0rpy6p
        lNtOfAh3a+Ez+6cFzjHsYLkEgdQ5hrX+oJetIeG0Wg==
X-Google-Smtp-Source: ACHHUZ7ziGMJ00VxXyHbYiSqOp0MCIv38v8NGDyit/yB2cFLQ4BKFhCVfAMvLnAe6r/h3PNlp7yQKg==
X-Received: by 2002:a17:907:3f28:b0:889:5686:486a with SMTP id hq40-20020a1709073f2800b008895686486amr41507100ejc.30.1684341458491;
        Wed, 17 May 2023 09:37:38 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709065dac00b009663cf5dc2fsm12583152ejv.66.2023.05.17.09.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:37:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] soundwire: qcom: add proper error paths in qcom_swrm_startup()
Date:   Wed, 17 May 2023 18:37:36 +0200
Message-Id: <20230517163736.997553-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reverse actions in qcom_swrm_startup() error paths to avoid leaking
stream memory and keeping runtime PM unbalanced.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/qcom.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index f442280af9d3..baaa75320ae3 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1208,8 +1208,10 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 	}
 
 	sruntime = sdw_alloc_stream(dai->name);
-	if (!sruntime)
-		return -ENOMEM;
+	if (!sruntime) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
 
 	ctrl->sruntime[dai->id] = sruntime;
 
@@ -1219,12 +1221,19 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 		if (ret < 0 && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "Failed to set sdw stream on %s\n",
 				codec_dai->name);
-			sdw_release_stream(sruntime);
-			return ret;
+			goto err_set_stream;
 		}
 	}
 
 	return 0;
+
+err_set_stream:
+	sdw_release_stream(sruntime);
+err_alloc:
+	pm_runtime_mark_last_busy(ctrl->dev);
+	pm_runtime_put_autosuspend(ctrl->dev);
+
+	return ret;
 }
 
 static void qcom_swrm_shutdown(struct snd_pcm_substream *substream,
-- 
2.34.1

