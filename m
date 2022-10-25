Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAC960C0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJYBM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiJYBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B55C4D91
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1B5661052
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51282C433D6;
        Tue, 25 Oct 2022 00:23:57 +0000 (UTC)
Date:   Mon, 24 Oct 2022 20:24:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2] x86/mm: Do not verify W^X at boot up on ftrace
 trampolines
Message-ID: <20221024202407.44a3611b@gandalf.local.home>
In-Reply-To: <CAHk-=wj-j6Lntr84Qssq1gcsUKtNU8Y=RP+0+fnLT4y38zrsPw@mail.gmail.com>
References: <20221024182545.78d638a9@gandalf.local.home>
        <CAHk-=wj-j6Lntr84Qssq1gcsUKtNU8Y=RP+0+fnLT4y38zrsPw@mail.gmail.com>
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

On Mon, 24 Oct 2022 16:58:58 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Oct 24, 2022 at 3:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > Adding on the kernel command line "ftrace=function" triggered:  
> 
> This one I *really* detest.
> 
> If we have to have a special case, make it just be the simple
> "system_state == SYSTEM_BOOTING", don't make it even nastier.
> 
> Special cases are bad. Making them these kinds of "this is
> super-magical and special" is even worse.
>

I was just trying to narrow down the one special case that allows the
one exception to get pass the security check. It's what they taught me in
security school. Only allow what you know is allowable and block everything
else.

But anyway, I'll just let anyone take the v1 patch. I'll add it to my tests
so that I can at least get my tests to finish.

-- Steve
