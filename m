Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF9773688D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjFTJ7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjFTJ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:59:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E619AC;
        Tue, 20 Jun 2023 02:56:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3112f256941so2509825f8f.1;
        Tue, 20 Jun 2023 02:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687254982; x=1689846982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nzfSnFwwgUKGBxhz4K3sxN6CVZIzUqaHD5LMCxLNTs=;
        b=nQZMj+0R5+KtxAXE0ZEN5ZZdFles83qKs8iX+fsg0noiCxN6QmGAD6ma8fz06kMDaR
         XQNjrEiFt3dtK1/l3kNeazgIIK42SDIEKr96LHiUIxWZJjIQv5V4iY0IFAPENO16ZAQo
         FVOmaLdV5jFqjVz2hHie1anPFYgc9EzCMcN5WBFl7npcHDdF8GgLkMWKtKS+z9mCnwz0
         30VCojhkx80O0xpnXMG/JSkVIK4hnts0+yZU8+9hBov0VwbMe0E5jJgKRiAPVvRP/MIO
         2XDGBf5iVoPFE2jvS7WVxE8nPGRuMj/xvjWkIAB9QfPodQnO0ivRf/ouX7DLff1t4/EX
         /ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687254982; x=1689846982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nzfSnFwwgUKGBxhz4K3sxN6CVZIzUqaHD5LMCxLNTs=;
        b=d8JCC38dOHkwSs81sBmdxf7rRWYOAFwj1Oa61wU6cqTDO4AMHxGjCo2hcvwazSvgeH
         hv2ofQrOv3+R9Lj7CupyLpY1fwsnZRE/zpt+lpXxFIQgAixYjeXMUcVvhgQ27aD/MDvu
         IhuvxjWKEtJppEq+jAnr0wNlN7CICGgVNw8+QodEtELjZKxslt8T+mno3ecRzRSl7IP2
         i4Fl3B0SmOy/9+BUOQCdDdKumNEjMYAvdQ4Ws1VZOwP36KatrsDNpR0vxhAHIC8glA6P
         nrA4DAHOQOVEND+JmaDJ8wEPMiMYpOuaZc7uznUuL5XnphUNIvWlxPuRXp2JsXqHmr11
         iakw==
X-Gm-Message-State: AC+VfDxU2ZbxpkDXomBkif1CLW/mTgdVo1SZioMe39GDKLiyJhH4uyx3
        2QEt+ZuW1HevaW/WeUbL6t/hyyBxXeHGCw==
X-Google-Smtp-Source: ACHHUZ57QTB7wxq1J7LAwX05NJAArS4vx/ZblH3A3rVBL1H9ewMMGIwbkkwag/Q5ylBcYjKIpX35/g==
X-Received: by 2002:adf:e7c2:0:b0:30f:c764:189a with SMTP id e2-20020adfe7c2000000b0030fc764189amr7427650wrn.39.1687254982152;
        Tue, 20 Jun 2023 02:56:22 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm1659046wrs.2.2023.06.20.02.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 02:56:21 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shenghao Ding <13916275206@139.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: tas2781: Fix spelling mistake "calibraiton" -> "calibration"
Date:   Tue, 20 Jun 2023 10:56:20 +0100
Message-Id: <20230620095620.2522058-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a dev_err message. Fix it. Also fix
grammar and add space between last word and (%d)".

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/tas2781-fmwlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 432b19ccec8c..cbf0aef2c001 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -1863,7 +1863,7 @@ static int fw_parse_calibration_data(struct tasdevice_priv *tas_priv,
 
 	if (tas_fmw->nr_calibrations != 1) {
 		dev_err(tas_priv->dev,
-			"%s: only support one calibraiton(%d)!\n",
+			"%s: only supports one calibration (%d)!\n",
 			__func__, tas_fmw->nr_calibrations);
 		goto out;
 	}
-- 
2.39.2

