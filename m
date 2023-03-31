Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC566D2B40
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjCaWYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 18:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCaWYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:24:08 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9631EA02;
        Fri, 31 Mar 2023 15:24:07 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id cu4so17428975qvb.3;
        Fri, 31 Mar 2023 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680301446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtftlvxQJ039HPxSLQblKHBrwyQ77QzbzDmRY3gJhwU=;
        b=Ctn+GnX1rq1Z7HSzKakAN5zxRYXrz1UW4nISkjn0Vnb4KaVx+Ycx+g7RWTQ2ZW7Uw9
         IizLYZ5zcA7xeP8wr7jSn6Fd5BlZdHJIwUabFbnC+tZ1ddWK+TfLXnIkty6d+9vg1bvC
         bDAqtDu31uLhWoqDX2B75cO+Pqo4C120ZoGCytBzTgsSo20w9qa5/IL1RqM+gqn8vrSu
         q4LBsvjd2x1IN2QzifFIM/E8WUbPDmBokkaR+0ZamLEc+F8Q1GrsPqn4DXhzPAeHUeOY
         Z8+LT7OI0khd9kXHlVoTI5di2vSsNr0ApgqJvjm5p22eYdrZtti+gIaJ/o4bWoI4Yatj
         6xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680301446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtftlvxQJ039HPxSLQblKHBrwyQ77QzbzDmRY3gJhwU=;
        b=tJkBl6Fg6bdtu9A2ax+CEBTHnj9oF7rCYjcKZw7SFSPLJ9pEUWtHIGXzI/EJN7nhTT
         1vFE4rEWfcRXEHTDm9dFqrntp6mPw3RjSvOeN4NAgcgAArB/oL+QceHIuccX8ghoUm+s
         zjUQc+1zD5J8FgyscT7XuBcmYyIK+n/tZ3+uvnAmWot9BHUXoJ8DNlLJeJvTWoEPbPiM
         peAvxvKhqbmTyswFmE1xC8EU1KaP0ZE3rQxOycT9MqlO7y0uKAaPYOrM39j3fA1gYiMe
         i7Dn0oNaiUtQ2NTJ6wa62mEc+RMb95Rlt+ajp+J4ikID/KX1jNBKmDgRquU/E+IU6Eje
         TB9w==
X-Gm-Message-State: AAQBX9fBN4RZxnpH4a5+TSWXeOoEtQTbOe+2yGgzHmptSxgvws4Vq6+U
        ELLqc2O2J0LUmq7uO9jzavM=
X-Google-Smtp-Source: AKy350aYKxU1nt9CaIHh9UA5sMMVmy62LYl/MTSN9NDTiDP/B3htWeBAUOlUh6tpfYXRtuzh/jLq9w==
X-Received: by 2002:ad4:5ca7:0:b0:5cc:e059:efa3 with SMTP id q7-20020ad45ca7000000b005cce059efa3mr47450729qvh.23.1680301446517;
        Fri, 31 Mar 2023 15:24:06 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g10-20020a0cfdca000000b005dd8b9345d2sm873652qvs.106.2023.03.31.15.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 15:24:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8C69427C0054;
        Fri, 31 Mar 2023 18:24:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 31 Mar 2023 18:24:05 -0400
X-ME-Sender: <xms:hV0nZA_ferdFOrQoFRFaXmBcjljGfG01srEMtk6iut8YnymAUOELMg>
    <xme:hV0nZIuPgm8ETE9ojbKeoVAcrKfsmos19wt0ZVIGW-u1nnjqN-X9FX08yfE_yQgl9
    ei_RjavxkmXwKOtLw>
X-ME-Received: <xmr:hV0nZGBYEp3yk6VcqgNYoTC5zPl9ry0NfzQyONlvUiA6C6P6TD8vPKXDSiUyKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeivddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:hV0nZAdNmVkF3mgkB9c6PMxVuYkkH7ozusQwKnT8WL6a5d9ZL8HPhQ>
    <xmx:hV0nZFPaMTKoe1zhdOda5PwubWlA0wD2oWMrFA0iA2LDwOIphRfCUQ>
    <xmx:hV0nZKkjy-jDU_xxl2-qxRAFmhIidHvX7qUx0eMCv38L5j3iy7DrSA>
    <xmx:hV0nZKlyBXk5RDqo7MnSxNtSCSm71vyvHNNVWTL65KY4LZVsNV6f_w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 18:24:04 -0400 (EDT)
Date:   Fri, 31 Mar 2023 15:23:17 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v4 01/15] rust: enable the `pin_macro` feature
Message-ID: <ZCddVfb9vUw8j7u/@boqun-archlinux>
References: <20230331215053.585759-1-y86-dev@protonmail.com>
 <20230331215053.585759-2-y86-dev@protonmail.com>
 <ZCdWErZLBFl205UP@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCdWErZLBFl205UP@boqun-archlinux>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 02:52:18PM -0700, Boqun Feng wrote:
> On Fri, Mar 31, 2023 at 09:51:35PM +0000, y86-dev@protonmail.com wrote:
> > From: Benno Lossin <y86-dev@protonmail.com>
> > 
> > This feature enables the use of the `pin!` macro for the `stack_pin_init!`
> > macro. This feature is already stabilized in Rust version 1.68.
> > 
> > Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: Andreas Hindborg <a.hindborg@samsung.com>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> 

Hmm.. actually I think you will need to add this in the
scripts/Makefile.build, because the user (stack_pin_init!()) is a macro,
feel free to add my acked-by after that.

Regards,
Boqun

> Regards,
> Boqun
> 
> > ---
> >  rust/kernel/lib.rs | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 223564f9f0cc..4317b6d5f50b 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -17,6 +17,7 @@
> >  #![feature(core_ffi_c)]
> >  #![feature(dispatch_from_dyn)]
> >  #![feature(generic_associated_types)]
> > +#![feature(pin_macro)]
> >  #![feature(receiver_trait)]
> >  #![feature(unsize)]
> > 
> > --
> > 2.39.2
> > 
> > 
