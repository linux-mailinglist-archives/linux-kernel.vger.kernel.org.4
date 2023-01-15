Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78866B06F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 11:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjAOKtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 05:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjAOKtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 05:49:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBE5CDEC;
        Sun, 15 Jan 2023 02:49:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1769DB80B06;
        Sun, 15 Jan 2023 10:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D63C433EF;
        Sun, 15 Jan 2023 10:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673779775;
        bh=OgDN7XhvhGQQg/Z/xx44nHHo48uhQDWG853IVpEr0qg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jRu03WoQyLf3Q1MTtBJGdW33TWSMSPOrmQhLdT+xnDfJ7YIdIDNScdarn7+g6qq6q
         2s7sM4PNPiTXtFeOvgspA5z0XK2i4S8hhvHqvvFmLNZr/0vsSNhba9P+6NlObUvwzU
         NzbFpwasTLYnHKK/8rPRVmatK3EaNtVIP8hSTV3dX57bNHclJvCFjmY6L5Q93sKmYl
         586BiHqcSpna9tagaXItYJVJ5rnwfr9DqXy5ldCRKiSs2sYTlrHpke7uuv8H/A1w2Q
         MnbE6WrXP9GF8is2nuOPD0eH53xqebBa5kd2xQ2upym1nEpftCsZ1ipyOu7TYW24jP
         DptK4Q+7G2lhA==
Received: by mail-oi1-f169.google.com with SMTP id d127so21057645oif.12;
        Sun, 15 Jan 2023 02:49:35 -0800 (PST)
X-Gm-Message-State: AFqh2kpnWHo0wsF1jqkr0MW7tLgG2cB5A7twk0JcMdMVkJA5CxyoLUGw
        zivvQwzr8R28N5wETFZ+oqEO/HIAEpVAoUPmJfo=
X-Google-Smtp-Source: AMrXdXsiOdEBrkARrRYgYGuTHYvZmu28Gequ+ROkp35laCJSEQSVS9ZQ8Wg1wGKkiSSWBJGblYa+uOBVMR71pEJznq0=
X-Received: by 2002:aca:3755:0:b0:35e:7c55:b015 with SMTP id
 e82-20020aca3755000000b0035e7c55b015mr5483293oia.287.1673779774935; Sun, 15
 Jan 2023 02:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-6-ojeda@kernel.org>
 <CAK7LNAQYk6s11MASRHW6oxtkqF00EJVqhHOP=5rynWt-QDUsXw@mail.gmail.com>
 <CANiq72kyUr9PGYqHTsNzYn0_cyuYA0vAxHLC08ivxKo5XvOESg@mail.gmail.com> <CAK7LNASawny3wSTvjB8-CZJ2Mw8UnB0C4k5-X8yC8TyrmsM8RQ@mail.gmail.com>
In-Reply-To: <CAK7LNASawny3wSTvjB8-CZJ2Mw8UnB0C4k5-X8yC8TyrmsM8RQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 15 Jan 2023 19:48:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT0p0N=DtNpUsCuw=rhLNRY5VeozYr-XL4WxJ+0bfszyg@mail.gmail.com>
Message-ID: <CAK7LNAT0p0N=DtNpUsCuw=rhLNRY5VeozYr-XL4WxJ+0bfszyg@mail.gmail.com>
Subject: Re: [PATCH 6/6] kbuild: rust_is_available: normalize version matching
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 11:48 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Jan 14, 2023 at 8:15 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Thu, Jan 12, 2023 at 7:23 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Maybe, your purpose is to use sed consistently, but
> > > perhaps you can avoid forking sed if you know the
> > > format of the first line.
> >
> > The most unknown format would be the one of the libclang check, where
> > there may be other lines before the one we are interested in. However,
> > the pattern expansion would still match newlines, right?
> >
> > > BTW, what is missing here is, you do not check if
> > > ${RUSTC} is really rustc.
> > >
> > > I can fool this script to print
> > > "arithmetic expression: expecting primary: "100000 *  + 100 *  + "
> >
> > We can test if nothing was printed by `sed` for that (or do it with
> > shell builtins).
> >
> > Having said that, I would say fooling the script on purpose is an more
> > of an oddity compared to the case `MAKEFLAGS` attempts to cover
> > (please see my reply on the other patch). So if we cover this, then I
> > would say we should really cover the other one.
>
>
>
> get_canonical_version() in scripts/as-version.sh has
> a little more trick to avoid
> "arithmetic expression: expecting primary: "100000 *  + 100 *  + "
> but it is up to you.



My code accepts anything that is separated by dots
(and non-numerical strings are silently turned into zero).

Your code takes exactly the "([0-9]+\.[0-9]+\.[0-9]+)" pattern,
so it works very safely.

I think using sed is fine.





-- 
Best Regards
Masahiro Yamada
