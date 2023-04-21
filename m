Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D709A6EA4AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjDUH1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjDUH1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:27:46 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBBFD132;
        Fri, 21 Apr 2023 00:27:44 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pplBD-0004sS-00; Fri, 21 Apr 2023 09:27:39 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E0BBCC0121; Fri, 21 Apr 2023 09:27:12 +0200 (CEST)
Date:   Fri, 21 Apr 2023 09:27:12 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, jpoimboe@kernel.org,
        peterz@infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH] MIPS: Mark check_bugs{,_early}() as __init
Message-ID: <20230421072712.GA5563@alpha.franken.de>
References: <20230419-mips-check_bugs-init-attribute-v1-1-91e6eed55b89@kernel.org>
 <CAKwvOdmuQBnZR_pB5bUdsF+OoB_4pxBT9TNFF83fZhzwZ1gbxw@mail.gmail.com>
 <20230419233710.GA1314058@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419233710.GA1314058@dev-arch.thelio-3990X>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 04:37:10PM -0700, Nathan Chancellor wrote:
> > > diff --git a/arch/mips/include/asm/bugs.h b/arch/mips/include/asm/bugs.h
> > > index d72dc6e1cf3c..9b9bf9bc7d24 100644
> > > --- a/arch/mips/include/asm/bugs.h
> > > +++ b/arch/mips/include/asm/bugs.h
> > > @@ -24,13 +24,13 @@ extern void check_bugs64_early(void);
> > >  extern void check_bugs32(void);
> > >  extern void check_bugs64(void);
> > >
> > > -static inline void check_bugs_early(void)
> > > +static inline void __init check_bugs_early(void)
> > >  {
> > >         if (IS_ENABLED(CONFIG_CPU_R4X00_BUGS64))
> > >                 check_bugs64_early();
> > >  }
> > 
> > If the only call site is in arch/mips/kernel/setup.c, then perhaps we
> > can move the definition of check_bugs_early there and mark it static
> > __init and drop inline?
> 
> Sure, we could even go a step further and just copy the body into the
> one call site ourselves, I see little reason for this to be a dedicated
> function. That is probably best done in a separate patch altogether in
> lieu of just adding __init.

I don't expect any new checks added to check_bugs_early so let's
move the whole function into the call site.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
