Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95DA65F476
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjAETa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbjAETaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:30:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC4963F75
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:24:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE51261BCD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 19:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14384C433D2;
        Thu,  5 Jan 2023 19:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672946671;
        bh=8sug4N+XOkt7hHrOlUu1is4NYUzllmpcO7ETWOyO+08=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZHpiPx1jjkVospHkCnRuOjvxSzaRhOs8AsSyrnSF/m6CGFWiOAqzY0aIi67QWs7mS
         6vNh/o/mS8aOW3nJflDyCJDk/nwh4hvOgf27yrLmv1n5XkHYVlPj2JrNXL4YY17BsF
         93KeZwIEjxsud0GFzt3jPTMcgt9bD8vg+65B5bEtLkk/WLPyy2TiPnGUlTLq3syR6/
         hXOATAdq+bZvWgb8VFyzorqCD0HtNDEOfAMnoE/GxtwARX6i8BltCIE0eYmhwV6lb2
         X5M/NX3rcH41bSXGrKMiwk7AviUwNMxcurTI88A9wvEHrfaxS49xmzbz2NqCiHWqHr
         ofErHzdteW6cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A14E85C0544; Thu,  5 Jan 2023 11:24:30 -0800 (PST)
Date:   Thu, 5 Jan 2023 11:24:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH x86/nmi 2/2] x86/nmi: Print reasons why backtrace NMIs
 are ignored
Message-ID: <20230105192430.GJ4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105011537.1774941-1-paulmck@kernel.org>
 <20230105011537.1774941-2-paulmck@kernel.org>
 <Y7apHi9A0i63X4Me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7apHi9A0i63X4Me@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 11:40:30AM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > +#ifdef CONFIG_NMI_CHECK_CPU
> > +
> > +static char *nmi_check_stall_msg[] = {
> > +/*									*/
> > +/* +--------- nsp->idt_seq_snap & 0x1: CPU is in NMI handler.		*/
> > +/* | +------ cpu_is_offline(cpu)					*/
> > +/* | | +--- nsp->idt_calls_snap != atomic_long_read(&nsp->idt_calls):	*/
> > +/* | | |	NMI handler has been invoked.				*/
> > +/* | | |								*/
> > +/* V V V								*/
> > +/* 0 0 0 */ "NMIs are not reaching exc_nmi handler",
> > +/* 0 0 1 */ "exc_nmi handler is ignoring NMIs",
> > +/* 0 1 0 */ "CPU is offline and NMIs are not reaching exc_nmi handler",
> > +/* 0 1 1 */ "CPU is offline and exc_nmi handler is legitimately ignoring NMIs",
> > +/* 1 0 0 */ "CPU is in exc_nmi handler and no further NMIs are reaching handler",
> > +/* 1 0 1 */ "CPU is in exc_nmi handler which is legitimately ignoring NMIs",
> > +/* 1 1 0 */ "CPU is offline in exc_nmi handler and no further NMIs are reaching exc_nmi handler",
> > +/* 1 1 1 */ "CPU is offline in exc_nmi handler which is legitimately ignoring NMIs",
> 
> That kind of disambiguation of why a CPU is stuck looks really useful:
> 
>    Reviewed-by: Ingo Molnar <mingo@kernel.org>

Glad you like it and thank you!  I will apply this on the next rebase.

> One small suggestion would be to do this in the messages:
> 
>    s/exc_nmi handler
>     /exc_nmi() handler
> 
> ... to make it clear that it's a regular kernel function [well, hw entry 
> handler], not a function pointer or some other indirection? No strong 
> feelings though.

Will do!  I would balk at "DEFINE_IDTENTRY_RAW(exc_nmi)", though.  ;-)

							Thanx, Paul
