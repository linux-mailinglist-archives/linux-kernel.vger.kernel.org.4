Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0AD6BEA66
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCQNpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjCQNoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:44:55 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA4610CC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:44:53 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id y4so20632756edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679060692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJJBSnB7o70eAA7mqVir08dpO4NUXBSh7FyCL+f6E1s=;
        b=Ab/3L9n+Jpoworo651uEP1aIjiYPTvF+J0m8MKtGG6t+blqoKvU21hx/kUEc5nMeL6
         gEdlXp/4YOQRiQXhFgZQDJQxely+RgQy8TZsS56Z7cNyUL7SFYNJm6IN6krOICnb6QR2
         GO6K/0rx0GtGCti2UNoZUm2Pgibl3htt+OjMyRCgkzGRfhUKYw7Vmjof++ZGHt2ieN0o
         dBO7uf6xBjbSNbjJHLfSyh0QdQmwet9LaJie9ZMu42mMCwNrtndT8jov2P7Obvy9auSk
         cndDBICwLR+rpEuvkzc45rVp84AgnvDCfgRPOeRKqah94sD9/1igAmyPa2lEgq9LiXci
         mX+g==
X-Gm-Message-State: AO0yUKUk1agKlVfsGX2Z4r2zjGi/tBxotzxewEV3QVFHzYBkS8cIdLFt
        C4pacujzW7/QZMAJUkpC7j4=
X-Google-Smtp-Source: AK7set+bv2JJPSJzrjYUiKpymvnxoVfPw+PkOH4EeukjH39GC4jd/80SFBmpwh0LjjhTCUvCkSfCtQ==
X-Received: by 2002:a17:906:f85:b0:909:3c55:a1b3 with SMTP id q5-20020a1709060f8500b009093c55a1b3mr13801506ejj.38.1679060691908;
        Fri, 17 Mar 2023 06:44:51 -0700 (PDT)
Received: from localhost.localdomain (85-160-41-201.reb.o2.cz. [85.160.41.201])
        by smtp.gmail.com with ESMTPSA id gz14-20020a170906f2ce00b00923221f4062sm999273ejb.112.2023.03.17.06.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 06:44:51 -0700 (PDT)
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
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 0/2] memcg, cpuisol: do not interfere pcp cache charges draining with cpuisol workloads
Date:   Fri, 17 Mar 2023 14:44:46 +0100
Message-Id: <20230317134448.11082-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
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

Leonardo has reported [1] that pcp memcg charge draining can interfere
with cpu isolated workloads. The said draining is done from a WQ context
with a pcp worker scheduled on each CPU which holds any cached charges
for a specific memcg hierarchy. Operation is not really a common
operation [2]. It can be triggered from the userspace though so some
care is definitely due.

Leonardo has tried to address the issue by allowing remote charge
draining [3]. This approach requires an additional locking to
synchronize pcp caches sync from a remote cpu from local pcp consumers.
Even though the proposed lock was per-cpu there is still potential for
contention and less predictable behavior.

This patchset addresses the issue from a different angle. Rather than
dealing with a potential synchronization, cpus which are isolated are
simply never scheduled to be drained. This means that a small amount of
charges could be laying around and waiting for a later use or they are
flushed when a different memcg is charged from the same cpu. More
details are in patch 2. The first patch from Frederic is implementing an
abstraction to tell whether a specific cpu has been isolated and
therefore require a special treatment.

The patchset is on top of Andrew's mm-unstable tree. I am not sure which
tree is the best to route both of them but unless there are any special
requirements for the cpu isolation parts then pushing this via Andrew
seems like the easiest choice.

Frederic Weisbecker (1):
      sched/isolation: Add cpu_is_isolated() API

Michal Hocko (1):
      memcg: do not drain charge pcp caches on remote isolated cpus

 include/linux/sched/isolation.h | 12 ++++++++++++
 mm/memcontrol.c                 |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

[1] https://lore.kernel.org/all/20221102020243.522358-1-leobras@redhat.com/T/#u
[2] https://lore.kernel.org/all/Y9LQ615H13RmG7wL@dhcp22.suse.cz/T/#u
[3] https://lore.kernel.org/all/20230125073502.743446-1-leobras@redhat.com/T/#u


