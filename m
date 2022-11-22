Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6334063489D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiKVUlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbiKVUj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:39:57 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B99D697D9;
        Tue, 22 Nov 2022 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149593;
        bh=7vURJNeXW9U22SN33WMla8+qcI4XLD3d3buEpebC6PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KO6Zo8FfRfpxU3iNEwBJS8Lx1YxD9DnJ9LJL5kQ9gwyfcbW2fnKno/VlROUxSmcS2
         IOeckpiiQzEGPEQlOEtN9Bu9bngTntC3umbr+YEscCP2z0GfRC/t+Zbfsr8LNDx5B1
         zRx6pkIXVl1/9F6flzkgPQ8qBfKvT5okAZzCKejZjXN0UUtOnZliRlirNGb8f0FURz
         /tnQCWcL7DDS2T5He78GIHUFQ9cmdeU4fhhsnAkNzNcp3zwYPYegMLL9hFAvXZI+OS
         3jfmFzd82pX46H7B8kd9q5mCLSEvM6Y4WXia+bRebXaAmzp65U5kOnr36yB8Zd9Z6A
         Su92sdhQw0amQ==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2d1FZrzXP8;
        Tue, 22 Nov 2022 15:39:53 -0500 (EST)
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
Subject: [PATCH 21/30] tracing/rseq: Add mm_cid field to rseq_update
Date:   Tue, 22 Nov 2022 15:39:23 -0500
Message-Id: <20221122203932.231377-22-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mm_cid field to the rseq_update event, allowing tracers to
follow which mm_cid is observed by user-space, and whether negative
mm_cid values are visible in case of internal scheduler implementation
issues.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
Changes since v4:
- use task_mm_vcpu_id() to get the mm_vcpu_id from the task struct.

Changes since v5:
- rename vcpu_id to mm_cid.
---
 include/trace/events/rseq.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index dde7a359b4ef..823b47d1ba1e 100644
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -17,14 +17,17 @@ TRACE_EVENT(rseq_update,
 	TP_STRUCT__entry(
 		__field(s32, cpu_id)
 		__field(s32, node_id)
+		__field(s32, mm_cid)
 	),
 
 	TP_fast_assign(
 		__entry->cpu_id = raw_smp_processor_id();
 		__entry->node_id = cpu_to_node(__entry->cpu_id);
+		__entry->mm_cid = task_mm_cid(t);
 	),
 
-	TP_printk("cpu_id=%d node_id=%d", __entry->cpu_id, __entry->node_id)
+	TP_printk("cpu_id=%d node_id=%d mm_cid=%d", __entry->cpu_id,
+		  __entry->node_id, __entry->mm_cid)
 );
 
 TRACE_EVENT(rseq_ip_fixup,
-- 
2.25.1

