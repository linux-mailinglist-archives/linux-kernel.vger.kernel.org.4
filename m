Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961437170D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjE3Who (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjE3Whl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:37:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D263CEC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67C75634B5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB01EC433D2;
        Tue, 30 May 2023 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685486258;
        bh=zlKPf1zWEZmccX9g5IdIK7T/lGMu8AaFUNgCzd/alzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h8nJ9Vic5pc1MPghQKIV+6G4nGyVxapMQSX9onSpimd49f0Dt94rgN6uwFWN6JCx8
         g/uRtOt/CaWAN8Ti/n0pNBHxvraJqbAYAEDiySib6aRFx/kq2NSaRS6eYwsR9804EO
         xrVQB9d0QxMUL8fFPmH4goy/vbYeYl3MOPUTnTlmW0/xxipwzhZdN8zYP5NeourDky
         Kg2gls6Glev6/Ln4gve6totJHasnwJ8gHhVQJOAAH9+IZrNi/1ehUC92qGB27HynmO
         JdFxzPeMgqec4SxEwZgO9e4GQ6S2bTmz/Tu00CI6mIogKw92d3fYOuFqWWhMunTYq6
         FnWqgjkhex2Nw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f4d80bac38so5657423e87.2;
        Tue, 30 May 2023 15:37:38 -0700 (PDT)
X-Gm-Message-State: AC+VfDz3H1+mJUcJg79xCeLwiXFYAwKEvXoFFBGieuPcd+4eBLkJ3SiF
        fA8RRh8bQhaL8cUHRuruLXPwGVv8aTZtKimKEIc=
X-Google-Smtp-Source: ACHHUZ5ooYFKQsuPaTyXMgJ5NVjOHadGyJuwtkOmYRpkguSA/6TROmpB38zgUeFvQZYofPrrOwd3LU6QBgsDmUCj4K0=
X-Received: by 2002:ac2:518d:0:b0:4f3:b215:ef7c with SMTP id
 u13-20020ac2518d000000b004f3b215ef7cmr1466352lfi.23.1685486256839; Tue, 30
 May 2023 15:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230526051529.3387103-1-song@kernel.org> <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com> <20230529104530.GL4967@kernel.org>
In-Reply-To: <20230529104530.GL4967@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 30 May 2023 15:37:24 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6g98Wz9Oj1NiwwZ1OkSVNXX10USByY0b9tEfzOt8SVQg@mail.gmail.com>
Message-ID: <CAPhsuW6g98Wz9Oj1NiwwZ1OkSVNXX10USByY0b9tEfzOt8SVQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Type aware module allocator
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 3:45=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> > On Sat, May 27, 2023 at 12:04=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > I think this needs to back to the drawing board and we need something
> > > simpler just targeted at executable memory; architecture specific
> > > options should definitely _not_ be part of the exposed interface.
> >
> > I don't think we are exposing architecture specific options to users.
> > Some layer need to handle arch specifics. If the new allocator is
> > built on top of module_alloc, module_alloc is handling that. If the new
> > allocator is to replace module_alloc, it needs to handle arch specifics=
.
>
> I'm for creating a new allocator that will replace module_alloc(). This
> will give us a clean abstraction that modules and all the rest will use a=
nd
> it will make easier to plug binpack or another allocator instead of
> vmalloc.
>
> Another point is with a new allocator we won't have weird dependencies on
> CONFIG_MODULE in e.g. bpf and kprobes.
>
> I'll have something ready to post as an RFC in a few days.

I guess this RFC is similar to unmapped_alloc()? If it replaces
vmalloc, we can probably trim this set down a bit (remove
mod_alloc_params and vmalloc_params, etc.).

Thanks,
Song
