Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E323268A337
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjBCTqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjBCTqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:46:18 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0719DCB3;
        Fri,  3 Feb 2023 11:46:17 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id q10so3499858qvt.10;
        Fri, 03 Feb 2023 11:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81irN639b02GEcmRvaoW91apai4NlHhMmcLeIDey+EM=;
        b=T+xYQpi0k8whPSdL51LPz8QhAgaaD2lXc+aswRpA+PXhKBY8YyG04h+w5Zue9Z0C8o
         gOJumH5ZZY0SJfx0Qv4n058mLQWBep2Z1nJYEsgwdxceusLf130oNMpkya81a2u5Ubuo
         GafpLRPSW4bIfYlusp9xxPa2DpUvJpf+CF9fc3oRC4M6PS64N7AKQksywMyRFVFoEk6N
         90y2IQ8zctFy7ILq94Dmkh3cSrGG4h7RY+uft1WPtIatYM/pS9M4/FCyO/mtNQ8Wm2L/
         36lb9fxezSOzNBA/NDX9yEy1ZyNZsANHu2veCkYAEia08TVa4pPxxQbj5jTYo88LqeWN
         rymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81irN639b02GEcmRvaoW91apai4NlHhMmcLeIDey+EM=;
        b=gEoHG00z4WcxA/27tw1zNGVFCZrXM93abyibEHL6IQaHj0C2Sta6mawJLzrFC91Qzi
         Jkvb2TyVCGuzuQrdNLNr89IdBeuDJGyjKbr5y9A/n18jGoG7Mv5EDcaPQLgg+pzY8x2H
         ryAmv3g7MKGyRfiWu6ifb08Fga6WFcsguw/UyKmwhJ2n26rUt4nMXd/bAZBa8RxX7Lxr
         sBt6XqxefNVunG4/APDfeF1IPlLTEv1Kpr4mkQTJxiotIGdg6norsDCVxllbVgkIO2l/
         nlzUOClRlxqyUeskddKuOUkYjLpiBTJLcZly2FeFlHT+W4r100/XnNcg1/SZozYNft9m
         0uFA==
X-Gm-Message-State: AO0yUKXe3Pg+LBg+k5ZXsMuIHMkWecZhc8LDJQAJtqi4SOxGMkrqAjb0
        rLuA3CREtDLF5a9fnk3nxxrGBaDlAjs=
X-Google-Smtp-Source: AK7set/RfsZMziHQcq5BP7Gmtzasl8hL7vvzAoIn2kQ4KTjtXfiqjnj5TRM18FDZiFudtK+Gcp0hog==
X-Received: by 2002:a05:6214:cab:b0:53a:6241:a50f with SMTP id s11-20020a0562140cab00b0053a6241a50fmr23961779qvs.9.1675453577010;
        Fri, 03 Feb 2023 11:46:17 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h67-20020a376c46000000b0070495934152sm2428208qkc.48.2023.02.03.11.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 11:46:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5D66327C0054;
        Fri,  3 Feb 2023 14:46:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 03 Feb 2023 14:46:15 -0500
X-ME-Sender: <xms:hmTdY7WxKwEnZ8-yP0PzyihlJ5F3cqj4sXPY1WOThGtEScOOakG7mg>
    <xme:hmTdYzlkFdI6ZwcULyLlllmpmmZi0X3DzpOeVTiOc4LVgOWhRqOqZGAUCZMs0AKgJ
    fhOhvFi4wIczE5t8Q>
X-ME-Received: <xmr:hmTdY3Y6E3XdeUOmTrHTe8kmzC7g_xQthubPQA6k2w0O1luhpfPSQw6hJCs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegtddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:hmTdY2VUYZ12_wZxtt--ThR9C2cw_bcUEb6ZlfCmlVhCsjJB53C6Dw>
    <xmx:hmTdY1lxoxNkdDq7Ccd-aagxNgtoP5_hZt3ypjE9lp4XMCbh7Sftmw>
    <xmx:hmTdYzfVX2HfxiOPD2az7hfdEoUpeIJzkxCg4LSmKB9pbde6cjjo2Q>
    <xmx:hmTdY-cLHZDgf5Mm_qYB0JrngOciF1_sxjqigRzRP2DUu6QHAWbibw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Feb 2023 14:46:14 -0500 (EST)
Date:   Fri, 3 Feb 2023 11:46:07 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 4/5] rust: sync: impl Debug for {Unique,}Arc
Message-ID: <Y91kf/IMiYNw8BdR@boqun-archlinux>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-5-boqun.feng@gmail.com>
 <20230202142804.753c898c.gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202142804.753c898c.gary@garyguo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 02:28:04PM +0000, Gary Guo wrote:
> On Wed,  1 Feb 2023 15:22:43 -0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > This allows printing macros to print the data and the refcount nubmer
> > of these struct for debugging purposes.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/kernel/sync/arc.rs | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index 4d8de20c996f..f143d8305c36 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -474,6 +474,7 @@ impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
> >  ///
> >  /// # test().unwrap();
> >  /// ```
> > +#[derive(Debug)]
> 
> I don't think this should be a `#[derive(Debug)]`. For `UniqueArc` the
> refcount field in `Arc` is useless, and we should just delegate the
> `Debug` impl to that of deref, just like `Display` does.
> 

I was just being lazy ;-) Will change this in v2.

Regards,
Boqun

> Best,
> Gary
