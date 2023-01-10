Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA13C66458C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjAJQD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbjAJQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:03:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983C14F137
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673366550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DQpRVT0IkRUZeKZoKEdCQYhHtCMfLxNstGXOTDIvo4s=;
        b=SJWq2/D2crSWJOoit5wxybjmzmRtGFqTsebfav1wea3NtVkUOBO5zPM6+pzu+G/Jrl8oLy
        HnkTYLjPVWUeRaDb2iBdWNqWjJGenU4qihnFl1yJ4q4AnAA1kKI0LXe/KUtWM1FFwCUo/J
        Z3FBDy/RLH9gObH6bCnnSJ10CYmSutg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-pxik-GieMnKb-iuD7PHckg-1; Tue, 10 Jan 2023 11:02:27 -0500
X-MC-Unique: pxik-GieMnKb-iuD7PHckg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B74D3C0D855;
        Tue, 10 Jan 2023 16:02:25 +0000 (UTC)
Received: from ypodemsk.tlv.csb (unknown [10.39.193.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD7FFC16031;
        Tue, 10 Jan 2023 16:02:22 +0000 (UTC)
From:   Yair Podemsky <ypodemsk@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        paulmck@kernel.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ypodemsk@redhat.com
Subject: [PATCH] x86/aperfmperf: erase stale arch_freq_scale values when disabling frequency invariance readings
Date:   Tue, 10 Jan 2023 18:02:06 +0200
Message-Id: <20230110160206.75912-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once disable_freq_invariance_work is called the scale_freq_tick function
will not compute or update the arch_freq_scale values.
However the scheduler will still read these values and use them.
The result is that the scheduler might perform unfair decisions based on stale
values.

This patch adds the step of setting the arch_freq_scale values for all
cpus to the default (max) value SCHED_CAPACITY_SCALE, Once all cpus
have the same arch_freq_scale value the scaling is meaningless.

Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
---
 arch/x86/kernel/cpu/aperfmperf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 1f60a2b27936..fdbb5f07448f 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -330,7 +330,16 @@ static void __init bp_init_freq_invariance(void)
 
 static void disable_freq_invariance_workfn(struct work_struct *work)
 {
+	int cpu;
+
 	static_branch_disable(&arch_scale_freq_key);
+
+	/*
+	 * Set arch_freq_scale to a default value on all cpus
+	 * This negates the effect of scaling
+	 */
+	for_each_possible_cpu(cpu)
+		per_cpu(arch_freq_scale, cpu) = SCHED_CAPACITY_SCALE;
 }
 
 static DECLARE_WORK(disable_freq_invariance_work,
-- 
2.31.1

