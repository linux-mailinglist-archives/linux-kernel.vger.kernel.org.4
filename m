Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9E164804B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiLIJmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLIJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:42:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A663AC32
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:42:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EC53621E4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CF8C433F2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670578929;
        bh=Tbo2+FhoQ4maReKSfP3f06RUQ2E3eBLQFr4VEsoX8+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IpdMUZsomFZpvDXfSExNxKaFi3PliedjvAdgdx0xHDUii1cVQTS4RNX3CQz+QNLxR
         S+qaC3jQ3XAImoE7wbaEsliCTO+T1/nU5N9YBTDfort07HEgv9el/zWqEWKgK5/CW7
         nzZI3SAC2HbUHgCoKs0Yp4EJ4OZ8e49R7lUaSRWKOe+NWwUPK9kKPDQMkyu78DSjhE
         mtGSxRt4cknPTrJ/9S32s1CIrsbtqyKb2mMd84oDTXytSj12eClk2sL2TYcAKe1E6b
         7paAcQpPqPxfrwXwSwHmQn8Z8NGLwuPbE8c97QU3OJ4gW0GJVF4uxHAyQpRWFyhkyy
         QQkRbrjzpudlA==
Received: by mail-lj1-f173.google.com with SMTP id a19so4398498ljk.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:42:08 -0800 (PST)
X-Gm-Message-State: ANoB5plshiiK0mB8tc9dLGNQBsFIHodKAcyQJDmVqZvUT8KReyRnRftn
        Pn5hiQNP8kZOSy17oXKhXlLI64QcCXBJDfhyqQk=
X-Google-Smtp-Source: AA0mqf5M0GCSKWI7xqGnVJkB1vH9Q7C9RUCYQJKJi/3S+teCDp0IEOH/yR+g/iCluajWBerql34fPO3atuJp0+8H+0s=
X-Received: by 2002:a05:651c:220a:b0:277:2428:3682 with SMTP id
 y10-20020a05651c220a00b0027724283682mr32034797ljq.291.1670578926991; Fri, 09
 Dec 2022 01:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20221209060740.2785164-1-agordeev@linux.ibm.com>
In-Reply-To: <20221209060740.2785164-1-agordeev@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Dec 2022 10:41:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF5OR6TGhCrxYCmrnA=CTAfkGcga8BDE2Vj3rixgi7U3w@mail.gmail.com>
Message-ID: <CAMj1kXF5OR6TGhCrxYCmrnA=CTAfkGcga8BDE2Vj3rixgi7U3w@mail.gmail.com>
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

On Fri, 9 Dec 2022 at 07:08, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> inittext code may be out of [__init_begin, __init_end]
> range on some architectures. Yet, the jump_label_init()
> only calls init_section_contains() function to check if
> a label needs to be annotated as init and inittext code
> is left behind.
>
> Fixes: 19483677684b ("jump_label: Annotate entries that operate on __init code earlier")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  kernel/jump_label.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 714ac4c3b556..77680665d374 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -481,13 +481,16 @@ void __init jump_label_init(void)
>
>         for (iter = iter_start; iter < iter_stop; iter++) {
>                 struct static_key *iterk;
> +               unsigned long addr;
>                 bool in_init;
>
>                 /* rewrite NOPs */
>                 if (jump_label_type(iter) == JUMP_LABEL_NOP)
>                         arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
>
> -               in_init = init_section_contains((void *)jump_entry_code(iter), 1);
> +               addr = jump_entry_code(iter);
> +               in_init = init_section_contains((void *)addr, 1) ||
> +                         is_kernel_inittext(addr);

Isn't it sufficient to only call is_kenel_inittext here?

>                 jump_entry_set_init(iter, in_init);
>
>                 iterk = jump_entry_key(iter);
> --
> 2.34.1
>
