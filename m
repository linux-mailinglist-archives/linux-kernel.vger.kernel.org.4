Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0693B708A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjERVYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjERVYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:24:37 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3812E45;
        Thu, 18 May 2023 14:24:36 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7577ef2fa31so8553285a.0;
        Thu, 18 May 2023 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684445076; x=1687037076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgw3h9rAgm44YkEHXCPBK7C8FU1OMPHOzKXIy/8Zym0=;
        b=kph38xd19+bhLkS7PBNJQmjYiRXXbogSNSiH0Q5MEmL2DX8YmSJHAH0GgziFVvZn2y
         nELH46i2vuIvVbCfpwZV4EAOP0j04cFX8eUZ4pjDhmu8cckVJgKsx72k6pkd2AXxCYKG
         xh/t2rL50MrW8G7LR9K3CbM543nfvTW1dt4Y4j02Au+J392LYMiYjm6a5FjjmGNrB3QP
         hYo6XtFmMqenQPqajZ8UZDrhbNQiySvVQ0SKviU8pE9siXJ0T/6KGlpE1HVuYlTdKmbU
         Y09OVBXpsu9OWglqyM5PEERe+Ksq9amOE/6vkZPK3qDS+pGlZR56xArvN4pFdzI316i7
         2JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684445076; x=1687037076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fgw3h9rAgm44YkEHXCPBK7C8FU1OMPHOzKXIy/8Zym0=;
        b=FaXnZvpKzw/k8YMNRdLOHIQO4Wqmf0oPqbT5gWbTYARAjl1C0jqb81ug6cinW/Jgbb
         3/xSxWLm7LcS9nV4s9LnjYutkvyB4UOSWk5fHDZPDF1MuoywhHGpqQ34x9uy4Ub7NsHd
         1mu8N532Rj0MC6vHGaH7lIbwez4YCt8xpdOnHZ6JMJ6aG0MgdRp2JV5THZOMi4Yp4djJ
         gtwSeNHmyNWbL2sE2WHFlpTrfO3qBDI3VdQB6pYwiZ17tZszH21ef1E8wLsgDH+Q4Ma9
         nYuosYstTDHQctyd2aNYNo7jPk/9aPEibUAfVgUCxcAz+JqfNj/auZp6YpCEb/P/35mN
         vrNw==
X-Gm-Message-State: AC+VfDyCn3nC0od0bZNhZN4LpOSyy/QMEsLTz41fdsE3oNvrMebPpccO
        kc2eVDZN3LZnqHzXwHx6kro=
X-Google-Smtp-Source: ACHHUZ6N+5BKXIb2VODVQypeLfhqjkNDqfCIAEWmLr3NN4P7PZLTE382xgQF5sekxjyf/s88BGo36Q==
X-Received: by 2002:a05:6214:20ac:b0:623:5c93:77eb with SMTP id 12-20020a05621420ac00b006235c9377ebmr1779425qvd.13.1684445075710;
        Thu, 18 May 2023 14:24:35 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id mm19-20020a0562145e9300b005dd8b934579sm818981qvb.17.2023.05.18.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:24:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 263C227C0054;
        Thu, 18 May 2023 17:24:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 18 May 2023 17:24:34 -0400
X-ME-Sender: <xms:kZdmZDSneEX1kXbuwH7cu7l1r8M1HUt8db6Frkudpp0mNNfR9uTNxQ>
    <xme:kZdmZEwFfn67VVXdPXYk9iY4PbjH88G-WHeRbhwStX90GaUJ-2Hjh1kZ4lCWaNEOh
    Yrwg45M5Z2bjAKT2A>
X-ME-Received: <xmr:kZdmZI3h2tWjU4IKiNpWg9LRsQ2tZSns2ehPUt1miEmNbB6I04IgUWVHDfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeifedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:kZdmZDAjti1gsxVBbTEMV74nhPH0kT1V0bQ3_kIBI4lTd0NiwFnwKw>
    <xmx:kZdmZMjfrWb_MGtilHx2tN4iZEEFIE1OCUX8F7MOVCvRjMFFAUwJKA>
    <xmx:kZdmZHqUXCzz0aBcio3S4JSUBLrNPXV78uFU-GHUny3NKGrtU_0SaA>
    <xmx:kZdmZLRRJh0W1aTuHOVOpklEw9kgA_IB3epWENHTHjZFpk_MCIfFuA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 May 2023 17:24:32 -0400 (EDT)
Date:   Thu, 18 May 2023 14:24:05 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 1/2] rust: specify when `ARef` is thread safe
Message-ID: <ZGaXdS+psZoEZBMr@boqun-archlinux>
References: <20230517095905.3548100-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517095905.3548100-1-aliceryhl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 09:59:04AM +0000, Alice Ryhl wrote:
> An `ARef` behaves just like the `Arc` when it comes to thread safety, so
> we can reuse the thread safety comments from `Arc` here.
> 
> This is necessary because without this change, the Rust compiler will
> assume that things are not thread safe even though they are.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/types.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 29db59d6119a..9c8d94c04deb 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -321,6 +321,17 @@ pub struct ARef<T: AlwaysRefCounted> {
>      _p: PhantomData<T>,
>  }
>  
> +// SAFETY: It is safe to send `ARef<T>` to another thread when the underlying `T` is `Sync` because
> +// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
> +// `T` to be `Send` because any thread that has an `ARef<T>` may ultimately access `T` directly, for

Does the "ultimately access `T` directly" here imply mutably or
exclusively? If so, it makes sense to me to call it out. I'm trying to
make sure we can agree on some "common terminologies" ;-)

Regards,
Boqun

> +// example, when the reference count reaches zero and `T` is dropped.
> +unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
> +
> +// SAFETY: It is safe to send `&ARef<T>` to another thread when the underlying `T` is `Sync` for the
> +// same reason as above. `T` needs to be `Send` as well because a thread can clone an `&ARef<T>`
> +// into an `ARef<T>`, which may lead to `T` being accessed by the same reasoning as above.
> +unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
> +
>  impl<T: AlwaysRefCounted> ARef<T> {
>      /// Creates a new instance of [`ARef`].
>      ///
> 
> base-commit: ac9a78681b921877518763ba0e89202254349d1b
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 
