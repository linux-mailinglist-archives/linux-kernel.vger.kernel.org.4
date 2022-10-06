Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB025F6351
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiJFJIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiJFJIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:08:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9FC97EDB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AFCFB82062
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158E1C433C1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665047326;
        bh=SCoqS5eS6YE/AaM9otUbiginKmtjmNFJKRyykjM1IOk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pZlEAjPoF6mpa8RZIq9TvZU6BNMFdfAcfzP/xBAZ+70Lv2I6huG3ZHilhbrOCkfxE
         3KQP7w5rzKhymlPH1b5xInc671ZME9OCHZuPKB4R+UB0r46YbZdzXw0D2VsoiVJ/se
         7WkoUAA/+xpzQvtkuhShubzQjkKiRBhwSqPIX1jsj1V6d5y7afVdc0XchQ0fsBzi7p
         wjxQoid2VuQK/RS/R7+HgA8KDZFF8zt5DHp8O3t2QdKbP/jSoPQER8wWhfL44JXg7Z
         I7ouXUf3usci3/aVN4QcnJ7VUGF/5z+L0TKaVEfnK0DQe8qMF8PTwVNOjbooYlDSw/
         8A+YoC8oMMXtQ==
Received: by mail-lf1-f49.google.com with SMTP id g1so1725709lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:08:45 -0700 (PDT)
X-Gm-Message-State: ACrzQf0lCYrJS7/RoqOy5ZmqWswBD8WsjuSOutztcZP0REy58xPiiCtQ
        TN3cGHiewa/LQKXxYlZr/SKwDfvSK3X1jRjtyVM=
X-Google-Smtp-Source: AMsMyM7AOb9QrCzFf8WgjJca1KrbMRTJ/avD7fs3zNtgZo48Pud5Adz8r24Rw6EopBNDjaFjfwZSNIWssfbNUd3LH6Y=
X-Received: by 2002:ac2:4d1c:0:b0:4a2:4119:f647 with SMTP id
 r28-20020ac24d1c000000b004a24119f647mr1355428lfi.426.1665047324034; Thu, 06
 Oct 2022 02:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221006075542.2658-1-jszhang@kernel.org> <20221006075542.2658-2-jszhang@kernel.org>
 <CAMj1kXEWm9WuvxYN8ks09m3Rv+pt1Hd7=DcXuTwm+Etw2Y-KOQ@mail.gmail.com> <Yz6V2Ffm5jSJJa1V@xhacker>
In-Reply-To: <Yz6V2Ffm5jSJJa1V@xhacker>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 Oct 2022 11:08:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEdq+9BdFSD0CRgBVef9PJ=tAbhkRzkKz87CYomigr59Q@mail.gmail.com>
Message-ID: <CAMj1kXEdq+9BdFSD0CRgBVef9PJ=tAbhkRzkKz87CYomigr59Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: jump_label: mark arguments as const to satisfy
 asm constraints
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 at 10:55, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Thu, Oct 06, 2022 at 10:17:44AM +0200, Ard Biesheuvel wrote:
> > On Thu, 6 Oct 2022 at 10:05, Jisheng Zhang <jszhang@kernel.org> wrote:
> > >
> > > Inspired by x86 commit 864b435514b2("x86/jump_label: Mark arguments as
> > > const to satisfy asm constraints"), mark arch_static_branch()'s and
> > > arch_static_branch_jump()'s arguments as const to satisfy asm
> > > constraints. And Steven in [1] also pointed out that "The "i"
> > > constraint needs to be a constant."
> > >
> > > Tested with building a simple external kernel module with "O0".
> > >
> > > [1]https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/
> > >
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/jump_label.h | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> > > index cea441b6aa5d..48ddc0f45d22 100644
> > > --- a/arch/arm64/include/asm/jump_label.h
> > > +++ b/arch/arm64/include/asm/jump_label.h
> > > @@ -15,8 +15,8 @@
> > >
> > >  #define JUMP_LABEL_NOP_SIZE            AARCH64_INSN_SIZE
> > >
> > > -static __always_inline bool arch_static_branch(struct static_key *key,
> > > -                                              bool branch)
> > > +static __always_inline bool arch_static_branch(struct static_key * const key,
> > > +                                              const bool branch)
> > >  {
> > >         asm_volatile_goto(
> > >                 "1:     nop                                     \n\t"
> >
> > Is this still necessary if we specify the constraints in a more
> > reasonable manner:
> >
> >  "      .quad           %c0 - . + %1            \n\t"
> >  :  :  "i"(key), "i"(branch) :  : l_yes);
>
> Just tried this locally with the simple external kernel module, the
> asm operand 0 probably does not match constraints can still be
> reproduced with "O0".
>

OK so the key pointer needs to be pointer-to-const, which makes sense.
How about when using "Si" as the constraint for operand 0?


>
> >
> > instead of the horrid hack with the char* cast and using a bool as an
> > array index?
> >
> >
> >
> >
> > > @@ -32,8 +32,8 @@ static __always_inline bool arch_static_branch(struct static_key *key,
> > >         return true;
> > >  }
> > >
> > > -static __always_inline bool arch_static_branch_jump(struct static_key *key,
> > > -                                                   bool branch)
> > > +static __always_inline bool arch_static_branch_jump(struct static_key * const key,
> > > +                                                   const bool branch)
> > >  {
> > >         asm_volatile_goto(
> > >                 "1:     b               %l[l_yes]               \n\t"
> > > --
> > > 2.37.2
> > >
