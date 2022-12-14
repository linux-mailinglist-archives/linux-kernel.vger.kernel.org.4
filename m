Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1EF64CDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiLNQRt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Dec 2022 11:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbiLNQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:17:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E5214004
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:17:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7161BB8199A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 16:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93DFC433EF;
        Wed, 14 Dec 2022 16:17:43 +0000 (UTC)
Date:   Wed, 14 Dec 2022 11:17:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [for-next][PATCH 6/8] ftrace: Prevent RCU stall on
 PREEMPT_VOLUNTARY kernels
Message-ID: <20221214111742.4189bc6e@gandalf.local.home>
In-Reply-To: <20221214111544.01660987@gandalf.local.home>
References: <20221214140133.608431204@goodmis.org>
        <20221214140209.346584113@goodmis.org>
        <b95f7a3d-429a-3564-fc9e-fa05d1d551df@igalia.com>
        <20221214111544.01660987@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 11:15:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 14 Dec 2022 12:53:04 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
> > On 14/12/2022 11:01, Steven Rostedt wrote:  
> > > From: "gpiccoli@igalia.com" <gpiccoli@igalia.com>    
> > 
> > Hi Steve, would be possible to use my full name here, like: Guilherme G.
> > Piccoli <gpiccoli@igalia.com> ?  
> 
> Sure, I haven't pushed to the next repo yet.
> 
> I found the reason it didn't go into my patchwork, and did a resend via a
> "redirect", and that must have changed the from address :-/
> 

Here's the new update:

-- Steve


From d0b24b4e91fcb8408c4979888547f86be514e337 Mon Sep 17 00:00:00 2001
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Date: Tue, 15 Nov 2022 17:48:47 -0300
Subject: [PATCH] ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels

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

