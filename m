Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E365FB6F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjAFGaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjAFGaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:30:15 -0500
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE732276
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 22:30:10 -0800 (PST)
X-QQ-mid: bizesmtp76t1672986596twrrafam
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 06 Jan 2023 14:29:55 +0800 (CST)
X-QQ-SSF: 01400000002000D0G000B00A0000020
X-QQ-FEAT: snGZFTpAiwuNKdSS78HtF8QAoUM+hajCnQuvn65hIPUCInRq89S5NZ7aijOQJ
        KMqj7WXy+sTAOgrpFf/mAxQ6IQgTux/gpaPptPdg7hd9C+I9FmwimAMXZOVnrCj9Bhp9DOg
        L48Tfe/vJQhP+3wyp6GjhYaTcH8/ZDAFeWXUTqhDJGHkETsiyvsDZjYoA6gn32lii9dODs1
        rHSAw13C3boW50WERWUSbqFnx7aDMsym2No9E1kxdihDqnpYDNiMTQagxGnOfuwuXPxNMJe
        bbBQ467m1D7ETqLrimnXZRBN7eN2Ph98abqIHPyp8n8uI3oWQRuuUIV+XRmWe030viLIx+T
        yEWgspdOi4tZRiK8W78GWLZAPafV+Df5N7pbsUWd8yP7Zmf78pfhGHSAmpBIV/1TK56y8Uu
X-QQ-GoodBg: 2
From:   Guo Hui <guohui@uniontech.com>
To:     sboyd@kernel.org
Cc:     tglx@linutronix.de, jstultz@google.com, wangxiaohua@uniontech.com,
        linux-kernel@vger.kernel.org, Guo Hui <guohui@uniontech.com>
Subject: [PATCH] timekeeping:add padding in timekeeper for Unixbench pipe
Date:   Fri,  6 Jan 2023 14:29:46 +0800
Message-Id: <20230106062946.19983-1-guohui@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the LLC cache line size is 128 bytes, such as Kunpeng 920,
the seq attribute and xtime attribute in the structure tk_core
are completely in the same LLC cache line,
and xtime_sec is the data protected by the seq lock
in the function ktime_get_coarse_real_ts64,
so seq and xtime_sec are in the same LLC cache line
causing the false sharing problem.

Adding padding before xtime_sec in the structure timekeeper
is based on the comment of the structure tk_read_base: "This
struct has size 56 byte on 64 bit. Together with a seqcount
it occupies a single 64byte cache line." Therefore,
seq and the structure tk_read_base
should be placed in the same 64-byte cacheline.

The performance data of Unixbench pipe on Kunpeng 920 is as follows:

Enable the LSE instruction:
seq and xtime are in the same LLC cache line:
System Benchmarks Partial Index              BASELINE       RESULT    INDEX
Pipe Throughput                               12440.0   14800574.4  11897.6
Pipe-based Context Switching                   4000.0    4357419.0  10893.5
                                                                   ========
System Benchmarks Index Score (Partial Only)                        11384.5

seq and xtime are not in the same LLC cache line:
System Benchmarks Partial Index              BASELINE       RESULT    INDEX
Pipe Throughput                               12440.0   16546306.6  13300.9
Pipe-based Context Switching                   4000.0    5654281.8  14135.7
                                                                   ========
System Benchmarks Index Score (Partial Only)                        13711.9

When the LSE instruction is enabled,
Pipe Throughput increases by 11.79%,
and Pipe-based Context Switching increases by 29.76%.

Close the LSE instruction:
seq and xtime are in the same LLC cache line:
System Benchmarks Partial Index              BASELINE       RESULT    INDEX
Pipe Throughput                               12440.0   36375286.5  29240.6
Pipe-based Context Switching                   4000.0   11994739.7  29986.8
                                                                   ========
System Benchmarks Index Score (Partial Only)                        29611.4

seq and xtime are not in the same LLC cache line:
System Benchmarks Partial Index              BASELINE       RESULT    INDEX
Pipe Throughput                               12440.0   44887148.8  36082.9
Pipe-based Context Switching                   4000.0   13666392.0  34166.0
                                                                   ========
System Benchmarks Index Score (Partial Only)                        35111.4

When the LSE instruction is disabled,
Pipe Throughput increases by 23.40%,
and Pipe-based Context Switching increases by 13.94%.

Signed-off-by: Guo Hui <guohui@uniontech.com>
---
 include/linux/timekeeper_internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 84ff2844d..d363cd1f3 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -92,6 +92,7 @@ struct tk_read_base {
 struct timekeeper {
 	struct tk_read_base	tkr_mono;
 	struct tk_read_base	tkr_raw;
+	u64			padding;
 	u64			xtime_sec;
 	unsigned long		ktime_sec;
 	struct timespec64	wall_to_monotonic;
-- 
2.20.1

