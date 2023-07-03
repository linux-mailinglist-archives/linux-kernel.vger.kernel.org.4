Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31CB745C8A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjGCMt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjGCMt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:49:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602CFFD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:49:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc0981733so42180135e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688388593; x=1690980593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ/nerEaJdoYRd5ld9GUr9ghotX2eSIq7nKEUZxClAs=;
        b=VDQ8BEKOua2MPOeh7UBCA5TLJ/SQzpLxqtHvvtIg9IqrzRgS7zzfIxI4bW61B3TpT/
         MYsOJpsJcMfRcGvKTaEPdwM9HmFspVAwIChFvV8xQi9MAA9nH5gSHhp80hpeuCfLbGf8
         9/OhuweNy85U8eaY0Jm0RwCTxGVuVZPevxQQRXlfQX++Ypoahdq5JQYRcm7UHC++5W+W
         l93VRH6OcveCipTB6jLSZNnSNUII5M5aWbj8X325YjIIJJjL2CRByrBR4aOgWEsP0cUV
         smHrq0CD3JYoL/Ab9OgZfTvhxLFJyHAxAkJmtKFeFSubj0NjZvWaAVGpYRgSX99lLhAP
         Uk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388593; x=1690980593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ/nerEaJdoYRd5ld9GUr9ghotX2eSIq7nKEUZxClAs=;
        b=QUOUVOVNiC7X0W0mbuUvRZoxrl0uumIrAArXTs/1G/UUZ09ym31hCmXrlu7XDBTwq0
         6TSBk//cAhi+NuD+3kvcjhPMvyqBuCN62vZyIypjHhourWZbs6wDQfPENIfYb4ZJF2nr
         AQaqrJz7cugtPz9X3I4uLH+yim1tz50BME96Lv1KtE0cFUALG9hh3oQSyvuEOlbVwRYY
         Aq+3YIRz6N6VMP+JLjJIwrjtSWUa5exbVykqwG7XHIu8txaXGxC5pfZY/yfh5j+h4xUY
         GUp6yoqC3j8o1Rc1bztb54Kza+8NN7FmSfkdsBqGd18h+FgXBlTje7jQP2t7ymfhved1
         ZdgA==
X-Gm-Message-State: AC+VfDwoeNVqkliI8afAjrraBAPtYxcdzH+j1+byzYJOyUDaWnxYVZuk
        ZPyvgyOlO6gYK5WD/DpBdqYGgg==
X-Google-Smtp-Source: ACHHUZ62WvlA3047ray8oXCOSgpbSvwQjyuzYzr8ddqDY560e4nA5mtjjXKgLaeaLCURCwTViq3JeQ==
X-Received: by 2002:a1c:770d:0:b0:3fb:a506:5656 with SMTP id t13-20020a1c770d000000b003fba5065656mr7785924wmi.32.1688388592878;
        Mon, 03 Jul 2023 05:49:52 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c220700b003fa999cefc0sm21128205wml.36.2023.07.03.05.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:49:52 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 03/10] riscv: Make legacy counter enum match the HW numbering
Date:   Mon,  3 Jul 2023 14:46:40 +0200
Message-Id: <20230703124647.215952-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703124647.215952-1-alexghiti@rivosinc.com>
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISCV_PMU_LEGACY_INSTRET used to be set to 1 whereas the offset of this
hardware counter from CSR_CYCLE is actually 2: make this offset match the
real hw offset so that we can directly expose those values to userspace.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/perf/riscv_pmu_legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index ca9e20bfc7ac..6a000abc28bb 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 
 #define RISCV_PMU_LEGACY_CYCLE		0
-#define RISCV_PMU_LEGACY_INSTRET	1
+#define RISCV_PMU_LEGACY_INSTRET	2
 
 static bool pmu_init_done;
 
-- 
2.39.2

