Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22E26348A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiKVUm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiKVUlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:41:01 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBFB716E3;
        Tue, 22 Nov 2022 12:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149597;
        bh=O1N2y3vjljIZnKe9A0DWaJyuaE+DJOz1zqwzlJQB/j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FH7kxxsZPNpCeWLHljPWd50s3fK1CsH4OXiUxDH0jqtzGiw0TUUBVWGDNuR+tQpct
         rroSkpWJfrMBtTt8xT9zKWR/lqefUTomiiG+stVJdiEQvrX3bJI6RsfRWx7T2aZhSD
         m/Jhj69J2E4Nkv7benyo6QmJxAk43hcbZaRUw1iSmeKuhvUZcMW1ckZrTFuZaZC6kA
         iUMIk0m2QCc0mqNZths82FXge0o/YMfl5Cj6dU2olLZuXPIGPqS31M7w5wD4h3ntKX
         XQORaOj+SPbuY1DXGDyub5sJAIhj6RZodCmsIkL6QlfX+h9iOF2udmmPFapgNLVpW1
         /10GtKzySEgEQ==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2h5jgJzXLV;
        Tue, 22 Nov 2022 15:39:56 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 30/30] tracing/rseq: Add mm_numa_cid field to rseq_update
Date:   Tue, 22 Nov 2022 15:39:32 -0500
Message-Id: <20221122203932.231377-31-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mm_numa_cid field to the rseq_update event, allowing tracers to
follow which mm_numa_cid is observed by user-space, and whether negative
mm_numa_cid values are visible in case of internal scheduler
implementation issues.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/trace/events/rseq.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index 823b47d1ba1e..95f33d2c0714 100644
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -18,16 +18,18 @@ TRACE_EVENT(rseq_update,
 		__field(s32, cpu_id)
 		__field(s32, node_id)
 		__field(s32, mm_cid)
+		__field(s32, mm_numa_cid)
 	),
 
 	TP_fast_assign(
 		__entry->cpu_id = raw_smp_processor_id();
 		__entry->node_id = cpu_to_node(__entry->cpu_id);
 		__entry->mm_cid = task_mm_cid(t);
+		__entry->mm_numa_cid = task_mm_numa_cid(t);
 	),
 
-	TP_printk("cpu_id=%d node_id=%d mm_cid=%d", __entry->cpu_id,
-		  __entry->node_id, __entry->mm_cid)
+	TP_printk("cpu_id=%d node_id=%d mm_cid=%d mm_numa_cid=%d", __entry->cpu_id,
+		  __entry->node_id, __entry->mm_cid,  __entry->mm_numa_cid)
 );
 
 TRACE_EVENT(rseq_ip_fixup,
-- 
2.25.1

