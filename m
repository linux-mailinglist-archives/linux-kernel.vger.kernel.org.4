Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99359743769
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjF3IgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjF3Ifr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:35:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C34735BD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:35:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f973035d60so2607886e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688114144; x=1690706144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ourpCES+L8D+Sf3DlwDnrKMPgPuj2Rb0Ie1m7RKO9o=;
        b=0KLssk8HRfE90130xKoKTzd8QqIpNNmEGYyeL+ivfM59890lBfIuxPh/YTTtxMCeJu
         HilIlZL6yYJHT+NSdn2sWN1C3I33DwQxN5PPXQk69+hLlbGiOnTa3XOfshkprJru9dCp
         AeDmMl1VoQDpxwaI+8E2wJD1THYAUCwr1Zaa0GHElk3IDp8gkCxpUazrlnegNSdrthgC
         JBuREIxskFXjzwLrlDfKLochEuX5EBp/lfz3dW1Ko/jbOkZn5tzbNH7Xy/WEQlTW29Mw
         zbe10nFdCWzgoKjjn4/cjhnuLG9yl9b+oDWEOXNbIRq2mQX+Hv0MyM55crAam+humX+M
         /6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688114144; x=1690706144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ourpCES+L8D+Sf3DlwDnrKMPgPuj2Rb0Ie1m7RKO9o=;
        b=USCZW7w4kFn/wUpcKu4QG83Is2n2g8FOOivATw33cn5EDkL2MNwRmHbV7Cw3JmC7Q/
         sai3EqG/QOx+ouKrnUZR3WMb9LZ6pxy0nHdQFdQjpBRvLhQ/pb+mw/wVJ8ELiH9v90m4
         E3DIwCz+ZRuBUWv7PmyIa9NrFS6qTjaE8X7x3cQGhhrFau9Nv/Nrg0gqpM735vdoN0u9
         OtGX3m7vFs6OLozHo1AcoEUGydXUGS+N7x+QY25z//2kA0Ss+imkWpe91oib81ajlKKE
         DmYJISVLzFOpmvPr2tzE5/3An9UVlKBRL82WwQO00cP4koOPJPG5/IcjMxoxZeRetUed
         xTzw==
X-Gm-Message-State: ABy/qLZK8+lxpFBBgfaY7wPE6WKYwTYASfL/ynDeAZvAklBq6kAGZAmm
        PdGipNWs05mnCtOmu0snfd8+kfelRao6Cl6Iec8=
X-Google-Smtp-Source: APBJJlEKmo6oGA8BhKLYpuMDCbIqFVI+6Q81fGGqSIHo2vLevwphPX4q4nQy50JIRXqiJIM8dj26WQ==
X-Received: by 2002:a19:9110:0:b0:4fb:8ee0:b8a5 with SMTP id t16-20020a199110000000b004fb8ee0b8a5mr1396269lfd.46.1688114144613;
        Fri, 30 Jun 2023 01:35:44 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id s15-20020adfeccf000000b003127741d7desm6286799wro.58.2023.06.30.01.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:35:44 -0700 (PDT)
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
Subject: [PATCH v3 04/10] drivers: perf: Rename riscv pmu sbi driver
Date:   Fri, 30 Jun 2023 10:30:07 +0200
Message-Id: <20230630083013.102334-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630083013.102334-1-alexghiti@rivosinc.com>
References: <20230630083013.102334-1-alexghiti@rivosinc.com>
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

That's just cosmetic, no functional changes.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/perf/riscv_pmu_sbi.c   | 4 ++--
 include/linux/perf/riscv_pmu.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 4f3ac296b3e2..83c3f1c4d2f1 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -914,7 +914,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 static struct platform_driver pmu_sbi_driver = {
 	.probe		= pmu_sbi_device_probe,
 	.driver		= {
-		.name	= RISCV_PMU_PDEV_NAME,
+		.name	= RISCV_PMU_SBI_PDEV_NAME,
 	},
 };
 
@@ -941,7 +941,7 @@ static int __init pmu_sbi_devinit(void)
 	if (ret)
 		return ret;
 
-	pdev = platform_device_register_simple(RISCV_PMU_PDEV_NAME, -1, NULL, 0);
+	pdev = platform_device_register_simple(RISCV_PMU_SBI_PDEV_NAME, -1, NULL, 0);
 	if (IS_ERR(pdev)) {
 		platform_driver_unregister(&pmu_sbi_driver);
 		return PTR_ERR(pdev);
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 9f70d94942e0..5deeea0be7cb 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -21,7 +21,7 @@
 
 #define RISCV_MAX_COUNTERS	64
 #define RISCV_OP_UNSUPP		(-EOPNOTSUPP)
-#define RISCV_PMU_PDEV_NAME	"riscv-pmu"
+#define RISCV_PMU_SBI_PDEV_NAME	"riscv-pmu-sbi"
 #define RISCV_PMU_LEGACY_PDEV_NAME	"riscv-pmu-legacy"
 
 #define RISCV_PMU_STOP_FLAG_RESET 1
-- 
2.39.2

