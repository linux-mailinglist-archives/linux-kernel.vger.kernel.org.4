Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983786BEA67
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjCQNpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCQNo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:44:57 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869C10CC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:44:55 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id r11so20594554edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679060694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJPMQdWRr2R62+6qFAGrbR0pxQ+XXGNRMUC/h0VNtm0=;
        b=NblaNDhlO7T4DUnSrbf+fQ3DoMDrfuzzdpADg/F2IxCD1zIMpAXMxHQV5I2GYGjNJc
         8ERTQbenqFS5GnId9swpvBxSa95UBJlUz1dKPuYSfhoXGCHtlHIOa3/n/WmQVyK+wl3N
         j++xOagxxEwTzbMUFNdWrcX80tv1kXZo2lTuru/Q47ybDPsvREPd9O6klukhbRpwRGVa
         4XNU+5nTYl1TYnIt8GOHzkm8uFqJOjPBleGViQRmaKw3Bok+pvI8pNKV+mwz9Y69R3Gp
         SgSOqzFjmFh1HC/RC1MvXx1aq5hwChRQMykq7DOSt72V62wpRKXz1lD17Ey6Jm/exYCP
         f9jg==
X-Gm-Message-State: AO0yUKWrOAJdgU8agLRWXsrS83Lmep+wPxr73Dofw2YtWYV79K3i/9/L
        ddWwkK1zkQWFbwnDbBOdQb8=
X-Google-Smtp-Source: AK7set83jXniV558MlOBbZXcyh1vr8063l9PNIhAzz51dJmEJsUiFtl0X65tzwCOY8u2W3NER4j7yg==
X-Received: by 2002:a17:906:eec2:b0:92d:46f1:dc68 with SMTP id wu2-20020a170906eec200b0092d46f1dc68mr17325149ejb.67.1679060694390;
        Fri, 17 Mar 2023 06:44:54 -0700 (PDT)
Received: from localhost.localdomain (85-160-41-201.reb.o2.cz. [85.160.41.201])
        by smtp.gmail.com with ESMTPSA id gz14-20020a170906f2ce00b00923221f4062sm999273ejb.112.2023.03.17.06.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 06:44:54 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras@redhat.com>
Cc:     Frederic Weisbecker <fweisbecker@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 2/2] memcg: do not drain charge pcp caches on remote isolated cpus
Date:   Fri, 17 Mar 2023 14:44:48 +0100
Message-Id: <20230317134448.11082-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230317134448.11082-1-mhocko@kernel.org>
References: <20230317134448.11082-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Leonardo Bras has noticed that pcp charge cache draining might be
disruptive on workloads relying on 'isolated cpus', a feature commonly
used on workloads that are sensitive to interruption and context
switching such as vRAN and Industrial Control Systems.

There are essentially two ways how to approach the issue. We can either
allow the pcp cache to be drained on a different rather than a local cpu
or avoid remote flushing on isolated cpus.

The current pcp charge cache is really optimized for high performance
and it always relies to stick with its cpu. That means it only requires
local_lock (preempt_disable on !RT) and draining is handed over to pcp
WQ to drain locally again.

The former solution (remote draining) would require to add an additional
locking to prevent local charges from racing with the draining. This
adds an atomic operation to otherwise simple arithmetic fast path in the
try_charge path. Another concern is that the remote draining can cause a
lock contention for the isolated workloads and therefore interfere with
it indirectly via user space interfaces.

Another option is to avoid draining scheduling on isolated cpus
altogether. That means that those remote cpus would keep their charges
even after drain_all_stock returns. This is certainly not optimal either
but it shouldn't really cause any major problems. In the worst case
(many isolated cpus with charges - each of them with MEMCG_CHARGE_BATCH
i.e 64 page) the memory consumption of a memcg would be artificially
higher than can be immediately used from other cpus.

Theoretically a memcg OOM killer could be triggered pre-maturely.
Currently it is not really clear whether this is a practical problem
though. Tight memcg limit would be really counter productive to cpu
isolated workloads pretty much by definition because any memory
reclaimed induced by memcg limit could break user space timing
expectations as those usually expect execution in the userspace most of
the time.

Also charges could be left behind on memcg removal. Any future charge on
those isolated cpus will drain that pcp cache so this won't be a
permanent leak.

Considering cons and pros of both approaches this patch is implementing
the second option and simply do not schedule remote draining if the
target cpu is isolated. This solution is much more simpler. It doesn't
add any new locking and it is more more predictable from the user space
POV. Should the pre-mature memcg OOM become a real life problem, we can
revisit this decision.

Cc: Leonardo Brás <leobras@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Reported-by: Leonardo Bras <leobras@redhat.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Suggested-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0524add35cae..12559c08d976 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2366,7 +2366,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
 			if (cpu == curcpu)
 				drain_local_stock(&stock->work);
-			else
+			else if (!cpu_is_isolated(cpu))
 				schedule_work_on(cpu, &stock->work);
 		}
 	}
-- 
2.30.2

