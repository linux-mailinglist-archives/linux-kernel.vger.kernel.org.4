Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F696A1FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBXQcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBXQcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:32:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78CA4AFCA;
        Fri, 24 Feb 2023 08:32:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3413B81CA7;
        Fri, 24 Feb 2023 16:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5469C4339E;
        Fri, 24 Feb 2023 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677256320;
        bh=cTcR7JXgwQoIQrfS9qSNzrEQYELIPef/5bA+akG1xTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPjZyZf0M11GBceoaUIL+ljJkLlQM2r417ia3P+YylLcGVwqlQEQfDcq9PK6xSfst
         B3dz2xA+NDPSWA7za5Z73Kst2PRoCU4JkVXRi+frexL3+fmS3HBEz3O6X5kTpSyBSS
         qnHO91LkDYxHrWOgU+BGkHa50kx1gM/6DUow/aAU=
Date:   Fri, 24 Feb 2023 17:31:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
Message-ID: <Y/jmfR47ZdepTyf7@kroah.com>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
 <Y/idMBIOfFZxXnVM@kroah.com>
 <26fc1456-0244-a379-0af4-e6adc819545c@asahilina.net>
 <Y/jZCCl4jbKoOiPX@kroah.com>
 <bd93ed8c-b020-5883-4baa-f9743e395b97@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd93ed8c-b020-5883-4baa-f9743e395b97@asahilina.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 12:51:38AM +0900, Asahi Lina wrote:
> On 25/02/2023 00.34, Greg Kroah-Hartman wrote:
> > On Sat, Feb 25, 2023 at 12:10:47AM +0900, Asahi Lina wrote:
> >>>> +impl Device {
> >>>> +    /// Creates a new device instance.
> >>>> +    ///
> >>>> +    /// # Safety
> >>>> +    ///
> >>>> +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
> >>>> +    pub unsafe fn new(ptr: *mut bindings::device) -> Self {
> >>>> +        // SAFETY: By the safety requirements, ptr is valid and its refcounted will be incremented.
> >>>> +        unsafe { bindings::get_device(ptr) };
> >>>
> >>> You don't check the return value of get_device()?  What if it failed
> >>> (hint, it can)?
> >>
> >> Really? I looked at the implementation and I don't see how it can fail,
> >> as long as the argument is non-NULL and valid... (which is a
> >> precondition of this unsafe function). Did I miss something?
> > 
> > This function has changed a bit over time, but yes, it could fail if
> > someone else just dropped the last reference right before you tried to
> > grab a new one (look at the implementation of kobject_get()).
> > 
> > Yes, if you "know" you have a non-zero reference count first, it should
> > never fail, but how do you know this?  We have the ability to check the
> > return value of the function, shouldn't that happen?
> 
> Well, we know this because it is part of the invariant. If we don't
> uphold invariants, things fall apart... that's why we create safe
> abstractions that don't let you break those invariants after all!
> 
> In this particular case though, I don't see what we can usefully do
> here. `device_get()` is going to be part of Clone impls and things like
> that which are non-fallible. At most we can assert!() and rust-panic
> (which is a BUG as far as I know) if it fails... would that be preferable?

That's a good question, I don't know.  In thinking about it some more,
I think we are ok with this as-is for now.

BUT, I want to see any code that is actually using a struct device, and
I really want to review the heck out of the platform device api that you
must have somewhere, as that might show some other issues around this
type of thing that might be lurking.

thanks,

greg k-h
