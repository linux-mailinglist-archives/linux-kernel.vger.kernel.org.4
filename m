Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FEB637BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiKXOvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiKXOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:51:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15514134F25
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:50:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17A9EB82839
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4651C43151;
        Thu, 24 Nov 2022 14:50:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDYs-001X6T-2h;
        Thu, 24 Nov 2022 09:50:46 -0500
Message-ID: <20221124145046.712465586@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:50:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [for-next][PATCH 09/11] tracing: Make tracepoint_print_iter static
References: <20221124145019.782980678@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

After change in commit 4239174570da ("tracing: Make tracepoint_printk a
static_key"), this symbol is not used outside of the file, so mark it
static.

Link: https://lkml.kernel.org/r/20221122091456.72055-1-xiujianfeng@huawei.com

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 kernel/trace/trace.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5c97dbef741b..93a75a97118f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -85,7 +85,7 @@ void __init disable_tracing_selftest(const char *reason)
 #endif
 
 /* Pipe tracepoints to printk */
-struct trace_iterator *tracepoint_print_iter;
+static struct trace_iterator *tracepoint_print_iter;
 int tracepoint_printk;
 static bool tracepoint_printk_stop_on_boot __initdata;
 static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d42e24507152..48643f07bc01 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1942,8 +1942,6 @@ static inline void tracer_hardirqs_on(unsigned long a0, unsigned long a1) { }
 static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
 #endif
 
-extern struct trace_iterator *tracepoint_print_iter;
-
 /*
  * Reset the state of the trace_iterator so that it can read consumed data.
  * Normally, the trace_iterator is used for reading the data when it is not
-- 
2.35.1


