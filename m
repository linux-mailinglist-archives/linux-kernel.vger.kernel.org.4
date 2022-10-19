Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58A6037EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJSCL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJSCL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:11:26 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 825BBD73F3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:11:24 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:51444.1560931561
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-111.162.158.155 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 6ED7E10032F;
        Wed, 19 Oct 2022 10:11:21 +0800 (CST)
Received: from  ([111.162.158.155])
        by gateway-153622-dep-787c977d48-v8sdr with ESMTP id 54bbaa6152bb4178846e0ce8118d5e48 for rostedt@goodmis.org;
        Wed, 19 Oct 2022 10:11:22 CST
X-Transaction-ID: 54bbaa6152bb4178846e0ce8118d5e48
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 111.162.158.155
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, xiehuan09@gmail.com,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH v2] trace/kprobe: remove duplicated calls of ring_buffer_event_data
Date:   Wed, 19 Oct 2022 10:11:18 +0800
Message-Id: <1666145478-4706-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function __kprobe_trace_func calls ring_buffer_event_data to
get a ring buffer, however, it has been done in above call
trace_event_buffer_reserve. So does __kretprobe_trace_func.

This patch removes those duplicated calls.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/trace/trace_kprobe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 23f7f0ec4f4c..f905829b856b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1394,7 +1394,6 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 		return;
 
 	fbuffer.regs = regs;
-	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
@@ -1435,7 +1434,6 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 		return;
 
 	fbuffer.regs = regs;
-	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = get_kretprobe_retaddr(ri);
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
-- 
2.25.1

