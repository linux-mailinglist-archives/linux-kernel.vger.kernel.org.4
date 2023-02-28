Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5405A6A5CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjB1QOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1QOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:14:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CC62330E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:14:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ck15so42473020edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8tRS460nc4KIz6Gi8dIzh48uT/Gqvrt2n9DWhZ29rY=;
        b=IehjgpMbn3Eo6EKsrwBu/GL6F4CUPB9kww4ilDWDx4m4BtWjE74S+RumzMcpLSqTnp
         9bB+30LJDDS6o2IHlzAgYNlFgK7kxPN+BGnVW0Qhjwqz9501OoCyi22zBk4gSMfxAjhB
         H5RJlC98/rS/t7vyuKP6BT8UsRe+GDueaKJue8cWRBeZzdQbjGlomLR7LQclmlBEft6N
         YHhS8f+Ic7fY3hMeSTkgasGz6KgRQLIK89g1wWaFyBdq1lK1rajRIBQ5TczwRlcmDOoe
         QdLi2sbZE5wdCatI7nupb+nMGRlvx8xVVBGqsPN+VU0HOM964PhJGVDuLXQ4wPFywdZ9
         qnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8tRS460nc4KIz6Gi8dIzh48uT/Gqvrt2n9DWhZ29rY=;
        b=d3/yBJj7NPm2gfmm5feyBtIb4xG27gaRBzdtIG/2wpdcV7mmHwe1tGCA8X2Oud2j/j
         bbizvkrXi97KmcobcNcXyPpkv4UCOHNUuWnt42fh9O5uORC3q3Nh1aEIVQYLVyFYRZvj
         uD6Rx8X8cjCWs2IqDN8KFCGLWrrGtit/N/VqH5a/iFF7C69VeqCJN8TU27ysC2ilsPw4
         1SzlTSzqZ6Ksbh4fGzUa0uonj25/Ya2SYgTd07wCu0qUFi1m6tOlNd5NXwKr77gszlxa
         aFLPbiBYsh3DPqc3flFKypGTFunK33RDrL5NU/nq+J/NrQ0qPzU3r3UCNjHdOdZst0nI
         Ihag==
X-Gm-Message-State: AO0yUKXAvW+V+yiQE4y5PpRtxaeJHJAtMkBNIgQdXf71TgmHePNEj92Q
        W2EkokY3wSdQV1kXlp0JDu/BaLnjDAFXWkHA
X-Google-Smtp-Source: AK7set/uK6TxHaNRknwX1VSyDeTfQU+WOOuUwcbU1jti4MIbn43Z87o2cLpqpaTquIMFuQNbm0SaBg==
X-Received: by 2002:aa7:ca50:0:b0:4ae:eae1:21f8 with SMTP id j16-20020aa7ca50000000b004aeeae121f8mr4153879edt.29.1677600876852;
        Tue, 28 Feb 2023 08:14:36 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id p3-20020a50cd83000000b004acba0afaa3sm4483665edi.21.2023.02.28.08.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:14:36 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH] sched/core: Use do-while instead of for loop in set_nr_if_polling
Date:   Tue, 28 Feb 2023 17:14:26 +0100
Message-Id: <20230228161426.4508-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use equivalent do-while loop instead of infinite for loop.

There are no asm code changes.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
---
 kernel/sched/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index af017e038b48..349c018eaf09 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -899,14 +899,13 @@ static bool set_nr_if_polling(struct task_struct *p)
 	struct thread_info *ti = task_thread_info(p);
 	typeof(ti->flags) val = READ_ONCE(ti->flags);
 
-	for (;;) {
+	do {
 		if (!(val & _TIF_POLLING_NRFLAG))
 			return false;
 		if (val & _TIF_NEED_RESCHED)
 			return true;
-		if (try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED))
-			break;
-	}
+	} while (!try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED));
+
 	return true;
 }
 
-- 
2.39.2

