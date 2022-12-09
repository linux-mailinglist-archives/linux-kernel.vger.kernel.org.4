Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90037648424
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLIOuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLIOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:50:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DAD60B74
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:49:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2646B82879
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 14:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815E9C433EF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670597387;
        bh=4xslH6JmOTECk7jUodalEZzuelwitLamqkoVFLf4c0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YtShiEscG/wfOTFrnXehlpT2k4F/TOP3usffEXo6EmKV8YKAl6s3qQanUiu1YkHiZ
         4NW9PenUhY625U13GT5Nkg9EJB/TFORZbf8Ef9JJ3sT/KThl1/IvWsEv82ScTEeKCK
         aukiMAbTsTl7PQ3ZJvZExK0RIgMdfGGPMfC5ajBObxW1ADRCGuFPvM8LGAV2Q8Kixn
         igKYbwt24m9Y4fHeWkpMdbSNQdb5U0+PnGP/3O1A6vn+naigd8k9auECIBiWbeWIlU
         sjP3pd2cd7xtFWYowgUnZh0da4SXY4MH0pbplAw6Jq+eMki9arTx1/BAV2ONzBdsl0
         o9WOgenqIE0IA==
Received: by mail-lj1-f173.google.com with SMTP id a19so5181701ljk.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:49:47 -0800 (PST)
X-Gm-Message-State: ANoB5pl2Nly5Wbie7hq6CBGqFEPJSQgfZ+mOnZruREbk+xhNXF/Df9nU
        wluNHwkqPr8GeHuwQH8Xv+4NraKDFwTv3qlmcHw=
X-Google-Smtp-Source: AA0mqf4edDlV4fh4DmAp9nCKK68wJJhkRTAa2tM3aymG/nWAb7g33C3TER3BcvOn9vstb/xbL9kie1lu/gt8hqSUYsE=
X-Received: by 2002:a05:651c:1601:b0:277:3a1:e86d with SMTP id
 f1-20020a05651c160100b0027703a1e86dmr26941061ljq.152.1670597385513; Fri, 09
 Dec 2022 06:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20221209060740.2785164-1-agordeev@linux.ibm.com>
 <CAMj1kXF5OR6TGhCrxYCmrnA=CTAfkGcga8BDE2Vj3rixgi7U3w@mail.gmail.com>
 <Y5Murs1nSi45xEuK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAMj1kXEW-m4Z=wt0S-drRCD0naKrQk07hcONdQTRZJGmHYRY-Q@mail.gmail.com> <Y5NKpudEBjfD2K+N@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y5NKpudEBjfD2K+N@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Dec 2022 15:49:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG_FeUa4H2kdgaLV=U8GniR0nK-oeB4hV7wuia6kt_e3w@mail.gmail.com>
Message-ID: <CAMj1kXG_FeUa4H2kdgaLV=U8GniR0nK-oeB4hV7wuia6kt_e3w@mail.gmail.com>
Subject: Re: [PATCH] jump_label: explicitly annotate inittext labels as init
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2022 at 15:48, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> On Fri, Dec 09, 2022 at 02:48:49PM +0100, Ard Biesheuvel wrote:
> > On Fri, 9 Dec 2022 at 13:49, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> > >
> > > On Fri, Dec 09, 2022 at 10:41:55AM +0100, Ard Biesheuvel wrote:
> > > > > diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> > > > > index 714ac4c3b556..77680665d374 100644
> > > > > --- a/kernel/jump_label.c
> > > > > +++ b/kernel/jump_label.c
> > > > > @@ -481,13 +481,16 @@ void __init jump_label_init(void)
> > > > >
> > > > >         for (iter = iter_start; iter < iter_stop; iter++) {
> > > > >                 struct static_key *iterk;
> > > > > +               unsigned long addr;
> > > > >                 bool in_init;
> > > > >
> > > > >                 /* rewrite NOPs */
> > > > >                 if (jump_label_type(iter) == JUMP_LABEL_NOP)
> > > > >                         arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
> > > > >
> > > > > -               in_init = init_section_contains((void *)jump_entry_code(iter), 1);
> > > > > +               addr = jump_entry_code(iter);
> > > > > +               in_init = init_section_contains((void *)addr, 1) ||
> > > > > +                         is_kernel_inittext(addr);
> > > >
> > > > Isn't it sufficient to only call is_kenel_inittext here?
> > >
> > > I am not sure every arch out there would stick to putting
> > > init code to inittext only.
> > >
> > > However, should not is_kernel_exittext() (which does not
> > > exist) also get checked here?
> >
> > No, exittext either exists or it doesn't, rather than disappearing at
> > runtime like inittext.
>
> May be just swap the order of init_section_contains() and
> is_kernel_inittext() checks then?

No I don't think we need both.
