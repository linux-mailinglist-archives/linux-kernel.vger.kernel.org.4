Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F90E74B78C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGGT6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjGGT6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87519A5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688759872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xSvAWe0AbfxlQd6ChnkxMAuhPvkStpZHDRjDCilD0FY=;
        b=XUQp6iXEKRf2Iuo0sA94+ux62pQvAzyoztQ3GAy/nCNgPHK0pMOjnMCr7oJkT7lJL3ztc5
        QjI0WdDy+qsScAtjS6A7yNoz1vT1JXHzm3064gCEBdQ2H1k50NauZM4HMV7yb8+9vDWF7r
        75vGXj78y+8NNePyClHfGYNPXyZi80g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-TG5PUHubPpu3k0TjR7rIIQ-1; Fri, 07 Jul 2023 15:57:50 -0400
X-MC-Unique: TG5PUHubPpu3k0TjR7rIIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11FCC3C0E207;
        Fri,  7 Jul 2023 19:57:50 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 925124087C6A;
        Fri,  7 Jul 2023 19:57:49 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Phil Auld <pauld@redhat.com>
Subject: [PATCH v5 0/2] Fix nohz_full vs cfs bandwidth
Date:   Fri,  7 Jul 2023 15:57:46 -0400
Message-Id: <20230707195748.2918490-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v5 of patch 2/2 which is adding code to prevent
the tick from being stopped when the single running task
has bandwidth limits. Discussions had led to the idea of
adding a bit to task_struct to help make this decision.

There was some complexity with doing it in the task which
is  avoided by using something in the cfs_rq. Looking 
into that lead me to the hierarchical_quota field in the 
cfs_bandwith struct. We spend a good deal of effort
updating (or trying to, see patch 1/2) that value for
the whole task_group tree when a quota is set/changed.

This new version first fixes that value to be meaningful
for cgroupv2 and then leverages it to make the decisions
about blocking the tick_stop. 

Phil Auld (2):
  sched, cgroup: Restore meaning to hierarchical_quota
  Sched/fair: Block nohz tick_stop when cfs bandwidth in use

 kernel/sched/core.c     | 23 ++++++++++++++---
 kernel/sched/fair.c     | 56 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/features.h |  2 ++
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 76 insertions(+), 8 deletions(-)

-- 
2.31.1

