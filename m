Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D503601162
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiJQOpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJQOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:45:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3A42F65E;
        Mon, 17 Oct 2022 07:45:30 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:45:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666017929;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9QpAqs6GyUJEi3LXVbk4btEPF2HufReWPHZpghC9FY=;
        b=WCxycd4DgNHnbQFpQWAhIxkbwZsNCWJ/C29nq17PHPxihtOAREqI28Uij/A13ypQnMjQjz
        PjC/hcrNFuSl07WqiG7kMjgSLU2q0rxRhfdRSu/uYj7csk+uJaRO5/8KBC+NQ2P3n10gUZ
        gjKaSlBnxB47JDXnObnKC1eueZzSMaVNJftXV9gtxX2DT/SX/IStKSQK+s2KD8lJvnZLED
        l4pUW+Pqwmua0M/JvImxuZnqvviaR0pRXBi+OnNnUeoFTivMl4Y3Ea/vssbzqFyrgRygWU
        ZJ3Nk4gDV2GMc8HxGzOOyoWqMzqeh/vv0Jr28KB3ZcGoZ+RRJ20X4H42bHzi9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666017929;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9QpAqs6GyUJEi3LXVbk4btEPF2HufReWPHZpghC9FY=;
        b=YNc+pHLGOPHw6egVEbDMffAEHjmNuIc75GsP74HsaSvqE9eMspoy+1MIlDZp39zSDwObiO
        0LFHrC+wlgMC+xBw==
From:   "tip-bot2 for Sumanth Korikkar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] bpf: Fix sample_flags for bpf_perf_event_output
Cc:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221007081327.1047552-1-sumanthk@linux.ibm.com>
References: <20221007081327.1047552-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <166601792750.401.18306154915385335790.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     21da7472a040420f2dc624ffec70291a72c5d6a6
Gitweb:        https://git.kernel.org/tip/21da7472a040420f2dc624ffec70291a72c5d6a6
Author:        Sumanth Korikkar <sumanthk@linux.ibm.com>
AuthorDate:    Fri, 07 Oct 2022 10:13:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:32:06 +02:00

bpf: Fix sample_flags for bpf_perf_event_output

* Raw data is also filled by bpf_perf_event_output.
* Add sample_flags to indicate raw data.
* This eliminates the segfaults as shown below:
  Run ./samples/bpf/trace_output
  BUG pid 9 cookie 1001000000004 sized 4
  BUG pid 9 cookie 1001000000004 sized 4
  BUG pid 9 cookie 1001000000004 sized 4
  Segmentation fault (core dumped)

Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20221007081327.1047552-1-sumanthk@linux.ibm.com
---
 kernel/trace/bpf_trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 49fb9ec..1ed0896 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -687,6 +687,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 
 	perf_sample_data_init(sd, 0, 0);
 	sd->raw = &raw;
+	sd->sample_flags |= PERF_SAMPLE_RAW;
 
 	err = __bpf_perf_event_output(regs, map, flags, sd);
 
@@ -745,6 +746,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 	perf_fetch_caller_regs(regs);
 	perf_sample_data_init(sd, 0, 0);
 	sd->raw = &raw;
+	sd->sample_flags |= PERF_SAMPLE_RAW;
 
 	ret = __bpf_perf_event_output(regs, map, flags, sd);
 out:
