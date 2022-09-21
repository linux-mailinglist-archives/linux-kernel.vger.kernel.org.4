Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E016E5BFD42
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiIULr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiIULq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:46:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89493956A0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o2so8718435lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Z9Ue5DS5Cga8o/w2e+6VqkFN/cO/eMoPZweW6fx+Axk=;
        b=evlmInS7BghmrM8Z0zAIKp53bvbv2IpVwbmqJkDXMdyLGUoMR/TI3ZH3McmfIjqUaz
         50+7sDhtQFGJhoRxO2h2HH7jkaWu3+nf6lXPQhHrTPCh9aaRSG6Pbl61EoUmBanMPnx4
         6J5fZqeYmXz8I7eVoOaS62kfUstAuBDIFmzbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Z9Ue5DS5Cga8o/w2e+6VqkFN/cO/eMoPZweW6fx+Axk=;
        b=chJeUWrnlZsnY9O4vl37lWmIaVHWpWokM2BqdH3xNeWYq4CymAn9KApOzfHGun+NAa
         qClUjfjiqBtCTT7SDuG0g4UvSqq5/9bx+jpVAWirixvi7sVnU3b4aa3fDMNnUNPr6bCk
         7OzQHwO/FgQVlu/3LKHLua5/xltlVfh2t9JeOTROi+5Ar4kM7sXSBIgoDtGtzI+FNeWx
         c40tG7yQM9Dtz+BEp6Tzsw98Ybg7BRcZOQSmR+hxJ8zWj1QKm6QVWDmR8HY/g+ArCswW
         rlK4JksY8RXtSr1vlPOOGO9EaWYcEUscqPZpW2Q03WLhkKm91ZjsgKi5fR5zdfP3Q2iC
         H01g==
X-Gm-Message-State: ACrzQf3FCYXPiwhDXyu6KCR/7XE9AB9x9ZNiRJneWH3e31NuVG0bj6s7
        ce9GqTtWWXOMktpWNaIiVeFpYA==
X-Google-Smtp-Source: AMsMyM5WhXsNX6XVZJGeBmRacLDjdOlwrLy/r5SegrTbMy4w/i5inYO8mQreICTZZ/Lr6BpLgc0xww==
X-Received: by 2002:ac2:454a:0:b0:49c:6212:c44d with SMTP id j10-20020ac2454a000000b0049c6212c44dmr10742580lfm.430.1663760798387;
        Wed, 21 Sep 2022 04:46:38 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00494618889c0sm405713lfr.42.2022.09.21.04.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:46:38 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] rtc: isl12022: use dev_set_drvdata() instead of i2c_set_clientdata()
Date:   Wed, 21 Sep 2022 13:46:21 +0200
Message-Id: <20220921114624.3250848-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As another preparation for removing direct references to the
i2c_client in the helper functions, stash a pointer to the private
data via dev_set_drvdata() instead of i2c_set_clientdata().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index d396d6076db5..df6d91f4e8f3 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -149,7 +149,7 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct isl12022 *isl12022 = i2c_get_clientdata(client);
+	struct isl12022 *isl12022 = dev_get_drvdata(dev);
 	size_t i;
 	int ret;
 	uint8_t buf[ISL12022_REG_DW + 1];
@@ -232,8 +232,7 @@ static int isl12022_probe(struct i2c_client *client)
 				GFP_KERNEL);
 	if (!isl12022)
 		return -ENOMEM;
-
-	i2c_set_clientdata(client, isl12022);
+	dev_set_drvdata(&client->dev, isl12022);
 
 	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(isl12022->rtc))
-- 
2.37.2

