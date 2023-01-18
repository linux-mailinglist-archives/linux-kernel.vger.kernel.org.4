Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE267258D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjARRwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjARRwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:52:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658D54B49C;
        Wed, 18 Jan 2023 09:52:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16813B81E69;
        Wed, 18 Jan 2023 17:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D82C43396;
        Wed, 18 Jan 2023 17:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674064364;
        bh=/Gzr/WR95XMtTWMDsej0/0zxfcG/BPllZVyCwX0lM6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fp574ofBRl53RryS+r3YEUQmBy2MWwMXjhG7vQtUhrJf6LKDt67DX8BUISkoG2Uti
         WoBCyuJEOz3podTg4r4Kphc8ssJgU4ND0pwm6Dzch+HfBVkTsZHOW9RwBAHGi/3Ytp
         IoCOOuUslmdW+dRxJs1BoTn4PjIFpIzkaDEdJz1pxXzfK0DbIUI48OlS7YMuW9gTiQ
         YZIyQ0ejF8YuQCvPXsabh99XYmQu0V8i8neWI47Q6qAcj+s7fA+gfBD8jygCBTtqlo
         blXPaDNdc4lnWgwR+NeRB+MGgfP0SyHUKJoakjeh16zyGTFfjmb8QRMmUkoaGKIZRE
         HG37jgpgijwCw==
Received: by mail-lf1-f53.google.com with SMTP id bp15so52786765lfb.13;
        Wed, 18 Jan 2023 09:52:44 -0800 (PST)
X-Gm-Message-State: AFqh2kpx5yuivhUR3FZK7l0fxyFJHQ7hUH5nnHXAqXufhK/YwGrOOLeX
        E26YGx7LB+YjAF4Y21y2dKT0KqTzaDyTqC5voDU=
X-Google-Smtp-Source: AMrXdXsz3DFc0OfRs+agT2c4zNuyTjg7T6vN1ft7TBpReHglOHBeqGsmrSwT3VPQxp0zw2d14zoZpRBoF2VVObWLE1I=
X-Received: by 2002:ac2:48b7:0:b0:4b6:e71d:94a6 with SMTP id
 u23-20020ac248b7000000b004b6e71d94a6mr586014lfg.476.1674064362704; Wed, 18
 Jan 2023 09:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20230106220959.3398792-1-song@kernel.org> <83941b74-7585-235b-ee54-3b127ca70d9e@csgroup.eu>
 <CAPhsuW6S8qJWFzSLpVf_4ZpyM0Cxty=-pS2_K=tgF52s95Zhag@mail.gmail.com>
 <CAPhsuW7+BG9wYaoD6EYH-jnWqX30JdgNr5_733sO-++SzR5v3w@mail.gmail.com>
 <154ed99c-5877-35f6-5e7d-9d7abada7d33@csgroup.eu> <Y8gLJYA3ibA8De58@hirez.programming.kicks-ass.net>
In-Reply-To: <Y8gLJYA3ibA8De58@hirez.programming.kicks-ass.net>
From:   Song Liu <song@kernel.org>
Date:   Wed, 18 Jan 2023 09:52:29 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6AR9CorYPL88-92_VBn-7uZoXj4SfWXn5N_bRC_SXSKQ@mail.gmail.com>
Message-ID: <CAPhsuW6AR9CorYPL88-92_VBn-7uZoXj4SfWXn5N_bRC_SXSKQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] module: replace module_layout with module_memory
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 7:07 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Tue, Jan 10, 2023 at 06:31:41AM +0000, Christophe Leroy wrote:
> > Le 09/01/2023 =C4=85 21:51, Song Liu a =C3=A9crit :
>
> > > Do you mean one tree will cause addr_[min|max] to be inaccurate?
> > >
> >
> > Yes at least. On powerpc you will have module text below kernel,
> > somewhere between 0xb0000000 and 0xcfffffff, and you will have module
> > data in vmalloc area, somewhere between 0xf0000000 and 0xffffffff.
> >
> > If you have only one tree, any address between 0xc0000000 and 0xeffffff=
f
> > will trigger a tree search.
>
> The current min/max thing is tied to the tree because of easy update on
> remove, but module-insert/remove is not a performance critical path.
>
> So I think it should be possible to have {min,max}[TYPES] pairs.  Either
> brute force the removal -- using a linear scan of the mod->list to find
> the new bounds on removal.

I think keeping an array of min/max pairs is an overkill.
w/o CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, all the
types will be allocated in the same range (MODULES_VADDR, MODULES_END),
so one min/max pair should be enough.
w/ CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, there
is a big gap between text allocation and data allocation. I think a second
min/max pair will be useful here.

>
> Or overengineer the whole thing and use an augmented tree to keep that
> many heaps in sync during the update -- but this seems total overkill.
>
> The only consideration is testing that many ranges in
> __module_address(), this is already 2 cachelines worth of range-checks
> -- which seems a little excessive.

Currently, min/max are updated on module load, but not on module unload.
I guess we won't really need __module_address() to be that fast.

If there are no objections or suggestions. I will update the patches with a
second min/max pair with CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC.

Thanks,
Song

>
> (also, I note that module_addr_{min,max} are unused these days)
