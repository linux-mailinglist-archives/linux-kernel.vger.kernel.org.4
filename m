Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C28700306
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbjELIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240139AbjELIzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:55:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7456E10E63
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:54:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso44473485e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683881694; x=1686473694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zC284Mx5M3d9WrVkxHAYpIwsSHj0B1udyIbm0+qXIw=;
        b=z44JIICsJ3FFmRv9/ChN1HSVSRV0MHsv5RbNUZGm/8+AuijyMI+HMBrhW1eDSp5v3b
         w0iMXFR0+HVV5NUmF191qH+N7+qxBY8TwTuOFXtbvH4n/3HY8EFgR3GYOZ7/nwLNSQ7C
         vCEkxCdwycPnXu67Oiw8yp09FtNQPxCo64ra48yGlduNuWNHR5VmHRSlQe8yNfTolfZi
         U9dYgsOwEsY0FzsHPjAAlCnfRLU7a0KLp9KO5DF4Mr34hM/azMOwBKS3r5newR9Ov8/y
         cTpW1quhiIeXGRQgbI8Aj3XZTkjzfQy1euYvkbBMoyXm6I8nIjNICS1bgMNlOuZ38Xgy
         ceqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683881694; x=1686473694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zC284Mx5M3d9WrVkxHAYpIwsSHj0B1udyIbm0+qXIw=;
        b=OV0Hu4FQji/9zVYCu9PZy5zhbhSuGxonVvT9hO4JB1gGCSLk9RqltxpbBJZBkbqPZ6
         X7gBQXVuJ8C2JeBxNPhHOUfLgyo8hsYGnzDKz539jgmZ2m1bStMZNhXw0RT5wdm8q5lh
         /oqBilssWcwv0vHP85VOA/3xnhJBrv7FeTLOHIQA4m+XA5zs7fB7DpMXQHXibD8aD5e7
         0ujerIiLhDNrB2EepSjE4Q6goI63NpsCcJ9tVgLLLs5M1XV7WFqeASmVSRVrP47bKESP
         xc/AgeapLbGazxL4MXIaCj/rJnrIcLCsswgprX5WnnWYmVS144hr9TKdNsWOV56OIoF3
         pAng==
X-Gm-Message-State: AC+VfDyh9Zpqzb1nIqD9LjgGtRggSg8d/l7CKeo1zJiVs2WjttYDtkX1
        OZXGU9lNUnAhNm47Gy9jXW34mw==
X-Google-Smtp-Source: ACHHUZ7yTqFGJSEOt4qvmG1LunFjlDzDAQO5Tm0YmvPi5fam/8fYjVc3Q48PRj/C9ibBB+6HaVTApQ==
X-Received: by 2002:a7b:c419:0:b0:3f4:a09f:1877 with SMTP id k25-20020a7bc419000000b003f4a09f1877mr5918180wmi.23.1683881693890;
        Fri, 12 May 2023 01:54:53 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id y25-20020a05600c365900b003f42456c490sm15098356wmq.33.2023.05.12.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:54:53 -0700 (PDT)
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
Subject: [PATCH v2 01/10] perf: Fix wrong comment about default event_idx
Date:   Fri, 12 May 2023 10:53:12 +0200
Message-Id: <20230512085321.13259-2-alexghiti@rivosinc.com>
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

event_idx default implementation returns 0, not idx + 1.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 include/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..56fe43b20966 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -442,7 +442,8 @@ struct pmu {
 
 	/*
 	 * Will return the value for perf_event_mmap_page::index for this event,
-	 * if no implementation is provided it will default to: event->hw.idx + 1.
+	 * if no implementation is provided it will default to 0 (see
+	 * perf_event_idx_default).
 	 */
 	int (*event_idx)		(struct perf_event *event); /*optional */
 
-- 
2.37.2

