Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7020A682E32
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjAaNmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjAaNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:42:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0908518FE;
        Tue, 31 Jan 2023 05:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 886A8B81CD0;
        Tue, 31 Jan 2023 13:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FA8C4339C;
        Tue, 31 Jan 2023 13:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675172532;
        bh=VlM37WR9rNiac0IuoMSWkR+y7EXv5Abb56xkJSYDsCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UNNNoTpRaq0yFTWXOzK4Rpjx/x2E/p74j+hPGcODn4gTW5z3ruMYi6ZcPAqTvmWlB
         cpJXbdrnNO5K5c1uALvYYT8LP8zi193bLkEqwM2IxsDZNVT+mBAkuXvkiOgZR4JQ8M
         xyF6N5StQFTjk3qwGAky/yLtzqTSD2SgE+a/BPh8=
Date:   Tue, 31 Jan 2023 14:42:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH] rust: add this_module macro
Message-ID: <Y9kasJQZf146ekp+@kroah.com>
References: <20230131130841.318301-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131130841.318301-1-yakoyoku@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:08:41AM -0300, Martin Rodriguez Reboredo wrote:
> Adds a Rust equivalent to the handy THIS_MODULE macro from C.
> 
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> ---
>  rust/kernel/lib.rs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e0b0e953907d..afb6b0390426 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -80,6 +80,18 @@ impl ThisModule {
>      }
>  }
>  
> +/// Returns the current module.
> +#[macro_export]
> +macro_rules! this_module {
> +    () => {
> +        if cfg!(MODULE) {
> +            Some(unsafe { $crate::ThisModule::from_ptr(&mut $crate::bindings::__this_module) })
> +        } else {
> +            None
> +        }
> +    };
> +}

While this is handy, what exactly will it be used for?  The C
wrappers/shim/whatever should probably handle this for you already when
you save this pointer into a structure right?

Surely you aren't trying to increment your own module's reference count,
right?  That just doesn't work :)

thanks,

greg k-h
