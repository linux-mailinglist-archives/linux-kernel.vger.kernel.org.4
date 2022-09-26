Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3BF5EB071
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIZSqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiIZSqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:46:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72593B6D;
        Mon, 26 Sep 2022 11:45:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so8493133wmr.1;
        Mon, 26 Sep 2022 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=KbE8+k0DQbQiN6rvJmf+M4QiM27Iyd9apl5Sske1Zzw=;
        b=lEcglelMVfI2ds6r+pDA9x4BrelWnkKw82KQaIX1ppGx7vEVQmiIlZrrmC7NxTlcZD
         Gq7WI4BxLyydc11i7GBzwbYddKffR9aNMnmaKvVHkxwJYi/y1uEsuG0x+SdS7tGjEF8E
         tZoNaN+xbDeWOnSE/d7wvOWYff5pq9Kix6T9Toquh6u7PaIZXvoHhKK4F1qB7NdZTC+Y
         OPgAnLs9jMLkUkg4VwstbCHVyPjxX7OqYNujR1Ulp9NhSsxEbHIJpheFTNnKp7t6SosN
         EdaOM8FZvlFGs2uf5iEyFfc6mo/4nIyP/CcEYBmOwKjhGL8EdLE5gJGNpqynDoRAx/ct
         oHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KbE8+k0DQbQiN6rvJmf+M4QiM27Iyd9apl5Sske1Zzw=;
        b=qJV2r3garlnGtKJjkJtUfAQT7mbBxjISLLUaTQ+EVtja88vVHQakc8LzYlC4mn0Yw5
         qgjoHsUPY+YXGBR9C+mD0r87JaNIfyWQW/9LuVcfaoXCgXrt43dionHpq1N1Sj8BY3t+
         6rHta2IObNexx1TJO+biqcBNo12bisr+YmhDMASt+WaToWstAyqLExV/jkpqtlsqrQ4O
         qHOJpRBH14xMPKmKJ+i05V/qvEUdfwY54GMu3+YexWzwl/hspvhMOcEgimS3W2UZpQyW
         QcX76Dfc39P5v53xYbUlDQME3faIFaOmjVH+MjjJMzU91KPjTL13JLvX9FnDBHUbHH9m
         2rJw==
X-Gm-Message-State: ACrzQf28eL5yNB2yiRGeCDnb+mj56y1HgabD3rjyrOShsNQatLlIuFMW
        A1LBD5dKuc2d0AKZbDjJHk0VXriHnDd/
X-Google-Smtp-Source: AMsMyM5tpVrKELCli736w1Un7LQjURTIyih0DtUhl0KVk+6QQ6tDeOcWn2gbBaTL5/k5CsaCE744TQ==
X-Received: by 2002:a05:600c:4f82:b0:3b4:9f2f:430b with SMTP id n2-20020a05600c4f8200b003b49f2f430bmr103344wmq.16.1664217955598;
        Mon, 26 Sep 2022 11:45:55 -0700 (PDT)
Received: from fedora (88-106-97-87.dynamic.dsl.as9105.com. [88.106.97.87])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5537bb2besm12607843wmb.25.2022.09.26.11.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:45:55 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:45:53 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     mark.rutland@arm.com
Cc:     alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, elana.copperman@mobileye.com
Subject: [PATCH 4/7] x86: events: Convert snprintf() to scnprintf()
Message-ID: <YzHzYWiq64y4DU7p@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinnelle reports a warning
Warning: Use scnprintf or sprintf
Adding to that, there has been a slow migration from snprintf to scnprintf.
This LWN article explains the rationale for this change
https: //lwn.net/Articles/69419/
Ie. snprintf() returns what *would* be the resulting length,
while scnprintf() returns the actual length.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f969410d0c90..71695d21ffd1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1905,7 +1905,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
 		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
 			next_str = strchr(str, ';');
 			if (next_str)
-				return snprintf(page, next_str - str + 1, "%s", str);
+				return scnprintf(page, next_str - str + 1, "%s", str);
 			else
 				return sprintf(page, "%s", str);
 		}
@@ -2566,7 +2566,7 @@ static ssize_t get_attr_rdpmc(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
+	return scnprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
 }
 
 static ssize_t set_attr_rdpmc(struct device *cdev,
@@ -2624,7 +2624,7 @@ static ssize_t max_precise_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
+	return scnprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
 }
 
 static DEVICE_ATTR_RO(max_precise);
-- 
2.37.3

