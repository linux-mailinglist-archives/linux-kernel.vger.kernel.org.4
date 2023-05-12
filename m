Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8345700319
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbjELI6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbjELI6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:58:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859DE2126
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:58:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307c040797bso1840919f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683881877; x=1686473877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcoGNF7JhrmxjCUJ31ZWLSLoY1qQtRXBvkDSeKWeoAE=;
        b=j0DLCCtMEV6UXHGMXtA6jElCfmVNii679kPYYZsmKm9aD75PHOebwGkVrc6Gfiboyx
         RvCFvQmdeuzdeOvfXCdQOXwLou3CT6k5zHrydjFCJOM4CfLlm23nYTXhdENsRytg1bw2
         M+WUTSR3utlqD0vuCxQR2w2Ifa3W3yUVTfIhLcL+gs4ADta+RZD/IzA7ThYOKELeV3hw
         /YXVPvWlRyErSS21CkUFyhAfXahfWVYARbMIE9VKbydkHTCJT+v3ZtI+4FtUTpkIkXTZ
         uUkHKb7RdfHC8Q06kUAnddmIThthmriXlIOQgdPdvAX5tb59HXmbwuvIUmyRBi8UL7kz
         2WdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683881877; x=1686473877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcoGNF7JhrmxjCUJ31ZWLSLoY1qQtRXBvkDSeKWeoAE=;
        b=DaXl68QYvq2xyKCfA86zOUM1UXJjiyHrJglUJ8ooTeQQofaoNC23L4lf7goXspx6MV
         PUWSKSKD1r7QCilvsS5E0YSHLdF3x7YTy7hAAYG5lX0y5/08pcTTW6xLzaR/Da/7Uimm
         9pZLQ/rfyJHZj2n8pQKm+s22lqZTpKimQpiBoYMtKylqRfLPw1a4dIImIoGnfpsw+58n
         lSRD8s9B1u2m1wb2lsDNt+2gvSFxXBG+yimx0pKd6GfkRVyC1dB28Tbp5AlDa2w1/6GE
         Teffjs3GLvtnbb5OaBnEK761Vs47HEv7y5ACQPVxfTERzVN8DZLyDfNtngGGizZZuAQn
         vVPg==
X-Gm-Message-State: AC+VfDzUyzbMk29JdENyJDSR4kCyOZpnWoX/Ot9C6KoQ8+lGHrRPGK8M
        I00uApGOMvipbN5Ozkr+H0RsZQ==
X-Google-Smtp-Source: ACHHUZ59QZ/d2h0X4opjouOE+vww3Ww10su+H5NJb68TnAb4iZVlA+QJrLsykQHhtEpQNw67FT9wNQ==
X-Received: by 2002:adf:e941:0:b0:307:a8e8:ca6c with SMTP id m1-20020adfe941000000b00307a8e8ca6cmr8411496wrn.35.1683881877661;
        Fri, 12 May 2023 01:57:57 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc7d6000000b003f42813b315sm12616421wmk.32.2023.05.12.01.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:57:57 -0700 (PDT)
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
Subject: [PATCH v2 04/10] drivers: perf: Rename riscv pmu driver
Date:   Fri, 12 May 2023 10:53:15 +0200
Message-Id: <20230512085321.13259-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512085321.13259-1-alexghiti@rivosinc.com>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
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

In addition to being more pretty, it will be useful in upcoming commits
to distinguish those pmu drivers from the other pmu drivers.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/perf/riscv_pmu_legacy.c | 2 +-
 drivers/perf/riscv_pmu_sbi.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index 0d8c9d8849ee..ffe09d857366 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -95,7 +95,7 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
 	pmu->ctr_clear_idx = NULL;
 	pmu->ctr_read = pmu_legacy_read_ctr;
 
-	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
+	perf_pmu_register(&pmu->pmu, RISCV_PMU_LEGACY_PDEV_NAME, PERF_TYPE_RAW);
 }
 
 static int pmu_legacy_device_probe(struct platform_device *pdev)
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 70cb50fd41c2..3b0ee2148054 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -897,7 +897,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_unregister;
 
-	ret = perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
+	ret = perf_pmu_register(&pmu->pmu, RISCV_PMU_PDEV_NAME, PERF_TYPE_RAW);
 	if (ret)
 		goto out_unregister;
 
-- 
2.37.2

