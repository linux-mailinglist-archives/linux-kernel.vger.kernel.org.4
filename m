Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1805E6735
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiIVPe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIVPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:34:53 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08E03DF12;
        Thu, 22 Sep 2022 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663860887;
        bh=5Ep3EBM1hIoqjRHZdJsBaCJcMFgOZVCUSGq+oVi8Y6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WqbPB7YtbE+32T8k0MINGVkVVhw2+LNTMIExACWsImLGNPj4O3FylcFOFsLfCWOf/
         U1jG12CppL7TykiYG5J2V0snXXsnIT10u1iIFxwBmGHpZiqo9ZnSrc0YovOIznkce5
         3tgfwIDyaUcAXP4F+d5+70QzWj/sGe7tew2yVzqz8qw/T/uaKC0hpAFkGrfMew4fZT
         nxDWGwgNugDj1ibd9vWshJIFoG2m2Oq5y84xqoXh78NHa+mmi8U/b073yiwikCyNeM
         Bnd0uJh5LlM/LV7fkuEntIIxND99Z6JB2GHqlpUiFX0b3uR3b0vNbrxQeKkChBu5Or
         gixD3E5M3Curg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYK8l4gwxzNWT;
        Thu, 22 Sep 2022 11:34:47 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4.1 25/25] tracing/rseq: Add mm_vcpu_id field to rseq_update
Date:   Thu, 22 Sep 2022 11:33:04 -0400
Message-Id: <20220922153304.281881-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202209222301.8AZY1n7J-lkp@intel.com>
References: <202209222301.8AZY1n7J-lkp@intel.com>
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

Add the mm_vcpu_id field to the rseq_update event, allowing tracers to
follow which vcpu_id is observed by user-space, and whether negative
vcpu_id values are visible in case of internal scheduler implementation
issues.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
Changes since v4:
- use task_mm_vcpu_id() to get the mm_vcpu_id from the task struct.
---
 include/trace/events/rseq.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index 6bd442697354..cef5a91a9ba0 100644
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -17,14 +17,17 @@ TRACE_EVENT(rseq_update,
 	TP_STRUCT__entry(
 		__field(s32, cpu_id)
 		__field(s32, node_id)
+		__field(s32, mm_vcpu_id)
 	),
 
 	TP_fast_assign(
 		__entry->cpu_id = raw_smp_processor_id();
 		__entry->node_id = cpu_to_node(raw_smp_processor_id());
+		__entry->mm_vcpu_id = task_mm_vcpu_id(t);
 	),
 
-	TP_printk("cpu_id=%d node_id=%d", __entry->cpu_id, __entry->node_id)
+	TP_printk("cpu_id=%d node_id=%d mm_vcpu_id=%d", __entry->cpu_id,
+		  __entry->node_id, __entry->mm_vcpu_id)
 );
 
 TRACE_EVENT(rseq_ip_fixup,
-- 
2.25.1

