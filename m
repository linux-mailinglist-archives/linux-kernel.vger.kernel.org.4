Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77D6E1214
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDMQSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDMQSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:18:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0946759C5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:18:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o29so3688882wro.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681402711; x=1683994711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zC284Mx5M3d9WrVkxHAYpIwsSHj0B1udyIbm0+qXIw=;
        b=jnYAXcdc2F/ZUYjwGbFde5j1fnjVc7M0pT4u8eeWu2p7a9wNVttC/D6yh195iVKys4
         mxVhroni/klSct1CM/u8HtxLFdwyp8gxBeK52u97EoUsZcYEPG2gbhqDiF3zDqXCerCB
         NiYRItU+QsjrhYXfzgriIL7Bq8c+QDOLPiydToeJ3LjmuvIfa/zHFQnEagnw96dZk03u
         pd3KVMh0PwwJ+kCSQtIFpnMRaviqT8YGPxin0RGwxSiSveSxjexCjxUGU1uXkFwYZmqb
         xTjttfIuMCcu+Ru3hr7RR5/IDoy+4Vxv8/vqM7xpir2d0R6HwPiK+R5voQ85on0tT3/z
         t3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681402711; x=1683994711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zC284Mx5M3d9WrVkxHAYpIwsSHj0B1udyIbm0+qXIw=;
        b=iLzUzIJM3o78p01/KW61TCKmxrwF5lmrbVxnFeYJypEoo16uXGHMdm1MVILFWa7LRR
         d34nm7oTNVbEuipWDYdb1YVO1kPPYI6WAu4D4M79JmOPbRlclDBx65qh/N+2PcX5rUZM
         0VEMDv12c67x/+5SH/PQgzXDO5frKJyw32FcjqNi0rRJQ7Rdza5nMcWKssPu9Ve1yxUc
         ttxZLkklUAxA8pF0Z6D/mhUFuuNfkWNOCeAeBU+8oCP4Obf2gLqhlhw8F9LpYcNcatQ2
         PT5GfEHbPpQoFvOGJrh2XlpJFqHARNmettyjijYbz17D5p0LFpSCWSkmESFcslWmt51J
         XhxA==
X-Gm-Message-State: AAQBX9f4E5SWTWoV8bD0Jdq8oeUCsM9i4KVnUDGyAItO4pn1+dIrUTuK
        e7P93YgMa3SesjrQRy8WkFF3Jw==
X-Google-Smtp-Source: AKy350Z58ybJnlDv5ztRusjd7HwtKvOy6HCP/IazeXuo09NcPyvJkiRUBITxW1O8s8n9bpTCu5u2/Q==
X-Received: by 2002:adf:e352:0:b0:2ef:b1bd:786 with SMTP id n18-20020adfe352000000b002efb1bd0786mr1600755wrj.13.1681402711478;
        Thu, 13 Apr 2023 09:18:31 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d4911000000b002e55cc69169sm1598882wrq.38.2023.04.13.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 09:18:31 -0700 (PDT)
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
Subject: [PATCH 1/4] perf: Fix wrong comment about default event_idx
Date:   Thu, 13 Apr 2023 18:17:22 +0200
Message-Id: <20230413161725.195417-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230413161725.195417-1-alexghiti@rivosinc.com>
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

