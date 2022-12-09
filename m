Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147826482EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLINtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLINtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:49:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5C3663D1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:49:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38A1F62252
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93421C433F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670593742;
        bh=3jHwGrWXIaajQHLAHJv0bUIaZfGO6HeNo3DaTBSlRTs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WcW+YPI5Smt1GF7pa41c0h5ENLwPBE2tEPnasGycyhsXhw5QPrm51AJJFvSH+Zwsu
         mXADFP6GEaW1SeRAIAlN2lNOsJqbsGcDlzxMOcuhzwaa/l0T3vIkB+c/BmBDhf0Pjg
         bHfvvOXNjaTeui4fR9MC5XYZJyg/EWcDxM4YMXBghKnDbdkAUXWHzD0XFpMcIneVhg
         PIsBc7z5ZuapLj7vVbiw6vQf880gduDaQK9j3JNlqVnm+KpJyZbw3yoG6vGfKmdPJZ
         8jtPJiORW4sU7fKzijuhLKvJQP30UuTj1AAfdzo/DaCd3gqelUAjY0IpzkaXscdn8f
         AqxOa5SvgFecA==
Received: by mail-lj1-f173.google.com with SMTP id f16so4964891ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 05:49:02 -0800 (PST)
X-Gm-Message-State: ANoB5pmx+Omq3kPgWm9w7qqpW/baiB3pmE3diR8gZzEJcTc9HjBgnRnW
        THat+TAGuIXW02khCCByNzCswJfMsgJdceAU91M=
X-Google-Smtp-Source: AA0mqf4RmbRqWXip5kBY4Jq/TgDztXi+43o+fLNAOHwfZQGgIoj2nYUTaNrBeTfyRVGTLAnhRIMUZ+ShaJmRykgCDtE=
X-Received: by 2002:a05:651c:220a:b0:277:2428:3682 with SMTP id
 y10-20020a05651c220a00b0027724283682mr32090765ljq.291.1670593740662; Fri, 09
 Dec 2022 05:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20221209060740.2785164-1-agordeev@linux.ibm.com>
 <CAMj1kXF5OR6TGhCrxYCmrnA=CTAfkGcga8BDE2Vj3rixgi7U3w@mail.gmail.com> <Y5Murs1nSi45xEuK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y5Murs1nSi45xEuK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Dec 2022 14:48:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEW-m4Z=wt0S-drRCD0naKrQk07hcONdQTRZJGmHYRY-Q@mail.gmail.com>
Message-ID: <CAMj1kXEW-m4Z=wt0S-drRCD0naKrQk07hcONdQTRZJGmHYRY-Q@mail.gmail.com>
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

On Fri, 9 Dec 2022 at 13:49, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> On Fri, Dec 09, 2022 at 10:41:55AM +0100, Ard Biesheuvel wrote:
> > > diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> > > index 714ac4c3b556..77680665d374 100644
> > > --- a/kernel/jump_label.c
> > > +++ b/kernel/jump_label.c
> > > @@ -481,13 +481,16 @@ void __init jump_label_init(void)
> > >
> > >         for (iter = iter_start; iter < iter_stop; iter++) {
> > >                 struct static_key *iterk;
> > > +               unsigned long addr;
> > >                 bool in_init;
> > >
> > >                 /* rewrite NOPs */
> > >                 if (jump_label_type(iter) == JUMP_LABEL_NOP)
> > >                         arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
> > >
> > > -               in_init = init_section_contains((void *)jump_entry_code(iter), 1);
> > > +               addr = jump_entry_code(iter);
> > > +               in_init = init_section_contains((void *)addr, 1) ||
> > > +                         is_kernel_inittext(addr);
> >
> > Isn't it sufficient to only call is_kenel_inittext here?
>
> I am not sure every arch out there would stick to putting
> init code to inittext only.
>
> However, should not is_kernel_exittext() (which does not
> exist) also get checked here?

No, exittext either exists or it doesn't, rather than disappearing at
runtime like inittext.
