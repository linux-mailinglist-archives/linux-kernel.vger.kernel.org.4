Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BD16AFB1D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCHAac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCHAa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:30:28 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD72EA72A9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:30:26 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id iw4-20020a170903044400b0019ccafc1fbeso8458117plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 16:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678235426;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SWmklWyVCwxXFF6wO6v9mDT+U/6Przz0XnTBbNzMl+M=;
        b=nEPr6VECvGe6NhTwzmP8wSYxHm/jEvwAdt6Nf1V10+vi5IktT6GFHvL8rBdGLMnVtH
         9lA2h/IYUoP3jBX6WWElTHI28Ll7lRZpsuo/iN+946s3pGgW8IH5X0WzAmyLsaeYeFjD
         JCMpdubtNGDzR7yfOd+tLfjak8QNM3m1nluDeA/Brik+UdUV9BeeuGYos6isWHWX8I87
         GpRsHlkDi92tuWY/LiBIZpdf4kHZqGw34elLw5/0XQ0iLfRINdoTLZ8HM/gsQsvh0mYA
         eNiKnTlXCP+v2Vt5cYtPZgdfKABpjBrhH0f8n/Spi/spBYNhIGzyFRwfDz2CMqEC9vh6
         4wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235426;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWmklWyVCwxXFF6wO6v9mDT+U/6Przz0XnTBbNzMl+M=;
        b=J1oEG6f6fBgKkTWgYwb1sjGNyMZ9e92hpDPGppSOu+A6xapDqFRVDkXN+ggbRawNur
         nx4hQAEdNPo6WnjC6zW01JLk8F50TkaR/GTd+kqUyjZ0nCn+ZaTZmGqUem+sd85lxkGV
         LE4m4/o/TFrWRanWTKhZfoE+VsVlX8E5be0dNz21h5Qde2fjbg967ClQ4etiHTCkGXK4
         Gr38ptYEmYX8Yz2WlhOIfs9MsTuWYw7rVF/B+yY2BN1X5rrwplH/iJUknZSVQ6D/d5zW
         8QKN+WnutS1fnSL/W31D28B1ebrgh8ZpraboDxPHIWKMAmX2NEBvD4xpvHjwrQ1IZXC6
         KpXw==
X-Gm-Message-State: AO0yUKV5qKt2DQubyWDcp84aj0xZP6kyXKnIf08lR4Ujp3sFw5bfrB7q
        K+qqA5EOX+C3OtRvqxJEKXDR+uwNSxL4
X-Google-Smtp-Source: AK7set/1oCu95AivzYKa9M4rxRkuUVpCxglBFgFEVUNGKBoNg8a61V4ubQnwxHaL2KN3ig51ffUXkYCuLGTn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a17:90b:3594:b0:234:bcb5:2a5f with SMTP id
 mm20-20020a17090b359400b00234bcb52a5fmr6097010pjb.5.1678235426354; Tue, 07
 Mar 2023 16:30:26 -0800 (PST)
Date:   Tue,  7 Mar 2023 16:30:20 -0800
Message-Id: <20230308003020.3653271-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2] perf lock contention: Fix builtin detection
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__has_builtin was passed the macro rather than the actual builtin
feature. The builtin test isn't sufficient and a clang version test
also needs to be performed.

Fixes: 1bece1351c65 ("perf lock contention: Support old rw_semaphore type")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index e6007eaeda1a..141b36d13b19 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -182,7 +182,13 @@ static inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
 		struct mutex *mutex = (void *)lock;
 		owner = BPF_CORE_READ(mutex, owner.counter);
 	} else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
-#if __has_builtin(bpf_core_type_matches)
+	/*
+	 * Support for the BPF_TYPE_MATCHES argument to the
+	 * __builtin_preserve_type_info builtin was added at some point during
+	 * development of clang 15 and it's what is needed for
+	 * bpf_core_type_matches.
+	 */
+#if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
 		if (bpf_core_type_matches(struct rw_semaphore___old)) {
 			struct rw_semaphore___old *rwsem = (void *)lock;
 			owner = (unsigned long)BPF_CORE_READ(rwsem, owner);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

