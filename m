Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7325F0E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiI3PQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiI3PP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:15:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4E1DF056
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:15:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so4516774pjk.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bkGZlMCLcjGUMJh18RhP4Ctr01ZIOmKFkpG+F89/rcQ=;
        b=cybBlknOX9/DfQdo0Xe980ssg21Q5o50iv9PUSvznC2qYrzK2NumO347QdFKTRyOHM
         FY4hfsYNXFezlLbuarWagHuoz1s+oVb5jXi5mtBx5Hg9andKcny+jCAmaPHHIkYeJkPX
         Nk2/IL12+8PjMxfSxrf2YNtcvLyJHguO1qIMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bkGZlMCLcjGUMJh18RhP4Ctr01ZIOmKFkpG+F89/rcQ=;
        b=ze2C3v1HGOAbmJrAMN3SPeAlSQXl5NlOSQJfSvtJldQ3ltbuuvJrDl/OZP0W0QlYJF
         VyOrfz4nxuxB4IVlcCuLyjm2KyF+zVJApVPtNU8hBDFc4kZu3t8RUg9ETX+cMrnFlD7Q
         3yi2HBY+RurDiuEp1DTMYyIv7Mc7GpR1/rub7btDUnTcypC6esLjB0yrfGgVRpD+U2hZ
         XQOkJNJp7gRwjbr/SdhirSWR+mcXUAVMXEgmW6KFEi8pBIF8BHJ7fTVQR5xdjPsxXlyt
         5++lGNlubRvYqRzJQxvj99K1ahcoROVutHgjcnMkG8Vp1QbcxeDCxreMfK7PE9Ld3N4w
         W9rQ==
X-Gm-Message-State: ACrzQf3BbUFbpRGTpIaZv+mENGEs/A6h3LDWRLknJPXcmO3WwmxSw+Cd
        qUvxWp+W4kfSIV1v+h41aQIRh2TeqeY7xA==
X-Google-Smtp-Source: AMsMyM7dgX6KIprJugnpW4W2X/BhsVT0zR5F1NzXqlIHS4EK3Do0GsiexPC5q7UZws3YeTuk7VrkxQ==
X-Received: by 2002:a17:90a:9b12:b0:203:9b0:284e with SMTP id f18-20020a17090a9b1200b0020309b0284emr10424274pjp.116.1664550954797;
        Fri, 30 Sep 2022 08:15:54 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id z3-20020aa79e43000000b0053b9e5d365bsm1894355pfq.216.2022.09.30.08.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:15:54 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Lin Huang <hl@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v1] ASoC: rockchip: i2s: use regmap_read_poll_timeout_atomic to poll I2S_CLR
Date:   Fri, 30 Sep 2022 15:15:46 +0000
Message-Id: <20220930151546.2017667-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Uses regmap_read_poll_timeout_atomic to poll I2S_CLR as it is called
   within a spin lock.

2. Fixes the typo of break condition in regmap_read_poll_timeout_atomic.

Fixes: fbb0ec656ee5 ("ASoC: rockchip: i2s: use regmap_read_poll_timeout to poll I2S_CLR")
Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 28c86f5e435e..a8758ad68442 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -162,12 +162,12 @@ static int rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 						 I2S_CLR_TXC | I2S_CLR_RXC);
 			if (ret < 0)
 				goto end;
-			ret = regmap_read_poll_timeout(i2s->regmap,
-						       I2S_CLR,
-						       val,
-						       val != 0,
-						       20,
-						       200);
+			ret = regmap_read_poll_timeout_atomic(i2s->regmap,
+							      I2S_CLR,
+							      val,
+							      val == 0,
+							      20,
+							      200);
 			if (ret < 0)
 				dev_warn(i2s->dev, "fail to clear: %d\n", ret);
 		}
@@ -220,12 +220,12 @@ static int rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 						 I2S_CLR_TXC | I2S_CLR_RXC);
 			if (ret < 0)
 				goto end;
-			ret = regmap_read_poll_timeout(i2s->regmap,
-						       I2S_CLR,
-						       val,
-						       val != 0,
-						       20,
-						       200);
+			ret = regmap_read_poll_timeout_atomic(i2s->regmap,
+							      I2S_CLR,
+							      val,
+							      val == 0,
+							      20,
+							      200);
 			if (ret < 0)
 				dev_warn(i2s->dev, "fail to clear: %d\n", ret);
 		}
-- 
2.38.0.rc1.362.ged0d419d3c-goog

