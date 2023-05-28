Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962367137EC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 07:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjE1F6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 01:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE1F6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 01:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647FFD8
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 22:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF01B60B63
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 05:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B94AC4339B;
        Sun, 28 May 2023 05:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685253531;
        bh=snJsYpgUWy+sW/MbYC1vdikaXeWm4JXAeQnv2EYir60=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PgPrso6v1AymYqAgyx8vsn1/v0QsnJ+kVXmB4yzU6zM+T/WWplSqvn77YDV+2R9m1
         yTD+YOjAuBIma9KFBAnM+CSBoNvkct9KH1dmN2OpJNHMdiHEzrV1I3Gu6l73HTfYRQ
         0HNAFCx0mrkIEk0WQ4qSDEp8diYSviG5paZPV31fdY4ghSm+Pjz9qpNYbkjEkpOd6G
         lk3/W0oj8WQruZtuVsU2EtvR0avI02ICKl18HJ9qwnzDPLFaeuQn6GiKe8Z6K5SRQF
         pNJR1hl7PcusXG+ElM+hlYGmlaSqWqC5suCrhfWzi39yeYjM1mYZabjCHleWuHrJZ4
         GDwd62o7rNGxA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2afb2875491so21969761fa.1;
        Sat, 27 May 2023 22:58:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDwi7ookzPHKVu/NYAmKlMzVgAeWW/Mu6KrV4snw+tpzy4OwjzBc
        7xEAtyeNPAuca6Z5SLTLKkoCUqfAWLG+2Zg6B88=
X-Google-Smtp-Source: ACHHUZ6192jMD4FnYS34nSBiVK97qgvQVlW1504l/mTQVh87LljXufB6WCelbGrM7nCseDzv0m9iOhwWdhz82buYz14=
X-Received: by 2002:a2e:808c:0:b0:2ad:92b9:83b4 with SMTP id
 i12-20020a2e808c000000b002ad92b983b4mr3208515ljg.5.1685253529235; Sat, 27 May
 2023 22:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230526051529.3387103-1-song@kernel.org> <ZHGrjJ8PqAGN9OZK@moria.home.lan>
In-Reply-To: <ZHGrjJ8PqAGN9OZK@moria.home.lan>
From:   Song Liu <song@kernel.org>
Date:   Sat, 27 May 2023 22:58:37 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
Message-ID: <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Type aware module allocator
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 12:04=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, May 25, 2023 at 10:15:26PM -0700, Song Liu wrote:
> > This set implements the second part of module type aware allocator
> > (module_alloc_type), which was discussed in [1]. This part contains the
> > interface of the new allocator, as well as changes in x86 code to use t=
he
> > new allocator (modules, BPF, ftrace, kprobe).
> >
> > The set does not contain a binpack allocator to enable sharing huge pag=
es
> > among different allocations. But this set defines the interface used by
> > the binpack allocator. [2] has some discussion on different options of =
the
> > binpack allocator.
>
> I'm afraid the more I look at this patchset the more it appears to be
> complete nonsense.

I don't think it is nonsense, as you clearly got most of the points here. :=
)

>
> The exposed interface appears to be both for specifying architecture
> dependent options (which should be hidden inside the allocator
> internals!) _and_ a general purpose interface for module/bpf/kprobes -
> but it's not very clear, and the rational appears to be completely
> missing.

The rationale is to have something to replace module_alloc(). Therefore,
it needs to handle architecture specific requirements, and provide
interface to all current users of module_alloc(). It may look a little weir=
d
at the moment, because the actual allocator logic is very thin. But that's
where we will plug in the next step of the work.

>
> I think this needs to back to the drawing board and we need something
> simpler just targeted at executable memory; architecture specific
> options should definitely _not_ be part of the exposed interface.

I don't think we are exposing architecture specific options to users.
Some layer need to handle arch specifics. If the new allocator is
built on top of module_alloc, module_alloc is handling that. If the new
allocator is to replace module_alloc, it needs to handle arch specifics.

>
> The memory protection interface also needs to go, we've got a better
> interface to model after (text_poke(), although that code needs work
> too!). And the instruction fill features need a thorough justification
> if they're to be included.

I guess the first step to use text_poke() is to make it available on all
archs? That doesn't seem easy to me.

Thanks,
Song
