Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6365E6A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiIVSCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiIVSBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B274852466
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663869671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QKj0XDJiFycujGKDCoaD+l0V6a5h4eQ/770vvHNlNfI=;
        b=RNIQDYL5ICACMvicIMnlZ5G11rcbQHE1YBAyx7j3tb8eIHH3+DSTaKRiaWqXfWhIt7tjT3
        2kkOWwHG98D8RU4XB/5y2obgBAajiV/rjARqBjN3cTUB1ij9WJ3XCU1DxYHccd3s5bwW9O
        RkWm4OAzYCsl4/GIHZXrpYHE+zUMEDI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-rsOsESkYNOWYBfJreKfKvg-1; Thu, 22 Sep 2022 14:01:09 -0400
X-MC-Unique: rsOsESkYNOWYBfJreKfKvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D3BF3C30508;
        Thu, 22 Sep 2022 18:01:08 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3482414152E8;
        Thu, 22 Sep 2022 18:01:05 +0000 (UTC)
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
Subject: [PATCH v10 0/5] sched: Persistent user requested affinity
Date:   Thu, 22 Sep 2022 14:00:36 -0400
Message-Id: <20220922180041.1768141-1-longman@redhat.com>
MIME-Version: 1.0
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

v10:
 - Squash patches 4, 5 & 6 together into a single patch as suggested
   by PeterZ.

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

Waiman Long (5):
  sched: Add __releases annotations to affine_move_task()
  sched: Use user_cpus_ptr for saving user provided cpumask in
    sched_setaffinity()
  sched: Enforce user requested affinity
  sched: Handle set_cpus_allowed_ptr(), sched_setaffinity() & other
    races
  sched: Always clear user_cpus_ptr in do_set_cpus_allowed()

 kernel/sched/core.c     | 231 +++++++++++++++++++++++++---------------
 kernel/sched/deadline.c |   7 +-
 kernel/sched/sched.h    |  22 +++-
 3 files changed, 169 insertions(+), 91 deletions(-)

-- 
2.31.1

