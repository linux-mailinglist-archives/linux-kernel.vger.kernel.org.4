Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199FC6C0341
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCSQrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCSQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF3C1E9E8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC58861134
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 16:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA8AC4339E;
        Sun, 19 Mar 2023 16:47:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pdwCC-000JXJ-0r;
        Sun, 19 Mar 2023 12:47:48 -0400
Message-ID: <20230319164748.089580957@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 19 Mar 2023 12:46:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Rix <trix@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 2/8] tracing/osnoise: set several trace_osnoise.c variables
 storage-class-specifier to static
References: <20230319164643.513018619@goodmis.org>
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

From: Tom Rix <trix@redhat.com>

smatch reports several similar warnings
kernel/trace/trace_osnoise.c:220:1: warning:
  symbol '__pcpu_scope_per_cpu_osnoise_var' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:243:1: warning:
  symbol '__pcpu_scope_per_cpu_timerlat_var' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:335:14: warning:
  symbol 'interface_lock' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:2242:5: warning:
  symbol 'timerlat_min_period' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:2243:5: warning:
  symbol 'timerlat_max_period' was not declared. Should it be static?

These variables are only used in trace_osnoise.c, so it should be static

Link: https://lore.kernel.org/linux-trace-kernel/20230309150414.4036764-1-trix@redhat.com

Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 04f0fdae19a1..9176bb7a9bb4 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -217,7 +217,7 @@ struct osnoise_variables {
 /*
  * Per-cpu runtime information.
  */
-DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
+static DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
 
 /*
  * this_cpu_osn_var - Return the per-cpu osnoise_variables on its relative CPU
@@ -240,7 +240,7 @@ struct timerlat_variables {
 	u64			count;
 };
 
-DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
+static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
 
 /*
  * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
@@ -332,7 +332,7 @@ struct timerlat_sample {
 /*
  * Protect the interface.
  */
-struct mutex interface_lock;
+static struct mutex interface_lock;
 
 /*
  * Tracer data.
@@ -2239,8 +2239,8 @@ static struct trace_min_max_param osnoise_print_stack = {
 /*
  * osnoise/timerlat_period: min 100 us, max 1 s
  */
-u64 timerlat_min_period = 100;
-u64 timerlat_max_period = 1000000;
+static u64 timerlat_min_period = 100;
+static u64 timerlat_max_period = 1000000;
 static struct trace_min_max_param timerlat_period = {
 	.lock	= &interface_lock,
 	.val	= &osnoise_data.timerlat_period,
-- 
2.39.1
