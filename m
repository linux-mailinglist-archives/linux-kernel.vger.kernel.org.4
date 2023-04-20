Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE586E8894
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 05:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjDTDXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 23:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDTDX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 23:23:29 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E7D40CF;
        Wed, 19 Apr 2023 20:23:26 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3ef112cac17so884561cf.0;
        Wed, 19 Apr 2023 20:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681961006; x=1684553006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adX5pTpCGut2wVqn2rN7BfLycw+2K2wX215Yvm2Skj0=;
        b=kN5PYjRolVrzo8OdzXjG2rOObhk9NXqlw5+diqgNyC2lFH+mHjybp2OrGa8qxslDst
         DS6tzZKsYIX5JPMeMRj5vjJqmGTs5k1w6JyB6k+F6baS1FdhHaEs5Qm47/kAH9y6GL2z
         CCjDdQvrrz7iH1bKXrbaj95wakTU1WL6x3HjKOrDmTkRvsUhU9c2KQjWe8yBpt+Dut8p
         0noJ6Y3HC8HmyWAEF8wQuuMvYAiRpOGFoFJ+sJ1zsQmY5Fk1GBLChxhLWF8YcUz7S5wL
         /HijpkFN/AxMBFCbKacgAXlmHb5sH1iTP2t9xSKHKuSNNXAbJJqMylw/FiHN3IzrAURw
         9EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681961006; x=1684553006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adX5pTpCGut2wVqn2rN7BfLycw+2K2wX215Yvm2Skj0=;
        b=kjza6qSLNZXtXY/jWfsrTWwkvMx6j/kXI+u9EITXbA4u4yTbSZv1W+qkNoP7tMNKsi
         yigBn+m3jZfkikkLEkCENEbjF6OFU7xTz4xB7kpyvET20tys/sJ0SH1ox42rZcqEAykq
         am0KqdElrFra/5IeDg0mQnswxgQIoAAndOGLosCBUqe29pauWClHB+NxtHDwoHG+LvLD
         VEe/9TRF9Gvka0AZJuRxbmLwtJ22qt+SMXQJj+Q50NJxhEKUZAHgaQXh21ztwFeuALUz
         M1Sg4TQvRfBCeJFgpFdbhNbcxtvcOH5x6jNsZQmzlWp1z36nCD4UK9jy30nW0tBOpaVK
         wMCQ==
X-Gm-Message-State: AAQBX9fd2OlqVH74uqHxArNmIhSH7LxfQ0NIw2ASMqWlAE1a8jlH2YEi
        ZPU57l+d6sM39+82ul1GpKc=
X-Google-Smtp-Source: AKy350aWroSwDmcbYQlKlOqteeglmMI/KFEwoMZCeXscp4drJ7QNHYwvApYy9mDszjXeHjptfUZPGQ==
X-Received: by 2002:ac8:5f86:0:b0:3e6:3ba9:3c8d with SMTP id j6-20020ac85f86000000b003e63ba93c8dmr1285459qta.13.1681961005879;
        Wed, 19 Apr 2023 20:23:25 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m8-20020ac84448000000b003ec47cc3613sm199905qtn.85.2023.04.19.20.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 20:23:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id B79EA27C0054;
        Wed, 19 Apr 2023 23:23:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 19 Apr 2023 23:23:24 -0400
X-ME-Sender: <xms:LLBAZFPRcqepmUcS0jeaIyNE4UVu1tikgQGj8zb1cuFW_X0x5Mwawg>
    <xme:LLBAZH_Oba4SUNRw87mNp4PpuxE0Mjx76Khqh4JNNnb6LakV8KsrFYigzOK3oqgtt
    KJJ0vuHHaGz5_QXuQ>
X-ME-Received: <xmr:LLBAZEReu2KuDj8YdVPSkyuiopHjytxBHMnarLKxRdgvUWXOSMHP3avW3Vn4aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtuddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:LLBAZBunC4RgYkjvCJm8TfMS5nZZdXIvMpE-agTozO6MvBi0AmOCdA>
    <xmx:LLBAZNcsQGQ3MLPiJP4ZtGzcP1GUvrAKg4g4VgNSejSSm_m5AM7r2A>
    <xmx:LLBAZN3dtqCXWKUqBbSf-sUZZey272HecYmAHvxlBFI_wM0c57-GOw>
    <xmx:LLBAZL18FVj0cmNgxoJvYsYBxzGLkJa6YQn1-Yo-AD_h22GMclj1PA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Apr 2023 23:23:23 -0400 (EDT)
Date:   Wed, 19 Apr 2023 20:23:01 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 0/3] Rust 1.68.2 upgrade
Message-ID: <ZECwFUyUt77E/5MO@boqun-archlinux>
References: <20230418214347.324156-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418214347.324156-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:43:44PM +0200, Miguel Ojeda wrote:
> This is the first upgrade to the Rust toolchain since the initial Rust
> merge, from 1.62.0 to 1.68.2 (i.e. the latest).
> 
> Please see the last patch message for a long explanation of the upgrade,
> the policy for future upgrades and some indications on how to easily
> review this.
> 
> The series is based on `rust-next`.
> 

Works on my machine ;-)

Tested-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Miguel Ojeda (3):
>   rust: alloc: clarify what is the upstream version
>   rust: arc: fix intra-doc link in `Arc<T>::init`
>   rust: upgrade to Rust 1.68.2
> 
>  Documentation/process/changes.rst |   2 +-
>  rust/alloc/README.md              |   3 +
>  rust/alloc/alloc.rs               |  55 ++--
>  rust/alloc/boxed.rs               | 446 ++++++++++++++++++++++++++--
>  rust/alloc/collections/mod.rs     |   5 +-
>  rust/alloc/lib.rs                 |  71 +++--
>  rust/alloc/raw_vec.rs             |  16 +-
>  rust/alloc/slice.rs               | 447 ++++------------------------
>  rust/alloc/vec/drain.rs           |  81 +++++-
>  rust/alloc/vec/drain_filter.rs    |  60 +++-
>  rust/alloc/vec/into_iter.rs       | 125 ++++++--
>  rust/alloc/vec/is_zero.rs         |  96 ++++++-
>  rust/alloc/vec/mod.rs             | 464 +++++++++++++++++++++++-------
>  rust/alloc/vec/set_len_on_drop.rs |   5 +
>  rust/alloc/vec/spec_extend.rs     |  63 +---
>  rust/bindings/lib.rs              |   1 -
>  rust/kernel/build_assert.rs       |   2 +
>  rust/kernel/init.rs               |   5 +
>  rust/kernel/lib.rs                |   4 -
>  rust/kernel/std_vendor.rs         |   2 +
>  rust/kernel/sync/arc.rs           |   2 +-
>  scripts/Makefile.build            |   2 +-
>  scripts/min-tool-version.sh       |   2 +-
>  23 files changed, 1278 insertions(+), 681 deletions(-)
> 
> -- 
> 2.40.0
> 
