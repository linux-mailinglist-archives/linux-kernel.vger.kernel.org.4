Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E551D5E585D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIVCHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIVCHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB3898D1F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DE0C62E20
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E0CC433D6;
        Thu, 22 Sep 2022 02:06:58 +0000 (UTC)
Date:   Wed, 21 Sep 2022 22:08:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: Use proper do_arch_spin_lock() API
Message-ID: <20220921220800.02c4c63e@gandalf.local.home>
In-Reply-To: <3789bf4d-d699-63d4-c97b-c8d9524cbc2f@redhat.com>
References: <20220921132152.1622616-1-longman@redhat.com>
        <20220921132152.1622616-3-longman@redhat.com>
        <20220921181721.3a51afe9@gandalf.local.home>
        <3789bf4d-d699-63d4-c97b-c8d9524cbc2f@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 21:48:41 -0400
Waiman Long <longman@redhat.com> wrote:

> On 9/21/22 18:17, Steven Rostedt wrote:
> >>   	savedcmd_temp = savedcmd;
> >>   	savedcmd = s;
> >> -	arch_spin_unlock(&trace_cmdline_lock);
> >> +	do_arch_spin_unlock(&trace_cmdline_lock);
> >>   	free_saved_cmdlines_buffer(savedcmd_temp);
> >>   
> >>   	return 0;
> >> @@ -6373,10 +6369,10 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
> >>   
> >>   #ifdef CONFIG_TRACER_SNAPSHOT
> >>   	if (t->use_max_tr) {
> >> -		arch_spin_lock(&tr->max_lock);
> >> +		do_arch_spin_lock(&tr->max_lock);  
> > Add preemption disabling.
> >  
> The pattern that I have seen so far is to disable preemption for 
> trace_cmdline_lock, but interrupt for max_lock. So should we also 
> disable interrupt here instead of preemption?
> 

Ah yes.

Thanks,

-- Steve
