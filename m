Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE4573D52F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjFYXON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjFYXOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:14:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E009E43;
        Sun, 25 Jun 2023 16:14:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-988883b0d8fso386587766b.1;
        Sun, 25 Jun 2023 16:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687734848; x=1690326848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=piRs1ggT0LvRTdkGPVU2tg01U2bMWdH46lm0StJp/N8=;
        b=pj/B5YlmUv8cMy6EGaggichA79rCBQqB7Fc2sxIHTBEJ2wMlXq72GrkSjrdzazGHkW
         IEsKefBjB3lMWOby58WNJs5xzh9g6AoPcX3PiRPb1UJkrpPEq/iZI4FmXkL0EV79waBr
         yT2Q9s9NqaR2rTRjMeXpzpTVqpEEOBc/hdnpQzIQ421PvyeeJ1NT3IKnVpdg5pa6Sflr
         lOQOP4c+sLcCz7VYwzfvXgQ6Grh5zTEjbamAS3j9VSpex2ne73j65Ggj8t7PrLeuC+ir
         eAAqos34E4+1URg8A9hOUNadMV36+RjBbiuCRkoHN5F7UmpQ88F4R7pUzhums8RI0286
         8wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687734848; x=1690326848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piRs1ggT0LvRTdkGPVU2tg01U2bMWdH46lm0StJp/N8=;
        b=MyaKL5S6pbKNTTw4sbBMQl5W/92w5gNFzXdjrbkVIVr3J20EjiMq2LT/ZUI9A7LK0q
         3XH1Tn/GnUEhKOJGuAIgHjsWALES8fiNG0Rhku1KMQoy4/FQX0YmHARsLFOMAVjh3oUh
         5Qlf8hXAu5PczGz3r4dia+Nnj3AjmJNI6+MBjgf3IAd+0RsuLtR6cpSCQnao5PIP6jFI
         ihm5hy1qU0/N7B56J8PcvwwOrOJzA51ORnJgWrXA9cwxkB2kyrm3OGPRwbB9vCoVB09d
         nTvyuFSP1RlGPRCJxpkWltZqalUdWC5whvqA5VK7Tcaa8Dv1jjueHRDdrEbxEpa4bssM
         wWYQ==
X-Gm-Message-State: AC+VfDwJF94qstQ9fHEEw0UhzdxL8zm47XAyTKwymvleQJUQvJxdS7wt
        yMp9UCWDzvo+EZjrY7+15dk=
X-Google-Smtp-Source: ACHHUZ4uMm+eLvbSG3DamsDMT9HZiV7bWBIPuqReEnxz4NEOIIybsqIS+oPMlw7RG3M2lW959KKGAg==
X-Received: by 2002:a17:907:72d3:b0:98c:eb41:5a8b with SMTP id du19-20020a17090772d300b0098ceb415a8bmr12331749ejc.7.1687734848449;
        Sun, 25 Jun 2023 16:14:08 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id z18-20020a1709067e5200b0096f7500502csm2556729ejr.199.2023.06.25.16.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 16:14:07 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1621227C0054;
        Sun, 25 Jun 2023 19:14:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 25 Jun 2023 19:14:06 -0400
X-ME-Sender: <xms:PcqYZBLQ63VAvis2OHUOzLz5TuPE-DxpULmViqmPGpc60vowitIklQ>
    <xme:PcqYZNLf5cb0thml1PP31Vw3hSBjt34HmEdjTvrkIdV8wZ_IV9S7-R3Y8_fC4ztKx
    iZmXuoaq3dTx_-HzQ>
X-ME-Received: <xmr:PcqYZJtQ75_wmef97KeRUUHWB4xu57k8hxpXF9qIvodVlbq1FJF8jI1W1PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehuddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepteeugeeihfeifedthfegffetjedvjeehfeeugedtheehudelvdeuieev
    feevvedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgv
X-ME-Proxy: <xmx:PcqYZCYAGBna709BVMfLjaxNQD6FazxmuVvSNqqJEutOZi1ffcCtFw>
    <xmx:PcqYZIb4pZLq3mEhDIrMxcFqIJY1pd1yMnbwvCcbuhc8jX1R94osmw>
    <xmx:PcqYZGDRYV5bWVO4IpP18EqaEIZASWuYw1GiL5UYPgY5J5WwAvRPPw>
    <xmx:PcqYZI4Cr2mYKZuJgMn1ooFDZOhxX6KgPkGiI3K8_gR6guf8iDr_IA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Jun 2023 19:14:04 -0400 (EDT)
Date:   Sun, 25 Jun 2023 16:13:51 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: alloc: Add realloc and alloc_zeroed to the
 GlobalAlloc impl
Message-ID: <ZJjKL968vGuNeNmL@boqun-archlinux>
References: <20230622-global_alloc_methods-v1-1-3d3561593e23@protonmail.com>
 <ZJXXxEfzVza5Jzxj@boqun-archlinux>
 <R7bIOWHPBelVxutK-V8lFrSCh_diCIJtJxP-HbOJDV0i2VaKriARSwBRv8TaTevuT06lySKkBALLFJ8S_7q2Qzzr2fH4eceYXYO1_kp1jnI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <R7bIOWHPBelVxutK-V8lFrSCh_diCIJtJxP-HbOJDV0i2VaKriARSwBRv8TaTevuT06lySKkBALLFJ8S_7q2Qzzr2fH4eceYXYO1_kp1jnI=@protonmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 02:40:23PM +0000, Björn Roy Baron wrote:
> On Friday, June 23rd, 2023 at 19:35, Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Thu, Jun 22, 2023 at 09:24:40PM +0200, Björn Roy Baron via B4 Relay wrote:
> > 
> > > From: Björn Roy Baron bjorn3_gh@protonmail.com
> > > 
> > > While there are default impls for these methods, using the respective C
> > > api's is faster. Currently neither the existing nor these new
> > > GlobalAlloc method implementations are actually called. Instead the
> > > _rust* function defined below the GlobalAlloc impl are used. With
> > > rustc 1.71 these functions will be gone and all allocation calls will go
> > > through the GlobalAlloc implementation.
> > > 
> > > Link: https://github.com/Rust-for-Linux/linux/issues/68
> > 
> > 
> > Nice! Although I think we need to do the simialr size adjustment as:
> > 
> > 	https://lore.kernel.org/rust-for-linux/20230613164258.3831917-1-boqun.feng@gmail.com/
> > 
> > so I applied your patch onto my patch and came up with the following:
> 
> Right. That patch LGTM.
> 

Thank you and Gary for the diff review, I will fold it into your
original patch and resend.

Regards,
Boqun

> Cheers,
> Björn
