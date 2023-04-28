Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1126F2173
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347019AbjD1X5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347081AbjD1X5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBBF4691
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A8A6172B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 23:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC213C433EF;
        Fri, 28 Apr 2023 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682726269;
        bh=ljx1jJWdznqccEUYrJ6+J1Ju0rsKG8Fd3TbGvNSEC1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LmR6eGa9wBBCbJPD9MgF1vqxvizQoBgfGkYBp/xPQXHDe3KWIg7uOOELr5xzPWef/
         HMz92usFRj18GMyt6DkHRpz2/6Xi2w5g4hLJgclxQjzr/5BP9hGQe6u/X1WDtq8CnO
         ZDFuUicuzbPt9KWBgKZGzTpvVwW2q+mLSYCHFhD110vZkxFN6gZFEmYLcRO+Bvu1tq
         AwMBwEE6Bi1wTnAj4Py5oTY8S2Y809bC0PIFypvjfam8oc4qA6kh1tgHGTOc7jmZuC
         z6eHj2bC3F0noauvr4nq7Z9gPPZBJLehESVErlrykZwuprdNG1pqKD5Qox0MSfknd8
         nGBVgqByNBxlg==
Date:   Fri, 28 Apr 2023 16:57:47 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vernon Lovejoy <vlovejoy@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/show_trace_log_lvl: ensure stack pointer is aligned,
 again
Message-ID: <20230428235747.b5smutdttv5eeopi@treble>
References: <20230427140054.GA17800@redhat.com>
 <20230428043158.r5omehiaqawcac2y@treble>
 <20230428065513.GA22111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230428065513.GA22111@redhat.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 08:55:13AM +0200, Oleg Nesterov wrote:
> On 04/27, Josh Poimboeuf wrote:
> >
> > On Thu, Apr 27, 2023 at 04:00:54PM +0200, Oleg Nesterov wrote:
> > > +	stack = PTR_ALIGN(stack, sizeof(long));
> > >  	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> > >  		const char *stack_name;
> >
> > Seems reasonable, though 'stack' is already initialized a few lines
> > above this, so it would be cleaner to do the PTR_ALIGN then.  Or even
> > better, just move it all to the for loop:
> >
> > 	for (stack = PTR_ALIGN(stack ? : get_stack_pointer(task, regs));
> > 	     stack;
> > 	     stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> 
> We decided to make the simplest one-liner fix, but I was thinking about
> 
> 	for ( stack = stack ? : get_stack_pointer(task, regs);
> 	     (stack = PTR_ALIGN(stack, sizeof(long)));
> 	      stack = stack_info.next_sp)
> 	{
> 		...
> 
> to factout out the annoying PTR_ALIGN(). Will it work for you?

I'd rather not, that's a little *too* clever, IMO.

-- 
Josh
