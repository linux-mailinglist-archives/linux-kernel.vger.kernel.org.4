Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF5641E8E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 19:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiLDSFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 13:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLDSFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 13:05:30 -0500
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63733DECF;
        Sun,  4 Dec 2022 10:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=y7n0hCnLGy1zh+SrdpqxlWp8vDHcKpVOgMWTyUVHEaQ=; b=A0wRDCpBFBt2mvSCaPYoSuQcDN
        f4aaXk7mu1f+GHWPClZ9jdgaDwmwCuXkI1ApIeFXaEbPbPK/GZZLJ/Y5BOqixCD5OtV3pk4wM1WbN
        MjLtH98IEOFFlw43yueO0Df4gFwGrQ1PmS2tBNobhLGAiwNViNJqKptN1OWXiwoFI+sk97L681aP9
        lUEaQ9RyUF1mulgo3Mcmip8YPYu4jC7Irq/q/QTbIn9i7rb6hFueWUZpUv4aDn5GMxaKV55QWgS5X
        WhvGUoE9ktjMC5IENU0wefbFz5v9pM1jXBjUWukP+gzsHtKY5wkJ3PAtzg9K2WYjNmK42mgwGBn47
        KPOxGklg==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1p1tMf-00534x-B2; Sun, 04 Dec 2022 18:05:21 +0000
Date:   Sun, 4 Dec 2022 18:05:21 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     ojeda@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH v2 20/28] rust: str: add `Formatter` type
Message-ID: <Y4zhYWNIaGtOH5u6@gallifrey>
References: <20221202161502.385525-1-ojeda@kernel.org>
 <20221202161502.385525-21-ojeda@kernel.org>
 <Y4y/ovfF3len/22J@gallifrey>
 <CANeycqrT69HJWEBZwbuhTehSy1qFF7A4q38cb5TqU1yf=nMLOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CANeycqrT69HJWEBZwbuhTehSy1qFF7A4q38cb5TqU1yf=nMLOQ@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-12-amd64 (x86_64)
X-Uptime: 17:58:55 up 268 days,  4:24,  1 user,  load average: 0.18, 0.09,
 0.03
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Wedson Almeida Filho (wedsonaf@gmail.com) wrote:
> On Sun, 4 Dec 2022 at 15:41, Dr. David Alan Gilbert <dave@treblig.org> wrote:
> >
> > * ojeda@kernel.org (ojeda@kernel.org) wrote:
> > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > >
> > > Add the `Formatter` type, which leverages `RawFormatter`,
> > > but fails if callers attempt to write more than will fit
> > > in the buffer.
> > >
> > > In order to so, implement the `RawFormatter::from_buffer()`
> > > constructor as well.
> > >
> > > Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> > > Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > Reviewed-by: Gary Guo <gary@garyguo.net>
> > > [Reworded, adapted for upstream and applied latest changes]
> > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > ---
> > >  rust/kernel/str.rs | 57 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 57 insertions(+)
> > >
> > > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > > index a995db36486f..ce207d1b3d2a 100644
> > > --- a/rust/kernel/str.rs
> > > +++ b/rust/kernel/str.rs
> > > @@ -406,6 +406,23 @@ impl RawFormatter {
> > >          }
> > >      }
> > >
> > > +    /// Creates a new instance of [`RawFormatter`] with the given buffer.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
> > > +    /// for the lifetime of the returned [`RawFormatter`].
> > > +    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
> > > +        let pos = buf as usize;
> > > +        // INVARIANT: We ensure that `end` is never less then `buf`, and the safety requirements
> > > +        // guarantees that the memory region is valid for writes.
> > > +        Self {
> > > +            pos,
> > > +            beg: pos,
> > > +            end: pos.saturating_add(len),
> > > +        }
> > > +    }
> > > +
> > >      /// Returns the current insert position.
> > >      ///
> > >      /// N.B. It may point to invalid memory.
> > > @@ -439,3 +456,43 @@ impl fmt::Write for RawFormatter {
> > >          Ok(())
> > >      }
> > >  }
> > > +
> > > +/// Allows formatting of [`fmt::Arguments`] into a raw buffer.
> > > +///
> > > +/// Fails if callers attempt to write more than will fit in the buffer.
> > > +pub(crate) struct Formatter(RawFormatter);
> 
> Here we mention that `Formatter` fails if callers attempt to write
> more than will fit in the buffer.
> 
> This is in contrast with `RawFormatter`, which doesn't fail in such
> cases. There's also a comment there explaining it (not visible in this
> patch because it's already there), but I reproduce below:
> 
> /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
> ///
> /// It does not fail if callers write past the end of the buffer so
> that they can calculate the
> /// size required to fit everything.
> ///
> /// # Invariants
> ///
> /// The memory region between `pos` (inclusive) and `end` (exclusive)
> is valid for writes if `pos`
> /// is less than `end`.
> pub(crate) struct RawFormatter {
> 
> `RawFormatter` is used to implement the "%pA" printf specifier, which
> requires this behaviour.
> 
> > > +
> > > +impl Formatter {
> > > +    /// Creates a new instance of [`Formatter`] with the given buffer.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
> > > +    /// for the lifetime of the returned [`Formatter`].
> > > +    #[allow(dead_code)]
> > > +    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
> > > +        // SAFETY: The safety requirements of this function satisfy those of the callee.
> > > +        Self(unsafe { RawFormatter::from_buffer(buf, len) })
> > > +    }
> > > +}
> > > +
> > > +impl Deref for Formatter {
> > > +    type Target = RawFormatter;
> > > +
> > > +    fn deref(&self) -> &Self::Target {
> > > +        &self.0
> > > +    }
> > > +}
> > > +
> > > +impl fmt::Write for Formatter {
> > > +    fn write_str(&mut self, s: &str) -> fmt::Result {
> > > +        self.0.write_str(s)?;
> > > +
> > > +        // Fail the request if we go past the end of the buffer.
> >
> > Reading this for the first time, I'm surprised by this, perhaps a
> > bit more comment is needed?  I was expecting that nothing would
> > let pos pass end.
> 
> Given the comments I highlight above, do you think we still need more?
> 
> (My impression is that you're reading this without the context I tried
> to explain above, and this context may perhaps be sufficient.)

Thanks for the pointer; I guess I find it trickier when I can't see the
type in self.0 to immediately see it's RawFormatter, and 'Raw' is
abstract enough to need to go hunt to see it's behaviour.

With that context, I wouldn't object to what's there, but how about
something like:

      // RawFormatter (self.0) still updates pos if the buffer
      // is too small, but doesn't fail - we want to fail the request.

Dave

> Thanks,
> -Wedson
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
