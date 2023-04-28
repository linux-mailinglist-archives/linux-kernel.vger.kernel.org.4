Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638946F1743
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjD1MIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345965AbjD1MIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:08:09 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D2345B88;
        Fri, 28 Apr 2023 05:07:56 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1psMro-0007Uh-00; Fri, 28 Apr 2023 14:06:24 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AEDC2C02E0; Fri, 28 Apr 2023 14:06:18 +0200 (CEST)
Date:   Fri, 28 Apr 2023 14:06:18 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     genjian zhang <zhanggenjian123@gmail.com>
Cc:     rdunlap@infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH v2] fix ___SYNC () build error when PROFILE_ALL_BRANCHES
 is enabled
Message-ID: <20230428120618.GA11325@alpha.franken.de>
References: <CAOd03yRAmPULzi8fYTnukCpRPHa1Zsv5ZFFeQRcQ7B1abQCGqA@mail.gmail.com>
 <20230427150332.2978867-1-zhanggenjian@kylinos.cn>
 <CAOd03yTc3+Sa4zsPQCu3dHiJfuUf-kOMxeUH6rm4u4Z6Hv2BQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOd03yTc3+Sa4zsPQCu3dHiJfuUf-kOMxeUH6rm4u4Z6Hv2BQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 03:13:32PM +0800, genjian zhang wrote:
> On Thu, Apr 27, 2023 at 11:05 PM Genjian <zhanggenjian123@gmail.com> wrote:
> >
> > From: Genjian Zhang <zhanggenjian@kylinos.cn>
> >
> > compiler error (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110):
> >
> > {standard input}: Assembler messages:
> > {standard input}:171: Error: found '(', expected: ')'
> > {standard input}:171: Error: found '(', expected: ')'
> > {standard input}:171: Error: non-constant expression in ".if" statement
> > {standard input}:171: Error: junk at end of line, first unrecognized
> > character is `('
> >
> > Expands ___SYNC() macros. However, 'if' statement will be wrong
> > assembly.This Compilers report a lot of errors like the above.
> > this problem is caused by the #define of if() in
> > include/linux/compiler.h when CONFIG_PROFILE_ALL_BRANCHES
> > is set. Move '.if' into quoted strings to fix it.
> >
> > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> > ---
> >  arch/mips/include/asm/sync.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/sync.h b/arch/mips/include/asm/sync.h
> > index aabd097933fe..56a4f6f6cdef 100644
> > --- a/arch/mips/include/asm/sync.h
> > +++ b/arch/mips/include/asm/sync.h
> > @@ -175,7 +175,7 @@
> >   */
> >  #ifdef CONFIG_CPU_HAS_SYNC
> >  # define ____SYNC(_type, _reason, _else)                       \
> > -       .if     (( _type ) != -1) && ( _reason );               \
> > +       ((_type) != -1) && (_reason);                           \
> >         .set    push;                                           \
> >         .set    MIPS_ISA_LEVEL_RAW;                             \
> >         .rept   __SYNC_rpt(_type);                              \
> > @@ -192,13 +192,14 @@
> >  /*
> >   * Preprocessor magic to expand macros used as arguments before we insert them
> >   * into assembly code.
> > + * In addition,'if' cannot be enabled.
> >   */
> >  #ifdef __ASSEMBLY__
> >  # define ___SYNC(type, reason, else)                           \
> > -       ____SYNC(type, reason, else)
> > +       .if     ____SYNC(type, reason, else)
> >  #else
> >  # define ___SYNC(type, reason, else)                           \
> > -       __stringify(____SYNC(type, reason, else))
> > +       ".if"   __stringify(____SYNC(type, reason, else))
> >  #endif
> >
> >  #define __SYNC(type, reason)                                   \
> > --
> > 2.25.1
> >
> 
> This patch does not take into account the situation that CPU_HAS_SYNC
> is not set. I will revise it later.

please post as a new mail not as a replay to this thread.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
