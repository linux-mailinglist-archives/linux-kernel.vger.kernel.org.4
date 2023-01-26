Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B878C67D98D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjAZXUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjAZXUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:20:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C4C39282
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:20:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B80FBCE2611
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB79C433D2;
        Thu, 26 Jan 2023 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674775231;
        bh=xPvjXUDySav2YucucA50vv2BpIYS0qDs++rjLiXkc94=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ncVJ9X+5FUmzZlWjp6TYXXSN7ZjQkUDe6KRiicElvgAsAxwYF2LwJdBkWxiSek1qf
         0Mv5n0/PfC4XLWV4BF/16QNgSOq4XTKQwFeDqWCXrRTN9pJcKtAMqSRFNHGFDGP0Me
         ETWYdKsbuX0rQIOKLZmAi1/wCc61mkv+h+MEWzsGrBz59xJQKre8ncrXplnwujx55t
         jy8g+pj1/IF+jsWgc/DvMfL6vQGRf6zX+riebBNobDbRcSbxEHVND7+kgKcRw8z/5J
         L210SJuaqqjslxcDxgmSaIai+DkkVshzE3szywvR8CQr9qG7sLrAXGl5mwmXLvq+1J
         zzY69SGKIFHPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7EB565C1C6D; Thu, 26 Jan 2023 15:20:31 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:20:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: Re: objtool warning from next-20230125
Message-ID: <20230126232031.GP2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230126182302.GA687063@paulmck-ThinkPad-P17-Gen-1>
 <20230126205954.zk3t4fpmxqowfu2d@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126205954.zk3t4fpmxqowfu2d@treble>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 12:59:54PM -0800, Josh Poimboeuf wrote:
> On Thu, Jan 26, 2023 at 10:23:02AM -0800, Paul E. McKenney wrote:
> > Hello!
> > 
> > I have started seeing these objtool warnings from a wide variety of
> > KASAN-enabled rcutorture-related test scenarios in next-20230125.  It has
> > been awhile since I tested -next, so I am not yet sure where this started.
> > 
> > vmlinux.o: warning: objtool: __asan_memset+0x34: call to __memset() with UACCESS enabled
> > vmlinux.o: warning: objtool: __asan_memmove+0x4d: call to __memmove() with UACCESS enabled
> > vmlinux.o: warning: objtool: __asan_memcpy+0x4d: call to __memcpy() with UACCESS enabled
> > 
> > As usual, should I be worried?
> 
> This apparently came from Peter's
> 
>   69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> 
> but I have no idea how this is supposed to work.  Peter?

I guess that I am glad that it is not just me, then.  ;-)

Thank you for tracking down the relevant commit!

							Thanx, Paul
