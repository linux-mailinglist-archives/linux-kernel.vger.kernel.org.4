Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A3D6A63E5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjB1Xvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1Xv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:51:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D928536FF3;
        Tue, 28 Feb 2023 15:51:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 934ABB80ED4;
        Tue, 28 Feb 2023 23:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D86C433EF;
        Tue, 28 Feb 2023 23:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677628285;
        bh=GwM9G/9wFjYtbhzH4L6XkQdhcTKMvoIH9VS8LYGSibc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q9+kIfl7a5k4VHZ9R6ycMoOwtkZ0Hi6A6uppzKFnMPN0hYO7SVBJVWkTgyL/KfZcZ
         JHjYfFEkR3LjcJ0Fx5FmTvyF0xu28x6GbJb8kktB3uHKhSBG3IvY3HGa5B16oIBeCr
         XVCl4Od7iWwRDYZ6/QButOm9+Xo9/jH/Y+hoZmSaC6mPFei3XzU8ocMp9jh2LX5f5v
         2IwM8S8h9wQK5uqR467wtih1mPslWRJh/IyUDQZ7LTzLUyGfhL3S9aDKw1EEI+7BqY
         buznBmoyh+/yoGK4l5+mLuuKiB8FZccVNeILXW7g328LYYdQq1r0hOdqROZOEVx3kR
         Y1soSp6f9awBA==
Received: by mail-vs1-f53.google.com with SMTP id x14so17512227vso.9;
        Tue, 28 Feb 2023 15:51:25 -0800 (PST)
X-Gm-Message-State: AO0yUKU+wENbvvsFPJPZY+vm14Y5ireB59+yTv3/eI2gyEo0tNwaPbzM
        3d0Hma72mebnLyqSCdddTASE0Czq8Q+h9KfUtA==
X-Google-Smtp-Source: AK7set/Y3qKNvORE+6urS8Xk6lcaPVI5GTC/l5XtFTLrqpbhjZdYe9geZzlXCjmLy7aaPGTDKi8QmczNNfrdrmT/gxo=
X-Received: by 2002:a67:ab42:0:b0:414:34d3:89a with SMTP id
 k2-20020a67ab42000000b0041434d3089amr3076081vsh.6.1677628284083; Tue, 28 Feb
 2023 15:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20230228174019.4004581-1-jjhiblot@traphandler.com>
 <CAGETcx-w4A3fz_DPqJG+9P6ETGAPv547DcnsO52gqTO1_vijsw@mail.gmail.com>
 <CAL_JsqL6qFDC5uC_0PgyM_8OVEwFq+o=gPk2=PRKBDTp9XTzOw@mail.gmail.com> <CAGETcx9DGK8Ass-f2wo=efHaGcQ8T2xzOqOP5TTrkM+537YPjA@mail.gmail.com>
In-Reply-To: <CAGETcx9DGK8Ass-f2wo=efHaGcQ8T2xzOqOP5TTrkM+537YPjA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Feb 2023 17:51:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKkaajnJL+1oHWF+68iRRm9t2H-bxtOKwq9zaXj_u62KA@mail.gmail.com>
Message-ID: <CAL_JsqKkaajnJL+1oHWF+68iRRm9t2H-bxtOKwq9zaXj_u62KA@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add missing of_node_get() in parse_interrupt()
To:     Saravana Kannan <saravanak@google.com>
Cc:     jjhiblot@traphandler.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
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

On Tue, Feb 28, 2023 at 3:58=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Tue, Feb 28, 2023 at 1:01=E2=80=AFPM Rob Herring <robh+dt@kernel.org> =
wrote:
> >
> > On Tue, Feb 28, 2023 at 1:07=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
> > >
> > > On Tue, Feb 28, 2023 at 9:40=E2=80=AFAM Jean-Jacques Hiblot
> > > <jjhiblot@traphandler.com> wrote:
> > > >
> > > > From: Jean Jacques Hiblot <jjhiblot@traphandler.com>
> > > >
> > > > As all the other parsers do, parse_interrupt() must increase the re=
fcount
> > > > of the device_node. Otherwise the refcount is decremented every tim=
e
> > > > parse_interrupt() is called on this node, leading to a potential
> > > > use-after-free.
> > > >
> > > > This is a regression introduced by commit f265f06af194 ("of: proper=
ty:
> > > > Fix fw_devlink handling of interrupts/interrupts-extended"). The re=
ason is
> > > > that of_irq_parse_one() does not increase the refcount while the pr=
eviously
> > > > used of_irq_find_parent() does.
> > >
> > > Thanks for catching the issue Jean!
> > >
> > > This feels like a bug in of_irq_parse_one() to me. It's returning a
> > > reference to a node without doing a of_node_get() on it.
> > >
> > > Rob, Marc, Do you agree?
> >
> > I think you are right. If we look at the 'interrupts-extended' path,
> > it just calls of_parse_phandle_with_args() which does a get.
> >
> > > Jean,
> > >
> > > If they agree, can you please fix of_irq_parse_one() and add a
> > > of_node_put() to existing callers (if they aren't already doing a
> > > put()).
> >
> > I think it is not that simple. The correct thing for callers may also
> > be to hold the ref. We wouldn't want to just blindly do a put that is
> > clearly wrong just to keep current behavior.
>
> Right, I was just giving the approximate idea. If the caller keeps
> using the node pointer, they shouldn't do a put().
>
> > But not having the put
> > means we're leaking refcounts as calling the APIs originally had no
> > side effect. For example, IIRC, of_irq_get() is called again on each
> > deferred probe. There is no of_irq_put() because Linux IRQ numbers
> > aren't (or weren't?) refcounted.
>
> Hopefully fw_devlink will avoid a lot of these deferred probes. But if
> it comes to wasting memory (leaking) vs use after free, we should for
> the short term switch to leaking.

A refcount overflow can cause a use after free too, but I guess the
underlying kref protects against that now.

The issue is we have what was a non-refcounted API and we've halfway
bolted on refcounting for what's 99% static anyways. I really wish we
were only worrying about refcounts for the 1% of the cases that
matter.

> IRQ themselves can't be freed once they are registered with the IRQ
> framework, but I'd think the consumers can still do a get/put on an
> IRQ. So, at the least, we should be able to do some put() from the
> consumer context.
>
> > Really, I'd like to get rid of exposing of_irq_parse_one() in the first=
 place.
>
> I don't have enough context to comment here.

Looking at the ~10 users, they are mostly cases wanting to get their
hwirq number. That then puts knowledge of the parent interrupt cell
format into the client which isn't great. There's also one case
(regulator-quirk-rcar-gen2.c) looking for shared interrupts. Probably
better ways to do both of those...

Rob
