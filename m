Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D3F741C62
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjF1XXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjF1XXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:23:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BD7E9;
        Wed, 28 Jun 2023 16:23:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso67196b3a.3;
        Wed, 28 Jun 2023 16:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687994583; x=1690586583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krWbw+BRsQITYVufaotBbsHrMdJirArhgEro2wyvZZw=;
        b=VG4eVmV7X0PrRJabZhLepIPCn10VfwxhUFLDyxL3WER+FWdxOkKJRMDYIAmD3iGbsR
         QscJf+8wHR01e1gZ6/22E3mlRfbx+EoXKlwwYZA53BTmjGI635oCwfrf2mJ0TkS5odJ8
         rrdk4YAtvlhHZmKgIrfFphLaMnfPnjZBDVOPookObmHkpavbBB0O682UYDkUxfX9q9dT
         XmVPf3ggYRyNgNRQUm6rrzkNMRSB55/79APdTgVjYqjDsZ9o1n5ykhANX8A2xfDJRnEa
         3xxZ24Nnb1P76Grro/BrOm+iZfOs5J5Z+wovkAKeFs8no/nJgfwXQamh96ciBtCq12ei
         xgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687994583; x=1690586583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krWbw+BRsQITYVufaotBbsHrMdJirArhgEro2wyvZZw=;
        b=jdZVsJNs5rP7OJ2GE/KeM4rIHobrV4SvuRCAVRBkOuB+DEHFH7l9gnxM0ClVRfTWYp
         kGojHlCVuIH9cwnUbLpFUC6MnZhAT/O/3CaUz+gJb/pdd0e673xlsL2iLIWIXFmAebnJ
         gWV22T5I8vtg9KIk1G1YyNv6ZzjrfYLjaIkxy1S4sipgAk7Pg3o2Q4G25DdkGpcjrL0/
         8QUgnkVIQxGYVL39p31xzyfYtQwfZd6Tj4yn45JeViKBlxhGOwjhPzdLKuGTgRFTYVQT
         TZZmD29Kt2NcjlXW6oY3r7qPhQTXXfnOpbfvch0v9VSiFlB9PmQRk2xkPrBpJOp7DgR/
         74cw==
X-Gm-Message-State: AC+VfDz8mCgfmMYY/i1Q3nhUlwz8S5O0lojCQnA8ilhm/uXSRKD1uW19
        q/yTC4h6BZ2TEpf5+eQXxa4=
X-Google-Smtp-Source: ACHHUZ7tpawt47u9azMsFTmz1yUC6zRi1mISK+ZPaSdG3gpeOvA2QQqUeLQlHIVTmz1PQNyGQ4h8Eg==
X-Received: by 2002:a05:6a20:8405:b0:12c:d44b:349 with SMTP id c5-20020a056a20840500b0012cd44b0349mr63898pzd.38.1687994582808;
        Wed, 28 Jun 2023 16:23:02 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:6887:93d0:b9c9:df85])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001b3d4d74749sm8213267plq.7.2023.06.28.16.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 16:23:01 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] perf tools changes for v6.5
Date:   Wed, 28 Jun 2023 16:22:59 -0700
Message-ID: <20230628232259.2777226-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230628215954.1230048-1-namhyung@kernel.org>
References: <20230628215954.1230048-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I forgot to mention that it'd create a conflict with the tip tree because
it contains some perf user space changes.

Stephen Rothwell already resolved this like below in the -next tree.

  https://lore.kernel.org/r/CAM9d7ciqQSp3zWNeq-P0r8pGN=6jJBWyxK=LzUz2SYm_kAaG4g@mail.gmail.com

I'm copying it in just case.

Thanks,
Namhyung

---
commit de114f42b7c24d1e8373800e46c3a19b944e4665
Merge: f78f1f477e06 ad5f604e186a
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Wed Jun 28 09:54:39 2023 +1000

    Merge branch 'perf-tools-next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
    
    # Conflicts:
    #       tools/perf/arch/x86/include/arch-tests.h
    #       tools/perf/arch/x86/tests/arch-tests.c

diff --cc tools/perf/arch/x86/include/arch-tests.h
index 93d3b8877baa,df133020d582..2b0684132f06
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@@ -11,7 -13,7 +13,8 @@@ int test__intel_pt_pkt_decoder(struct t
  int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
  int test__bp_modify(struct test_suite *test, int subtest);
  int test__x86_sample_parsing(struct test_suite *test, int subtest);
+ int test__hybrid(struct test_suite *test, int subtest);
 +int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
  
  extern struct test_suite *arch_tests[];
  
diff --cc tools/perf/arch/x86/tests/Build
index fd02d8181718,394771c00dca..b87f46e5feea
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@@ -3,6 -3,9 +3,10 @@@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-un
  
  perf-y += arch-tests.o
  perf-y += sample-parsing.o
- perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-test.o
+ perf-y += hybrid.o
+ perf-$(CONFIG_AUXTRACE) += intel-pt-test.o
+ ifeq ($(CONFIG_EXTRA_TESTS),y)
+ perf-$(CONFIG_AUXTRACE) += insn-x86.o
+ endif
  perf-$(CONFIG_X86_64) += bp-modify.o
 +perf-y += amd-ibs-via-core-pmu.o
diff --cc tools/perf/arch/x86/tests/arch-tests.c
index b5c85ab8d92e,3f2b90c59f92..9808dc02fe79
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@@ -22,7 -24,15 +24,16 @@@ struct test_suite suite__intel_pt = 
  DEFINE_SUITE("x86 bp modify", bp_modify);
  #endif
  DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
+ static struct test_case hybrid_tests[] = {
+ 	TEST_CASE_REASON("x86 hybrid event parsing", hybrid, "not hybrid"),
+ 	{ .name = NULL, }
+ };
+ 
+ struct test_suite suite__hybrid = {
+ 	.desc = "x86 hybrid",
+ 	.test_cases = hybrid_tests,
+ };
 +DEFINE_SUITE("AMD IBS via core pmu", amd_ibs_via_core_pmu);
  
  struct test_suite *arch_tests[] = {
  #ifdef HAVE_DWARF_UNWIND_SUPPORT
@@@ -36,6 -48,6 +49,7 @@@
  	&suite__bp_modify,
  #endif
  	&suite__x86_sample_parsing,
+ 	&suite__hybrid,
 +	&suite__amd_ibs_via_core_pmu,
  	NULL,
  };
