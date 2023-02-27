Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D50E6A48A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjB0Rxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjB0Rxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:53:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D573C17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:53:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5C9BB80D99
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5835FC4339B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677520413;
        bh=SAJSlQTkp0HhEdWMJDyOk2c0VmbdGe64aI1Pp9sBJTU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QAEDF4xsiW5hWShqlorEI9KBJz3MEjCCmdzHJfFEydcpUUEUSD8nb3qeDLXMp6bx3
         1FCNvJOGed5N0/hTpdlkrJuFz41GCDAqwO73wyqNNVhoiMc4jlrzG6WhZAuv3JXSk+
         aSXzZCHhtH3Fo0lG/jlqz5rMliurJBdLvoY9IrJJdLgFrt1juLZe8j+n1QPABmaqpl
         K0oKQJ/p7bZqSLBPISzE6CyBrkn+UxXxHFTOMMb4+22DDAq+dyzyJaXinrFUzRnA/u
         boJHYpfXaKwJIJdVFi/fO0eyAHr6LwecIecymCeCS9qc25z62Sd4pEm0WDKrgFbLhP
         HfF1bDhIqq1MQ==
Received: by mail-lf1-f48.google.com with SMTP id r27so9622430lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:53:33 -0800 (PST)
X-Gm-Message-State: AO0yUKV1JS/8xq6ET4tJdA8id10/Xsip9uogS3GUKKfAjr1m7PO+xAVd
        W76U/HKAYHoYrVtLKGF7lK94WgR0Q70gsKtlRoQ=
X-Google-Smtp-Source: AK7set/YEGwo805dHGA6DYHHdfoMRlSpmYLwmofHWomaxwAmR6Oksv1i9+fHz0SRMAq6j/ROjcH/CTRghgOjewmVzYo=
X-Received: by 2002:a19:7606:0:b0:4dc:807a:d143 with SMTP id
 c6-20020a197606000000b004dc807ad143mr7714348lff.7.1677520411316; Mon, 27 Feb
 2023 09:53:31 -0800 (PST)
MIME-Version: 1.0
References: <20221227092634.445212-1-liushixin2@huawei.com>
 <b93ec55c-f6f0-274a-e7d6-edb419b4be8a@huawei.com> <20230129134147.f19ca0641f1133f3e3bc185b@linux-foundation.org>
 <20230131150644.GA2605@willie-the-truck> <20230131150750.GB2605@willie-the-truck>
 <CAMj1kXGaxehOcrQqFZNA+C3dTk_H8sBr_1wsN3_KN82nXVaG_g@mail.gmail.com>
 <20230207112940.GA12147@willie-the-truck> <8c287b1d-476c-7b00-27f6-76c3a1a5fd46@leemhuis.info>
 <CAMj1kXGWEaQXoKj=DzG9XpVGi4t5zfE-RSG0BodVL-b47nsj-A@mail.gmail.com> <5a05e758-3c26-875a-af3a-6d7c8ddde653@leemhuis.info>
In-Reply-To: <5a05e758-3c26-875a-af3a-6d7c8ddde653@leemhuis.info>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 27 Feb 2023 18:53:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGNb6HsNNdEqAtNJsy7wC3nC5yH2+P6y3QK6M8uNG7MBA@mail.gmail.com>
Message-ID: <CAMj1kXGNb6HsNNdEqAtNJsy7wC3nC5yH2+P6y3QK6M8uNG7MBA@mail.gmail.com>
Subject: Re: [PATCH RFC] arm64/vmalloc: use module region only for
 module_alloc() if CONFIG_RANDOMIZE_BASE is set
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 at 18:17, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
>
>
> On 27.02.23 17:14, Ard Biesheuvel wrote:
> > On Mon, 27 Feb 2023 at 16:08, Linux regression tracking (Thorsten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >>
> >> [CCing the regression list, as it should be in the loop for regressions:
> >> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> >>
> >> On 07.02.23 12:29, Will Deacon wrote:
> >>> On Tue, Jan 31, 2023 at 05:03:32PM +0100, Ard Biesheuvel wrote:
> >>>> On Tue, 31 Jan 2023 at 16:07, Will Deacon <will@kernel.org> wrote:
> >>>>> On Tue, Jan 31, 2023 at 03:06:44PM +0000, Will Deacon wrote:
> >>>>>> On Sun, Jan 29, 2023 at 01:41:47PM -0800, Andrew Morton wrote:
> >>>>>>> On Sun, 29 Jan 2023 10:44:31 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
> >>>>>>>> On 2022/12/27 17:26, Liu Shixin wrote:
> >>>>>>>>> After I add a 10GB pmem device, I got the following error message when
> >>>>>>>>> insert module:
> >>>>>>>>>
> >>>>>>>>>  insmod: vmalloc error: size 16384, vm_struct allocation failed,
> >>>>>>>>>  mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> >>>>>>>>>
> >>>>>>>>> If CONFIG_RANDOMIZE_BASE is set, the module region can be located in the
> >>>>>>>>> vmalloc region entirely. Although module_alloc() can fall back to a 2GB
> >>>>>>>>> window if ARM64_MODULE_PLTS is set, the module region is still easily
> >>>>>>>>> exhausted because the module region is located at bottom of vmalloc region
> >>>>>>>>> and the vmalloc region is allocated from bottom to top.
> >>>>>>>>>
> >>>>>>>>> Skip module region if not calling from module_alloc().
> >>>>>>>
> >>>>>>> I'll assume this is for the arm tree.
> >>>>>>>
> >>>>>>> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> >>>>>>
> >>>>>> This looks like the same issue previously reported at:
> >>>>>>
> >>>>>> https://lore.kernel.org/all/e6a804de-a5f7-c551-ffba-e09d04e438fc@hisilicon.com/
> >>>>>>
> >>>>>> where Ard had a few suggestions but, afaict, they didn't help.
> >>>>>>
> >>>>
> >>>> Thanks for the cc.
> >>>>
> >>>> So this is a bit clunky, and I wonder whether we wouldn't be better
> >>>> off just splitting the vmalloc region into two separate regions: one
> >>>> for the kernel and modules, and one for everything else. That way, we
> >>>> lose one bit of entropy in the randomized placement, but the default
> >>>> 48-bit VA space is vast anway, and even on 39-bit VA configs (such as
> >>>> Android), I seriously doubt that we come anywhere close to exhausting
> >>>> the vmalloc space today.
> >>>
> >>> That sounds like a good idea to me.
> >>>
> >>> Liu Shixin -- do you think you could have a go at implementing Ard's
> >>> suggestion instead?
> >>
> >> Liu Shixin, did you ever look into realizing this idea?
> >>
> >> Or was some progress already made and I just missed it?
> >
> > This patch
> >
> > https://lore.kernel.org/all/20230223204101.1500373-1-ardb@kernel.org/
> >
> > should fix the issue.
>
> Great, many thx.
>
> >> I'm asking, as the idea discussed afaics is not only supposed to fix the
> >> regression you tried to address, but also one that is now three months
> >> old and stalled since Mid-December -- which is really unfortunate, as
> >> that's not how regressions should be handled. :-/
> >
> > Is it documented anywhere how regressions should be handled?
>
> https://docs.kernel.org/process/handling-regressions.html
>
> Side note: that also mentions use of the "Link" tag. If the patch had
> one, I'd noticed it and wouldn't bothered anyone here.
>

Thanks for the reference. I wasn't aware that that document existed.

However, please be careful with calling everything a regression: in
this particular case, the 10G pmem device simply never worked in this
configuration, and so calling this a regression, and quoting all these
rules that we must now abide by is, quite frankly, not entirely
appropriate.

Can we please reserve the 'regression' label for cases where the
workflow of a real user stopped working after a kernel change? I agree
that this must never happen, and so we should prioritize those cases
over the ones that are just ordinary bugs and not regressions.

> > The
> > mailing list is flooded with hard to reproduce reports from users as
> > well as automatic fuzzers and build bots, so I don't think it is
> > entirely unreasonable to move unresponsive reporters to the back of
> > the queue.
>
> I do that sometimes, but fwiw, from what I can see it wasn't a reporter
> that was unresponsive:
>
> https://lore.kernel.org/linux-arm-kernel/c1ff5cae-7f56-7fdb-c832-ffbcc177535b@leemhuis.info/
>
> But I might be missing something, sorry if I do. And there was the
> festive season what complicated everything. Whatever, as long as this
> this is fixed.
>
> /me wonders if we should ask "chenxiang (M)" to test that patch, too;
> but /me is not even totally sure it's the same problem
>

Yes, to me it looks like exactly the same issue.

> >> But well, it afaik was
> >> caused by a patch from Ard, so it's obviously not your job to address
> >> it. But it seems you were working on it.
> >
> > We are all working together here, so please refrain from telling
> > people what they should or should not be working on. (I am aware that
> > you probably did not mean it that way, but things tend to get lost in
> > translation very easily on the mailing list)
>
> Maybe I found the wrong words, sorry.
>

No worries. Your work is much appreciated, as I am sure it's a
thankless job at times.

Thanks,
Ard.
