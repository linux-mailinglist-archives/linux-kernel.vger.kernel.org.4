Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A18718801
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjEaRFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjEaREw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD131BC
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:04:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05BB663E12
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 17:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F0CC4339B;
        Wed, 31 May 2023 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685552653;
        bh=OvzFB8mGwFVt0GUfLdMmDb+IsQo2DWmmZgQEazFHV5s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RJdgFk8MLxkEfoIvMv4ajzYoMPa0Qdv2sEe7KAAVwLzg6LgoduIYrPIKqX8vxoOh/
         1zFIVmQi2TnzxTCoRufvv9dW/NWmkjU+JOepq9+ZUknWwyJRgP4e18Zdyv/eZWG2a3
         qOnznV0w93/ItBtgxmBvjEcyvzGn05GIWZE68pqv6MwdQPV+SPWdz06ExBMC2YuGCu
         6J0XO7Dsv7Jt6uHG/CZNLZ92AeEOBVGvmhTQyqk9Ct+W12iwRRfW1YinnO162UJ4fQ
         5hur64yyGuthFDt1G5zqY9cmLSMvVek7xJH9uYVp2zmWpKBpKJ4gnCcB3jt4Jdou8a
         X1j8bCEONsGpQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso7312673e87.3;
        Wed, 31 May 2023 10:04:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDy+1Lc1t8uNldDrVWwRZlhNxZxeauFVMa4IuAzaqGHTeFQ5KgkY
        i8mcgGgvUPu/iB3cZTWXsYVyDQZ4toPEVQn47fo=
X-Google-Smtp-Source: ACHHUZ5U0qhBdMIyrvOoX8zbY4lWBrfnPt4KiXT68q6MQ4+Mf9/YSdl1QJgo+JFQFWTi/5uq0X5gTARxNS9Rdn62m8g=
X-Received: by 2002:ac2:4c37:0:b0:4f3:a1fe:5b1c with SMTP id
 u23-20020ac24c37000000b004f3a1fe5b1cmr3050090lfq.44.1685552651403; Wed, 31
 May 2023 10:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230526051529.3387103-1-song@kernel.org> <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
 <20230529104530.GL4967@kernel.org> <CAPhsuW6g98Wz9Oj1NiwwZ1OkSVNXX10USByY0b9tEfzOt8SVQg@mail.gmail.com>
 <20230531135120.GA395338@kernel.org>
In-Reply-To: <20230531135120.GA395338@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 31 May 2023 10:03:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6r=0r0dKfKxwPp9KXqLSKWw4x6RrbNBnS=1M1Y1sh5Ag@mail.gmail.com>
Message-ID: <CAPhsuW6r=0r0dKfKxwPp9KXqLSKWw4x6RrbNBnS=1M1Y1sh5Ag@mail.gmail.com>
Subject: Re: [PATCH 0/3] Type aware module allocator
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 6:51=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, May 30, 2023 at 03:37:24PM -0700, Song Liu wrote:
> > On Mon, May 29, 2023 at 3:45=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> > > > On Sat, May 27, 2023 at 12:04=E2=80=AFAM Kent Overstreet
> > > > <kent.overstreet@linux.dev> wrote:
> > > > >
> > > > > I think this needs to back to the drawing board and we need somet=
hing
> > > > > simpler just targeted at executable memory; architecture specific
> > > > > options should definitely _not_ be part of the exposed interface.
> > > >
> > > > I don't think we are exposing architecture specific options to user=
s.
> > > > Some layer need to handle arch specifics. If the new allocator is
> > > > built on top of module_alloc, module_alloc is handling that. If the=
 new
> > > > allocator is to replace module_alloc, it needs to handle arch speci=
fics.
> > >
> > > I'm for creating a new allocator that will replace module_alloc(). Th=
is
> > > will give us a clean abstraction that modules and all the rest will u=
se and
> > > it will make easier to plug binpack or another allocator instead of
> > > vmalloc.
> > >
> > > Another point is with a new allocator we won't have weird dependencie=
s on
> > > CONFIG_MODULE in e.g. bpf and kprobes.
> > >
> > > I'll have something ready to post as an RFC in a few days.
> >
> > I guess this RFC is similar to unmapped_alloc()? If it replaces
> > vmalloc, we can probably trim this set down a bit (remove
> > mod_alloc_params and vmalloc_params, etc.).
>
> No, it's not a new allocator. I'm trying to create an API for code
> allocations that can accommodate all the architectures and it won't be a
> part of modules code. The modules will use the new API just like every
> other subsystem that needs to allocate code.
>
> I've got a core part of it here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=3Dj=
italloc/v1

This branch looks like the same scope as this set (but with different
implementation). So it will still use vmalloc, right?

Thanks,
Song
