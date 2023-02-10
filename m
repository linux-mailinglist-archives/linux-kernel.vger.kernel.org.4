Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6144692357
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjBJQcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjBJQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:32:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F5465B8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:32:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so6687293wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RD046aMUSgC5nQxm35DsMgjeT2pR30neiQo//qjB39Q=;
        b=DkVIR5xxeNFr3gjw0aHmFH64IP/9A6a6fA5kI31B46euAOD5ooCdetnboxWFsdSwz2
         UBxjvYZ3a/ZjAPKmWQaWvSpIrFOyiliXEO/Yi7cd9PWnDs3NbdHVIlNKB/Z4Ga4rwxqb
         Fyhc+XGjtQ2up8Y2YBt4G4ZdNZUcttGleqVbZpvW6EtiqnsK+5bd6Ta8tJKlA8c5f3Jc
         Un98moaAAvOOae51JKgVxomwtrEF2p4zPaGtpOArZ1Wyo4QFIpTBJ4d2BfsI9etC7Jjr
         hkYyo8Wfg40WRufm5Dlj240KcD6oc6YoB3VokgFoTnrwYRdpohBWwPOoMUBRlZqf6F2D
         8ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RD046aMUSgC5nQxm35DsMgjeT2pR30neiQo//qjB39Q=;
        b=reunswfQXh0YzDUZ4rNxEiysOb3nXtgyGMRX6KZFCj4ET8liRln6Cqi3jo3xYw7OLW
         lQJK9GcSYaUr6xUh92c1/WvN9PIrvtac+Xseq2EvENooO5/Z2vx9pa2osrOLA42MZ9Ur
         SwCFGUxZ+fOD6ZWpoQyewSRt51Ox3UfWlCV9f4t3Fzp+Rx2uBjULmomtUi1n037nZZrG
         wpZGPVcGD3TDQ4tMw/Re0k3/4wEExOgk6M2Q0ancCaquaVksBkPYpvb3/Sk+m+CrQznd
         U5oY/5m+UyvRPKBf4IIiuRCBw/Hk9D3PDTrfkAmHNpKiOcVoWsQQtgjRAftYUCXDM+V+
         mLZg==
X-Gm-Message-State: AO0yUKU3jZCzaNkKaw9N3vDbTQ1NcsnsABXSC7uZPBhFJ/GDUNtz4ldz
        XRVsgfwt6mT9IHRr2c+XCxWeBHSHR7lreVa7M3c=
X-Google-Smtp-Source: AK7set/vJF7G811BqDtmyQ9YF4/UCXYp5Gz8GCy4tHceLAMCPcPzUXZwa2LIQs9w+sVQdkDB8CLpmw==
X-Received: by 2002:a05:600c:4a9c:b0:3dd:1b6f:4f30 with SMTP id b28-20020a05600c4a9c00b003dd1b6f4f30mr17568155wmp.3.1676046754694;
        Fri, 10 Feb 2023 08:32:34 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id q28-20020a05600c331c00b003de2fc8214esm5162434wmp.20.2023.02.10.08.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:32:34 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: max597x: Remove unused variable
Date:   Fri, 10 Feb 2023 17:32:25 +0100
Message-Id: <20230210163225.1208035-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max597x_regmap_config isn't used & hence remove the same.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/max597x-regulator.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/regulator/max597x-regulator.c b/drivers/regulator/max597x-regulator.c
index 39f803ff0a90..ab9dc18f98e3 100644
--- a/drivers/regulator/max597x-regulator.c
+++ b/drivers/regulator/max597x-regulator.c
@@ -357,12 +357,6 @@ static int max597x_irq_handler(int irq, struct regulator_irq_data *rid,
 	return 0;
 }
 
-static const struct regmap_config max597x_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = MAX_REGISTERS,
-};
-
 static int max597x_adc_range(struct regmap *regmap, const int ch,
 			     u32 *irng, u32 *mon_rng)
 {

base-commit: e4b37538f6f7c24a13d6bede4e75f60f213bd2ea
-- 
2.39.1

