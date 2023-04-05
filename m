Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C06D8574
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjDESAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjDESAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24F935B1;
        Wed,  5 Apr 2023 11:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48F7863CE5;
        Wed,  5 Apr 2023 18:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B340C433D2;
        Wed,  5 Apr 2023 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680717617;
        bh=OTSz0e1YbSXma0rl8uSmOCO0265qUI7OXz6bhD+l8Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ie2hpT+QKck6Dn81IJpjOTA4b3RDVu74pXkTzJ7wrbH6zXFPSvkzqHm5pEL9H2NLu
         8WfdomburLLccbFNf2kyD9kLTsDSqI+uImOvRvOafDaNC4yIef1HcsUF5FrwAs2iYR
         qoCG9AEaivZwowuUuuAQnkwA9LUYAwurMTYK8Kwk=
Date:   Wed, 5 Apr 2023 20:00:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 01/13] rust: sync: introduce `LockClassKey`
Message-ID: <2023040519-crank-quarry-ef26@gregkh>
References: <20230405175111.5974-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405175111.5974-1-wedsonaf@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 02:50:59PM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> It is a wrapper around C's `lock_class_key`, which is used by the
> synchronisation primitives that are checked with lockdep. This is in
> preparation for introducing Rust abstractions for these primitives.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: Fixed a typo in comment
> 
>  rust/kernel/sync.rs | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 33da23e3076d..84a4b560828c 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -5,6 +5,51 @@
>  //! This module contains the kernel APIs related to synchronisation that have been ported or
>  //! wrapped for usage by Rust code in the kernel.
>  
> +use crate::types::Opaque;
> +
>  mod arc;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
> +
> +/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> +#[repr(transparent)]
> +pub struct LockClassKey(Opaque<bindings::lock_class_key>);

Will this disappear into "nothing" if lockdep is disabled in the build?

If not, it should, if so, I couldn't see where that option was, sorry
for the noise.

thanks,

greg k-h
