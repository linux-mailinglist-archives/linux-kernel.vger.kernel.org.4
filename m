Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B47660D21
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjAGJKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:10:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB19271A7;
        Sat,  7 Jan 2023 01:10:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AE34609FB;
        Sat,  7 Jan 2023 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D6BC433F0;
        Sat,  7 Jan 2023 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673082626;
        bh=IBB4vS9uXFcRA5vbIOpEIyUnvisvZwkqPn9Sb1Psd/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ppMRysQWQN03Z7wpwi3vlzb66/WBwSqtJiTO7+Uoaa4xEfOJfhWqTqKevE+06AMs/
         TyQwRzcX5X3FQ2S+h/s0U8CDyNBpVsPi1BPzA7VJbaufr+Q1gfuZKMts2blyiEE0Ug
         WwnZ32r1b8IRcfZqPR5S83nMC6jxtD6ToBfj0netvBYB8/Pv+piXsVYHm9YKMBLBqZ
         lJnZl9GUvleKl9TlA4thg5PrX22UnwpSkQGsZ7CP8J2oQUENp8Stxi3mx5JGTY3+Pg
         PBPEp8+ZfwDdMRFbjW/Vh1ihT97RYQ3KRi9Y9Al2jUjsGNCpBS0L2bWbhOFYngL5Pf
         6L4b4iaxQVHXw==
Received: by mail-ot1-f46.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso2264088otn.2;
        Sat, 07 Jan 2023 01:10:26 -0800 (PST)
X-Gm-Message-State: AFqh2kozTnXskRRHi96JnMTIvFvZDG2GUwK7uXu+oF+eff/0BfGC7dtK
        hqR7X464q6F7eTUQE9uUrIxvOTesPftUc8ZoDHA=
X-Google-Smtp-Source: AMrXdXuWtj+rWB/s6w4ffQZ35ddawNN5ZxJS3aZYJbk/c2fIqmUiiMaTwh5RfwH7fXDlq+d4890py22AWrj/Cm7q+20=
X-Received: by 2002:a9d:128c:0:b0:66c:794e:f8c6 with SMTP id
 g12-20020a9d128c000000b0066c794ef8c6mr3619042otg.343.1673082625996; Sat, 07
 Jan 2023 01:10:25 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org>
 <20221231064203.1623793-2-masahiroy@kernel.org> <CANiq72k8LSqsnWNd_aa-M1=rMNLWD7KJWrK6Pv0Waq15Exv59g@mail.gmail.com>
In-Reply-To: <CANiq72k8LSqsnWNd_aa-M1=rMNLWD7KJWrK6Pv0Waq15Exv59g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 7 Jan 2023 18:09:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT7of2JqjYpaM0=fZTB5PG9Sike9-mcKxHS12JwfEAbQA@mail.gmail.com>
Message-ID: <CAK7LNAT7of2JqjYpaM0=fZTB5PG9Sike9-mcKxHS12JwfEAbQA@mail.gmail.com>
Subject: Re: [PATCH 1/6] kbuild: specify output names separately for each
 emission type from rustc
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        llvm@lists.linux.dev, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 5:45 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Dec 31, 2022 at 7:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> >   $ make -j$(nproc) samples/rust/rust_minimal.o samples/rust/rust_minimal.rsi \
> >                     samples/rust/rust_minimal.s samples/rust/rust_minimal.ll
>
> Yeah, we were testing the single targets, but not multiple at once, thanks!
>
> > +               --emit=dep-info=$(depfile) --emit=obj=$@ --emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
>
> Perhaps a newline here to avoid the lengthy line?


OK, I will wrap it in v2.


>
> >  hostc_flags    = -Wp,-MMD,$(depfile) $(_hostc_flags)
> >  hostcxx_flags  = -Wp,-MMD,$(depfile) $(_hostcxx_flags)
> > -hostrust_flags = $(_hostrust_flags)
>
> This was originally meant to be consistent with C and C++ indeed, but
> if you prefer less variables, I guess it is fine, in which case,
> should we update the C/C++ side too (in another series)?


Yup, we could do this with less variables.
I will send a clean up.


> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
>
> Cheers,
> Miguel



-- 
Best Regards
Masahiro Yamada
