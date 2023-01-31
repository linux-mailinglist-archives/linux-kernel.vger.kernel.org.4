Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34230682DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjAaNYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjAaNY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:24:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A7A234FE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:24:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B394B81BDF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACDBC433A8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675171453;
        bh=BWyo85S31f1UQsUNQTKebmZ46eBrrXm1tWKRlYhorI8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uVsX2vLNW0uN243oQHh+8TZbhhHi1hwcc954Z7dNzUkxM09LgVGVGmECZQScBKbkR
         bPW0VvBkWOwk9OEkIKRPnSKXVtsM/FXUXw4+lSTtEzNoETFEXsHlX5gjXI5jdeAUlA
         gbSZCIs/s8bSTYpxnPkM/3sgV05JqGaxgv+kV+2OuW3KJT2PgbLPcAqPF30jpOgRhy
         AfMZgqOBBJbKUJttfPI3HpMMCjOYrFnqjuR+erh4mfYcU9gqGYKO7GYGvItsmK0MfX
         f/3iWfod9jgGlUVUPIkLNeaH809CuNCmNxSdCivgD3QUQoMGh53nYRnRUApD1Z54HP
         M0vlwAiQrOwFQ==
Received: by mail-ed1-f45.google.com with SMTP id cw4so9249037edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:24:13 -0800 (PST)
X-Gm-Message-State: AO0yUKXCLhgX91ckPJg80WGkFoYlkda7/Q5leEbYKYhk0agYgKlrIrdn
        iy8VRnR5PClRfnF1oC9Cza0IS3GrgUN8q3+INeg=
X-Google-Smtp-Source: AK7set9Otp07JUTr42TmNzrRx4W4b+aOce1FsAQZXhWJMe2XWMax3Bb02kt6uZnvwzr3iW49fdfxJCnT+VkzrGeNVic=
X-Received: by 2002:a05:6402:291:b0:4a2:1776:631b with SMTP id
 l17-20020a056402029100b004a21776631bmr3944330edv.30.1675171451223; Tue, 31
 Jan 2023 05:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us> <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
 <87ilgntdef.fsf@all.your.base.are.belong.to.us> <CAJF2gTTaartwjVdmtmsm1FqmYVuAq5_nGYU5zc6nkdTtCm200A@mail.gmail.com>
 <Y9jz+zUDebQ4VLlF@andrea>
In-Reply-To: <Y9jz+zUDebQ4VLlF@andrea>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 31 Jan 2023 21:23:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQsRcUpMk8nvFkEsz_fpVV+v6tpUDcPzaNjqfj+i_VvXA@mail.gmail.com>
Message-ID: <CAJF2gTQsRcUpMk8nvFkEsz_fpVV+v6tpUDcPzaNjqfj+i_VvXA@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 6:57 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> > > It's the concurrent modification that I was referring to (removing
> > > stop_machine()). You're saying "it'll always work", I'm saying "I'm not
> > > so sure". :-) E.g., writing c.ebreak on an 32b insn. Can you say that
> > Software must ensure write c.ebreak on the head of an 32b insn.
> >
> > That means IFU only see:
> >  - c.ebreak + broken/illegal insn.
> > or
> >  - origin insn
> >
> > Even in the worst case, such as IFU fetches instructions one by one:
> > If the IFU gets the origin insn, it will skip the broken/illegal insn.
> > If the IFU gets the c.ebreak + broken/illegal insn, then an ebreak
> > exception is raised.
> >
> > Because c.ebreak would raise an exception, I don't see any problem.
>
> That's the problem, this discussion is:
>
> Reviewer: "I'm not sure, that's not written in our spec"
> Submitter: "I said it, it's called -accurate atomicity-"
I really don't see any hardware that could break the atomicity of this
c.ebreak scenario:
 - c.ebreak on the head of 32b insn
 - ebreak on an aligned 32b insn

If IFU fetches with cacheline, all is atomicity.
If IFU fetches with 16bit one by one, the first c.ebreak would raise
an exception and skip the next broke/illegal instruction.
Even if IFU fetches without any sequence, the IDU must decode one by
one, right? The first half c.ebreak would protect and prevent the next
broke/illegal instruction. Speculative execution on broke/illegal
instruction won't cause any exceptions.

It's a common issue, not a specific ISA issue.
32b instruction A -> 16b ebreak + 16b broken/illegal -> 32b
instruction A. It's safe to transform.

>
>   Andrea



-- 
Best Regards
 Guo Ren
