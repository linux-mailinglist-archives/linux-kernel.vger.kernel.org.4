Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371AA63D617
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiK3M7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiK3M7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:59:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B463F429B1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669813092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ffLVilJfGN30ui/fAKJ/GAZJOVTJYPQ4bp9hp76WPQk=;
        b=OTsm2whIFmj1LcgwjwLOVj1buU9QrMFLruhWifLZ6VpfK/6SRzDCQxvbRlzABVovKsPcdv
        0cTYWnpOS6S0Yl64OpmiFxZZD2cm/AlqoPDqPMKpxFThY363mclmR5XINKNdV1DILz8tIy
        4Pw4vAAkOYd6i3iwQD+9Lq0z2VYCF4g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-nlmAYYNWO5agwsTaxFDO9w-1; Wed, 30 Nov 2022 07:58:08 -0500
X-MC-Unique: nlmAYYNWO5agwsTaxFDO9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0159D811E67;
        Wed, 30 Nov 2022 12:58:08 +0000 (UTC)
Received: from ypodemsk.tlv.csb (unknown [10.39.193.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B114742220;
        Wed, 30 Nov 2022 12:58:04 +0000 (UTC)
From:   Yair Podemsky <ypodemsk@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        rafael.j.wysocki@intel.com, ggherdovich@suse.cz, jlelli@redhat.com,
        mtosatti@redhat.com, nsaenz@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ypodemsk@redhat.com
Subject: [PATCH] sched/core: Fix arch_scale_freq_tick() on tickless systems
Date:   Wed, 30 Nov 2022 14:51:21 +0200
Message-Id: <20221130125121.34407-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the scheduler to be frequency invariant we measure the
ratio between the maximum cpu frequency and the actual cpu frequency.
During long tickless periods of time the calculations that keep track
of that might overflow, in the function scale_freq_tick():

if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
»       goto error;

eventually forcing the kernel to disable the feature for all cpus,
and show the warning message
"Scheduler frequency invariance went wobbly, disabling!".
Let's avoid that by limiting the frequency invariant calculations
to cpus with regular tick.

Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
Suggested-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
---
V1 -> V2: solution approach was changed from detecting long tickless periods
to frequency invariant measurements on housekeeping cpus only.
Link: ee89073a1e9de11c7bd7726eb5da71a0e8795099.camel@redhat.com
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index daff72f00385..1bb0a840c817 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5469,7 +5469,9 @@ void scheduler_tick(void)
 	unsigned long thermal_pressure;
 	u64 resched_latency;
 
-	arch_scale_freq_tick();
+	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+		arch_scale_freq_tick();
+
 	sched_clock_tick();
 
 	rq_lock(rq, &rf);
-- 
2.31.1

