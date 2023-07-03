Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF4A745C85
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGCMs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjGCMsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:48:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C8CA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:48:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so42289425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688388531; x=1690980531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFKT0CCXN0CmmHE2x8MUQw5sccSB1SdakxOhkM1UsG4=;
        b=i16J4ni9PRmgjYqxfrE1XbOUgfjftUIExJgrCxjMKUpNa0UHu4g4yT+G0k47/9OXnB
         1QZB5ciPxLMxQpV9Unfp9f38KrhcDrdpy19aiupbprTf6ktj0XEUYYpWnKBXfnS7wGnK
         1jnDUxYGgsa6sX3GiT/5N6zso6Tc56ROXb4EybFyia6SKn0G4VbXTyoksin6FNg45DCn
         F/LPCUrj8h4B5eRcFhh1e5sEkDM8anr5dq+g86J0nGpmQUjeO0YiV3ZN8NGYAaRQfSV3
         PvNJk0trAcDdP1lOMdY1spR+0ZPZsTIr6rZhwBUjfQWCajqHVMWOW8LuUebj+kMlwQBo
         UCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388531; x=1690980531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFKT0CCXN0CmmHE2x8MUQw5sccSB1SdakxOhkM1UsG4=;
        b=gsHVpqYy3elWiSLsN4PCyTckP8eg2ja7cp0iikN4ILttWQAELu0MhKBWFnuNhwD7Rp
         AkKnRHK4dmaeGSXo97W2xdSSqe+/EtrPyZlR5NtLVfVL7ByejJtuErRhZRSC4z5yM1EN
         L63VrVXyJRE/FnGjZVlr0aXmrfw9QY3o6fj5AjpW0bfFIWxVTWhpGeEN6qPPOS8ROQfa
         +cWFpykeP6ePoSmilGDY1InbKzbi3iC2lCVqAxUvt4FJtERgl9U9mFPrvyMWFAarNbDA
         d7FFXL7NcaE71oInzbQO1OTtaBaq6H3HFT7vr8KpS/ZYGoMFjdt0qgGaMxvU9v+GIqs5
         fguQ==
X-Gm-Message-State: AC+VfDzO1Rhlbf1JMPSt6tgMSg0NL50NAxoCDWJCGKRJPNjBYo+StBWC
        d8wGXVbcc9np0FnhbLouGWv4CQ==
X-Google-Smtp-Source: ACHHUZ5hXaX0d50B/MxYY7zmUATcMLkAUWf08O2mNTD1GDuz0rdbpLxwVWR6/kUM2N1nPey6Tok//g==
X-Received: by 2002:a7b:ce0a:0:b0:3fb:b1fd:4172 with SMTP id m10-20020a7bce0a000000b003fbb1fd4172mr7691263wmc.22.1688388531708;
        Mon, 03 Jul 2023 05:48:51 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c211400b003fbb618f7adsm12744165wml.15.2023.07.03.05.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:48:51 -0700 (PDT)
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
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 02/10] include: riscv: Fix wrong include guard in riscv_pmu.h
Date:   Mon,  3 Jul 2023 14:46:39 +0200
Message-Id: <20230703124647.215952-3-alexghiti@rivosinc.com>
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

The current include guard prevents the inclusion of asm/perf_event.h
which uses the same include guard: fix the one in riscv_pmu.h so that it
matches the file name.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
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
2.39.2

