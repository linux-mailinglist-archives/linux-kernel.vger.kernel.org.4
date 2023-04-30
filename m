Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C36F2A60
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 21:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjD3TBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 15:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3TBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 15:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2503D1BD5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682881233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPGpc4sz+9Nz9cOOaOox7Yqqqw3srJbqMl4YmzfUBsY=;
        b=Wqxcw+KVYIdzq5uUD0pNkrikPw6bR82zwszNEE24HaBX7QjaVeooFJpaG/UZRywIwsmRL1
        27U7KqboPe00cX7urCRY74Zl6MXKIRmQn4DEJmkDs1yqDqf5BnUzxgmoloikE7LGr4qr0s
        jsBCoJsSZFFgwjPhvbZOMXzNLlKgC7M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-JK5xjE3dNOCfg9bNWMJJlQ-1; Sun, 30 Apr 2023 15:00:31 -0400
X-MC-Unique: JK5xjE3dNOCfg9bNWMJJlQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD4573C0E213;
        Sun, 30 Apr 2023 19:00:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.26])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0E54940C6EC4;
        Sun, 30 Apr 2023 19:00:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 30 Apr 2023 21:00:19 +0200 (CEST)
Date:   Sun, 30 Apr 2023 21:00:16 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Josh Poimboeuf' <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vernon Lovejoy <vlovejoy@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/show_trace_log_lvl: ensure stack pointer is aligned,
 again
Message-ID: <20230430190016.GB606@redhat.com>
References: <20230427140054.GA17800@redhat.com>
 <20230428043158.r5omehiaqawcac2y@treble>
 <20230428065513.GA22111@redhat.com>
 <20230428235747.b5smutdttv5eeopi@treble>
 <aa8537d81dc747a097e9e30491b5081b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8537d81dc747a097e9e30491b5081b@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30, David Laight wrote:
>
> From: Josh Poimboeuf
> > Sent: 29 April 2023 00:58
> > 
> > On Fri, Apr 28, 2023 at 08:55:13AM +0200, Oleg Nesterov wrote:
> > > On 04/27, Josh Poimboeuf wrote:
> > > >
> > > > On Thu, Apr 27, 2023 at 04:00:54PM +0200, Oleg Nesterov wrote:
> > > > > +	stack = PTR_ALIGN(stack, sizeof(long));
> > > > >  	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> > > > >  		const char *stack_name;
> > > >
> > > > Seems reasonable, though 'stack' is already initialized a few lines
> > > > above this, so it would be cleaner to do the PTR_ALIGN then.  Or even
> > > > better, just move it all to the for loop:
> > > >
> > > > 	for (stack = PTR_ALIGN(stack ? : get_stack_pointer(task, regs));
> > > > 	     stack;
> > > > 	     stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> > >
> > > We decided to make the simplest one-liner fix, but I was thinking about
> > >
> > > 	for ( stack = stack ? : get_stack_pointer(task, regs);
> > > 	     (stack = PTR_ALIGN(stack, sizeof(long)));
> > > 	      stack = stack_info.next_sp)
> > > 	{
> > > 		...
> > >
> > > to factout out the annoying PTR_ALIGN(). Will it work for you?
> >
> > I'd rather not, that's a little *too* clever, IMO.
>
> I'd leave the initialisation outside the loop and move
> the PTR_ALIGN() into the loop so that the 'for' fits on one line:
> 	if (!stack)
> 		stack = get_stack_pointer(task, regs);
> 	for (; stack; stack = stack_info.next_sp) {
> 		const char ...
> 		stack = PTR_ALIGN(stack, sizeof(long));

Well to me this looks better than V2 I've sent. Although to be honest I'd
prefer the initial one-liner fix, but this doesn't mater.

I am fine either way, I guess Vernon too. So I leave this to you and Josh,
please tell us if we should send V3 or not.

Oleg.

