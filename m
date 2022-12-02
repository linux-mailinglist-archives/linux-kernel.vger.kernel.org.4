Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113D063FD41
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiLBArL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiLBArI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:47:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC2516583
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:47:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59F46B82042
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6A6C433D6;
        Fri,  2 Dec 2022 00:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669942025;
        bh=BrzxhmEo18u5JIGHicsAa/Ptukk29YM/75IerPRpATI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vLFE8nZ+3u922wGGK4lbUrKQKoXVHkft3Uqm1vePm8L0hMywbAHT3l02vhc9jSQYT
         IUQeB4cuHbi8U4LF72bkY1LWRPVOXjodxU6l6HvYCw/caIjiz1hw0QFHyyVgSjx8fY
         TxIAp1L8YvTdj7hrUphOqYUi7FGjTGr7ZNZiIBgls4jrPdBzHNHjSSkX7n+BHiqMnS
         lxSTqVq+IqgQ84Bi65KpKHpkFejLm3SLsspKUQ7tURoW9KhJJ1TAuX62xCm1rjKqGe
         89ui9q2Sewq4wEV4EsHKwAXR1hjGWxI2Er3DxHxoTLlF8AJ7UKEpL+IW4/0cENQrbC
         THLd52y0bNkrg==
Date:   Fri, 2 Dec 2022 09:46:59 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [RFC PATCH] panic: Add new taint flag for fault injection
Message-Id: <20221202094659.4dfdda10b7f99caaa6b553a7@kernel.org>
In-Reply-To: <20221201141426.08411b29@gandalf.local.home>
References: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
        <166991263326.311919.16890937584677289681.stgit@devnote3>
        <202212010838.B0B109DA@keescook>
        <20221201114848.13a87aca@gandalf.local.home>
        <202212010852.6D4B542@keescook>
        <20221201141426.08411b29@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 14:14:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 1 Dec 2022 08:53:02 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > > Have you not been reading this thread?  
> > 
> > I skimmed it -- trying to catch up from turkey week. If this was already
> > covered, then please ignore me. It just wasn't obvious from the commit
> > log why it was included.
> 
> That's a better request :-)
> 
> That is, please add why this is needed for BPF (and also include a Link:
> tag to this thread).

OK, let me update this :)

Thank you!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
