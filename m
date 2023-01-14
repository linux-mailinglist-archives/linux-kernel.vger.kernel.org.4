Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5D66AB64
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 13:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjANMea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 07:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjANMe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 07:34:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F6B869E;
        Sat, 14 Jan 2023 04:34:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5829CB807E8;
        Sat, 14 Jan 2023 12:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEC1C43392;
        Sat, 14 Jan 2023 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673699663;
        bh=4hogCgx26O6O66FhdhmvB8UE2W3v4MDEQPIa4tPZ7wg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S23PGG2Hrb07B5ZjmoVblAHiG7+WSQvjOSRlZBPyRME5RxG8uB54fQbPX1Z4ObGfr
         xoyg4MZNsmIXIDr/Dcs1JxvOTPsG7msX2q9aLI55eyzW57U1EjZsBm+5OTpWcxNpLY
         NAoXxYcFdKrrybubfWk8SxmqugfIKih1D7+gNh5jwVjc72ZKoVi9oklyn4F0xzE26h
         gE0K8bLzrZub0mCYECqOz/PFkkhSlowDsB02qAtgiPMMciQrU5xu6CmR8FICzL14kH
         z1k8YdhnIZSCrN4+R8YhX1m/nso9qc2r2u3CH/tfqwjX75LGPPTkPzlGYFOLzOEjlT
         bc+6Diy1C83Tw==
Received: by mail-oi1-f170.google.com with SMTP id s124so2872730oif.1;
        Sat, 14 Jan 2023 04:34:23 -0800 (PST)
X-Gm-Message-State: AFqh2kqzzEjZjs77TiywL42K1WAhSEQWfvd/WoIyaHnQftUZsvTmHtes
        zZLfFrGUKv1yBmpBqay7j8uPOwFCrW5eiKiv6II=
X-Google-Smtp-Source: AMrXdXuObkR9oQqxl9vnf+el/NKIwPtqYJCa8ifp41xFh4Xjg1eIDi8pMipHHu+sN/pnkq8+yvVJCnxFcm1jqZOAvBE=
X-Received: by 2002:a05:6808:1510:b0:364:5d10:7202 with SMTP id
 u16-20020a056808151000b003645d107202mr799454oiw.194.1673699662783; Sat, 14
 Jan 2023 04:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-4-ojeda@kernel.org>
 <CAK7LNARuGz=oFukWH4g=7zg1EbWP9rxpVXPgPrJBKHzLQW4N1Q@mail.gmail.com> <CANiq72=Evg9pQLCdtr+kTsr4fEewjKCkBw2dBYTB7WbPVy2wtg@mail.gmail.com>
In-Reply-To: <CANiq72=Evg9pQLCdtr+kTsr4fEewjKCkBw2dBYTB7WbPVy2wtg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 14 Jan 2023 21:33:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARnNEJVuBKaFnE2TL60ku_6F03C749BVjzr8E6-khPTJg@mail.gmail.com>
Message-ID: <CAK7LNARnNEJVuBKaFnE2TL60ku_6F03C749BVjzr8E6-khPTJg@mail.gmail.com>
Subject: Re: [PATCH 4/6] kbuild: rust_is_available: check if the script was
 invoked from Kbuild
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

On Sat, Jan 14, 2023 at 8:12 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 12, 2023 at 6:29 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > I do not like this.
> > We do not need to cater to every oddity.
> >
> > Checking MAKEFLAGS is too much.
>
> I agree we should not attempt to catch every possible mistake in the
> script, but there have been several people hitting precisely this case
> (the latest is in the linked thread in the commit message), i.e. some
> people read the `Makefile` and notice the script invocation, and go
> execute it, but they are unlikely to be aware of the target in that
> case.
>
> > You can check RUSTC/BINDGEN/CC if you persist in this.
>
> This is fine, and actually we should do it regardless of `MAKEFLAGS`.
> I can add it to v2.
>
> However, that does not cover the same thing as `MAKEFLAGS` is trying
> to here. The reason is that even if they see e.g. "RUSTC is not set",
> they will not know about how to call the script properly, i.e. through
> the `Makefile` target.
>
> For `RUSTC` and `BINDGEN`, it does not really matter (and we could
> give a default to the variable, since the name rarely would be
> different). However, for `CC`, the logic that Kbuild uses is more
> complex, so it seems best to me to let Kbuild tell us what the actual
> compiler is.
>
> Cheers,
> Miguel


OK, you maintain this script, so it is up to you.



-- 
Best Regards
Masahiro Yamada
