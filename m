Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF664CBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbiLNOCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbiLNOCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:02:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD522BC5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:02:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0108D61AA0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A15C433AC;
        Wed, 14 Dec 2022 14:02:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p5SKn-000gvH-1Y;
        Wed, 14 Dec 2022 09:02:09 -0500
Message-ID: <20221214140209.346584113@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Dec 2022 09:01:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [for-next][PATCH 6/8] ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels
References: <20221214140133.608431204@goodmis.org>
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

From: "gpiccoli@igalia.com" <gpiccoli@igalia.com>

The function match_records() may take a while due to a large
number of string comparisons, so when in PREEMPT_VOLUNTARY
kernels we could face RCU stalls due to that.

Add a cond_resched() to prevent that.

Link: https://lkml.kernel.org/r/20221115204847.593616-1-gpiccoli@igalia.com

Cc: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org> # from RCU CPU stall warning perspective
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index d04552c0c275..b8e374a372e5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4204,6 +4204,7 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 			}
 			found = 1;
 		}
+		cond_resched();
 	} while_for_each_ftrace_rec();
  out_unlock:
 	mutex_unlock(&ftrace_lock);
-- 
2.35.1


