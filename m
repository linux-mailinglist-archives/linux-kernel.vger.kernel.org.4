Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8348874FF74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjGLGgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjGLGgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:36:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7912D2704;
        Tue, 11 Jul 2023 23:34:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98e39784a85so85573166b.1;
        Tue, 11 Jul 2023 23:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689143629; x=1691735629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56MvB/3J+JBad1W9kmthsh6h04x3MOa3xhholvgYzw0=;
        b=kz0Icblc2nOJf9B6GXFsVTBSIi4xIXs1OfAGvyjNu6s3gUpwbZmbRCF7OZVFq9ZGwm
         4xBrIC8eYWetaUj9dS7qC1kEfFeG9/M5rFR7h6aUjkDunzPBBn3hWhH8nncb6iodBKE1
         f9wIwa7zddZsQTfQe0S2yQ1vHtAarEENPTdzQhZnBnHP+mi0Md6jEzNWbRbociSCW/Mc
         KXcAHhDfmueBCzh52I2MlG/K9Tqym047xSCQr2T4nYMr7KSCfZam0W3CT3zKNP/gPjlI
         amnf+BqIVUd7g1AeyYgRMSljANqYd1KEb+6ZM1BjIH8G2ud5oOsi3cAG0OvGGMJ33FRR
         pLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689143629; x=1691735629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56MvB/3J+JBad1W9kmthsh6h04x3MOa3xhholvgYzw0=;
        b=crG1YDlF8AmV6AldEw8j1gkA75yltgvM1QhtW9PXNcF8Btk+A+YsgOGlyx+ex1JvVY
         rbpUuj82NZusZTSKqH7UoRGtfDnK1+hx5bFDxXP5qdGD5ufU/w4xaAEiDcun67aMOUll
         cy+2Jk51hljJn49wr3jl8CvQYIf6SDsB7RzhNcbzRhYggyeZlKGyjK1h1/XPPDmn0tiG
         gL3w+YPSR3IEEso/00ZHzxiGzO8LWqpwpEbNHe+CNheW7WcY4mOngA+t/SmnRBvhy+Bl
         ewA4EmwknVOvluqtotKVPwQZ5Ecx+24y+VBSmftQkq6LmVrnf/vaZ5T8EiY1W338WdcB
         v3Jg==
X-Gm-Message-State: ABy/qLbzXSVl5LFm1Rx2mcgKH2pfte4hrm9ke/Yguex3tv1RAGzjb6TY
        5Vr5aULT4B0s8j1aeB8wbYw=
X-Google-Smtp-Source: APBJJlHT05ZQoF6ZT6j4+rJSGyHdyiBTHn+vCRN6hsRI1moTFmRe6AdNpPaWo4xB4RhTr9H53qu+6A==
X-Received: by 2002:a17:906:11e:b0:988:15f4:fdba with SMTP id 30-20020a170906011e00b0098815f4fdbamr1360656eje.14.1689143628737;
        Tue, 11 Jul 2023 23:33:48 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id qw5-20020a170906fca500b00992ed412c74sm2080021ejb.88.2023.07.11.23.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 23:33:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id D86C527C0054;
        Wed, 12 Jul 2023 02:33:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 12 Jul 2023 02:33:45 -0400
X-ME-Sender: <xms:SUmuZKdRNrlikRoDL6d4xzhJPu2aBW0sjgx-UKpTil8dXeAFVpqYtw>
    <xme:SUmuZEPqZgn_lKhliYAHjYphQGWslgFVikemg2ivHYjP0_87siAwanTta5iU3CA-_
    wEtFwEKkMgKl_n6zA>
X-ME-Received: <xmr:SUmuZLhIbn7SkpR_RaRAtLPaZiNQynUZfZkj3VtMcajPgmKITMEukXxhNjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedugddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:SUmuZH-yzci95aWcFY3r11zLGVkKuBRj7UxDmNO7weaHddrtQquyIg>
    <xmx:SUmuZGveSjnSs5n85ud5xfcE9k2hgtXxfP8I00kzL6dwAZ-kwgSlTw>
    <xmx:SUmuZOFxP_5KMekgJCIKmjKfoxXFKVNE2q8x6staJ0WIflHfn9fY9g>
    <xmx:SUmuZHHvWlvbEMvwcL_uTy_sA4Odrd62iCoSB4X4tQ1TQmjPPadvEQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 02:33:44 -0400 (EDT)
Date:   Tue, 11 Jul 2023 23:33:42 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 3/9] workqueue: introduce `__INIT_WORK_WITH_KEY`
Message-ID: <ZK5JRhXsV7RHey9V@Boquns-Mac-mini.home>
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <20230711093303.1433770-4-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711093303.1433770-4-aliceryhl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 09:32:57AM +0000, Alice Ryhl wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> A Rust helper (introduced in a later patch) needs to call
> `__INIT_WORK` with a passed key, rather than define one in place.
> 
> In order to do that, this moves the initialization code from
> the `__INIT_WORK` macro into a new `__INIT_WORK_WITH_KEY` macro
> which takes the key as an extra parameter.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Taken from [1]. Wedson's email updated at Wedson's request. Tejun's
> Acked-by taken from [2].
> 
> [1]: https://lore.kernel.org/rust-for-linux/20220802015052.10452-7-ojeda@kernel.org/
> [2]: https://lore.kernel.org/rust-for-linux/Yvq3IfK4+C94AeE2@slm.duckdns.org/
> 
>  include/linux/workqueue.h | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 3992c994787f..c91a84a4723d 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -221,24 +221,31 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
>   * to generate better code.
>   */
>  #ifdef CONFIG_LOCKDEP
> +#define __INIT_WORK_WITH_KEY(_work, _func, _onstack, _key)		\
> +	do {								\
> +		__init_work((_work), _onstack);				\
> +		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
> +		lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, _key, 0); \

The lock class name is generated as static string via C macro
"(work_completion)"#_work, and since Rust side helper will wrap it as
a function, so all work items in Rust will have the same lock class name
i.e. "(work_completion)work". ;-) 

Those names are for lockdep report readers to locate which lock class
cause the problem, so it make senses to have different names for
different work item types. Maybe change the C side function as what I
suggested[1], and use `core::any::typename::<Self>()` as the name? (Self
is `Work` since it's called in `Work::new`).

[1]: https://lore.kernel.org/rust-for-linux/ZHoZuIz97JN1VSBf@boqun-archlinux/

Regards,
Boqun

> +		INIT_LIST_HEAD(&(_work)->entry);			\
> +		(_work)->func = (_func);				\
> +	} while (0)
> +
>  #define __INIT_WORK(_work, _func, _onstack)				\
>  	do {								\
>  		static struct lock_class_key __key;			\
> -									\
> -		__init_work((_work), _onstack);				\
> -		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
> -		lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, &__key, 0); \
> -		INIT_LIST_HEAD(&(_work)->entry);			\
> -		(_work)->func = (_func);				\
> +		__INIT_WORK_WITH_KEY(_work, _func, _onstack, &__key);	\
>  	} while (0)
>  #else
> +#define __INIT_WORK_WITH_KEY(_work, _func, _onstack, _key)		\
> +	do {								\
> +		__init_work((_work), _onstack);				\
> +		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
> +		INIT_LIST_HEAD(&(_work)->entry);			\
> +		(_work)->func = (_func);				\
> +	} while (0)
> +
>  #define __INIT_WORK(_work, _func, _onstack)				\
> -	do {								\
> -		__init_work((_work), _onstack);				\
> -		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
> -		INIT_LIST_HEAD(&(_work)->entry);			\
> -		(_work)->func = (_func);				\
> -	} while (0)
> +	__INIT_WORK_WITH_KEY(_work, _func, _onstack, NULL)
>  #endif
>  
>  #define INIT_WORK(_work, _func)						\
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
