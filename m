Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96F8688EE9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjBCFWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBCFWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:22:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221A1783D1;
        Thu,  2 Feb 2023 21:22:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 33B96CE2E0F;
        Fri,  3 Feb 2023 05:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52E1C433D2;
        Fri,  3 Feb 2023 05:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675401747;
        bh=KZoxTV3ZMdQ05WF88OKxzgH+nB5kz++RuLauXMPspeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHOYsq0276hgBEXb7f62CABL7jnNgfbiG3lztCICaMfX7f/Un6JP6kJJbs0XOpcl9
         eXoTwrrE+2UGEebPZuiQw96Bf53L00YEAEtX8zQFWppgcicgC8iUN8ayCwXLdQeHgf
         PX9dDUnbbIWq+VIHtzukJDqXjiOvXnIK7E0qTKag=
Date:   Fri, 3 Feb 2023 06:22:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
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
Message-ID: <Y9yaBybest8JBu8A@kroah.com>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-3-boqun.feng@gmail.com>
 <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
 <20230202142153.352ba479.gary@garyguo.net>
 <Y9vZu08L2WaLNJIc@kroah.com>
 <Y9vga90K0aVfGUwW@boqun-archlinux>
 <Y9viM2POUsSnbKUh@kroah.com>
 <Y9vqJ1h2nkaFRpOY@boqun-archlinux>
 <CANiq72kMZ9XQvte41Mzu4oXX=ujGRCrGDZDiYUBVD3=JTGG57g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kMZ9XQvte41Mzu4oXX=ujGRCrGDZDiYUBVD3=JTGG57g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 10:47:12PM +0100, Miguel Ojeda wrote:
> On Thu, Feb 2, 2023 at 5:52 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > As I said, I'm open to remove the printing of the refcount, and if you
> > and Peter think maybe it's OK to do that after the explanation above,
> 
> Perhaps part of the confusion came from the overloaded "safe" term.
> 
> When Gary and Boqun used the term "safe", they meant it in the Rust
> sense, i.e. calling the method will not allow to introduce undefined
> behavior. While I think Peter and Greg are using the term to mean
> something different.

Yes, I mean it in a "this is not giving you the value you think you are
getting and you can not rely on it for anything at all as it is going to
be incorrect" meaning.

Which in kernel code means "this is not something you should do".

thanks,

greg k-h
