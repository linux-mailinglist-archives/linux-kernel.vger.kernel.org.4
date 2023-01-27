Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A63367EE5D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjA0TjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjA0Tiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:38:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969B91ABEA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:38:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B29CB821C1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280DAC433D2;
        Fri, 27 Jan 2023 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674848266;
        bh=nwoh6givfuSBmXb3GCR7oK6jqFpnszFTLiwUZsLjbzQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MbiirT+5CVovD3F0K+FJCEJeiQWkLenJgi2xiqJ7sIojQ+BJCYPneuWsFdSiExlWF
         Fmu6PEIZ3uXV1wp1VHMbOgK/olcRlwf4fqdVRfPmpU30hUav8UsAxvaYBvvVMQ3tvT
         OF63tTLARfAvlole4uwUS5vFeme/6qg0Kuv5virwY18+RD+xo8APKqyxKgXWWkf217
         NpmQGr2SExy7e4VXOS+fA1AfaNSgLzSCgu8bHGLBK8bGsUs2s/lVwYVuR5WrzcFGVF
         /S0ZRmdbWdFh/yzGRhYXPWawE63h0VRlIQAhEyvAXoDMZXgZpEEs68cbfqCDAShJqb
         Si6TVieWiEVFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C6FB75C0510; Fri, 27 Jan 2023 11:37:45 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:37:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: Re: objtool warning from next-20230125
Message-ID: <20230127193745.GX2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230126182302.GA687063@paulmck-ThinkPad-P17-Gen-1>
 <20230126205954.zk3t4fpmxqowfu2d@treble>
 <Y9PAN12SPHuGL99G@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9PAN12SPHuGL99G@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 01:14:47PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 26, 2023 at 12:59:54PM -0800, Josh Poimboeuf wrote:
> > On Thu, Jan 26, 2023 at 10:23:02AM -0800, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > I have started seeing these objtool warnings from a wide variety of
> > > KASAN-enabled rcutorture-related test scenarios in next-20230125.  It has
> > > been awhile since I tested -next, so I am not yet sure where this started.
> > > 
> > > vmlinux.o: warning: objtool: __asan_memset+0x34: call to __memset() with UACCESS enabled
> > > vmlinux.o: warning: objtool: __asan_memmove+0x4d: call to __memmove() with UACCESS enabled
> > > vmlinux.o: warning: objtool: __asan_memcpy+0x4d: call to __memcpy() with UACCESS enabled
> > > 
> > > As usual, should I be worried?
> > 
> > This apparently came from Peter's
> > 
> >   69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> > 
> > but I have no idea how this is supposed to work.  Peter?
> 
> Durr.. I'm not sure why I put them in the uaccess_safe_builtin[] array.
> 
> So yeah, this reproduces using defconfig+KASAN, removing the functions
> from the array shuts it up and doesn't generate new ones -- for that
> config.
> 
> Let me try and build a few more .configs...

Again, I am glad that it is not just me...

And thank you for digging into this!

							Thanx, Paul
