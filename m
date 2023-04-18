Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7EC6E6AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjDRR0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjDRR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:26:38 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34555BB92;
        Tue, 18 Apr 2023 10:26:29 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id xd13so41241798ejb.4;
        Tue, 18 Apr 2023 10:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681838787; x=1684430787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y75P8H32UG8qaN1RFcrKVl4lR71O6GrEWubbNzGhkQE=;
        b=Z1XH00UTWa5NBh071ecnWf7eosd+V24Jyz0Z4ZGz0XoJA2UJGfVO8c3xky7R74z/gY
         Hl2omgF/LsvsAp7jDGAuBP5Vb8BlGCkJLymxYJyo0KZrvZt1pfltq3GZA1RlAcFg/vSj
         mXUp6n2jAGg4QKlunTYfIycM1yfkbu/eFge1Q/zlrLhck02TkcFUqxntQffF0Csm/2f8
         VfP5NUJMpDtdlt0hvHy1E3EHP45HDDd6NfAknQ8TROsj53fz97u9nia5N0hMETQZWY11
         CybX4L5+11mtzvQgJcIqOV42A/5ifnHaGEoSmXdI4hN/mIP1F6QJAPniEz9oVZkZVmM9
         F/Cg==
X-Gm-Message-State: AAQBX9ffELxSTBUVU8RwaCgVtSbnn/+7uBJScdx89+CfHmxbqojK9w1r
        cGzc98j8dGq4Yk6vETXVoHr/Hn+XIHPINQ==
X-Google-Smtp-Source: AKy350aqQUDdYW9CQcCoN8BCnSTaBpwe7yhcfezWXcDF+/LwvnN4lZxmnvIsOCPacxO6EWput7NcQw==
X-Received: by 2002:a17:907:3c23:b0:94a:7da2:d339 with SMTP id gh35-20020a1709073c2300b0094a7da2d339mr9252149ejc.26.1681838784884;
        Tue, 18 Apr 2023 10:26:24 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-204.dynamic.mnet-online.de. [62.216.205.204])
        by smtp.googlemail.com with ESMTPSA id j23-20020a1709066c1700b0095342bfb701sm63259ejr.16.2023.04.18.10.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:26:24 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 2/2] watchdog: menz069_wdt: fix timeout setting
Date:   Tue, 18 Apr 2023 19:25:31 +0200
Message-Id: <20230418172531.177349-3-jth@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418172531.177349-1-jth@kernel.org>
References: <20230418172531.177349-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting the timeout for the menz069_wdt watchdog driver, we
erroneously read from the 'watchdog value register' (WVR) instead of the
'watchdog timer register' (WTR) and then write the value back into WTR.

This can potentially lead to wrong timeouts and wrong enable bit settings.

Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/watchdog/menz69_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
index bca0938f3429..3c98030b9fcd 100644
--- a/drivers/watchdog/menz69_wdt.c
+++ b/drivers/watchdog/menz69_wdt.c
@@ -77,7 +77,7 @@ static int men_z069_wdt_set_timeout(struct watchdog_device *wdt,
 	wdt->timeout = timeout;
 	val = timeout * MEN_Z069_TIMER_FREQ;
 
-	reg = readw(drv->base + MEN_Z069_WVR);
+	reg = readw(drv->base + MEN_Z069_WTR);
 	ena = reg & MEN_Z069_WTR_WDEN;
 	reg = ena | val;
 	writew(reg, drv->base + MEN_Z069_WTR);
-- 
2.39.2

