Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB227689107
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjBCHid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCHic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:38:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A607D6F3;
        Thu,  2 Feb 2023 23:38:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E80F5B82981;
        Fri,  3 Feb 2023 07:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBBDC433D2;
        Fri,  3 Feb 2023 07:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675409908;
        bh=qUfQKPbWLFNNYDlVNeVkDAaUvXzQfDytxs7Vxk9uI5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fn4Kt2yu6cYoJLumd7JQOXxNnVmb0pZa7uV3m5wxtkLeMB27oJfrz0vNmgszuT3I1
         yAEE25qMqcx4entNNulBiDIkX0h5rYyUdnIVsnolais1tJb2Zfn7u9/Y4B0orOB8gx
         3MuccQ084/LUr2IaDsvMw2mWELBanGvm5OjsZvz4=
Date:   Fri, 3 Feb 2023 08:38:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Peter Zijlstra <peterz@infradead.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Message-ID: <Y9y58cy1GKZLdyjb@kroah.com>
References: <20230201232244.212908-3-boqun.feng@gmail.com>
 <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
 <20230202142153.352ba479.gary@garyguo.net>
 <Y9vZu08L2WaLNJIc@kroah.com>
 <Y9vga90K0aVfGUwW@boqun-archlinux>
 <Y9viM2POUsSnbKUh@kroah.com>
 <Y9vqJ1h2nkaFRpOY@boqun-archlinux>
 <CANiq72kMZ9XQvte41Mzu4oXX=ujGRCrGDZDiYUBVD3=JTGG57g@mail.gmail.com>
 <Y9yaBybest8JBu8A@kroah.com>
 <Y9y21JyuPF1nCCzr@Boquns-Mac-mini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9y21JyuPF1nCCzr@Boquns-Mac-mini.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 11:25:08PM -0800, Boqun Feng wrote:
> On Fri, Feb 03, 2023 at 06:22:15AM +0100, Greg KH wrote:
> > On Thu, Feb 02, 2023 at 10:47:12PM +0100, Miguel Ojeda wrote:
> > > On Thu, Feb 2, 2023 at 5:52 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > As I said, I'm open to remove the printing of the refcount, and if you
> > > > and Peter think maybe it's OK to do that after the explanation above,
> > > 
> > > Perhaps part of the confusion came from the overloaded "safe" term.
> > > 
> > > When Gary and Boqun used the term "safe", they meant it in the Rust
> > > sense, i.e. calling the method will not allow to introduce undefined
> > > behavior. While I think Peter and Greg are using the term to mean
> > > something different.
> > 
> > Yes, I mean it in a "this is not giving you the value you think you are
> > getting and you can not rely on it for anything at all as it is going to
> > be incorrect" meaning.
> > 
> > Which in kernel code means "this is not something you should do".
> > 
> 
> Now what really confuses me is why kref_read() is safe..

It isn't, and I hate it and it should be removed from the kernel
entirely.  But the scsi and drm developers seem to insist that "their
locking model ensures it will be safe to use" and I lost that argument
:(

> or how this is different than kref_read().

It isn't, but again, I don't like that and do not agree it should be
used as it is almost always a sign that the logic in the code is
incorrect.

> Needless to say that ArcInner::count() can guarantee not reading 0

How?  Because you have an implicit reference on it already?  If so, then
why does reading from it matter at all, as if you have a reference, you
know it isn't 0, and that's all that you can really care about.  You
don't care about any number other than 0 for a reference count, as by
definition, that's what a reference count does :)

> (because of the type invariants) but kref_read() cannot..

I totally agree with you.  Let's not mirror bad decisions of legacy
subsystems in the kernel written in C with new designs in Rust please.

thanks,

greg k-h
