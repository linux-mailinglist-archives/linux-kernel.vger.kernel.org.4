Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5806B5325
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjCJVph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjCJVo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:44:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B93130C2E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:43:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o12so26066503edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIfiMP3YESLd/oa/N7VLY54fnA1n1mTobvMyaeAJG5I=;
        b=SUNi2TaXheAbWPG/KVUefcPFHvQs9X6TNeLNLxse1maLOXEGTl4/TyuaVqStDczSnd
         EXs4WAYhkL8UPIiQcgLk+EfoS5XdVMurMYigvZ7oXcwdz/+XJL5xAF2ZzCqv/grclfFN
         RTRK4GXBvCHkvg6cvw8Yl7A94AoQfHauKem9e6r5R16eKeWor5pGclrxLxrAFIpu9QCF
         UiMfeAcMguDx4E6r4e1owv2+G/n4mxUqwoQ+YgGVJUWc9EPIhP2fdRu6QzXKiZmMU5Ud
         fxlvZMnRkhKd2qyFmWHHaxT88WgodGOk76u1I3ZLhOHFUb42R6f7EEuxRIajZqkBHwlH
         gbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIfiMP3YESLd/oa/N7VLY54fnA1n1mTobvMyaeAJG5I=;
        b=dCdhnnNZWfD8362mZa2afRCuTdNEfSEViqsIxwFgs2k2BjWHbEexWpS/pKMImDr5sN
         Lkg7gO/m8OJFcPhgamDCX7xFXLgykK6WIehtftJ6IUuNdNDcMtdiXDxNTCvDSvaAIdSM
         d16K9eRHfj7AXhUaemTGjTUtoyyRARuqvqOSDkW5kqRTa15HD2LsBg07YJ7D/1dbGgkC
         DVIgNIWCHVF3EutFpPRLSX5UJ0/cdb/J/LEbEQ0u7g+/iVu4FOZINiUSA2LHDrpzw5o6
         S44qKpDTtFUsr4r6XYRfSm6LKOXDxslrV7+CWMGUwN0+EGXeZ+sx1t4rPqMGMsXSIoex
         h3jg==
X-Gm-Message-State: AO0yUKV5F/0RYDPHANjs8X0vH8Zl4Ow8R2W36832XdYaWKdcaQsL/VRa
        d0q4eQXrGqpqFwKNgcUOy5J+TA==
X-Google-Smtp-Source: AK7set+6+KrtBdSfaV0uxoCP+fEPUyNxImT6xVJWnAKpCnDbvKIKZNH0aQlabNfXa7pbDKxh5ul0BA==
X-Received: by 2002:a17:906:fe41:b0:8f1:949f:37b5 with SMTP id wz1-20020a170906fe4100b008f1949f37b5mr32934345ejb.32.1678484618989;
        Fri, 10 Mar 2023 13:43:38 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id f2-20020a1709064dc200b008dcf89a72d7sm327228ejw.147.2023.03.10.13.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:43:38 -0800 (PST)
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
Subject: [PATCH] power: reset: qcom-pon: drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 22:43:25 +0100
Message-Id: <20230310214333.274903-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
References: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

The Qualcomm SoC power-on driver is specific to ARCH_QCOM which depends
on OF thus the driver is OF-only.  It's of_device_id table is built
unconditionally, thus of_match_ptr() for ID table does not make sense.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/reset/qcom-pon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 16bc01738be9..ebdcfb28c4a0 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -91,7 +91,7 @@ static struct platform_driver pm8916_pon_driver = {
 	.probe = pm8916_pon_probe,
 	.driver = {
 		.name = "pm8916-pon",
-		.of_match_table = of_match_ptr(pm8916_pon_id_table),
+		.of_match_table = pm8916_pon_id_table,
 	},
 };
 module_platform_driver(pm8916_pon_driver);
-- 
2.34.1

