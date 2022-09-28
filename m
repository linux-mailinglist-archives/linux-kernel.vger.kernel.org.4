Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38215ED581
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiI1G5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiI1G52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:57:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED7263F10;
        Tue, 27 Sep 2022 23:57:23 -0700 (PDT)
Date:   Wed, 28 Sep 2022 06:57:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664348240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JykWq5c8PgvO0Em9NwSaZy2eh5npciNbuq8edi2FoO4=;
        b=SKbew54R+KbF1OIyE2bQ42y4t0gH16WCgKiU6bhOR8Rocg58UtJ6nd77wF4LYGj69aLyOu
        gvJbQxdtZF8aO08fAqhyDX8PUZ7EUO2Nku+BdYVSN2YE/eddAHF91VT+2DyMnZZ/3hKpMI
        P7MNf409spiqlkHFUKGEJDeFF0g52dINhZOrlf555LW1ixbBppxaMWn1s2rgts5uxA8lbp
        UTSUbySS7ngel2iy2L6wl/fX1Gt88eh4IhJ8MKRyLr9/q/uJ654X/ZFLdB3jzsu/yyF+Kw
        334lMxxsbkm64oXgQazu+oe0vthJ4T6M5Cl9NfWMQEh59YV2IZ7dA4zaZXkAcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664348240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JykWq5c8PgvO0Em9NwSaZy2eh5npciNbuq8edi2FoO4=;
        b=Idvj6+On7OylSMMxWz3i3oaDUQWIEAiKPb2jo1vtjQ21lfefNONL+J7i+AwrcrOOMGq9nL
        iEDC2kMiPWteLhBQ==
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] bpf: Check flags for branch stack in
 bpf_read_branch_records helper
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220927203259.590950-1-jolsa@kernel.org>
References: <20220927203259.590950-1-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <166434823927.401.13847148343207516601.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cce6a2d7e0e494c453ad73e1e78bd50684f20cca
Gitweb:        https://git.kernel.org/tip/cce6a2d7e0e494c453ad73e1e78bd50684f20cca
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Tue, 27 Sep 2022 22:32:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Sep 2022 22:50:25 +02:00

bpf: Check flags for branch stack in bpf_read_branch_records helper

Recent commit [1] changed branch stack data indication from
br_stack pointer to sample_flags in perf_sample_data struct.

We need to check sample_flags for PERF_SAMPLE_BRANCH_STACK
bit for valid branch stack data.

[1] a9a931e26668 ("perf: Use sample_flags for branch stack")

Fixes: a9a931e26668 ("perf: Use sample_flags for branch stack")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20220927203259.590950-1-jolsa@kernel.org
---
 kernel/trace/bpf_trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 68e5cdd..1fcd123 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1507,6 +1507,9 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
 		return -EINVAL;
 
+	if (unlikely(!(ctx->data->sample_flags & PERF_SAMPLE_BRANCH_STACK)))
+		return -ENOENT;
+
 	if (unlikely(!br_stack))
 		return -ENOENT;
 
