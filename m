Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AE0708CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjESATG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjESASk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6B31735
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaea43def7so19741075ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455484; x=1687047484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aRD0uHMN5cuSsBQXhyFHHuk25uP1lpS3hnLUdCcdjw=;
        b=K3JWZMj6Oyd82tH0kb4x5BmwKNW4MaWVQx7uB4Q8Al43umNTMrrQISNjn23mVZnuNo
         y9TbIFvMXS65F00kjGUikKqn/PpHgH/rbPs4OZTKFLrmqQ00R0XVr2iDFKxSzZAZxPWd
         qbH3I14wn4tVn9ewb9aFGhEHvvC4Qd0CHiTQ1G+ieTSSqBHDmwJPkQSgEYsStDHeB/SM
         CmQRY9xKRlbTK6lCt9RCDrosb9uE42UwoNrDXFiZGsC3eNyWEzNLj0n2iZsRZm9o7Bhn
         L2tmba9nI2U356/Q3Y8MPDKlpk4c5aTcCYd5/ENM8W0j92MAOs99x+chVl8JICLFXeML
         CSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455484; x=1687047484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5aRD0uHMN5cuSsBQXhyFHHuk25uP1lpS3hnLUdCcdjw=;
        b=iSEmp6NyEtY1iQlYOOqW5iQt25aPcJNi7xDR5YrMCQjB4dulbabQHD7ZXMlbjwZLDc
         1RLcIDPVjn0tS+wReozYTFOg9/VIncRyXO3LNfN6/N3sIlXJZlG53JYn4cFCtoWNI7+H
         WlcdZItiIfM+Ih+AOfPnuh2f9t4G0vnQvvVnnyvK5eky0r1NtYlHrXEdpziKQ9S0A3yx
         bwSq0OOhfHqqDhBFg/sLacaKpaslDeq+9ujW4cs5V1WYF1Pkksq0yhiYEaI9/wasSIOu
         +akKYAoMJM55QvbPwVFcHZ0KHPD3tA/QCmQfWmh1cvJGeJd+2AkzFDP+GCmYBaBCdwxF
         IPvw==
X-Gm-Message-State: AC+VfDzTVeQ4kSmWO3MLIml0R+kU/xD7ZLx5XdGpBsW22he6BEuy/Zf3
        3k+PNj4aI8UCjU44tnRoQ1Y=
X-Google-Smtp-Source: ACHHUZ5c/AXLTq1fYTpLeA0RP+Sx78pDS3cxh9wtlh7dWih6XARaIVPvicP8aLCNNa33xCzdjOzyJw==
X-Received: by 2002:a17:902:c944:b0:1a6:46f2:4365 with SMTP id i4-20020a170902c94400b001a646f24365mr1073430pla.30.1684455484325;
        Thu, 18 May 2023 17:18:04 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p19-20020a170902b09300b001ae44cd96besm2027265plr.135.2023.05.18.17.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 15/24] workqueue: Add tools/workqueue/wq_dump.py which prints out workqueue configuration
Date:   Thu, 18 May 2023 14:17:00 -1000
Message-Id: <20230519001709.2563-16-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
References: <20230519001709.2563-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lack of visibility has always been a pain point for workqueues. While the
recently added wq_monitor.py improved the situation, it's still difficult to
understand what worker pools are active in the system, how workqueues map to
them and why. The lack of visibility into how workqueues are configured is
going to become more noticeable as workqueue improves locality awareness and
provides more mechanisms to customize locality related behaviors.

Now that the basic framework for more flexible locality support is in place,
this is a good time to improve the situation. This patch adds
tools/workqueues/wq_dump.py which prints out the topology configuration,
worker pools and how workqueues are mapped to pools. Read the command's help
message for more details.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/core-api/workqueue.rst |  59 ++++++++++
 tools/workqueue/wq_dump.py           | 166 +++++++++++++++++++++++++++
 2 files changed, 225 insertions(+)
 create mode 100644 tools/workqueue/wq_dump.py

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 8e541c5d8fa9..c9e46acd339b 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -347,6 +347,65 @@ Guidelines
   level of locality in wq operations and work item execution.
 
 
+Examining Configuration
+=======================
+
+Use tools/workqueue/wq_dump.py to examine unbound CPU affinity
+configuration, worker pools and how workqueues map to the pools: ::
+
+  $ tools/workqueue/wq_dump.py
+  Affinity Scopes
+  ===============
+  wq_unbound_cpumask=0000000f
+
+  NUMA
+    nr_pods  2
+    pod_cpus [0]=00000003 [1]=0000000c
+    pod_node [0]=0 [1]=1
+    cpu_pod  [0]=0 [1]=0 [2]=1 [3]=1
+
+  SYSTEM
+    nr_pods  1
+    pod_cpus [0]=0000000f
+    pod_node [0]=-1
+    cpu_pod  [0]=0 [1]=0 [2]=0 [3]=0
+
+  Worker Pools
+  ============
+  pool[00] ref= 1 nice=  0 idle/workers=  4/  4 cpu=  0
+  pool[01] ref= 1 nice=-20 idle/workers=  2/  2 cpu=  0
+  pool[02] ref= 1 nice=  0 idle/workers=  4/  4 cpu=  1
+  pool[03] ref= 1 nice=-20 idle/workers=  2/  2 cpu=  1
+  pool[04] ref= 1 nice=  0 idle/workers=  4/  4 cpu=  2
+  pool[05] ref= 1 nice=-20 idle/workers=  2/  2 cpu=  2
+  pool[06] ref= 1 nice=  0 idle/workers=  3/  3 cpu=  3
+  pool[07] ref= 1 nice=-20 idle/workers=  2/  2 cpu=  3
+  pool[08] ref=42 nice=  0 idle/workers=  6/  6 cpus=0000000f
+  pool[09] ref=28 nice=  0 idle/workers=  3/  3 cpus=00000003
+  pool[10] ref=28 nice=  0 idle/workers= 17/ 17 cpus=0000000c
+  pool[11] ref= 1 nice=-20 idle/workers=  1/  1 cpus=0000000f
+  pool[12] ref= 2 nice=-20 idle/workers=  1/  1 cpus=00000003
+  pool[13] ref= 2 nice=-20 idle/workers=  1/  1 cpus=0000000c
+
+  Workqueue CPU -> pool
+  =====================
+  [    workqueue \ CPU              0  1  2  3 dfl]
+  events                   percpu   0  2  4  6
+  events_highpri           percpu   1  3  5  7
+  events_long              percpu   0  2  4  6
+  events_unbound           unbound  9  9 10 10  8
+  events_freezable         percpu   0  2  4  6
+  events_power_efficient   percpu   0  2  4  6
+  events_freezable_power_  percpu   0  2  4  6
+  rcu_gp                   percpu   0  2  4  6
+  rcu_par_gp               percpu   0  2  4  6
+  slub_flushwq             percpu   0  2  4  6
+  netns                    ordered  8  8  8  8  8
+  ...
+
+See the command's help message for more info.
+
+
 Monitoring
 ==========
 
diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
new file mode 100644
index 000000000000..ddd0bb4395ea
--- /dev/null
+++ b/tools/workqueue/wq_dump.py
@@ -0,0 +1,166 @@
+#!/usr/bin/env drgn
+#
+# Copyright (C) 2023 Tejun Heo <tj@kernel.org>
+# Copyright (C) 2023 Meta Platforms, Inc. and affiliates.
+
+desc = """
+This is a drgn script to show the current workqueue configuration. For more
+info on drgn, visit https://github.com/osandov/drgn.
+
+Affinity Scopes
+===============
+
+Shows the CPUs that can be used for unbound workqueues and how they will be
+grouped by each available affinity type. For each type:
+
+  nr_pods   number of CPU pods in the affinity type
+  pod_cpus  CPUs in each pod
+  pod_node  NUMA node for memory allocation for each pod
+  cpu_pod   pod that each CPU is associated to
+
+Worker Pools
+============
+
+Lists all worker pools indexed by their ID. For each pool:
+
+  ref       number of pool_workqueue's associated with this pool
+  nice      nice value of the worker threads in the pool
+  idle      number of idle workers
+  workers   number of all workers
+  cpu       CPU the pool is associated with (per-cpu pool)
+  cpus      CPUs the workers in the pool can run on (unbound pool)
+
+Workqueue CPU -> pool
+=====================
+
+Lists all workqueues along with their type and worker pool association. For
+each workqueue:
+
+  NAME TYPE POOL_ID...
+
+  NAME      name of the workqueue
+  TYPE      percpu, unbound or ordered
+  POOL_ID   worker pool ID associated with each possible CPU
+"""
+
+import sys
+
+import drgn
+from drgn.helpers.linux.list import list_for_each_entry,list_empty
+from drgn.helpers.linux.percpu import per_cpu_ptr
+from drgn.helpers.linux.cpumask import for_each_cpu,for_each_possible_cpu
+from drgn.helpers.linux.idr import idr_for_each
+
+import argparse
+parser = argparse.ArgumentParser(description=desc,
+                                 formatter_class=argparse.RawTextHelpFormatter)
+args = parser.parse_args()
+
+def err(s):
+    print(s, file=sys.stderr, flush=True)
+    sys.exit(1)
+
+def cpumask_str(cpumask):
+    output = ""
+    base = 0
+    v = 0
+    for cpu in for_each_cpu(cpumask[0]):
+        while cpu - base >= 32:
+            output += f'{hex(v)} '
+            base += 32
+            v = 0
+        v |= 1 << (cpu - base)
+    if v > 0:
+        output += f'{v:08x}'
+    return output.strip()
+
+worker_pool_idr         = prog['worker_pool_idr']
+workqueues              = prog['workqueues']
+wq_unbound_cpumask      = prog['wq_unbound_cpumask']
+wq_pod_types            = prog['wq_pod_types']
+
+WQ_UNBOUND              = prog['WQ_UNBOUND']
+WQ_ORDERED              = prog['__WQ_ORDERED']
+WQ_MEM_RECLAIM          = prog['WQ_MEM_RECLAIM']
+
+WQ_AFFN_NUMA            = prog['WQ_AFFN_NUMA']
+WQ_AFFN_SYSTEM          = prog['WQ_AFFN_SYSTEM']
+
+print('Affinity Scopes')
+print('===============')
+
+print(f'wq_unbound_cpumask={cpumask_str(wq_unbound_cpumask)}')
+
+def print_pod_type(pt):
+    print(f'  nr_pods  {pt.nr_pods.value_()}')
+
+    print('  pod_cpus', end='')
+    for pod in range(pt.nr_pods):
+        print(f' [{pod}]={cpumask_str(pt.pod_cpus[pod])}', end='')
+    print('')
+
+    print('  pod_node', end='')
+    for pod in range(pt.nr_pods):
+        print(f' [{pod}]={pt.pod_node[pod].value_()}', end='')
+    print('')
+
+    print(f'  cpu_pod ', end='')
+    for cpu in for_each_possible_cpu(prog):
+        print(f' [{cpu}]={pt.cpu_pod[cpu].value_()}', end='')
+    print('')
+
+print('')
+print('NUMA')
+print_pod_type(wq_pod_types[WQ_AFFN_NUMA])
+print('')
+print('SYSTEM')
+print_pod_type(wq_pod_types[WQ_AFFN_SYSTEM])
+
+print('')
+print('Worker Pools')
+print('============')
+
+max_pool_id_len = 0
+max_ref_len = 0
+for pi, pool in idr_for_each(worker_pool_idr):
+    pool = drgn.Object(prog, 'struct worker_pool', address=pool)
+    max_pool_id_len = max(max_pool_id_len, len(f'{pi}'))
+    max_ref_len = max(max_ref_len, len(f'{pool.refcnt.value_()}'))
+
+for pi, pool in idr_for_each(worker_pool_idr):
+    pool = drgn.Object(prog, 'struct worker_pool', address=pool)
+    print(f'pool[{pi:0{max_pool_id_len}}] ref={pool.refcnt.value_():{max_ref_len}} nice={pool.attrs.nice.value_():3} ', end='')
+    print(f'idle/workers={pool.nr_idle.value_():3}/{pool.nr_workers.value_():3} ', end='')
+    if pool.cpu >= 0:
+        print(f'cpu={pool.cpu.value_():3}', end='')
+    else:
+        print(f'cpus={cpumask_str(pool.attrs.cpumask)}', end='')
+    print('')
+
+print('')
+print('Workqueue CPU -> pool')
+print('=====================')
+
+print('[    workqueue \ CPU            ', end='')
+for cpu in for_each_possible_cpu(prog):
+    print(f' {cpu:{max_pool_id_len}}', end='')
+print(' dfl]')
+
+for wq in list_for_each_entry('struct workqueue_struct', workqueues.address_of_(), 'list'):
+    print(f'{wq.name.string_().decode()[-24:]:24}', end='')
+    if wq.flags & WQ_UNBOUND:
+        if wq.flags & WQ_ORDERED:
+            print(' ordered', end='')
+        else:
+            print(' unbound', end='')
+    else:
+        print(' percpu ', end='')
+
+    for cpu in for_each_possible_cpu(prog):
+        pool_id = per_cpu_ptr(wq.cpu_pwq, cpu)[0].pool.id.value_()
+        field_len = max(len(str(cpu)), max_pool_id_len)
+        print(f' {pool_id:{field_len}}', end='')
+
+    if wq.flags & WQ_UNBOUND:
+        print(f' {wq.dfl_pwq.pool.id.value_():{max_pool_id_len}}', end='')
+    print('')
-- 
2.40.1

