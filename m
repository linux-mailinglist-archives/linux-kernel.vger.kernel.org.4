Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5826267580E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjATPEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjATPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF84B2E66
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674227028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lda/+ml5+8vWZrx9vfKLtfMa+7nWIziVhjlRSwPRz3M=;
        b=dLYPoSVO6rnvIsMAH9X9Bq66MUJXwYdu+oCku7s5I8eIjgZqlH2i4Qk4sN/zS26eSKFlmp
        VPRd5N6jYbfUGIPrHsmSYUdiM8xU8u4wVhvQLYcUCkc8aI5KRqechgR1B0VeSA/WXxylEf
        q9+3J5No++34u6JmW4kGpCeojZBK6fI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-bhRqpXYPNP-zoGd957nf9Q-1; Fri, 20 Jan 2023 10:03:43 -0500
X-MC-Unique: bhRqpXYPNP-zoGd957nf9Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43D06800DB5;
        Fri, 20 Jan 2023 15:03:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7F02492B02;
        Fri, 20 Jan 2023 15:03:37 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stafford Horne <shorne@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/4] sched/core: use put_task_struct_atomic_safe() to avoid potential splat
Date:   Fri, 20 Jan 2023 12:02:42 -0300
Message-Id: <20230120150246.20797-5-wander@redhat.com>
In-Reply-To: <20230120150246.20797-1-wander@redhat.com>
References: <20230120150246.20797-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

push_cpu_stop() is called form a context in which it must not sleep.
Since push_cpu_stop() calls put_task_struct(), it potentially can sleep
under PREEMPT_RT if the usage count reaches zero.

Use put_task_struct_atomic_safe(0 instead to avoid this potential splat.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c437260e19b0..e5d0c66cb90c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2565,7 +2565,7 @@ int push_cpu_stop(void *arg)
 	raw_spin_rq_unlock(rq);
 	raw_spin_unlock_irq(&p->pi_lock);
 
-	put_task_struct(p);
+	put_task_struct_atomic_safe(p);
 	return 0;
 }
 
-- 
2.39.0

