Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BBA6E4B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjDQOPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjDQOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:15:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58092525D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:15:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94eff00bcdaso181011666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681740899; x=1684332899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQmIdP3RJKa4pxnl8xRRCwok/HaLYslpm8yDZiO67M8=;
        b=YATFDIf1tAx0aaKR/kVjChTDSUWOUhhDgFiTENafwW1rgezl7ILWfZWDw7oLDEc87Z
         WAeF8koTDqiRrZERt0r5ffbpmiST9jLq98jNACPzcNl8xc9i1n6uTg9yHpYkniMzqqOb
         aD+QzPlJ8NBVDHP02Frk2E6BEEKg2xV+qMvhMbWghNmVHZyfRwU4g23CMLjuDATcepUT
         oOLNzDjPSi0ISjl6KGii894jUlFkCB/i10NRV2OYEUh90uc7zKQb+cGedzuwuJ9ExXrj
         dlFdJzyayYN8rsX0TE55PsClsyyjgAHlMZx98V9EM2F2IC6D4G5Su4RsT0QStuq0wxfI
         WGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681740899; x=1684332899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQmIdP3RJKa4pxnl8xRRCwok/HaLYslpm8yDZiO67M8=;
        b=GoWPWW0sgO3lmwykQJ3JESmto3r0w+x0XZFhJ8X0f9rkxyA0ST4hmR0vkBOnqLRyBv
         y2tNUZKuSQdexTl1IKchz8ztVBAiNqzHhS6gOXS8kyNKgug0Cm5yikjg1dFyp1Fk99PB
         d4nrjm92xCAMTZi3KVnlRU4Pm/E4SNaIePiD0fjm/bF+1D1OgulG0ELVdHpr6FomlTdf
         97CX05xdN54lsuK3dE47kU/JL2zbOdNTwxs9VzUJXJ9tzgv8hQNVsk24zFTeGeNRVv9Q
         F6jplO4F+kOYAWPJTBtiAZ6FGwiInhdOAJi/tGStFHwd5Y1js7PMASbumcaZ17mq6bPd
         dTTg==
X-Gm-Message-State: AAQBX9devOqQcl3ukGPqd8jtQ0ULtKcGsXI2DOAfbyAP6GSy++aS3cqJ
        YPW0GPEbI5Bk0+k3T4MLoCwJrA==
X-Google-Smtp-Source: AKy350bRPznj0J6IQHjCFui2MZsj2ItlqRKRcsBx6mlmVaNEguH3nVSNRhQE5soAROe85/63hO39ow==
X-Received: by 2002:aa7:c90b:0:b0:506:7385:9653 with SMTP id b11-20020aa7c90b000000b0050673859653mr13444306edt.39.1681740898824;
        Mon, 17 Apr 2023 07:14:58 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id q6-20020a056402040600b004f9e6495f94sm5832034edv.50.2023.04.17.07.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 07:14:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] ASoC: codecs: wcd934x: Simplify &pdev->dev in probe
Date:   Mon, 17 Apr 2023 16:14:52 +0200
Message-Id: <20230417141453.919158-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
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

The probe already stores pointer to &pdev->dev, so use it to make the
code a bit easier to read.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 56487ad2f048..c0d1fa36d841 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5892,12 +5892,12 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 
 static int wcd934x_codec_probe(struct platform_device *pdev)
 {
-	struct wcd934x_ddata *data = dev_get_drvdata(pdev->dev.parent);
-	struct wcd934x_codec *wcd;
 	struct device *dev = &pdev->dev;
+	struct wcd934x_ddata *data = dev_get_drvdata(dev->parent);
+	struct wcd934x_codec *wcd;
 	int ret, irq;
 
-	wcd = devm_kzalloc(&pdev->dev, sizeof(*wcd), GFP_KERNEL);
+	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
 	if (!wcd)
 		return -ENOMEM;
 
-- 
2.34.1

