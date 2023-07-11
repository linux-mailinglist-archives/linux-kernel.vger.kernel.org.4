Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D93974F83D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGKTGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGKTGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:06:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67A51704
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:06:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb9fd28025so9221716e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689102375; x=1691694375;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj+9UulOxBhqwuLu9TU2zy1SRgpm3ojxV4TrMHj756I=;
        b=pe521qSj6XlIkT0wWVYUQ6offLjqsA3ryzdMSJcnFaivsXnrDnCGw+olI+HqdrA5F5
         tbY4xx/GP7utKH9SSqGDEfcU7H1MUecxCo6W7XdcTv6b1dhtKjZfcQRMtArG2Myk3zJi
         IbwkXUTqzDYWHv/rBhEvBWX6h8yCTM2g09rJ2rNFit1pQ6+WNzaq4i9N5lhAeH/JKCpH
         Sgzz+pOHbZjVIitupqzGCevKonh25E1CAnNDTEI06XiU8f8sc0tAWD09MvOzm+GSe/9o
         WyRF4XmGHCd5upMH/n5X8hm9ByLct6shL9/dtKv54CYg6NZBfvi/fG9VwGGGv/9wEf7D
         abwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689102375; x=1691694375;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rj+9UulOxBhqwuLu9TU2zy1SRgpm3ojxV4TrMHj756I=;
        b=g9+4OXlWw9PYsg0KjAIxJVBeK0h0ZJkwxOY+CPAdzpwBgGrlnqOUgIgwELdt2aCbaT
         Q9GhVMbZOPT+P8nzGCfKZneC1h4FOolyIWbW/LmW1Iz20lFC0gdmOMLYoww3kqCxpQ9k
         vQpusN7QICOHIr+pYAczjZGfcqnh7VsbefS+YGQ7tAQJxZk4GzqH0WjqeAOlO0R0NY1B
         jrcDRCS5RccGBaLWmZMi+WnUdpmpnifAjdfiuW+cBBeI5ut2QOIcOQIFtQ18An+kH1Bt
         S98dj1oLSmqh6PUy6UfJV9l4UShUdeHQkwl7yA+m7fKAcxAnObXN04V8lHqr6MjkmUV3
         Ndew==
X-Gm-Message-State: ABy/qLaMyhVJL/afMAxduP/NIsf2y7Nh0EnV0LkZaa9KWji3NrJmdsMf
        EcIrcvq/lwkImtDOPPgsE5LQgw==
X-Google-Smtp-Source: APBJJlGKBbaogf/KkWjxjVBOaCfqmQJWTcRiDA9PTN8fejC2aiZHmebUlhvOj7RYHNDcM0HV1A3rJg==
X-Received: by 2002:a05:6512:2351:b0:4fb:99c6:8533 with SMTP id p17-20020a056512235100b004fb99c68533mr16771901lfu.33.1689102375065;
        Tue, 11 Jul 2023 12:06:15 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id y6-20020a197506000000b004fb8c31c8desm411450lfe.208.2023.07.11.12.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 12:06:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 21:06:09 +0200
Subject: [PATCH] ASoC: codecs: aw88395: Add of_match_table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-topic-aw88395_of_tbl-v1-1-a05fdf5d0efa@linaro.org>
X-B4-Tracking: v=1; b=H4sIACCorWQC/x2NQQrDIBAAvxL23AVN0Np+pZSgdtMsiAZN20DI3
 7P0OAPD7NCoMjW4dztU+nLjkgX0pYM4+/wm5Jcw9Kof1FVrXMvCEf3PueFmxjKNa0hoXdA2Gme
 VNyBp8I0wVJ/jLHH+pCRyqTTx9n89nsdxAuHXowx7AAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Weidong Wang <wangweidong.a@awinic.com>,
        Bruce zhao <zhaolei@awinic.com>, Nick Li <liweilei@awinic.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689102373; l=1327;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=OOJMpaWhRd1u50nkpVqck1mnyPm7Ai73M9mHx/W/fAM=;
 b=hjEsFXNcNR0npi/4muWRweo74uXrSNbApcvxjP6fIg6SokaXK5XsN7FlfEm+Wa7sUzlRGD2CJ
 tTIvpRX6msJASOhpvRMtxDq7OMTboPYbVrQ+/7V5XtcYSOGShdRRoRD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c_match_id entry is not enough to get the device probing with DT.
Add an of match table in accordance with the bindings.

Fixes: 62fc25fbab5f ("ASoC: codecs: Add i2c and codec registration for aw88395 and their associated operation functions")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 sound/soc/codecs/aw88395/aw88395.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/aw88395/aw88395.c b/sound/soc/codecs/aw88395/aw88395.c
index 9dcd75dd799a..5ff01d3c31c8 100644
--- a/sound/soc/codecs/aw88395/aw88395.c
+++ b/sound/soc/codecs/aw88395/aw88395.c
@@ -566,9 +566,18 @@ static const struct i2c_device_id aw88395_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, aw88395_i2c_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id aw88395_of_match[] = {
+	{ .compatible = "awinic,aw88395" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, aw88395_of_match);
+#endif
+
 static struct i2c_driver aw88395_i2c_driver = {
 	.driver = {
 		.name = AW88395_I2C_NAME,
+		.of_match_table = of_match_ptr(aw88395_of_match),
 	},
 	.probe = aw88395_i2c_probe,
 	.id_table = aw88395_i2c_id,

---
base-commit: 8e4b7f2f3d6071665b1dfd70786229c8a5d6c256
change-id: 20230711-topic-aw88395_of_tbl-68b16c5860a5

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

