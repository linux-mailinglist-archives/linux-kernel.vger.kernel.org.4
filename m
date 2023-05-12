Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1F7700344
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbjELJDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbjELJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:03:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11411B4D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:03:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30789a4c537so4788366f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683882184; x=1686474184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khPfbby7IPCncqSF+FJrwJStKuiFrL9boyjJq7WdL+E=;
        b=hY9SG8dIhRNYozeemNnkzLRlAbmVclRbZV3GRGK8YaSPWIybFgW0uvkLWj0tKns0Bs
         7zgdl9tvFRUhZGLmm6dTtm8savwM52e2Bvepp1mbPtloweWDurrvhdOwraeoXZbrmZx/
         k85584aexQU9oFvEfH40xPUvrrym3cZvpS3Lf39pgKr9+vJ5fJaMprpKiCj2mUYagz8Q
         mwar/oteCL2Z/7RsFJQ1cZNrrp5dEbAyhDmb1fZxe3jQZphniieKvdjIyHYdsqLTSWjR
         WALgmEEY6qh90Mqw0shMHNhkY3aHivEgjjPxoyQF+OkxrkOFkHo2BIJXYWKv8miIwvGR
         qgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683882184; x=1686474184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khPfbby7IPCncqSF+FJrwJStKuiFrL9boyjJq7WdL+E=;
        b=QdgIiqUb8p6Ju/9+GkwWfhPNJE8QKw8e70T87UY21a0G7kOBrXtZfytJHkuNjT6ijc
         JriVFs3nj3vRz1vZwH6UZXK1JPr5uCfexdTIVMQokrT/H7QGcaj8d5JMn3E+al1rwPav
         BChbY6yzZ21Sa60n3Mjo2JCFM3DeafF61K6c1LbTS6rx9pddEQneGVHlXkOFuM81pU0v
         +nw2LSpptV/x5LSZ83fNEMHJrAfq8TmUoShAsFXdjejK/DejIgiSiWxO3XFST1UL4RBK
         qr3fjIOpEsUzwFwMrKxiMv3Ua6vq5FcGNBpc3YNfTOScBmnsZ5VWuOVXX74M2YUuRe2U
         owCw==
X-Gm-Message-State: AC+VfDyKy4injTdhDqHUbc5fLL9LmfcHeJmv1y50L2Q/EO7SpSOC/T4L
        OdcWZDpT45CQ2AiMoQfXJniUHg==
X-Google-Smtp-Source: ACHHUZ6Bl4FWbRLFAer4w2NXv26Ofk/W3DAGO9+CBJd/IoeWPKcp1Q1abg9G/dgxr8hI2QmW+SHLjQ==
X-Received: by 2002:adf:fd4c:0:b0:306:2c47:9736 with SMTP id h12-20020adffd4c000000b003062c479736mr16490510wrs.15.1683882184164;
        Fri, 12 May 2023 02:03:04 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z6-20020adff746000000b002f103ca90cdsm22791785wrp.101.2023.05.12.02.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:03:03 -0700 (PDT)
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
Subject: [PATCH v2 09/10] tools: lib: perf: Implement riscv mmap support
Date:   Fri, 12 May 2023 10:53:20 +0200
Message-Id: <20230512085321.13259-10-alexghiti@rivosinc.com>
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

riscv now support mmaping hardware counters so add what's needed to
take advantage of that in libperf.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 tools/lib/perf/mmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 0d1634cedf44..65f250e0ef92 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int counter)
 
 static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
 
+#elif __riscv_xlen == 64
+
+#define CSR_CYCLE	0xc00
+#define CSR_TIME	0xc01
+#define CSR_CYCLEH	0xc80
+
+#define csr_read(csr)						\
+({								\
+	register unsigned long __v;				\
+		__asm__ __volatile__ ("csrr %0, " #csr		\
+		 : "=r" (__v) :					\
+		 : "memory");					\
+		 __v;						\
+})
+
+static unsigned long csr_read_num(int csr_num)
+{
+#define switchcase_csr_read(__csr_num, __val)           {\
+	case __csr_num:                                 \
+		__val = csr_read(__csr_num);            \
+		break; }
+#define switchcase_csr_read_2(__csr_num, __val)         {\
+	switchcase_csr_read(__csr_num + 0, __val)        \
+	switchcase_csr_read(__csr_num + 1, __val)}
+#define switchcase_csr_read_4(__csr_num, __val)         {\
+	switchcase_csr_read_2(__csr_num + 0, __val)      \
+	switchcase_csr_read_2(__csr_num + 2, __val)}
+#define switchcase_csr_read_8(__csr_num, __val)         {\
+	switchcase_csr_read_4(__csr_num + 0, __val)      \
+	switchcase_csr_read_4(__csr_num + 4, __val)}
+#define switchcase_csr_read_16(__csr_num, __val)        {\
+	switchcase_csr_read_8(__csr_num + 0, __val)      \
+	switchcase_csr_read_8(__csr_num + 8, __val)}
+#define switchcase_csr_read_32(__csr_num, __val)        {\
+	switchcase_csr_read_16(__csr_num + 0, __val)     \
+	switchcase_csr_read_16(__csr_num + 16, __val)}
+
+	unsigned long ret = 0;
+
+	switch (csr_num) {
+	switchcase_csr_read_32(CSR_CYCLE, ret)
+	switchcase_csr_read_32(CSR_CYCLEH, ret)
+	default:
+		break;
+	}
+
+	return ret;
+#undef switchcase_csr_read_32
+#undef switchcase_csr_read_16
+#undef switchcase_csr_read_8
+#undef switchcase_csr_read_4
+#undef switchcase_csr_read_2
+#undef switchcase_csr_read
+}
+
+static u64 read_perf_counter(unsigned int counter)
+{
+	return csr_read_num(CSR_CYCLE + counter);
+}
+
+static u64 read_timestamp(void)
+{
+	return csr_read_num(CSR_TIME);
+}
+
 #else
 static u64 read_perf_counter(unsigned int counter __maybe_unused) { return 0; }
 static u64 read_timestamp(void) { return 0; }
-- 
2.37.2

