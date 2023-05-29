Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BC5714247
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 05:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjE2DVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 23:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjE2DVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 23:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0498BB
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 20:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62BEA61524
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E57C433EF;
        Mon, 29 May 2023 03:21:36 +0000 (UTC)
Date:   Sun, 28 May 2023 23:21:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/alternatives: Add cond_resched() to
 text_poke_bp_batch()
Message-ID: <20230528232132.14ab3201@rorschach.local.home>
In-Reply-To: <20230529115246.a61734ce4e6d7644e2faec72@kernel.org>
References: <20230528084652.5f3b48f0@rorschach.local.home>
        <20230529115246.a61734ce4e6d7644e2faec72@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 11:52:46 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +	/*
> > +	 * Function tracing can enable thousands of places that need to be
> > +	 * updated. This can take quite some time, and with full kernel debugging
> > +	 * enabled, this could cause the softlockup watchdog to trigger.
> > +	 * Add cond_resched() calls to each phase.
> > +	 */
> > +	cond_resched();  
> 
> Hmm, why don't you put this between the first step (put int3) and the
> second step (put other bytes)? I guess those would takes more time.

Ah you're right. I still want this here to clear the 'need resched'
flag before we start the process, but I did miss one after the first
loop.

Thanks for the review!

-- Steve
