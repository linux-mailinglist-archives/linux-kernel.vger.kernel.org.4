Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453E460384B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJSCz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJSCz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:55:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5408E5ECF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66DA0B821EB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6F9C43142
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666148123;
        bh=5kYqembv+YpjeHp7+ryb4q5hAFpoO+zim4SanD/yA2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lg5nneR05pA7Uyp/6yDHLQ0lv/FvSCJgKB9zgsPhYW97lwtHHW0sCoNOxth3WHcqn
         LIffbmGZD9n3wYxVIkeFA9JGT376Q0vySQRT+iUihgiq4Sd/Rv4D6uIriY41E3TjAi
         gNjbHLPrz7jwQLM8hVo6pF3wWrOCQKj+/foh3wo/Qu9OKdeoKMgPr5lhUNZL93Z5b3
         8TnR1QQZ2PfHpt7GF8jKRqR7bIZdouX2tq6HjcxC+Ag0fNhkEsSACG+yebLs79DZbC
         /ECaOjoyOL8Ej3mbchEVWDoI7hMajnEn85fSQgnnaechD2ZiopfRde+NBkdD5fcGZA
         vXEwdW2bcH8Rg==
Received: by mail-ot1-f41.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so8748124otb.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:55:23 -0700 (PDT)
X-Gm-Message-State: ACrzQf1taT9YoGICX7FnDBIlvl3r1UAkZKrfAtxmGc6aAgVyO+pV2X3e
        0aaWWL5b8cIXJXe2UMbYpCy7m7SEjhlVCZdi6ts=
X-Google-Smtp-Source: AMsMyM5C2i3Ly90Zfv1TFQiVbzhvl/qqipUlQgQ5lvq37RcRpl/8aSWNrQoateRH2fQeJuj+TJ+GtxnpltGYrkmr3Ko=
X-Received: by 2002:a9d:60dd:0:b0:661:b6ae:aa7a with SMTP id
 b29-20020a9d60dd000000b00661b6aeaa7amr2779172otk.140.1666148122239; Tue, 18
 Oct 2022 19:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220928162007.3791-1-jszhang@kernel.org> <20220928162007.3791-5-jszhang@kernel.org>
 <CAJF2gTTADq-JpUtitSr0nw1aDPZrsB6f1jA-04WmOVcrxYeakw@mail.gmail.com> <YzXBZnGXQdEGR1LW@xhacker>
In-Reply-To: <YzXBZnGXQdEGR1LW@xhacker>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 19 Oct 2022 10:55:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTonVbTAJGw3qHdfK5vKkHRX64hJB757zsiNgWq4y0Xmw@mail.gmail.com>
Message-ID: <CAJF2gTTonVbTAJGw3qHdfK5vKkHRX64hJB757zsiNgWq4y0Xmw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] riscv: entry: consolidate general regs saving into save_gp
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 12:11 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Thu, Sep 29, 2022 at 11:59:00AM +0800, Guo Ren wrote:
> > On Thu, Sep 29, 2022 at 12:29 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> > >
> > > Consolidate the saving/restoring GPs(except ra, sp and tp) into
> > > save_gp/restore_gp macro.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/asm.h   | 65 +++++++++++++++++++++++++
> > >  arch/riscv/kernel/entry.S      | 87 ++--------------------------------
> > >  arch/riscv/kernel/mcount-dyn.S | 58 +----------------------
> > >  3 files changed, 70 insertions(+), 140 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> > > index 1b471ff73178..2f3b49536e9d 100644
> > > --- a/arch/riscv/include/asm/asm.h
> > > +++ b/arch/riscv/include/asm/asm.h
> > > @@ -68,6 +68,7 @@
> > >  #endif
> > >
> > >  #ifdef __ASSEMBLY__
> > > +#include <asm/asm-offsets.h>
> > >
> > >  /* Common assembly source macros */
> > >
> > > @@ -80,6 +81,70 @@
> > >         .endr
> > >  .endm
> > >
> > > +       /* save all GPs except ra, sp and tp */
> > > +       .macro save_gp
> > How about leave x3(gp) out of the macro, and define:
> > .marco save_from_x5_to_x31
> > .marco restore_from_x5_to_x31
>
> Good idea, will do in next version.

Where is the next version?

I want to involve the patch in my generic entry series, it would help
in the coding convention of the entry code.

>
> Thanks



-- 
Best Regards
 Guo Ren
