Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7237B6079AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJUOfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJUOfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB26FE22C7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:35:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA5C961ED9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9A8C433B5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666362936;
        bh=B/5S/o4drVYHhiJToyAIzlZIavyyZUO2GzzMWPOCRFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oxPZ4DvnpzhyB31VWjvWVlmDbdfsz7IIn4MjSXnnZkd7Wxv+JfyO84t1oF/wj4ZIo
         ADbbMVe1KEckFXK5LhCRuBHiPx3J48pA0p8GaTXKBzlyq5Ka9lr4oLhB94rzAp0jLD
         w9bMMwkq3j2wrgM8C7AyMOmXS7yg2Jh2bhvWIy6ypy0SilnR+kw1uqnG1wN42e+Kle
         ICcYjE+wwdh/S5rZ1ZoF8ZnmtXSIVKvJreBDyqndreet6C8RnXCIBNTWse/hdUY5YM
         zJdKltagoMM6zxGzsjALam5sIG0BqB7OtkaXgslBO0aQMhUZpAkPveERrE3aGNjnIh
         Srn4b+CQ5dTuA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-131dda37dddso3840903fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:35:36 -0700 (PDT)
X-Gm-Message-State: ACrzQf2TB+ZpLqvFnO5VPIAHJSGbtIM7eXBnJFjJfyfdD86CbDYNsTpK
        H1wMLbKnAupZplDHm6OFYv69Z+y0rpPyspLhgys=
X-Google-Smtp-Source: AMsMyM67fmIp02X01LltgnR22002Nyx8nO5i3CGxzwXCtW7W6hgE8MoIslqqWisrCMwZm9k1V0Tl1aKjfJEkZuQuzFM=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr27899577oap.19.1666362935455; Fri, 21
 Oct 2022 07:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221019154727.2395-1-jszhang@kernel.org> <Y1HZFcBo21SQzXVj@andrea>
 <CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com> <Y1JaE/ot91Z0KXuC@andrea>
In-Reply-To: <Y1JaE/ot91Z0KXuC@andrea>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Oct 2022 22:35:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTROm_ifvbccUmj0_CTLNq5oh1GC+XCLX+NQm4L5P71CFw@mail.gmail.com>
Message-ID: <CAJF2gTROm_ifvbccUmj0_CTLNq5oh1GC+XCLX+NQm4L5P71CFw@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix race when vmap stack overflow
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 4:36 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> > > > +     atomic_set_release(&spin_shadow_stack, 0);
> > >
> > > Have not really looked the details: should there be a matching acquire?
> >
> > I use atomic_set_release here, because I need earlier memory
> > operations finished to make sure the sp is ready then set the spin
> > flag.
> >
> > The following memory operations order is not important, because we
> > just care about sp value.
> >
> > Also, we use relax amoswap before, because sp has naturelly
> > dependency. But giving them RCsc is okay here, because we don't care
> > about performance here.
>
> Thanks for the clarification.
>
> I'm not really suggesting to add unneeded synchronization, even more
> so in local/private constructs as in this case.  It just felt odd to
> see the release without a pairing acquire, so I asked.  ;-)
Okay, let's keep:

 handle_kernel_stack_overflow:
+1:     la sp, spin_shadow_stack
+       amoswap.w sp, sp, (sp)
+       bnez sp, 1b
+
....
+     smp_store_release(&spin_shadow_stack, 0);

>
> Thanks,
>   Andrea
>
>
> > eg:
> >  handle_kernel_stack_overflow:
> > +1:     la sp, spin_shadow_stack
> > +       amoswap.w.aqrl sp, sp, (sp)
> > +       bnez sp, 1b
> > +
> > ....
> > +     smp_store_release(&spin_shadow_stack, 0);
> > +     smp_mb();



-- 
Best Regards
 Guo Ren
