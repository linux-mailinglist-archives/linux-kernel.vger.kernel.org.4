Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7967B5BB22B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIPSce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIPScc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B0B6D68
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663353150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=n5T5qp4eiaP5ejWPa9++racRV8XGlUqNAd/WXYfkzk4=;
        b=hlNzL1xs01sfM85wp5bbKFk5H4So+Dq+fHUF5k+dUWwZFQDSJ3Rn9ay1VxaLpAcMXxJSmi
        WPQ84X16vKjnuPTOGjhazOlSUQ5hS//hU4wBl6jEKBzoa4N3tg3fRprXhhcx5nJbjJnJRb
        5XZ1JXDdvqmxrtJliFDIHztnkzTwN34=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-vwScVDKNN2Cq5hhTJy18oA-1; Fri, 16 Sep 2022 14:32:27 -0400
X-MC-Unique: vwScVDKNN2Cq5hhTJy18oA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EE1029AB3EF;
        Fri, 16 Sep 2022 18:32:26 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79F11140EBF3;
        Fri, 16 Sep 2022 18:32:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 0/7] sched: Persistent user requested affinity
Date:   Fri, 16 Sep 2022 14:32:10 -0400
Message-Id: <20220916183217.1172225-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v9:
 - Fix non-SMP config build errors in patch 4 reported by kernel test
   robot.
 - Disable user_cpus_ptr masking also when any of the SCA_MIGRATE_*
   flags are set.

v8:
 - Add patches "sched: Introduce affinity_context structure" and
   "sched: Always clear user_cpus_ptr in do_set_cpus_allowed()" as
   suggested by PeterZ.
 - Better handle cpuset and sched_setaffinity() race in patch 5.

v7:
 - Make changes recommended by Peter such as making scratch_mask
   allocation earlier and using percpu variable to pass information.

v6:
 - Drop the cpuset patch and make user_cpus_ptr masking applicable to
   all callers of set_cpus_allowed_ptr().
 - Make user_cpus_ptr and cpus_mask update in a single lock critical
   section to avoid race problems.

The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
Introduce task_struct::user_cpus_ptr to track requested affinity")
which uses it narrowly to allow keeping cpus affinity intact with
asymmetric cpu setup.

This patchset extends user_cpus_ptr to store user requested cpus affinity
via the sched_setaffinity() API. With that information available, it will
enable cpuset and other callers of set_cpus_allowed_ptr() like hotplug
to keep cpus afinity as close to what the user wants as possible within
the cpu list constraint of the current cpuset. Otherwise some change
to the cpuset hierarchy or a hotplug event may reset the cpumask of
the tasks in the affected cpusets to the default cpuset value even if
those tasks have cpus affinity explicitly set by the users before.

It also means that once sched_setaffinity() is called successfully,
user_cpus_ptr will remain allocated until the task exits except in some
rare circumstances.

Waiman Long (7):
  sched: Add __releases annotations to affine_move_task()
  sched: Use user_cpus_ptr for saving user provided cpumask in
    sched_setaffinity()
  sched: Enforce user requested affinity
  sched: Introduce affinity_context structure
  sched: Handle set_cpus_allowed_ptr() & sched_setaffinity() race
  sched: Fix sched_setaffinity() and fork/clone() race
  sched: Always clear user_cpus_ptr in do_set_cpus_allowed()

 kernel/sched/core.c     | 231 +++++++++++++++++++++++++---------------
 kernel/sched/deadline.c |   7 +-
 kernel/sched/sched.h    |  22 +++-
 3 files changed, 169 insertions(+), 91 deletions(-)

-- 
2.31.1

