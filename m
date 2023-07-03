Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F055A745CAD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGCM5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGCM5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:57:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9965118
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:57:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbd33a573cso15863305e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688389021; x=1690981021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDd0P6Z6Y37kRPaqqHaNAC3kQrjxk6Pu8HaK2zooeKg=;
        b=Sphcz5qq3+buhzDZsZI3W4+b4HigOS5WU6NMwnUZs/kQbxA9PrbT3K+5o0p+1ABhil
         HZO2QoS68J/YmOLK5ud3i4DoQp3AMTM6ENbWuC5bwUi/1iBU4Y7Thgw0OpAcSzia3XxW
         7ItXaRtwC4HMKc98rtOe9L0V9SB0/dx1QQxnKIUPI8IngESdeojydIjryy66+xXmuhzc
         ipRs+hTSO4xt7oghX+frCZ6A4RWNmu6JY+Hu8WATZZCJX9xr7YrtzPbTUOzLthmSKHpS
         ZCGbCIxrnPm7pyUceyeOfFItc/CioLz+WWoy7ghuQL0R8TiNKRjrg+yuNZ8zvmejwvLm
         Efow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389021; x=1690981021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDd0P6Z6Y37kRPaqqHaNAC3kQrjxk6Pu8HaK2zooeKg=;
        b=EFrj9eezLTgUv1gmw6ul6am2a+Tj5pqBMlHyV3JIzYa9aOL5nP01HQtvb4t+19aSgw
         DWRjWjwimjU3xqgpiANtTHl8qcLxf+5aY2EguupdSCGTeh9zT9xMwPKdPVJLNUkyICoF
         zjWQFzHPDsqxvBg6YuuFYGnB/9dU5K92IeuRfUCQf9WyMN3Ip/T8lG8nUdOLmHxAZ3mB
         4Xq431ppgEaymolYSJMb/ZjEkJLmFBLct68O16ssS4GpNAu1Om2jJQ0lVCIVBmPJhTPr
         iX+hirknx5is8fjMxCA1Aj4MCxhTz7wNLUTJF41L2/hCu3GA1ymfd3kG2VzFEcxaJv/0
         zIuA==
X-Gm-Message-State: AC+VfDzkU1PbxAgbNWBI3NDquT3gwLwmksshgBXSsQrjCTmIq64oOKEe
        BB/XZcRWXGPxWMo935Cg94lqTg==
X-Google-Smtp-Source: ACHHUZ6/fBeiAWwj87e60iBk0jsshSg/HXNuUNYk789KVMfnmQErAN4M02VvuTIO86TKRIqfowM8+g==
X-Received: by 2002:a05:600c:2049:b0:3f9:b31d:5689 with SMTP id p9-20020a05600c204900b003f9b31d5689mr7826755wmg.36.1688389021142;
        Mon, 03 Jul 2023 05:57:01 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bcbd4000000b003fb739d27aesm18799546wmi.35.2023.07.03.05.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:57:00 -0700 (PDT)
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
Subject: [PATCH v4 10/10] perf: tests: Adapt mmap-basic.c for riscv
Date:   Mon,  3 Jul 2023 14:46:47 +0200
Message-Id: <20230703124647.215952-11-alexghiti@rivosinc.com>
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

riscv now supports mmaping hardware counters to userspace so adapt the test
to run on this architecture.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/perf/tests/mmap-basic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index e68ca6229756..f5075ca774f8 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -284,7 +284,7 @@ static struct test_case tests__basic_mmap[] = {
 			 "permissions"),
 	TEST_CASE_REASON("User space counter reading of instructions",
 			 mmap_user_read_instr,
-#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || __riscv_xlen == 64
 			 "permissions"
 #else
 			 "unsupported"
@@ -292,7 +292,7 @@ static struct test_case tests__basic_mmap[] = {
 		),
 	TEST_CASE_REASON("User space counter reading of cycles",
 			 mmap_user_read_cycles,
-#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || __riscv_xlen == 64
 			 "permissions"
 #else
 			 "unsupported"
-- 
2.39.2

