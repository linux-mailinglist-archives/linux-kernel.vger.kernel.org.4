Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D14574FE05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGLD6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGLD6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:58:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ACB10EF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:58:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2640a8ceefdso4707476a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689134331; x=1691726331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEOY9a4/YWLBUoOg+yf0OlLFQEwXhAnCHNBGem6V3F8=;
        b=styZZBD34zzOBWH2SU7YeYnvifTmA5S3+v2YspEuc7HDdwOfAU9G7rrmX4hwLfN5Pq
         VlWajywT8qXISFBMOqOVS7Fs1hDiWxSV9e8EsUei5xmKK6elen2zIuKtXGyYHXbZBdzn
         17Ru3vxHI8hhYEsv6TBWk+8KGgGpGtmdb9I7qQ5cCvJPAgGBovzrsDmfO5foD27w7cU8
         XzOuhsdENCEcNvZGC+geQqsRbSbfOd++Gr1Slp5vaaQSP5Cn2hz05J7LyXwgX4DblWCd
         s3R+XqfpFWQSCjBlKaYQcDnglEF4Sn2jJjGN7UrOMnhzXCUok0ffXJINu/p81ih7hcwp
         lsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689134331; x=1691726331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEOY9a4/YWLBUoOg+yf0OlLFQEwXhAnCHNBGem6V3F8=;
        b=WK/1Hs9yNJJtLMQ1FGbb0QjFjIUk3oISGN5nd89mNvqvx996NQBLgeXbLKE2kYuuz6
         t8V/+8HqQ2FeCaafnc6NCxB8vU9aVc+Zflu5m0BVJHFslNBDAPwlQ9qqZbOfVAavCNCd
         73a2Ke8Q8rH4i+sCRSJLln+C1OcORwqr/5z0bzVW2OVACYSm8d+F7zvpMHmGZd/lL+St
         jLi3CWuKsoYenfaaJDUqTdn22N/5nD3n/9sDVXo1aopQYZPl7yLq/g4asIYp/c6skJkc
         SC53MZCf9r7CITaelG6y5NLneiprDIHKoCt2Y5+Md2ekfGmfVoWr1r99iqkpOQytkiIb
         XwQA==
X-Gm-Message-State: ABy/qLZ+eR3sPntxT3QOw704NzRwfZOFxMeIz7XM9NoqiO7D/f8hMSSB
        Q5kL2Jrfd6/KbmHpgzY2NYmJRPfePRBi2OX4Q4A=
X-Google-Smtp-Source: APBJJlGuySQn81JpLv1P3ociE7k0w/G4VfpcKdQF75gIlQj1BUydeqT6E6kg74SfUgLM0KM549cOMw==
X-Received: by 2002:a17:90b:614:b0:260:fd64:a20 with SMTP id gb20-20020a17090b061400b00260fd640a20mr18186325pjb.9.1689134331055;
        Tue, 11 Jul 2023 20:58:51 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id z20-20020a17090ab11400b00263e1db8460sm8927872pjq.9.2023.07.11.20.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 20:58:50 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: sparc: Don't mark cpufreq callbacks with __init
Date:   Wed, 12 Jul 2023 09:28:43 +0530
Message-Id: <94682b1572da4a3c6afd31bddf93b797f73fff5e.1689055100.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These callbacks can be called again by the cpufreq core after the driver
is initialized and must be kept around. We currently get section
mismatch build warnings.

Don't mark them with __init.

Fixes: dcfce7c2cee4 ("cpufreq: sparc: Don't allocate cpufreq_driver dynamically")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rafael,

Please apply this for -rc2. Thanks.

 drivers/cpufreq/sparc-us2e-cpufreq.c | 2 +-
 drivers/cpufreq/sparc-us3-cpufreq.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index d3510cfdb3eb..2783d3d55fce 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -269,7 +269,7 @@ static int us2e_freq_target(struct cpufreq_policy *policy, unsigned int index)
 	return smp_call_function_single(cpu, __us2e_freq_target, &index, 1);
 }
 
-static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
+static int us2e_freq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
 	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index 91d1ed558136..6c3657679a88 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -117,7 +117,7 @@ static int us3_freq_target(struct cpufreq_policy *policy, unsigned int index)
 	return smp_call_function_single(cpu, update_safari_cfg, &new_bits, 1);
 }
 
-static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
+static int us3_freq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
 	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
-- 
2.31.1.272.g89b43f80a514

