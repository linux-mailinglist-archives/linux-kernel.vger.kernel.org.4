Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6DE6E1218
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjDMQTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:19:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0281C10F8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:19:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so6598889wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681402772; x=1683994772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K1lqgu2UMJSXGJkQ/CNFe9i2Bxz4FKmXNvI/1jCqDo=;
        b=15siB7iyaLI7ctUMscCZfFX7080U7A2snA5d/ylfDn2u0Pb2PAujpho+y2aaI8sDES
         L9dYvDnEKV28S0BEUMUYMff3pHCziTgOwLvMBYdNsHgsE8onnhngFHIWkp5qQQO5NnA6
         HDYnzLU3zZPRt1RMj1UYXdjtAX/E5HB9ziYTRiqybX3T5i4kqboxQTZPLFIprCtCV73A
         9GV4d8UEvAJ1foOmAeHQQEhFUH6dhZ9W9TJRDXGt9YiynihCT59rnmSu6FrNGrgf2+BQ
         gu/1A9UIhojnFwn5Bjj/eN+sgmpT8UeQR4Nt78j6/1Qvs0RG4TE2rOrliYct6yfHNMxO
         y5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681402772; x=1683994772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7K1lqgu2UMJSXGJkQ/CNFe9i2Bxz4FKmXNvI/1jCqDo=;
        b=kztl3q81zUh+XYOMecBvosyPjTog6CaleQHjCcD1Jqj8UX8tkTc3koJChu81mGuYA9
         OsOu7pJ9WbwEZLp6kbbD+RmlFrnExixHwWctVFbxUIwqoTzBahlqiVeQ59XuAkLRd1Xo
         nwDceGRlWC7hUfROp6Cl26HqmXx1vNO3C45f5/FQz6NHAhMvvFfctnyglS1uUbo/zcUr
         PAGMqk65D9MK9RLgFr4iFBgE9OpeaUTBKez63BId+X/MHDKXY/BfbJSbnkwcp4JKtDdf
         5/kSO3J2T9l9G6PmrfaLD9x6AOR3htuf+p0HVr0K9YfC9nfJD4t4DUtGvmORTPIlRplt
         ElDA==
X-Gm-Message-State: AAQBX9folEo73ZtvcAu60Ok3NdlQNmeBsPRyuBE5guR/tFwCUv/VcWwR
        2pY5nVJGNIQE8VRQZzOFDWMO+A==
X-Google-Smtp-Source: AKy350bbu+EgoDrMFvfMpZKlXMYBBCuVXkA66tWJ2iTh3msfJsJnFkge5XkpmCS78VFL7H6Vq98hpQ==
X-Received: by 2002:a05:600c:201:b0:3ef:76dc:4b80 with SMTP id 1-20020a05600c020100b003ef76dc4b80mr1984394wmi.9.1681402772524;
        Thu, 13 Apr 2023 09:19:32 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id bl18-20020adfe252000000b002d7a75a2c20sm1573011wrb.80.2023.04.13.09.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 09:19:32 -0700 (PDT)
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 2/4] include: riscv: Fix wrong include guard in riscv_pmu.h
Date:   Thu, 13 Apr 2023 18:17:23 +0200
Message-Id: <20230413161725.195417-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230413161725.195417-1-alexghiti@rivosinc.com>
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current include guard prevents the inclusion of asm/perf_event.h
which uses the same include guard: fix the one in riscv_pmu.h so that it
matches the file name.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 include/linux/perf/riscv_pmu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 43fc892aa7d9..9f70d94942e0 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -6,8 +6,8 @@
  *
  */
 
-#ifndef _ASM_RISCV_PERF_EVENT_H
-#define _ASM_RISCV_PERF_EVENT_H
+#ifndef _RISCV_PMU_H
+#define _RISCV_PMU_H
 
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
@@ -81,4 +81,4 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr);
 
 #endif /* CONFIG_RISCV_PMU */
 
-#endif /* _ASM_RISCV_PERF_EVENT_H */
+#endif /* _RISCV_PMU_H */
-- 
2.37.2

