Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3013A666A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjALEgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbjALEfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:35:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB911DF00;
        Wed, 11 Jan 2023 20:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8814561EE8;
        Thu, 12 Jan 2023 04:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FC1C433F0;
        Thu, 12 Jan 2023 04:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673498145;
        bh=cEC/8ycHGZmpawhW7zGWVnL8kp2g8DOTp2ORTPKCtng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cd32bzC14tymjpdDMJhPRxnKI6ydKagoH+s1enPNPJnzuSYjiCpq0QhUJLuccxS+9
         1Evh46ERVNJmV3GbLANSkKE0KMi5t05sHqsp+njmTZVZaUCTV7WutILzYBxPcAbS/u
         psOMqTr+Fl3d3wFfgEviVW3StqTjHP35tvrRxPdv3LOD9l9iwKJklJXpbw/jN/F2cv
         11w7jd+PUvPlvqiL7aWuifcYBDK6ZxkpBgCmmsKRWbIl37ZM9306iXjPFn4pzG/Fki
         69tDkbzr6lL25yqvUvLapn+flhLqwRvFVmlL+rA2IfI8a7kN0b/UjvCnycmg+07JNe
         F+cQHWWlF9gwQ==
Received: by mail-oi1-f170.google.com with SMTP id r130so14454681oih.2;
        Wed, 11 Jan 2023 20:35:45 -0800 (PST)
X-Gm-Message-State: AFqh2kpq15RJWSC+AOxJ7BaOxr7cD2Xyy55f0vjo7ykVAQU06jFb7W2W
        BacFKA5Pp/FZis/bn6EYN/I5/7HIU3MYbjgoPgk=
X-Google-Smtp-Source: AMrXdXsv4uFA2ckMcPSKcLyd59iRAkaYtzx3HgzCgDZGW9c0li9O94jf5ZN16WBncqaFzqsZn9xLrJ45AEfChZuqpgQ=
X-Received: by 2002:a05:6808:1510:b0:364:5d10:7202 with SMTP id
 u16-20020a056808151000b003645d107202mr422189oiw.194.1673498145165; Wed, 11
 Jan 2023 20:35:45 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-3-ojeda@kernel.org>
 <CAK7LNATVJ5e=DnbJ++03iEMk0bN3-UvODBLkEKcYdSnJZa_tmA@mail.gmail.com>
In-Reply-To: <CAK7LNATVJ5e=DnbJ++03iEMk0bN3-UvODBLkEKcYdSnJZa_tmA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 Jan 2023 13:35:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASDu+i4G88TYYa6feg-bha-_cLv1si_ujuSMbWuyUve0Q@mail.gmail.com>
Message-ID: <CAK7LNASDu+i4G88TYYa6feg-bha-_cLv1si_ujuSMbWuyUve0Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] kbuild: rust_is_available: add check for `bindgen` invocation
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alexandru Radovici <msg4alex@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
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

On Thu, Jan 12, 2023 at 1:33 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Jan 10, 2023 at 5:45 AM Miguel Ojeda <ojeda@kernel.org> wrote:
> >
> > `scripts/rust_is_available.sh` calls `bindgen` with a special
> > header in order to check whether the `libclang` version in use
> > is suitable.
> >
> > However, the invocation itself may fail if, for instance, `bindgen`
> > cannot locate `libclang`. This is fine for Kconfig (since the
> > script will still fail and therefore disable Rust as it should),
> > but it is pretty confusing for users of the `rustavailable` target
> > given the error will be unrelated:
> >
> >     ./scripts/rust_is_available.sh: 21: arithmetic expression: expecting primary: "100000 *  + 100 *  + "
> >     make: *** [Makefile:1816: rustavailable] Error 2
> >
> > Instead, run the `bindgen` invocation independently in a previous
> > step, saving its output and return code. If it fails, then show
> > the user a proper error message. Otherwise, continue as usual
> > with the saved output.
> >
> > Since the previous patch we show a reference to the docs, and
> > the docs now explain how `bindgen` looks for `libclang`,
> > thus the error message can leverage the documentation, avoiding
> > duplication here (and making users aware of the setup guide in
> > the documentation).
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Reported-by: fvalenduc (@fvalenduc)
> > Reported-by: Alexandru Radovici <msg4alex@gmail.com>
> > Link: https://lore.kernel.org/rust-for-linux/CAKwvOdm5JT4wbdQQYuW+RT07rCi6whGBM2iUAyg8A1CmLXG6Nw@mail.gmail.com/
> > Link: https://github.com/Rust-for-Linux/linux/issues/934
> > Link: https://github.com/Rust-for-Linux/linux/pull/921
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
> >  scripts/rust_is_available.sh | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> > index c907cf881c2c..cd87729ca3bf 100755
> > --- a/scripts/rust_is_available.sh
> > +++ b/scripts/rust_is_available.sh
> > @@ -108,8 +108,29 @@ if [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cvers
> >  fi
> >
> >  # Check that the `libclang` used by the Rust bindings generator is suitable.
> > +#
> > +# In order to do that, first invoke `bindgen` to get the `libclang` version
> > +# found by `bindgen`. This step may already fail if, for instance, `libclang`
> > +# is not found, thus inform the user in such a case.
> > +set +e
> > +bindgen_libclang_output=$(LC_ALL=C "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null)
> > +bindgen_libclang_code=$?
> > +set -e
> > +if [ $bindgen_libclang_code -ne 0 ]; then
> > +       echo >&2 "***"
> > +       echo >&2 "*** Running '$BINDGEN' to check the libclang version (used by the Rust"
> > +       echo >&2 "*** bindings generator) failed with code $bindgen_libclang_code. This may be caused by"
> > +       echo >&2 "*** a failure to locate libclang. See output and docs below for details:"
> > +       echo >&2 "***"
> > +       echo >&2 "$bindgen_libclang_output"
> > +       echo >&2 "***"
> > +       exit 1
> > +fi
> >
>
>
> Instead of toggling -e, why don't you write like this?
>
>
> if ! bindgen_libclang_output=$(LC_ALL=C "$BINDGEN" $(dirname
> $0)/rust_is_available_bindgen_libclang.h 2>&1); then
>        [snip]
> fi
>


I meant this:



if ! bindgen_libclang_output=$(LC_ALL=C "$BINDGEN" $(dirname
$0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null); then
       [snip]
fi




(">/dev/null" was lost in the previous email)




-- 
Best Regards
Masahiro Yamada
