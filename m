Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3EA60D3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiJYSrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiJYSq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:46:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C648F26F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DX8GeZD+7wIauIxcml5zJGVF3YPfTLq0mBVS5tuc9VM=; b=Q+69t2hWlib0hjKDIuhez4Wu8Z
        wy5GuV/BhVxQxDtgWAa65Yaw6pYGVY8U7VAQ/7Kt9UeKOHfNq4aF4rNMAiskyOWck7ep3c7Tz55rl
        bc4lnjTy46vDyO95b7xVtCFWWzm43B+JHKftxk0N0jtv5JV368bzZ+dor6bUCiqIH8WQmD0gN/s9/
        dFkxou5+TxQhorrLIDlkouc7VJGboKDoA5z2TQkBzpdWT2wQUV078uG9oindo4bxJX3dhcF2Xg0Cl
        CVLEiWJ9EHEvwXh7+UTJhCEc54D/7aN9VBoMtJE5MZMGPAksDQ+J/svMogrInNVS7h77UR0Vczkic
        uWINwXwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onOwX-006NMi-0T; Tue, 25 Oct 2022 18:46:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD63F30020C;
        Tue, 25 Oct 2022 20:46:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C77342C450017; Tue, 25 Oct 2022 20:46:27 +0200 (CEST)
Date:   Tue, 25 Oct 2022 20:46:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
Message-ID: <Y1gvA9gHUIiQFogw@hirez.programming.kicks-ass.net>
References: <20221024114536.44686c83@gandalf.local.home>
 <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
 <20221024145250.08cfc147@gandalf.local.home>
 <CAHk-=wjRpCS3oAJHVfByDoaj0-tAhV5a5YKV7QssUdMOAm8bAg@mail.gmail.com>
 <Y1eu2wFVp1zcLg5b@hirez.programming.kicks-ass.net>
 <Y1e3i3RJRxOHTcJS@hirez.programming.kicks-ass.net>
 <CAHk-=wjwjWAhPD=C7sW7804eOTSQRnpSrrQh44PFYpVjn8SjKg@mail.gmail.com>
 <Y1ghRheOJeAfJvdY@hirez.programming.kicks-ass.net>
 <CAHk-=wgvuanYPtndJR2iDpn60ry4FMueEg2DCRdQresvkdRgHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgvuanYPtndJR2iDpn60ry4FMueEg2DCRdQresvkdRgHQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:14:07AM -0700, Linus Torvalds wrote:
> On Tue, Oct 25, 2022 at 10:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > mm_alloc() uses allocate_mm() which requires a kmem_cache to be set-up.
> 
> Well, that seems to be just a strange effect of mm_cachep being set up
> by the oddly named "proc_caches_init" (I say oddly named because these
> days I associate "proc" with proc-fs, but I think it actually comes
> from "process").
> 
> That would actually probably make more sense if it was part of
> mm_init(), much earlier (where we do "kmem_cache_init()")
> 
> So this is another oddity in how we do "mm_init()", but we haven't
> actually initialized _that_ part of the mm setup.
> 
> Extra bonus points for another strange thing: we have "fork_init()",
> but that too doesn't actually initialize the mm_cachep that fork()
> actually uses. It does initialize the process one
> (task_struct_cachep). So that kind of makes sense, but yeah, the
> mm_alloc() cachep should have been set up by mm_init.
> 
> I think this is all "we just ended up randomly initializing things due
> to hysterical raisins"

OK, I'll go make all that happen.
