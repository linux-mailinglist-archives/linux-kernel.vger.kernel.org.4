Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE657461FD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjGCSRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjGCSRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:17:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1B810C6;
        Mon,  3 Jul 2023 11:16:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so7714530e87.2;
        Mon, 03 Jul 2023 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688408198; x=1691000198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eZ/EoUWegRc8/u2SMi8KWUfNcMs+klcUTvjnhBYKRk=;
        b=ZRLXbeFj/nKg7IbfmX2jcXGNMLHz42pBnS7ZnuJSmYgngT+jWUP9Xjc07BCLkfvAsz
         ZHSagI8RgN+q+aRCtkX/e4Rt78iy+8rQEBVwQf/i8QgO09LMaKmidHcIx+XpqTD1wt9W
         gfys1DSLu1QltBYekLy+Cv8TLsmpwNSU06PxU8z8zhSvJTyOURaui7jvlPJ8sjmKnhnn
         zwHItdhlNwsFjcFZPWE62r83WnLXbVabfvyy3dq0zxH9yb43eHJxUPBezlGODJRBtB6C
         DsQgbIbSYvGRvpAdobJ/UDgQyQ+mNv4WwddxXLSDhxcOqbPV788D9EGTcMcvGCFVvOxM
         DZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688408198; x=1691000198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eZ/EoUWegRc8/u2SMi8KWUfNcMs+klcUTvjnhBYKRk=;
        b=FrrlXeAKNKsIy5IL8T3q++pHuh6QPnCTTFYi87f2vrDnJYcTiLNG0Rhu2LRz2SAdCc
         KZEFjq0N7Fx+5iz0W9dUZanlsp5VfAB3CkZm1t7ziY9JtUs+bkaRF4X8XA+OE1SJVuRK
         lLqE+chLfZafbDzbfnfN3U6NiJCAM4RjZ/D6rW3ZOOKHaZc2mXDgvkPOGLaBeT40qGDz
         Cdjd/4PDTIySJDVR99TJzX3zgDeTUWw/DnK1VrXMcbScOOVpolYx6zinK0c5paYY68Qk
         8zvAiO5Rt9aZIGExNdJWOny1jeZHzvkU/SXFKFv4dB52TJ0b5BfYcQ0thEDFLdkof+fr
         lxwQ==
X-Gm-Message-State: ABy/qLYfDz8r10z9VJoxDl7i3mAXznwfb4tL0iIZBhHx0Woa1yPAoLdO
        4/F2U3hJZ+OcZ1XyX9m5lhM=
X-Google-Smtp-Source: APBJJlFUZCCrWLABSxmV2hd6JSJkwOdI8OlK2f77QdFrrsdrujBf9zjI7MKwOhtTnF16weZ2Wd2Geg==
X-Received: by 2002:a19:5049:0:b0:4f9:5ff6:c06a with SMTP id z9-20020a195049000000b004f95ff6c06amr7054969lfj.67.1688408197923;
        Mon, 03 Jul 2023 11:16:37 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id s1-20020a19ad41000000b004fb738e3ea7sm4194143lfd.101.2023.07.03.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:16:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1567427C0054;
        Mon,  3 Jul 2023 14:16:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jul 2023 14:16:34 -0400
X-ME-Sender: <xms:gBCjZPyMKlffm9-Xonr7RoDKBXCIMfOeA4S8RDiFdqVFLuqqK7WO5g>
    <xme:gBCjZHSLDiDFxUTQyDht3ylMPjQNpWq8uhqVt08Gt8BD15LK0z26x09ssZ4rfH-i1
    8oM-dUltd69pmF-qA>
X-ME-Received: <xmr:gBCjZJXwy9V2GylSG86HAzaFJ0qaewk5xjcTUfgaFldcoiG0lA7iTfkGivc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:gBCjZJi5Ooa5ummUmju2nXuNlGtO2xWJ9hiXi6__mtyeFeW6IcThdg>
    <xmx:gBCjZBBaIw6-418ycCHx2aBQc9oa48fzDbbUjFJB2VImVNCsMEcR7Q>
    <xmx:gBCjZCJVni-vGA8EwdTwqQhf6UUq32TKKBQpQ9PaBdpzrKNPfUY61g>
    <xmx:gRCjZGL02-VECWkyc9pk107UwGGYqWcaptzfHdhrS2EG8Iv5uDxujw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 14:16:32 -0400 (EDT)
Date:   Mon, 3 Jul 2023 11:15:55 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 5/7] rust: init: add `..Zeroable::zeroed()` syntax for
 zeroing all missing fields
Message-ID: <ZKMQW4UGPQZ8yF39@boqun-archlinux>
References: <20230624092330.157338-1-benno.lossin@proton.me>
 <20230624092330.157338-5-benno.lossin@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624092330.157338-5-benno.lossin@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 09:25:19AM +0000, Benno Lossin wrote:
[...]
(this is `init_slot`)
> @@ -1064,7 +1152,7 @@ macro_rules! __init_internal {
>          @data($data:ident),
>          @slot($slot:ident),
>          @guards($($guards:ident,)*),
> -        @munch_fields($(,)?),
> +        @munch_fields($(..Zeroable::zeroed())? $(,)?),

since you append an unconditional comma ',' to init_slot and
make_initializer when "calling" them in with_update_parsed, shouldn't
this be:

+        @munch_fields($(..Zeroable::zeroed(),)? $(,)?),

, and..

>      ) => {
>          // Endpoint of munching, no fields are left. If execution reaches this point, all fields
>          // have been initialized. Therefore we can now dismiss the guards by forgetting them.
> @@ -1157,6 +1245,30 @@ macro_rules! __init_internal {
>              @munch_fields($($rest)*),
>          );
>      };
> +    (make_initializer:
> +        @slot($slot:ident),
> +        @type_name($t:ident),
> +        @munch_fields(..Zeroable::zeroed() $(,)?),

this should be:

+        @munch_fields(..Zeroable::zeroed() , $(,)?),

Otherwise the example before `pin_init!()` wouldn't compile:

	/// pin_init!(Buf {
	///     buf: [1; 64],
	///     ..Zeroable::zeroed(),
	/// });

Regards,
Boqun

> +        @acc($($acc:tt)*),
> +    ) => {
> +        // Endpoint, nothing more to munch, create the initializer. Since the users specified
> +        // `..Zeroable::zeroed()`, the slot will already have been zeroed and all field that have
> +        // not been overwritten are thus zero and initialized. We still check that all fields are
> +        // actually accessible by using the struct update syntax ourselves.
> +        // Since we are in the `if false` branch, this will never get executed. We abuse `slot` to
> +        // get the correct type inference here:
> +        unsafe {
> +            let mut zeroed = ::core::mem::zeroed();
> +            // We have to use type inference her to make zeroed have the correct type. This does
> +            // not get executed, so it has no effect.
> +            ::core::ptr::write($slot, zeroed);
> +            zeroed = ::core::mem::zeroed();
> +            ::core::ptr::write($slot, $t {
> +                $($acc)*
> +                ..zeroed
> +            });
> +        }
> +    };
>      (make_initializer:
>          @slot($slot:ident),
>          @type_name($t:ident),
> --
> 2.41.0
> 
> 
