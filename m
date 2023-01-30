Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC1F681AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbjA3TiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbjA3TiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106340BFF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675107437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iRSQN5/L7bEE3ed7pm8jn+u620qpw2qg0aSU5e5+V5A=;
        b=Q+mRGe1L4WVrrQNKBejPQ7OAgoqPpBJ0y+WASOzsoA5vgVpXB1TxsRpFXmSj64ITzU1OsM
        2nWGalutuei1NPSeSekDEnqFOHWflT652Y6v+uaitwMgtQ/pYUYp6p99IuI8SK+TSflhAW
        0tbE5+2dVnTvkG4taSiBhZP0kxw9Cvo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-6-T_cEugAhPtKpm-xXoASZwA-1; Mon, 30 Jan 2023 14:37:14 -0500
X-MC-Unique: T_cEugAhPtKpm-xXoASZwA-1
Received: by mail-qv1-f70.google.com with SMTP id lp6-20020a056214590600b0053a07384c95so3747206qvb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRSQN5/L7bEE3ed7pm8jn+u620qpw2qg0aSU5e5+V5A=;
        b=dOUhdVd1Vj/8w8rk5rlhYYry29NUjhrYOec64a4Y7ETZKToocXVMvdvzkndNoglbGR
         6rVRkDKpRgSVQZLBsbXFSyqyDSEEaQdRXC4hmJeA+jYqnMNcPvG7q0OJFUDWVN0KJ7Gb
         cgw/SE60K1jhO6D6fGtsyFQTuUdQyKnl7srlmA9kS5cQ+WKe2rLR9AavrySdw6Lwmj2x
         Lh4JiKvaoIOGRgwz4D9U1+TMn71XRRvxfKVknJrk8Vq+6Ok5FQbckRT+DZQlveex5WVx
         L8ZqVayJUK7a/HlZPLycjtrB8l5+Wi1JlLq42AaeoVInO41LXWt9KKuTlwd6yobgnEop
         zIpA==
X-Gm-Message-State: AO0yUKX3Xwdf2WdHS3BkcWb5ROeB3FRtTop9NVDaobdlQMjauqA3+LVg
        ebF2yMbw925SPsJIjwQp8ysL3nT5zQ68JS1ptoOcAQCfU3TrAFkLPkxq68edf4nAraS9DX6Pj07
        bVumVE6vBsQrgU3Ea5PYDd5Sa
X-Received: by 2002:a05:622a:1008:b0:3b8:73c:15e6 with SMTP id d8-20020a05622a100800b003b8073c15e6mr37046134qte.18.1675107433502;
        Mon, 30 Jan 2023 11:37:13 -0800 (PST)
X-Google-Smtp-Source: AK7set9hTwciE89kW9G1USpz2AsDZXlnJeMZKGsvliD+KAOUZgbUQkV5hSbiU+q0+ZII6t+TWLarzA==
X-Received: by 2002:a05:622a:1008:b0:3b8:73c:15e6 with SMTP id d8-20020a05622a100800b003b8073c15e6mr37046108qte.18.1675107433234;
        Mon, 30 Jan 2023 11:37:13 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p64-20020a374243000000b006ee8874f5fasm8499120qka.53.2023.01.30.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:37:12 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] samples: ftrace: make some global variables static
Date:   Mon, 30 Jan 2023 11:37:08 -0800
Message-Id: <20230130193708.1378108-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports this representative issue
samples/ftrace/ftrace-ops.c:15:14: warning: symbol 'nr_function_calls' was not declared. Should it be static?

The nr_functions_calls and several other global variables are only
used in ftrace-ops.c, so they should be static.
Remove the instances of initializing static int to 0.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 samples/ftrace/ftrace-ops.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
index 24deb51c7261..5e891a995dd3 100644
--- a/samples/ftrace/ftrace-ops.c
+++ b/samples/ftrace/ftrace-ops.c
@@ -12,7 +12,7 @@
  * Arbitrary large value chosen to be sufficiently large to minimize noise but
  * sufficiently small to complete quickly.
  */
-unsigned int nr_function_calls = 100000;
+static unsigned int nr_function_calls = 100000;
 module_param(nr_function_calls, uint, 0);
 MODULE_PARM_DESC(nr_function_calls, "How many times to call the relevant tracee");
 
@@ -21,7 +21,7 @@ MODULE_PARM_DESC(nr_function_calls, "How many times to call the relevant tracee"
  * be called directly or whether it's necessary to go via the list func, which
  * can be significantly more expensive.
  */
-unsigned int nr_ops_relevant = 1;
+static unsigned int nr_ops_relevant = 1;
 module_param(nr_ops_relevant, uint, 0);
 MODULE_PARM_DESC(nr_ops_relevant, "How many ftrace_ops to associate with the relevant tracee");
 
@@ -30,7 +30,7 @@ MODULE_PARM_DESC(nr_ops_relevant, "How many ftrace_ops to associate with the rel
  * tracers enabled for distinct functions can force the use of the list func
  * and incur overhead for all call sites.
  */
-unsigned int nr_ops_irrelevant = 0;
+static unsigned int nr_ops_irrelevant;
 module_param(nr_ops_irrelevant, uint, 0);
 MODULE_PARM_DESC(nr_ops_irrelevant, "How many ftrace_ops to associate with the irrelevant tracee");
 
@@ -38,15 +38,15 @@ MODULE_PARM_DESC(nr_ops_irrelevant, "How many ftrace_ops to associate with the i
  * On architectures with DYNAMIC_FTRACE_WITH_REGS, saving the full pt_regs can
  * be more expensive than only saving the minimal necessary regs.
  */
-bool save_regs = false;
+static bool save_regs;
 module_param(save_regs, bool, 0);
 MODULE_PARM_DESC(save_regs, "Register ops with FTRACE_OPS_FL_SAVE_REGS (save all registers in the trampoline)");
 
-bool assist_recursion = false;
+static bool assist_recursion;
 module_param(assist_recursion, bool, 0);
 MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RECURSION");
 
-bool assist_rcu = false;
+static bool assist_rcu;
 module_param(assist_rcu, bool, 0);
 MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RCU");
 
@@ -55,7 +55,7 @@ MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RCU");
  * overhead. Sometimes a consistency check using a more expensive tracer is
  * desireable.
  */
-bool check_count = false;
+static bool check_count;
 module_param(check_count, bool, 0);
 MODULE_PARM_DESC(check_count, "Check that tracers are called the expected number of times\n");
 
@@ -64,7 +64,7 @@ MODULE_PARM_DESC(check_count, "Check that tracers are called the expected number
  * runs, but sometimes it can be useful to leave them registered so that they
  * can be inspected through the tracefs 'enabled_functions' file.
  */
-bool persist = false;
+static bool persist;
 module_param(persist, bool, 0);
 MODULE_PARM_DESC(persist, "Successfully load module and leave ftrace ops registered after test completes\n");
 
@@ -114,8 +114,8 @@ static void ops_func_count(unsigned long ip, unsigned long parent_ip,
 	self->count++;
 }
 
-struct sample_ops *ops_relevant;
-struct sample_ops *ops_irrelevant;
+static struct sample_ops *ops_relevant;
+static struct sample_ops *ops_irrelevant;
 
 static struct sample_ops *ops_alloc_init(void *tracee, ftrace_func_t func,
 					 unsigned long flags, int nr)
@@ -163,8 +163,8 @@ static void ops_check(struct sample_ops *ops, int nr,
 	}
 }
 
-ftrace_func_t tracer_relevant = ops_func_nop;
-ftrace_func_t tracer_irrelevant = ops_func_nop;
+static ftrace_func_t tracer_relevant = ops_func_nop;
+static ftrace_func_t tracer_irrelevant = ops_func_nop;
 
 static int __init ftrace_ops_sample_init(void)
 {
-- 
2.26.3

