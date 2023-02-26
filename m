Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953476A3478
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjBZWNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBZWNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:13:46 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12464D32C;
        Sun, 26 Feb 2023 14:13:44 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c19so4835433qtn.13;
        Sun, 26 Feb 2023 14:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YSvtnIwZ5WRViy9d2TMUt/v4cYgNq+s2fM5I8EDWvtc=;
        b=L4BNZgYJuHmXZh6jpoP1Ok9qx7UtcelHbhasYhA4IjxXL4dlyxMpdyC3rC1qmzJNvP
         /9IQsj9TzVY3a8ccbhkO3L71/rQUVTG28Co0H+XPVApyxYfTsWtxqgG+WL/MwS1X/+ib
         SytdzsQviD065IwWMRpEuCPJuPzon7eOjVevuUQ4CTHhiIoP4F28COli8oUlal2NV24O
         9QWi9kAUMrK5buVW286Sf+2jkLkdsuDBbAzwhZA7hQ9MJpCIToRqGF5BIIT8CZVrpt9M
         FeAr/Cu5Rh+qEuNYoeK91j322nC0pLdGry0q2LHwNnGpON/6Tmgx8ffhImmXTmI4+roA
         SV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSvtnIwZ5WRViy9d2TMUt/v4cYgNq+s2fM5I8EDWvtc=;
        b=bpfGjpdsChjZ37UnVqElcveEJbHo/rrbjIbopIxYzekRgGT1j0GNO0qE8KJnnhVgUD
         r+1BUKfYXshIFSNHezmP0JaAP0V5MGZrpe4jRXekYnLFULll0KeXYPKGtkfBRc3kAh7P
         Nf2xvN+nmCPDz+e8JVPGE/41nmlRylcgCwlPWOe18gBqghRRwkmz1wfxpa6tg+75C9EL
         3ufwpy/GTVA0vrlIDos2pbOhgbK33mH3VukrH488PrbHGIrx+k2SxJZUIjgvyrIsiKnv
         OLbsR/a253OuzAOebQSs4aBgaVzHF7OhGnGp/49RxgYIQkdNpOjc4FEWUtriajvU80/3
         xAoQ==
X-Gm-Message-State: AO0yUKXBh8Oowl4ybQUEg9CicZlRfWyHHJL67/lmlRQOk5a0iKFKV456
        V8bG+eq1L54jdgyVPrYAQF0=
X-Google-Smtp-Source: AK7set8OSDr9hpaY3SS9NJn62sJ2bXOTexDdPhu2v9fo9Er1B7ekjKM958IsuZx9UXYVFoDTvWAPZQ==
X-Received: by 2002:a05:622a:14d:b0:3af:4d45:b73 with SMTP id v13-20020a05622a014d00b003af4d450b73mr38461022qtw.33.1677449623091;
        Sun, 26 Feb 2023 14:13:43 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s67-20020a374546000000b007424239e4casm3693819qka.117.2023.02.26.14.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:13:42 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id DC8C427C005A;
        Sun, 26 Feb 2023 17:13:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 26 Feb 2023 17:13:41 -0500
X-ME-Sender: <xms:ldn7Y9MxJP_Xb8X2x5kL8DyZwUd3MB9H_3v_NCxxM1xn59h7UdnjsQ>
    <xme:ldn7Y__kpldqhgC5CigpCQZFRteHVtnv5UUZpKQpqd_fxMXVAc3YyiERgX1bJa6lo
    VmBr9DK6FeyfUZhRg>
X-ME-Received: <xmr:ldn7Y8TyQHhlOWxrMzdLVuLe7ZO3yz1aiZtsNbX16W4isapw4vpqTUsE-XE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekkedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeeiheefkefgvdefteejjedukefhieevleeffeevheehfeffhfekhfet
    veffvefhgfenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqd
    gsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ldn7Y5vhVpdg9h2nrjjzK09-X1mA5DAX1zBOzolz83Wgv46q_qk68w>
    <xmx:ldn7Y1cV1x8UZgRu72e7OQSzTTvNGi6bfV9m5V-GPAsIMJR9tKnb7g>
    <xmx:ldn7Y13c2mpU-Wt3-ayaJxTrAQiwbqCHpBjpXfJ5aB1Gdk8pdASLyQ>
    <xmx:ldn7Y13ABND4N80_SL-DSpTCU0B8VvHieRwiYaLIBETvBFp07bRxtg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Feb 2023 17:13:40 -0500 (EST)
Date:   Sun, 26 Feb 2023 14:13:10 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>, Asahi Lina <lina@asahilina.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 5/5] rust: error: Add from_kernel_result!() macro
Message-ID: <Y/vZdv6IVmrcP7wR@boqun-archlinux>
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-5-f8f9a9a87303@asahilina.net>
 <Y/lOlcSpc+d9ytq/@boqun-archlinux>
 <20230225222340.34d749ee.gary@garyguo.net>
 <Y/rCU1S+GDgIojNf@boqun-archlinux>
 <20230226133606.583cd1d8.gary@garyguo.net>
 <Y/uiAfZnfbbMrQuD@boqun-archlinux>
 <CANiq72kTiHF76T0AycM43qj4rUgQpHzBqXujdvk+H2qoDz22AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kTiHF76T0AycM43qj4rUgQpHzBqXujdvk+H2qoDz22AQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 09:59:25PM +0100, Miguel Ojeda wrote:
> On Sun, Feb 26, 2023 at 7:17 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > My preference to function instead of macro here is because I want to
> > avoid the extra level of abstraction and make things explict, so that
> > users and reviewers can understand the API behavior solely based on
> > Rust's types, functions and closures: they are simpler than macros, at
> > least to me ;-)
> 
> There is one extra problem with the macro: `rustfmt` does not format
> the contents if called with braces (as we currently do).

Interesting, sounds like a missing feature in `rustfmt` or maybe we
don't use the correct config ;-)

> 
> So when I was cleaning some things up for v8, one of the things I did
> was run manually `rustfmt` on the blocks by removing the macro
> invocation, in commit 77a1a8c952e1 ("rust: kernel: apply `rustfmt` to
> `from_kernel_result!` blocks").
> 
> Having said that, it does format it when called with parenthesis
> wrapping the block, so we could do that if we end up with the macro.
> 
> > First, I think the macro version here is just a poor-man's try block, in
> > other words, I'd expect explicit use of try blocks intead of
> > `from_kernel_result` when the feature is ready. If that's the case, we
> > need to change the use sites anyway.
> 
> Yeah, if we eventually get a better language feature that fits well,
> then we should use it.
> 
> > Do both implementation share the same behavior?
> 
> Yeah, a `return` will return to the outer caller in the case of a
> `try` block, while it returns to the closure (macro) in the other
> case. Or do you mean something else?
> 

"Yeah" means they have different behaviors, right? ;-)

Thanks for confirming and I think you get it, but just in case for
others reading this: if we use the macro way to implement
`from_kernel_result` as in this patch:

	macro_rules! from_kernel_result {
	    ($($tt:tt)*) => {{
		$crate::error::from_kernel_result_helper((|| {
		    $($tt)*
		})())
	    }};
	}

and later we re-implement with try blocks:

	macro_rules! from_kernel_result {
	    ($($tt:tt)*) => {{
		$crate::error::from_kernel_result_helper(try {
		    $($tt)*
		})
	    }};
	}

the `from_kernel_result` semantics will get changed on the `return`
statement inside the macro blocks.

And this is another reason why we want to avoid use macros here. Code
example as below:

	https://play.rust-lang.org/?version=nightly&mode=debug&edition=2021&gist=58ea8b95cdfd6b053561052853b0ac00

`foo_v1` and `foo_v3` has the exact same function body, but behave
differently.

> In that case, I think one could use use a labeled block to `break`
> out, not sure if `try` blocks will allow an easier way.
> 
> We have a case of such a `return` within the closure at `rust/rust` in
> `file.rs`:

Thanks for finding an example! Means we did use return.

For this particular API, I'd say function right now, `try` blocks if
avaiable.

Regards,
Boqun

> 
>     from_kernel_result! {
>         let off = match whence as u32 {
>             bindings::SEEK_SET => SeekFrom::Start(offset.try_into()?),
>             bindings::SEEK_CUR => SeekFrom::Current(offset),
>             bindings::SEEK_END => SeekFrom::End(offset),
>             _ => return Err(EINVAL),
>         };
>         ...
>         Ok(off as bindings::loff_t)
>     }
> 
> Cheers,
> Miguel
