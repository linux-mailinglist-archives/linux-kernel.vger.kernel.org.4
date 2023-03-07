Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B269C6AD59D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCGDVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCGDVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:21:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D0A2BEE7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 19:21:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i11-20020a256d0b000000b0086349255277so12764549ybc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 19:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678159289;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4V7qYWhF33WfuebsbvBQGuVFdWrj0NpdHzfUvHWbnC8=;
        b=T6aJICY3NlE5u1vNf9OmUu/eQQfbV1GOJRNrimXa/y/VrCdgNdOV7kGTIj3rJyf4wa
         aqwHTM01jEscUPE0aEfwaQeY7t7uOeWnYctZUoykgy3b/+ezfZnYP/dibefqCpC8upTn
         ojKMH5WPYxFHPy+ps/fY/KIMAmJueL/XJO2AVHpeeRyo+9BLATfCDjkoxAhaH38hFolS
         KB15K1yev8xl8ggZq9RJzJp7l431FszYjyPjR4iCTFLUWp06RhKgWW2QF6ViLTB6UYti
         25dfkSOrJjRW17VdryAboCaHdNloYycIqLVfz7XIBhCBHvHHroIen3Y0R0JTpZwvBdJG
         1b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678159289;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4V7qYWhF33WfuebsbvBQGuVFdWrj0NpdHzfUvHWbnC8=;
        b=y49iJNxiAOcC/cLhgQAJcooaXOdhOVvM/8ET1LdALQGmI5WmKd74JCHmuXmK19WQ3C
         tDhibbFbritsPD4lvrixgQAGAucYWMgWf3MU0FfptOiZZJPtMYQxgw1i+nzhF4jBj/dx
         osiWdGmo+WU2BmWvS9Od1qlS6ZlNJjkdBd8UEgkoT++JzcACT6kfIIevM8CVXrPvIIcB
         Hu6Nwkm+eZg6d5v8/lYcJEiHELEsQhV6GAyBcPnx2JVBgsDSOOBcawRZfcaSQYCRvdHj
         j4PIuYge575tyCPK7IFBYYQPZtC/w3WDYIFkYzSR+G9RrQbZIFJkLsxV3Y3vqj6j24hL
         UCQg==
X-Gm-Message-State: AO0yUKXoKOsdr6NJ1DhNlWd3QvxwuxgvtcuZrUxpYZBsh6BBWlU6Hveo
        lFduHSBFhKy64+MSAkJEigaaP3V7BtHP
X-Google-Smtp-Source: AK7set/GvSG52lshrWljOTP0+TlFYk0pdSie2CoXb1dha9MKGJX2b0KrwFUW5yKqo7j0oALBm3rVqp9b7WJc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1c60:6b8e:dccc:a3b1])
 (user=irogers job=sendgmr) by 2002:a81:4005:0:b0:532:e887:2c23 with SMTP id
 l5-20020a814005000000b00532e8872c23mr8552310ywn.9.1678159288922; Mon, 06 Mar
 2023 19:21:28 -0800 (PST)
Date:   Mon,  6 Mar 2023 19:21:17 -0800
Message-Id: <20230307032117.3461008-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH] perf lock contention: Fix builtin detection
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
feature.

Fixes: 1bece1351c65 ("perf lock contention: Support old rw_semaphore type")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index e6007eaeda1a..e422eee0f942 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -182,7 +182,7 @@ static inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
 		struct mutex *mutex = (void *)lock;
 		owner = BPF_CORE_READ(mutex, owner.counter);
 	} else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
-#if __has_builtin(bpf_core_type_matches)
+#if __has_builtin(__builtin_preserve_type_info)
 		if (bpf_core_type_matches(struct rw_semaphore___old)) {
 			struct rw_semaphore___old *rwsem = (void *)lock;
 			owner = (unsigned long)BPF_CORE_READ(rwsem, owner);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

