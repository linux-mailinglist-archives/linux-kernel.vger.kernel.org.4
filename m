Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097055B82D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiINITE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiINITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:19:01 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C7A57E30
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:19:00 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g5so21497173ybg.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=HuIXq0gxsLhtrekbIwvVhrdsOJWyOZiMwcr+S3al2lw=;
        b=cAprc2ENkwAzsA1ScDy+/sr6d/3f9p0nPP8Mc6N0iDX/hEs+T1BUfS8BVAHrFx8MBJ
         HgdkV+kfd0A7J7ZkjA4pAMF35RkIlAimda9FEzqjxzOjqbAqi6UcEzmg80AYkWzJLeXI
         zCakpoSPHtw0VWKrXcAwGiT2kHvjFGxiv1LWCO1x3nMcoFAgS40VLpeBMd2E2Sq2drcS
         dOMWDCuymV7EHVprME2crDl+J9zBU+jt+l8DKpJSeYYBkVBy0Hjq4GnKe8WMKbvghvh6
         wixA88tuAYTRq3++zVPDafixpOW89tYSoKU9nEYwEn2VMSK/OfJ9UcfIWE7GZqM+8IAZ
         WeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HuIXq0gxsLhtrekbIwvVhrdsOJWyOZiMwcr+S3al2lw=;
        b=BLkSOsEuHElXdygucqlph3lLGDl1ngeheqi/luieqOdBP3XyGpXpUtekNhID+tbvTu
         y/coZuepI4Ng3smF3h9KskAE3KGh00Zhprc/ejiVY6xIHiA1n0TW4qZmEAnXpGHh3cki
         ex8i4/mwSjdR12nW1xfBLLULyytQSV56CrkmmK6BuEJSjxDSGyt8sYIgMWW8TF0/CxNK
         RSdEP/I4LdfIXwuOtOAYCz7SK0UJvbWJwxDncwzYdfomM3zy8O39uLfIjE5f1tqA9v9a
         VHKEuiIwAHAZi0i/GGYbctclcnlmgTySx6ojLL5UNeLnj81Hl+D6M4Vi1pQmT5xCvVgv
         sNyg==
X-Gm-Message-State: ACrzQf2jGcgY8IFK4CaSRL5bf+a8IeQo71CYBxEtbxRy2OhrVFTmsXkT
        B5gEiQ4WG+1SYoGkdsVmGYQeKyfkcXbTRHOgMZ5HRw==
X-Google-Smtp-Source: AMsMyM4gAetVuxJCy5rc8GccIvL8xPemtsGubVjAx9z1OYMfS0WxwpXd1nfRIx3By7x7exkAz6pnQPQ/bPRykgvkaz0=
X-Received: by 2002:a25:3f03:0:b0:6af:f33f:7711 with SMTP id
 m3-20020a253f03000000b006aff33f7711mr2350646yba.376.1663143538967; Wed, 14
 Sep 2022 01:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220909095811.2166073-1-glider@google.com> <20220913175210.50945edb0738bf95300dc500@linux-foundation.org>
In-Reply-To: <20220913175210.50945edb0738bf95300dc500@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 14 Sep 2022 10:18:22 +0200
Message-ID: <CAG_fn=XsmcKNi1Sg-HgP9Hh98mf910o0Uo4fCpwijiS_3adgyQ@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] x86: crypto: kmsan: revert !KMSAN dependencies
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Robert Elliott <elliott@hpe.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 2:52 AM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Fri,  9 Sep 2022 11:58:10 +0200 Alexander Potapenko <glider@google.com=
> wrote:
>
> > This patch reverts "crypto: Kconfig: fix up for "crypto: kmsan: disable
> > accelerated configs under KMSAN" used by Stephen Rothwell to cleanly
> > merge KMSAN patches into linux-next.
> >
> > Because now arch-specific crypto configs reside in a separate Kconfig
> > file, we can disable them all by adding a single !KMSAN before includin=
g
> > that file (done in the following patch).
> >
> > Among others, this patch reverts !KMSAN check for
> > CONFIG_CRYPTO_AEGIS128_SIMD, which is ARM-only and is hence unnecessary=
,
> > because KMSAN does not support ARM yet.
>
> As I understand it, these patches are against linux-next and only
> linux-next because they pertain to linux-next's resolution of conflicts
> between the MM tree and the crypto tree?

The thing is that this patch only makes sense with its counterpart
that adds a !KMSAN condition on "source arch/x86/crypto/Kconfig", and
the latter file is missing in the -mm tree.

> I'm not sure how to handle that, even if anyone wants to.  How about
> you send an update to
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm's mm-unstable
> branch so the code which is there makes sense?  Then we'll ask Stephen
> to redo the crypto tree resolution?

Because the crypto tree is moving code crypto/Kconfig to
arch/x86/crypto/Kconfig, we'll still need to apply these two patches
to the result of the crypto tree merge.

I was going to send out the updated patch series anyway (there are
minor improvements to the core which let us drop "kmsan: unpoison @tlb
in arch_tlb_gather_mmu()", also there's a new test case).
I could drop "crypto: kmsan: disable accelerated configs under KMSAN"
from it, so that it would be possible to enable accelerated configs
under KMSAN at the cost of false positives (which are only visible if
one builds with KMSAN).
Then, once arch/x86/crypto/Kconfig hits -mm, I can send the remaining
patch that disables accelerated crypto under KMSAN:
https://lore.kernel.org/all/20220909095811.2166073-2-glider@google.com/

Or I could just send v7 patches against mm-unstable and ask Stephen to
apply both https://lore.kernel.org/all/20220909095811.2166073-2-glider@goog=
le.com/
and https://lore.kernel.org/all/20220909095811.2166073-2-glider@google.com/
at merge time.

Which option is better?


--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
