Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746AF6025A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJRHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJRHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:25:01 -0400
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Oct 2022 00:24:57 PDT
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3758C4DB57
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:24:55 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:36526.1712495038
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-111.162.158.155 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 9E03E1002D6;
        Tue, 18 Oct 2022 15:13:23 +0800 (CST)
Received: from  ([111.162.158.155])
        by gateway-153622-dep-787c977d48-59pdt with ESMTP id 68899f125ad14432bd8a16e068113e36 for rostedt@goodmis.org;
        Tue, 18 Oct 2022 15:13:23 CST
X-Transaction-ID: 68899f125ad14432bd8a16e068113e36
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 111.162.158.155
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, xiehuan09@gmail.com,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH] trace/kprobe: remove duplicated call of ring_buffer_event_data
Date:   Tue, 18 Oct 2022 15:13:06 +0800
Message-Id: <1666077186-6042-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function __kprobe_trace_func calls ring_buffer_event_data to get
a ring buffer, however, it has been done in above call
trace_event_buffer_reserve.

So remove one of them.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/trace/trace_kprobe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 23f7f0ec4f4c..dfd5809a4a65 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1394,7 +1394,6 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 		return;
 
 	fbuffer.regs = regs;
-	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
-- 
2.25.1

