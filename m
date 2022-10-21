Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C57607306
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiJUIzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiJUIzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:55:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3958F278;
        Fri, 21 Oct 2022 01:54:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d10so1990184pfh.6;
        Fri, 21 Oct 2022 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NW463Igz6cQC3RaEvw8WDzTJ4CdrSyo6nM6hGHOMkTg=;
        b=drX/ctD2faQZRSHwPE6bgBOPuQP4t2psLZ1zSbIMSreWD+ceMp5xID5RhVjMEGvhLo
         7IszKXtAuSnpMk47VmJCpL8Kf0yYz+9YFbgjy8i7bFx/OqAI5Q2Xh9wUVtFCuiQv2+kj
         BChLBtgAMSfEssm6UC9Fp3o2L+GEOZlWVM/dIeM0Xi2oYLWXPdTB+dq1S02uC/s7YPSq
         5a18zdlgdRXGC4SsQDVfkCHbeUZaCEj6AoNWF7dxByEiSuTEZ86LYwi312rM6QLvdE3i
         btXNYpZjrijjuR4ujJDOU6VIfWdH2sXrmv/xDMYAmyJJiMoy37JZ/hDyirc4QUbGkEZK
         n0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NW463Igz6cQC3RaEvw8WDzTJ4CdrSyo6nM6hGHOMkTg=;
        b=Sxklm+i+ki5kEV2ZSqSn6CxwRgY9K6ABEhoMoHq+ChcJ6QFuPY0xReUau+52QbY8Hb
         rbEvU3IurFjm+EEpsvm+T7z0AzrWISFlX5lYCJ5SaFqzo2Y/etAk6qdXmHJ4JvKLHxUY
         toQW+KiHCccsYXvNIUBsyP6GD5f3yTwBF80KM/PEIH/j5FII9d8a2dhHwY1TVqMrKBiG
         iiKtbo88MfjlEbhz9pPq9MJYMypILqlGuBbomPPdJZsSVq354AQ+rUwC3owyF8w53c5x
         aTi+3Pvgj/7kMQaWazXpd9aSBozs6hHixPNqFS9gMPMNfsLEnMHB0PGviJ92s7ypRA9m
         SYsQ==
X-Gm-Message-State: ACrzQf2B9YT1itmBK0Um40co107NeQEvAGExriwzWmgfmcYrdjv5pIJ2
        m7ONQcW2dB4zzVDDDIN/BbY=
X-Google-Smtp-Source: AMsMyM51qvVJE1RiwK8mQdWSsdqQyT425nRze957rS+v3ZMVxZgWpeMTbwxPM6xlSZg/s+OWeuC2fA==
X-Received: by 2002:a63:4507:0:b0:43c:9cf4:f1d6 with SMTP id s7-20020a634507000000b0043c9cf4f1d6mr15852327pga.316.1666342494338;
        Fri, 21 Oct 2022 01:54:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001811a197797sm14069544pll.194.2022.10.21.01.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:54:53 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     axboe@kernel.dk
Cc:     kch@nvidia.com, damien.lemoal@opensource.wdc.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, vincent.fu@samsung.com,
        shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] null_blk: use sysfs_emit() to instead of scnprintf()
Date:   Fri, 21 Oct 2022 08:54:46 +0000
Message-Id: <20221021085446.414696-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/block/null_blk/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..5317ef2ba227 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -255,18 +255,18 @@ static inline struct nullb_device *to_nullb_device(struct config_item *item)
 
 static inline ssize_t nullb_device_uint_attr_show(unsigned int val, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(page, "%u\n", val);
 }
 
 static inline ssize_t nullb_device_ulong_attr_show(unsigned long val,
 	char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%lu\n", val);
+	return sysfs_emit(page, "%lu\n", val);
 }
 
 static inline ssize_t nullb_device_bool_attr_show(bool val, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(page, "%u\n", val);
 }
 
 static ssize_t nullb_device_uint_attr_store(unsigned int *val,
-- 
2.25.1

