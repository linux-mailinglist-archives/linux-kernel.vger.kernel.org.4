Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6524A6883EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBBQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBBQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:18:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4A35FEE;
        Thu,  2 Feb 2023 08:18:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED140B825EE;
        Thu,  2 Feb 2023 16:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E277BC433D2;
        Thu,  2 Feb 2023 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675354678;
        bh=9wvzHO8wwuC2YRBPUHGOKjopuz1pTtKG0YW4ESE1H2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGK4fiAe08S2PN9tk5AxRjEQN74QBk7N19pOZ3GGz9OFOEWf1sSYiy/DriSRUYucr
         JtKkbNyZh0MGFSmFBVXmxVRIiPJdi0UeutLCCUCtQO27BkHMzOJ/NbUtTXbih1FBMU
         6X7VMtpnrrijoQw/pUyBLZMxHUPwSGp4xNdm+rv0=
Date:   Thu, 2 Feb 2023 17:17:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>, Peter Zijlstra <peterz@infradead.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Message-ID: <Y9viM2POUsSnbKUh@kroah.com>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-3-boqun.feng@gmail.com>
 <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
 <20230202142153.352ba479.gary@garyguo.net>
 <Y9vZu08L2WaLNJIc@kroah.com>
 <Y9vga90K0aVfGUwW@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9vga90K0aVfGUwW@boqun-archlinux>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 08:10:19AM -0800, Boqun Feng wrote:
> On Thu, Feb 02, 2023 at 04:41:47PM +0100, Greg KH wrote:
> > On Thu, Feb 02, 2023 at 02:21:53PM +0000, Gary Guo wrote:
> > > On Thu, 2 Feb 2023 10:14:06 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > On Wed, Feb 01, 2023 at 03:22:41PM -0800, Boqun Feng wrote:
> > > > > This allows reading the current count of a refcount in an `ArcInner`.
> > > > > 
> > > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > > ---
> > > > >  rust/helpers.c          | 6 ++++++
> > > > >  rust/kernel/sync/arc.rs | 9 +++++++++
> > > > >  2 files changed, 15 insertions(+)
> > > > > 
> > > > > diff --git a/rust/helpers.c b/rust/helpers.c
> > > > > index 09a4d93f9d62..afc5f1a39fef 100644
> > > > > --- a/rust/helpers.c
> > > > > +++ b/rust/helpers.c
> > > > > @@ -46,6 +46,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> > > > >  
> > > > > +unsigned int rust_helper_refcount_read(refcount_t *r)
> > > > > +{
> > > > > +	return refcount_read(r);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(rust_helper_refcount_read);
> > > > > +
> > > > >  /*
> > > > >   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
> > > > >   * as the Rust `usize` type, so we can use it in contexts where Rust
> > > > > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > > > > index fc680a4a795c..fbfceaa3096e 100644
> > > > > --- a/rust/kernel/sync/arc.rs
> > > > > +++ b/rust/kernel/sync/arc.rs
> > > > > @@ -127,6 +127,15 @@ struct ArcInner<T: ?Sized> {
> > > > >      data: T,
> > > > >  }
> > > > >  
> > > > > +impl<T: ?Sized> ArcInner<T> {
> > > > > +    /// Returns the current reference count of [`ArcInner`].
> > > > > +    fn count(&self) -> u32 {
> > > > > +        // SAFETY: `self.refcount.get()` is always a valid pointer, and `refcount_read()` is a
> > > > > +        // normal atomic read (i.e. no data race) only requiring on the address is valid.
> > > > > +        unsafe { bindings::refcount_read(self.refcount.get()) }
> > > > > +    }
> > > > > +}  
> > > > 
> > > > This is completely unsafe vs concurrency. In order to enable correct
> > > > tracing of refcount manipulations we have the __refcount_*(.oldp) API.
> > > 
> > > Retrieving the reference count is safe. It's just that in many
> > > scenarios it's very hard to use the retrieved reference count
> > > correctly, because it might be concurrently changed.
> > 
> > Yes, so you really should never ever ever care about the value, and that
> > includes printing it out as it will be wrong the instant you read it.
> > 
> 
> Agreed.
> 
> > > But there are correct ways to use a refcount, e.g. if you own
> > > `Arc` and `.count()` returns 1, then you know that you are the
> > > exclusive owner of the `Arc` and nobody else is going to touch it.
> > 
> > But you should never know this, as it is not relevant.
> > 
> > So no, please don't allow printing out of a reference count, that will
> > only cause problems and allow people to think it is safe to do so.
> > 
> 
> People already do it, even in *security* code,
> 
> security/keys/keyring.c:
> 
> 	int key_link(struct key *keyring, struct key *key)
> 	{
> 		...
> 		kenter("{%d,%d}", keyring->serial, refcount_read(&keyring->usage));
> 		...
> 	}
> 
> Should we fix that?

Yes.  But really, that's debugging code, it probably should all be
removed now.

thanks,

greg k-h
