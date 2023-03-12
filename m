Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970886B6533
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCLLG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCLLG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:06:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20814D618;
        Sun, 12 Mar 2023 04:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F2F2B8074D;
        Sun, 12 Mar 2023 11:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA58DC433EF;
        Sun, 12 Mar 2023 11:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678619183;
        bh=GhXxQ3LGqBwu1PDYIRUrHFHxvh4REo5L/XF+09XJtA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UXEr1Gv/oTDMY7Vm7pkDh9fTv9KlV34UHz9IPWS6o0qb6h037dPedNzxigMD+cHES
         8Zd9Swd1k75o1+RSblngXhEYO82KmetXLplpd3giDrkLYAxwLDU+UYu+3+yXMMNCHW
         RV6Oh6d9lSw6z++ZdjWQWrGT5hNhAbia7XzNjTHa+4lNFCrcrMi3igT2oTqhMiM4Xq
         CU9orID0wj8hCCjwvOOfAAXEMth0R3CVrx4zpVD8LyedqKIalnJg/TD36hAy+ITHGj
         IQ4Q9M1dRck5G6vLhoCOs9DqLo1dpqbPBVebpCFtJay5cuzoNYecv6fTU1iyX972Kq
         +oIm6I9XNx9Dg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-17683b570b8so10910037fac.13;
        Sun, 12 Mar 2023 04:06:23 -0700 (PDT)
X-Gm-Message-State: AO0yUKUe6SfJ4BiBqpyg7cInAhhSjO5o0pZidkxfGQ+V/TsXC+z1Yu5x
        XurjeEbsNzXhtIlzqpGoAQf1rZmbgwyhyhn1Kw8=
X-Google-Smtp-Source: AK7set8N/yTqs/8oLs98VVUCh2i/kT0xhMJy8fcAHCei2tSBTmzoBxO7UBLop8YToq1+IztNPBywlwqoUZb9vHGB+b8=
X-Received: by 2002:a05:6870:b00a:b0:176:50be:85b4 with SMTP id
 y10-20020a056870b00a00b0017650be85b4mr11293648oae.8.1678619183114; Sun, 12
 Mar 2023 04:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230310183717.RESEND.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <bae2702e-3570-f461-b86f-e56ce82a636e@infradead.org> <20230311165507.GN3041508@bill-the-cat>
In-Reply-To: <20230311165507.GN3041508@bill-the-cat>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 12 Mar 2023 20:05:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARQ-PgxiCh+gm2efpfXmNBkdTp18OTk3sHtqNsk6by5-Q@mail.gmail.com>
Message-ID: <CAK7LNARQ-PgxiCh+gm2efpfXmNBkdTp18OTk3sHtqNsk6by5-Q@mail.gmail.com>
Subject: Re: [RESEND PATCH] kconfig: Proposed language extension for multiple builds
To:     Tom Rini <trini@konsulko.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Simon Glass <sjg@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        U-Boot Custodians <u-boot-custodians@lists.denx.de>,
        barebox@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org
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

On Sun, Mar 12, 2023 at 1:55=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Mar 10, 2023 at 09:39:15PM -0800, Randy Dunlap wrote:
> > Hi--
> >
> > On 3/10/23 18:37, Simon Glass wrote:
> > > (I am sending this again to get more feedback)
> > >
> > > In the case of Linux, only one build is produced so there is only a
> > > single configuration. For other projects, such as U-Boot and Zephyr, =
the
> > > same code is used to produce multiple builds, each with related (but
> > > different) options enabled.
> > >
> > > This can be handled with the existing kconfig language, but it is qui=
te
> > > verbose, somewhat tedious and very error-prone, since there is a lot =
of
> > > duplication. The result is hard to maintain.
> > >
> > > Describe an extension to the Kconfig language to support easier handl=
ing
> > > of this use case.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > IMO Masahiro has already answered this multiple times and I agree with =
his answers.
> >
> > For others, the full previous thread is at
> >   https://lore.kernel.org/all/20230219145453.1.Idaaf79c3e768b85750d5a7e=
b732052576c5e07e5@changeid/
>
> Well, I think what was unclear, or maybe we just wanted to confirm the
> answer was "none at all", was this. As good community neighbors, we see
> a generic issue in the Kconfig language, a tool used frequently outside
> of just the Linux kernel, and would like to contribute back. Ideally
> without having first gone off, designed and implemented something, and
> then been told it's all wrong and to rewrite it first. So what level of
> interest is there in this?

Sorry, no interest.
If you want to get a clear answer, NACK.

>
> As I pointed out in that thread, I believe barebox has examples where
> some keyword like we're proposing here would help them (and yes, there's
> only a dozen or so symbols so it's also manageable without anything
> special),

Barebox keeps PBL in very limited, ad-hoc implementation.
PBL has no more than 10 user-configurable options.
Sascha Hauer designed it this way.



Linux kernel also has a small loader (a.k.a decompressor) in
arch/*/boot/decompress/.

For example, CONFIG_KERNEL_GZIP is a CONFIG option
for the decompressor instead of the main kernel.

In this sense, you could apply your theory,
"Linux kernel is also multi build-phases, so Kconfig should have this
extension to move CONFIG_KERNEL_GZIP to another build phase".
No, no. The main kernel and the decompressor are well separated
and the latter is small and simple.

Barebox is the same - the main Barebox and PBL are well separated
and PBL is really small and simple.

The problems you are suffering from do not exist in Barebox.



> and Simon believes Zephyr will be in a similar situation soon
> enough (which doesn't use the kernel's implementation of the language).

Zephyr does not share any Kconfig code with Linux.
They use Python implementation, a.k.a. Kconfiglib.
It is up to the Zephyr community, but this requires extra effort.

> Frankly, I keep going back to "tristate" is just the original example of
> what we're talking about here (CONFIG_FOO=3Dn, CONFIG_FOO_MODULE=3Dy), no=
t
> that I'm suggesting we would remove the tristate word.
> So we would really like to make sure as many people and projects are
> aware, as possible.

This is on the boundary.
We can make the tristate optional if it does not make the code too ugly.

But, if you do not add CONFIG_MODULES in your Kconfig file,
users will not see 'm' in the first place.

I know some help messages still mention 'm', but is this the problem
you want to solve?


> And as Simon asked in the thread, what about code refactoring that makes
> further maintenance easier? Clearly, such patches would need to be
> against the current appropriate tree.

If such patches clean up the code, they will be appreciated.

--=20
Best Regards
Masahiro Yamada
