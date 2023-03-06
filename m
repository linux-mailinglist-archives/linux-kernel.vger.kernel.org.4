Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40ED6AC5D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCFPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCFPqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:46:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE5E36FC6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:45:59 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q16so9307302wrw.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 07:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20210112.gappssmtp.com; s=20210112; t=1678117557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FK3DmguboOukt1iHc1HrCdV38+6oWDtRK0mdWOzWsHs=;
        b=gQiPQhImmG1kml4a8V42voVxpGLISWqPfGjKkwT1jkfOdV997Hzq4+nVieoDu7lpg2
         8uBa1Rkh9Q0LxPe6ZeNQc2St2m2++nw3V3uvn7LSRNSCRTOpdT4FKW3VJc3tjTvBE5pl
         qsjyuUiOrZfDElyJ5bXp8E5JNpJdE3W2oDybTYvJwKcL0MKl9cdNffVla+eToOhOg9yr
         fbOzSXkwuzWcrGfAeh/uiDchIvFRbGRuezqc/plwhVrwKj6ILmOAFSjQV9pPE6s9z2Pd
         OthiSQY5QOaxsa5hKVXGH9Ck2Av8xpfVon2lFQxNb2M3XkzF7VIuKVMzWSCmLbeIqILj
         5g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678117557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FK3DmguboOukt1iHc1HrCdV38+6oWDtRK0mdWOzWsHs=;
        b=VVIWBBGjXtmoBtfwB4yvh3cSVtIQHkyjDCia5vDvW3yFnoCeW3NwbHkC5xziOQ3CA1
         MBItjIGM8LGoaw12zzRvXDT6nsnfZ6a3qFc9N0z9yQy2KFKOiTv+zeu23N4vB3Uik8WU
         HjM1WAYcIGTvdAEQkHbf20nz+ahWWow1fNS1Jbn34XAV2YpWtI51WoiOYWsXhD9TqY/K
         R0LJYGOoi8MaTVxzUwQLAEVkN5XPRvkKGg4r+n1baVHF6onpRbMFAQtI674Ov6yVFr4r
         LFgWsIk27tooYVQyk8hXOhWkEple0c1YHqOoTT5qiPghygwPPW8O1VhrC8Nzaf9YmRg5
         clwg==
X-Gm-Message-State: AO0yUKVhs68dgqz8sdnSZo04/NPG9ivqgLijiuDPu9MtJ57pkuqpCqE+
        skOUItCuo69H1lNI/8/7bviv8BbWPRIDJnFn0q5WAg==
X-Google-Smtp-Source: AK7set+lPZBOvn8geYrkNAOOJSOaf4Ds1lrLKCedCe85LYrB68Nr937COVLqlIYVtrFcHkBxXzsHMg==
X-Received: by 2002:a5d:4a51:0:b0:2ca:fd48:7c1e with SMTP id v17-20020a5d4a51000000b002cafd487c1emr7093099wrs.48.1678117557029;
        Mon, 06 Mar 2023 07:45:57 -0800 (PST)
Received: from ntb.petris.klfree.czf ([193.86.118.65])
        by smtp.googlemail.com with ESMTPSA id e15-20020a5d500f000000b002c561805a4csm10225692wrt.45.2023.03.06.07.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:45:56 -0800 (PST)
From:   Petr Malat <oss@malat.biz>
To:     linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org, tglx@linutronix.de, bigeasy@linutronix.de,
        nsaenzju@redhat.com, frederic@kernel.org,
        Petr Malat <oss@malat.biz>
Subject: [PATCH] softirq: Do not loop if running under a real-time task
Date:   Mon,  6 Mar 2023 16:45:48 +0100
Message-Id: <20230306154548.655799-1-oss@malat.biz>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Softirq processing can be a source of a scheduling jitter if it executes
in a real-time task as in that case need_resched() is false unless there
is another runnable task with a higher priority. This is especially bad
if the softirq processing runs in a migration thread, which has priority
99 and usually runs for a short time.

One option would be to not restart the softirq processing if there is
another runnable task to allow the high prio task to finish and yield the
CPU, the second one is to not restart if softirq executes in a real-time
task. Usually, real-time tasks don't want to be interrupted, so implement
the second option.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 kernel/softirq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c8a6913c067d..6a66d28bf020 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -478,7 +478,8 @@ asmlinkage __visible void do_softirq(void)
 
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
- * but break the loop if need_resched() is set or after 2 ms.
+ * but break the loop after 2 ms or if need_resched() is set or if we
+ * execute in a real-time task.
  * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
  * certain cases, such as stop_machine(), jiffies may cease to
  * increment and so we need the MAX_SOFTIRQ_RESTART limit as
@@ -589,6 +590,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	pending = local_softirq_pending();
 	if (pending) {
 		if (time_before(jiffies, end) && !need_resched() &&
+		    (current->prio >= MAX_RT_PRIO || current == __this_cpu_read(ksoftirqd)) &&
 		    --max_restart)
 			goto restart;
 
-- 
2.30.2

