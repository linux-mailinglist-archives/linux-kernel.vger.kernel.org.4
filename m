Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE955E6083
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiIVLK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIVLKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:10:22 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5C782776;
        Thu, 22 Sep 2022 04:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844391;
        bh=MhEKuSHvpyw2ASMRkqrxGVeTk47bClxhV5jeTCTkWdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNxc5kzPJ3Fj9M0h+vIGyBhZyeA4WWCac/nbJBh9D+VtkEbJzdPBgxaP1ttR8W7Ej
         VdwY6JBnhjXiDbhJnvLIUlOjphoIwbDNZl66N0v4zw3yQ3lHWgFBVz7TfFy4sz2c7b
         wGoX8NcwRoZHs1W92Rh3eJ+dhIXD9PuMwaXDaR8pmfg6YLRVj15Ayeh7fMO7dGyrUP
         5UdBHdV8ph6tuT2C/j9GOIXDiv4422AgoAj7Vy08Qu5VXcQ0PyfBDABKLVhCK0jhZF
         ParlFkMspWiMkwgA++MlGHrzal1qp03ew8dESu73Z6ylNpahD9vlPTkUztVoVIqoCI
         iYm7q9kWXWnjg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3W0fGZzNr9;
        Thu, 22 Sep 2022 06:59:51 -0400 (EDT)
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
Subject: [PATCH v4 25/25] tracing/rseq: Add mm_vcpu_id field to rseq_update
Date:   Thu, 22 Sep 2022 06:59:40 -0400
Message-Id: <20220922105941.237830-26-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
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
 include/trace/events/rseq.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index 6bd442697354..10b236fc047a 100644
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
+		__entry->mm_vcpu_id = t->mm_vcpu;
 	),
 
-	TP_printk("cpu_id=%d node_id=%d", __entry->cpu_id, __entry->node_id)
+	TP_printk("cpu_id=%d node_id=%d mm_vcpu_id=%d", __entry->cpu_id,
+		  __entry->node_id, __entry->mm_vcpu_id)
 );
 
 TRACE_EVENT(rseq_ip_fixup,
-- 
2.25.1

