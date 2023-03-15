Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD076BBE69
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjCOVDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjCOVDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:03:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B9A3B5A;
        Wed, 15 Mar 2023 14:02:38 -0700 (PDT)
Date:   Wed, 15 Mar 2023 21:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678914086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XniifjN8MQzq952qxQ6M0YB9CHpC2Jk7NmP1AxZwCpI=;
        b=tuhSMAtuu0xvXURw6OCbAvdPeDU4C2EHsXpudIqyeefldWoYxZrPvLYohbn8uWwJCCgJaa
        zoTG1+2raAVxFhW8mckTRtIdDFDv8Oz3NK69RZIaWn4PoS1JvuccIvvfoQklTPN2m+mZtN
        gxsz+VTABFta3s5kVaYin2bhKxhhBTvdzkxWPF5pfJbQOS9blI3rpdjcq/vYG73r1GexBR
        ssa+nikXsY2pepaqHKsyIjiN/kioewVFpREQgP+THfDCJpNBvl19LCGElDWs5jRDiH0+47
        bYCmmjaYjal9AKtrQuoBxEU6pe2rud9e77n76tvwxUpVonbvk88wFO3R9x+vJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678914086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XniifjN8MQzq952qxQ6M0YB9CHpC2Jk7NmP1AxZwCpI=;
        b=4Ytn/jcPWX93151BUwlcCDw0mlmBnEw7e1RAwC8syjox2ErFCBzXdSbmIwFn2bWHCkO9uO
        /a69gklcoIiip5AA==
From:   "tip-bot2 for Yang Jihong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix perf_output_begin parameter is
 incorrectly invoked in perf_event_bpf_output
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230314044735.56551-1-yangjihong1@huawei.com>
References: <20230314044735.56551-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Message-ID: <167891408605.5837.5971862418041833851.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     eb81a2ed4f52be831c9fb879752d89645a312c13
Gitweb:        https://git.kernel.org/tip/eb81a2ed4f52be831c9fb879752d89645a312c13
Author:        Yang Jihong <yangjihong1@huawei.com>
AuthorDate:    Tue, 14 Mar 2023 04:47:35 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Mar 2023 21:49:46 +01:00

perf/core: Fix perf_output_begin parameter is incorrectly invoked in perf_event_bpf_output

syzkaller reportes a KASAN issue with stack-out-of-bounds.
The call trace is as follows:
  dump_stack+0x9c/0xd3
  print_address_description.constprop.0+0x19/0x170
  __kasan_report.cold+0x6c/0x84
  kasan_report+0x3a/0x50
  __perf_event_header__init_id+0x34/0x290
  perf_event_header__init_id+0x48/0x60
  perf_output_begin+0x4a4/0x560
  perf_event_bpf_output+0x161/0x1e0
  perf_iterate_sb_cpu+0x29e/0x340
  perf_iterate_sb+0x4c/0xc0
  perf_event_bpf_event+0x194/0x2c0
  __bpf_prog_put.constprop.0+0x55/0xf0
  __cls_bpf_delete_prog+0xea/0x120 [cls_bpf]
  cls_bpf_delete_prog_work+0x1c/0x30 [cls_bpf]
  process_one_work+0x3c2/0x730
  worker_thread+0x93/0x650
  kthread+0x1b8/0x210
  ret_from_fork+0x1f/0x30

commit 267fb27352b6 ("perf: Reduce stack usage of perf_output_begin()")
use on-stack struct perf_sample_data of the caller function.

However, perf_event_bpf_output uses incorrect parameter to convert
small-sized data (struct perf_bpf_event) into large-sized data
(struct perf_sample_data), which causes memory overwriting occurs in
__perf_event_header__init_id.

Fixes: 267fb27352b6 ("perf: Reduce stack usage of perf_output_begin()")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230314044735.56551-1-yangjihong1@huawei.com
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f79fd8b..296617e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9187,7 +9187,7 @@ static void perf_event_bpf_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&bpf_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, data, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				bpf_event->event_id.header.size);
 	if (ret)
 		return;
