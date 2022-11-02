Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0389061574A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKBCEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKBCEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3CE5FFE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667354620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gev6P7R24DpRq36R8wXz2kmWLBFI3J+84j/AqTpnyIw=;
        b=MOfBEerS645VWd2Qb57pO0cwOt987+X4dKwuWwO6qyXAW8y3ldOzlJN3azWUAB26wa71/W
        GeBhquCw4zdKKYaVdGVcUiH8UmwdAYhui2vnQ2IB3KkxT74ITXMM4tFW/Md5L6/7oI43i7
        +VjjZ5zjQoDzjNkGiWeNLdZ3NHblI0M=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-17-CPM4xjpvOa2ACdhgQh_huQ-1; Tue, 01 Nov 2022 22:03:39 -0400
X-MC-Unique: CPM4xjpvOa2ACdhgQh_huQ-1
Received: by mail-oi1-f198.google.com with SMTP id z203-20020aca33d4000000b0035a0c54ff88so3397296oiz.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 19:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gev6P7R24DpRq36R8wXz2kmWLBFI3J+84j/AqTpnyIw=;
        b=3oMPtiSkbt4PDQlpzSs/gBb+5WRqSrmlmSMGB72U1YTje9w2awUoIRMrocx/1xhNsA
         zsSc3f+g8Ely84El3zuTpn7+QWj4x7CtEEjjFaLZM+QJPi606sMeB190zZ5dAWiF12oK
         3cuAV8Ugoa9aWZk3lu4o45qFsCnmoCI34gcNN2TqrI7wUnbQqpuVKWDC+6zRccEDA6im
         b1CDTfrA1xLyRa95IHxMx5jNZBeQ5dqCRcvGYFkdEUUIb8maBDN0wVQhoJcW5X5Pe+0Z
         jE4ZU8P8CcvgZbv5e3foMV2TBMJnJ+j/Pk6U+59Bgw3+3mHzGIA10ZaZ9EPdIVUoOewI
         iukw==
X-Gm-Message-State: ACrzQf2iz1XqJo+lhTCFhEip5hqbg72dTfMTjkNl2EVeNjceDgvc0n5I
        SR4zSrtgKHvt8r4k60xqCK2lKGeY2wqFMMDjrnVbPqllYLyr+kHzNXNA+uOwejVZB8K+LoBvwDl
        2MkWfnyueDsyU1LoA6X5k8dsp
X-Received: by 2002:a05:6830:3704:b0:660:fe76:3cb7 with SMTP id bl4-20020a056830370400b00660fe763cb7mr10900890otb.21.1667354618882;
        Tue, 01 Nov 2022 19:03:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7DG+li/A7VpDvIKqUuzfPg7gI21EhhlFF8vXWlawemkea0Kk/ubRWrfCId3EkcApts7tUZ1g==
X-Received: by 2002:a05:6830:3704:b0:660:fe76:3cb7 with SMTP id bl4-20020a056830370400b00660fe763cb7mr10900864otb.21.1667354618638;
        Tue, 01 Nov 2022 19:03:38 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a802:1099:7cb2:3a49:6197:5307])
        by smtp.gmail.com with ESMTPSA id h15-20020a9d6f8f000000b00665919f7823sm4526624otq.8.2022.11.01.19.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:03:38 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 0/3] Avoid scheduling cache draining to isolated cpus
Date:   Tue,  1 Nov 2022 23:02:40 -0300
Message-Id: <20221102020243.522358-1-leobras@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #1 expands housekeepíng_any_cpu() so we can find housekeeping cpus
closer (NUMA) to any desired CPU, instead of only the current CPU.

### Performance argument that motivated the change:
There could be an argument of why would that be needed, since the current
CPU is probably acessing the current cacheline, and so having a CPU closer
to the current one is always the best choice since the cache invalidation
will take less time. OTOH, there could be cases like this which uses
perCPU variables, and we can have up to 3 different CPUs touching the
cacheline:

C1 - Isolated CPU: The perCPU data 'belongs' to this one
C2 - Scheduling CPU: Schedule some work to be done elsewhere, current cpu
C3 - Housekeeping CPU: This one will do the work

Most of the times the cacheline is touched, it should be by C1. Some times
a C2 will schedule work to run on C3, since C1 is isolated.

If C1 and C2 are in different NUMA nodes, we could have C3 either in
C2 NUMA node (housekeeping_any_cpu()) or in C1 NUMA node 
(housekeeping_any_cpu_from(C1). 

If C3 is in C2 NUMA node, there will be a faster invalidation when C3
tries to get cacheline exclusivity, and then a slower invalidation when
this happens in C1, when it's working in its data.

If C3 is in C1 NUMA node, there will be a slower invalidation when C3
tries to get cacheline exclusivity, and then a faster invalidation when
this happens in C1.

The thing is: it should be better to wait less when doing kernel work
on an isolated CPU, even at the cost of some housekeeping CPU waiting
a few more cycles.
###

Patch #2 changes the locking strategy of memcg_stock_pcp->stock_lock from
local_lock to spinlocks, so it can be later used to do remote percpu
cache draining on patch #3. Most performance concerns should be pointed
in the commit log.

Patch #3 implements the remote per-CPU cache drain, making use of both 
patches #2 and #3. Performance-wise, in non-isolated scenarios, it should
introduce an extra function call and a single test to check if the CPU is
isolated. 

On scenarios with isolation enabled on boot, it will also introduce an
extra test to check in the cpumask if the CPU is isolated. If it is,
there will also be an extra read of the cpumask to look for a
housekeeping CPU.

Please, provide any feedback on that!
Thanks a lot for reading!

Leonardo Bras (3):
  sched/isolation: Add housekeepíng_any_cpu_from()
  mm/memcontrol: Change stock_lock type from local_lock_t to spinlock_t
  mm/memcontrol: Add drain_remote_stock(), avoid drain_stock on isolated
    cpus

 include/linux/sched/isolation.h | 11 +++--
 kernel/sched/isolation.c        |  8 ++--
 mm/memcontrol.c                 | 83 ++++++++++++++++++++++-----------
 3 files changed, 69 insertions(+), 33 deletions(-)

-- 
2.38.1

