Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6454063A8F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiK1NKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiK1NKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:10:09 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE091B9C9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:10:07 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NLQms5JrMz8QrkZ;
        Mon, 28 Nov 2022 21:10:05 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2ASD9vBr026909;
        Mon, 28 Nov 2022 21:09:57 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 28 Nov 2022 21:10:00 +0800 (CST)
Date:   Mon, 28 Nov 2022 21:10:00 +0800 (CST)
X-Zmail-TransId: 2afa6384b328ffffffff9b189469
X-Mailer: Zmail v1.0
Message-ID: <202211282110006083500@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHJpbmdfYnVmZmVyOiByZW1vdmUgcmVkdW5kYW50IHJldCB2YXJpYWJsZXM=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2ASD9vBr026909
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6384B32D.000 by FangMail milter!
X-FangMail-Envelope: 1669641005/4NLQms5JrMz8QrkZ/6384B32D.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6384B32D.000/4NLQms5JrMz8QrkZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

Return values from ring_buffer_bytes_cpu(), ring_buffer_overrun_cpu(),
ring_buffer_commit_overrun_cpu(), ring_buffer_dropped_events_cpu()
directly instead of taking this in another redundant variable.

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 kernel/trace/ring_buffer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 843818ee4814..353c90ce7640 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4224,15 +4224,13 @@ EXPORT_SYMBOL_GPL(ring_buffer_oldest_event_ts);
 unsigned long ring_buffer_bytes_cpu(struct trace_buffer *buffer, int cpu)
 {
        struct ring_buffer_per_cpu *cpu_buffer;
-       unsigned long ret;

        if (!cpumask_test_cpu(cpu, buffer->cpumask))
                return 0;

        cpu_buffer = buffer->buffers[cpu];
-       ret = local_read(&cpu_buffer->entries_bytes) - cpu_buffer->read_bytes;

-       return ret;
+       return local_read(&cpu_buffer->entries_bytes) - cpu_buffer->read_bytes;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_bytes_cpu);

@@ -4263,15 +4261,13 @@ EXPORT_SYMBOL_GPL(ring_buffer_entries_cpu);
 unsigned long ring_buffer_overrun_cpu(struct trace_buffer *buffer, int cpu)
 {
        struct ring_buffer_per_cpu *cpu_buffer;
-       unsigned long ret;

        if (!cpumask_test_cpu(cpu, buffer->cpumask))
                return 0;

        cpu_buffer = buffer->buffers[cpu];
-       ret = local_read(&cpu_buffer->overrun);

-       return ret;
+       return local_read(&cpu_buffer->overrun);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_overrun_cpu);

@@ -4286,15 +4282,13 @@ unsigned long
 ring_buffer_commit_overrun_cpu(struct trace_buffer *buffer, int cpu)
 {
        struct ring_buffer_per_cpu *cpu_buffer;
-       unsigned long ret;

        if (!cpumask_test_cpu(cpu, buffer->cpumask))
                return 0;

        cpu_buffer = buffer->buffers[cpu];
-       ret = local_read(&cpu_buffer->commit_overrun);

-       return ret;
+       return local_read(&cpu_buffer->commit_overrun);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_commit_overrun_cpu);

@@ -4308,15 +4302,13 @@ unsigned long
 ring_buffer_dropped_events_cpu(struct trace_buffer *buffer, int cpu)
 {
        struct ring_buffer_per_cpu *cpu_buffer;
-       unsigned long ret;

        if (!cpumask_test_cpu(cpu, buffer->cpumask))
                return 0;

        cpu_buffer = buffer->buffers[cpu];
-       ret = local_read(&cpu_buffer->dropped_events);

-       return ret;
+       return local_read(&cpu_buffer->dropped_events);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_dropped_events_cpu);

--
2.15.2
