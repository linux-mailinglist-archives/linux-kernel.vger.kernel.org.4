Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1B743B55
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjF3MAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjF3MAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:00:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997D71BE9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:00:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so3014673e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688126424; x=1690718424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14D7DHntwp60GlIftqa4afNY/9x1F06cw0RktL6nRlU=;
        b=fy1MI5UX56UXUrFu0J8cpIXdjPPG33um5E6owC4D67V1Th2H/9dmoDZEfyc3eJNVZ7
         osU0qAc2Xi57FirxHF5YqGd/hc5tj/CJlsuik/Gq0BuXz0PT5WZtci84yu5fxT3Jqpol
         NIMKFmVYK1kYjJzsvyxeriMC+MG9wcmUnq+Ih7aWAbteTAKBc/mFVJGDYyPFasA9umI4
         0uzO4XU0LlMVN0RPwJ2eYXHzwkTznWgNbbamO3EEU7kLPQcohvAYjeMZ5qZJc40c5UcK
         SLYIdstt45fjDisPwcRBFDCAI5uGYk9BV5n2zkauKfPAj9NI3whdpXKQI4LJ1HSJzFOx
         t2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688126424; x=1690718424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14D7DHntwp60GlIftqa4afNY/9x1F06cw0RktL6nRlU=;
        b=gdyoL5a2aNy5Ec2eovGYPqQhcv7DHlcqN7caHH6Vqu7RyNZKVwnaLBG/JBlWeqz8b3
         KsEzlmFL9/3dVGT9zLl0JQ5/lWPUY66BL/jtrjvQPgsqYDv5ejiNnGbSkM0VK3pEYG5f
         DkRlFsLz51L36OMgplNsD+VOF1sDL+GGICnyc5gA5cVbMet5/Ymdt+PhgdwIkAVt8vU0
         EYD8X+ldKmEni7leaIaqXS4mO3V8N2Qcq/XVyisE/4yqL092b+3T94vfU1wJdJFnhzTY
         TkvCco0LG7RPtaP8IqZ7Ghk02sfCrtB2F9jwEDik+4SKz/l75RqHRsceBuvP/d4sdEAG
         6Dng==
X-Gm-Message-State: ABy/qLbq9xp/oZefXJDDvYYs443R/+uHYRjdojwriBkDGI2gnJ47rIPn
        EcYbtUONGELgBfYOF7DFMdVc6g==
X-Google-Smtp-Source: APBJJlGqSfsXzaw++zzvdLROw7Yo3+uXOyWcPd+8UphTz1qVhnp35rk2owNCFJzRjQI6NL3Z38Tbiw==
X-Received: by 2002:a05:6512:3146:b0:4fa:5255:4fa3 with SMTP id s6-20020a056512314600b004fa52554fa3mr1912440lfi.5.1688126423715;
        Fri, 30 Jun 2023 05:00:23 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g24-20020ac25398000000b004efae490c51sm488936lfh.240.2023.06.30.05.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:00:22 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: Revert "mmc: core: Allow mmc_start_host() synchronously detect a card"
Date:   Fri, 30 Jun 2023 14:00:15 +0200
Message-Id: <20230630120015.363982-1-ulf.hansson@linaro.org>
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

It has turned out that some mmc host drivers were not ready to deal with
this change. Let's fix those host drivers first, then we can give this a
new try.

Fixes: 2cc83bf7d411 (mmc: core: Allow mmc_start_host() synchronously detect a card)
Cc: Dennis Zhou <dennis@kernel.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ec4108a3e5b9..3d3e0ca52614 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2199,8 +2199,10 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
 }
 EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
 
-static void __mmc_rescan(struct mmc_host *host)
+void mmc_rescan(struct work_struct *work)
 {
+	struct mmc_host *host =
+		container_of(work, struct mmc_host, detect.work);
 	int i;
 
 	if (host->rescan_disable)
@@ -2272,14 +2274,6 @@ static void __mmc_rescan(struct mmc_host *host)
 		mmc_schedule_delayed_work(&host->detect, HZ);
 }
 
-void mmc_rescan(struct work_struct *work)
-{
-	struct mmc_host *host =
-		container_of(work, struct mmc_host, detect.work);
-
-	__mmc_rescan(host);
-}
-
 void mmc_start_host(struct mmc_host *host)
 {
 	host->f_init = max(min(freqs[0], host->f_max), host->f_min);
@@ -2292,8 +2286,7 @@ void mmc_start_host(struct mmc_host *host)
 	}
 
 	mmc_gpiod_request_cd_irq(host);
-	host->detect_change = 1;
-	__mmc_rescan(host);
+	_mmc_detect_change(host, 0, false);
 }
 
 void __mmc_stop_host(struct mmc_host *host)
-- 
2.34.1

