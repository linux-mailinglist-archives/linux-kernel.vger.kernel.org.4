Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3767FD0C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 07:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjA2GEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 01:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjA2GEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 01:04:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB8E233D5;
        Sat, 28 Jan 2023 22:04:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0417960C6D;
        Sun, 29 Jan 2023 06:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCEFC4339B;
        Sun, 29 Jan 2023 06:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674972269;
        bh=QNdt3qe1MNCyxh69O4eYHn6YVUW/zrV6g7w5tVzDr74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fWXc2SNXXr5lyo38Cs59MAcTh0huVpBMUWd6w5kgDuqbHPSyWaRx+auE9aFWnskay
         zQQdq+QyqORfcF3NfUykXY7ota+gWVOcLGKFKlmmZZ9vQKvCBmg0HgXtB49A5evXek
         oXArSjb0+Ie7VCkt/fd5b3folFDx6RB7PpBgbHRZCwI56OevlzExUljspAeraZnltU
         j+B7AkruYZrOJ7/j8HxR4Rk2Xs30i4imnNrQFCO0bzKDomo2pznDoe3kRYJ8Yr9JEg
         54DczNCAZoZLL2w7BOiH0+ybbT4GUJJ5jn7t8e6R85m3w0iySYpBgREwq3nWTnXPW1
         C0mvZ+IopN0Fw==
Received: by mail-lf1-f48.google.com with SMTP id j17so14591536lfr.3;
        Sat, 28 Jan 2023 22:04:29 -0800 (PST)
X-Gm-Message-State: AFqh2kqJvF8pdRF+JPtQT/qOmp9rQ1TaoYBmBnoP188yydnB9tU1w+XW
        dMdLs9yLUWatadzEghtcILFeqFkXpTQCmIdyE6s=
X-Google-Smtp-Source: AMrXdXtO1QHIup5WbervvrXo5vWVm+e8+rIV6TCr+zckrfe/ZG2Nu24/02t3KiKp+f3h/3XyAO3bDPaBSD+RAS8jBzE=
X-Received: by 2002:ac2:4e92:0:b0:4b6:efc1:6d6e with SMTP id
 o18-20020ac24e92000000b004b6efc16d6emr2384115lfr.305.1674972267386; Sat, 28
 Jan 2023 22:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20230126233606.1317794-1-song@kernel.org> <ba42ca3d-cbc1-2f2b-846d-e6581e9fa706@csgroup.eu>
In-Reply-To: <ba42ca3d-cbc1-2f2b-846d-e6581e9fa706@csgroup.eu>
From:   Song Liu <song@kernel.org>
Date:   Sat, 28 Jan 2023 22:04:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7hVQW_1pG9w89b3wF8qgRdk4ULjRMPM3rVPOKdYe1oWA@mail.gmail.com>
Message-ID: <CAPhsuW7hVQW_1pG9w89b3wF8qgRdk4ULjRMPM3rVPOKdYe1oWA@mail.gmail.com>
Subject: Re: [PATCH v3] module: replace module_layout with module_memory
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:43 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
[...]
> > -struct module_layout {
> > -     /* The actual code + data. */
> > +enum mod_mem_type {
> > +     MOD_MEM_TYPE_TEXT,
> > +     MOD_MEM_TYPE_DATA,
> > +     MOD_MEM_TYPE_RODATA,
> > +     MOD_MEM_TYPE_RO_AFTER_INIT,
> > +     MOD_MEM_TYPE_INIT_TEXT,
> > +     MOD_MEM_TYPE_INIT_DATA,
> > +     MOD_MEM_TYPE_INIT_RODATA,
> > +
> > +     MOD_MEM_NUM_TYPES,
> > +     MOD_MEM_TYPE_INVALID = -1,
> > +};
>
> Ok, so we agreed to keep it as a table with enums. Fair enough.
>
> However, can we try to make it less ugly and more readable ?
>
> I don't thing the enums needs to be prefixed by MOD_MEM_TYPE_
> Would be enough with MOD_TEXT, MOD_DATA, MOD_RODATA, MOD_RO_AFTER_INIT,
> MOD_INIT_TEXT, MOD_INIT_DATA, MOD_INIT_RODATA, MOD_INVALID.

[...]

> > -     /* Core layout: rbtree is accessed frequently, so keep together. */
> > -     struct module_layout core_layout __module_layout_align;
> > -     struct module_layout init_layout;
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -     struct module_layout data_layout;
> > -#endif
> > +     /* rbtree is accessed frequently, so keep together. */
> > +     struct module_memory mod_mem[MOD_MEM_NUM_TYPES] __module_memory_align;
>
> We are already in a struct called module, so the module_memory struct
> could be called mem[MOD_MEM_NUM_TYPES]
>
> >
> >       /* Arch-specific module values */
> >       struct mod_arch_specific arch;
> > @@ -573,23 +574,35 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
> >   bool is_module_percpu_address(unsigned long addr);
> >   bool is_module_text_address(unsigned long addr);
> >
> > +static inline bool within_module_mem_type(unsigned long addr,
> > +                                       const struct module *mod,
> > +                                       enum mod_mem_type type)
> > +{
> > +     const struct module_memory *mod_mem;
> > +
> > +     if (WARN_ON_ONCE(type < MOD_MEM_TYPE_TEXT || type >= MOD_MEM_NUM_TYPES))
>
> Here I would rather use 0 instead of  MOD_MEM_TYPE_TEXT because
> MOD_MEM_TYPE_TEXT may change in the future.
>
> > +             return false;
> > +
> > +     mod_mem = &mod->mod_mem[type];
>
> I can't see the added value of the mod_ prefix.
>
> Would read better as
>
>         mem = &mod->mem[type];
>
>         return (unsigned long)mem->base <= addr && addr < (unsigned
> long)mem->base + mem->size;
>
> And could be even more readable as:
>
>         unsigned long base, size;
>
>         base = (unsigned long)mod->mod_mem[type].base;
>         size = mod->mod_mem[type].size;
>
>         return base <= addr && addr < base + size;

Yeah, the code does look better with shorter names.

If there is no objection from folks, I will send v4 with these
suggestions next week.

Thanks,
Song
