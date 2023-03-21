Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBFF6C3940
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCUSfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCUSf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A545CA16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679423684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sPS9ll6drXSpZudk7wgwyOxcgefAuYnobo/FFgs8jpQ=;
        b=jKOuX4H7KKrZHvL4QoJfSrsCEU4cE+O4j0K6ZpbFLZatVoKKp9wfJKdXPcDix//iYzqaW0
        BFBf1gzJVbkTMryBZ6DSDHo/RgHpWdelvh90WCiDH6ConTcvu8WCTy6zpejaZHcUtzMEyD
        p48Qxa0irnrCDG6vpE4suM/Y+j6ZoTA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-UjBmMrz9OpicOonRmkk_4w-1; Tue, 21 Mar 2023 14:34:43 -0400
X-MC-Unique: UjBmMrz9OpicOonRmkk_4w-1
Received: by mail-qt1-f200.google.com with SMTP id i24-20020ac84f58000000b003bfe3358691so9298354qtw.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679423683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPS9ll6drXSpZudk7wgwyOxcgefAuYnobo/FFgs8jpQ=;
        b=j4MvMRG92A3fsYkgY8QV+ZZZxdZuoC4ygvygL/q/LJYVUme1Ts0JkZGiJA4agsbRrM
         Mcv96YiZDD2waXQ0yBACnhXRFf6exAYP0HXuK71eUQNpMnxu4fqIqDfCE8uU+MK6pJtX
         aSl0yFRxByrA7riT7qOEXeNwUURZeXtSkrKnzQ/+Owu7q5W35vXoLYVYhX/1qn9rp4s9
         UawBr2JRYa3dCDmipMwrtWAdX/Djwl6L17zgkkjo7B58ym/GKEyHW+aIK8EdWkBRnW6I
         aa5fr8YL3Wzb3yr9lsE4rA3JE3lsx7lWRG/t5Pmgju+TNVEH6SeqWDybhjJm0+DfR3+3
         TxpA==
X-Gm-Message-State: AO0yUKV6Usw24EoygIqvXHAWeyCQahvnpLMgfKeA6dKYSCyxDBR0GzbY
        w/XRAyIOFuFAe9SW3dU6dMVBcpJmI6ShsLP0nBPK6wm3XeVrTev7edvHsDYaRxBzbRgA6GzvERX
        j1oi/KE0yawGCeCnUEwtxC2KV
X-Received: by 2002:a05:622a:c:b0:3b9:bc8c:c212 with SMTP id x12-20020a05622a000c00b003b9bc8cc212mr1130919qtw.29.1679423683057;
        Tue, 21 Mar 2023 11:34:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Nu0137AV03cS5KH42Ha1QHglBsq3KR/srTrXB0d2sDKNVBqq1BOANC35xWCA7cmroLW7GGw==
X-Received: by 2002:a05:622a:c:b0:3b9:bc8c:c212 with SMTP id x12-20020a05622a000c00b003b9bc8cc212mr1130898qtw.29.1679423682803;
        Tue, 21 Mar 2023 11:34:42 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i16-20020ac871d0000000b003d9a69b4876sm8778906qtp.11.2023.03.21.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:34:42 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        wim@linux-watchdog.org, linux@roeck-us.net, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] watchdog: s3c2410: remove unused freq_to_wdt and s3c2410wdt_is_running functions
Date:   Tue, 21 Mar 2023 14:34:39 -0400
Message-Id: <20230321183439.1826823-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/watchdog/s3c2410_wdt.c:311:35: error: unused function
  'freq_to_wdt' [-Werror,-Wunused-function]
static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
                                  ^
drivers/watchdog/s3c2410_wdt.c:446:19: error: unused function
  's3c2410wdt_is_running' [-Werror,-Wunused-function]
static inline int s3c2410wdt_is_running(struct s3c2410_wdt *wdt)
                  ^
These functions are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/watchdog/s3c2410_wdt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 200ba236a72e..6394dda7a5dc 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -308,11 +308,6 @@ static inline unsigned int s3c2410wdt_max_timeout(struct s3c2410_wdt *wdt)
 				       / S3C2410_WTCON_MAXDIV);
 }
 
-static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
-{
-	return container_of(nb, struct s3c2410_wdt, freq_transition);
-}
-
 static int s3c2410wdt_disable_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
 {
 	const u32 mask_val = BIT(wdt->drv_data->mask_bit);
@@ -443,11 +438,6 @@ static int s3c2410wdt_start(struct watchdog_device *wdd)
 	return 0;
 }
 
-static inline int s3c2410wdt_is_running(struct s3c2410_wdt *wdt)
-{
-	return readl(wdt->reg_base + S3C2410_WTCON) & S3C2410_WTCON_ENABLE;
-}
-
 static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd,
 				    unsigned int timeout)
 {
-- 
2.27.0

