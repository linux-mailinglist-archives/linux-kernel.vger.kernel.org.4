Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D0168312C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjAaPST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjAaPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:17:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF52359241;
        Tue, 31 Jan 2023 07:16:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE18A6156A;
        Tue, 31 Jan 2023 15:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7449C433EF;
        Tue, 31 Jan 2023 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675178154;
        bh=tIlkIAwhoU4Gqa2trj8qjbDbCf3WrEZyMlMXKhe5lFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/skL8LazREI8qonSp4pRdocHg1sVW0HoCYsvF4IMaLoye9Zt9avHiYiHrhL2howy
         V4PQDYxzOwUZpLWTpK2q//PgxxRy5u7HMJDKzKkQO91Sq/5i1FjXB9ooUKU3oPel33
         cCLx3MQSUOJ9eVrt4iU6Lkdca521AvU46aE/bRVo=
Date:   Tue, 31 Jan 2023 16:15:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH] rust: add this_module macro
Message-ID: <Y9kwpw18SVx9GZC4@kroah.com>
References: <Y9kasJQZf146ekp+@kroah.com>
 <20230131150745.370345-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131150745.370345-1-yakoyoku@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:07:45PM -0300, Martin Rodriguez Reboredo wrote:
> On Tue, Jan 31, 2023 at 02:42:08PM +0100, Greg KH wrote:
> >On Tue, Jan 31, 2023 at 10:08:41AM -0300, Martin Rodriguez Reboredo wrote:
> >> Adds a Rust equivalent to the handy THIS_MODULE macro from C.
> >> 
> >> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> >> ---
> >>  rust/kernel/lib.rs | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >> 
> >> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> >> index e0b0e953907d..afb6b0390426 100644
> >> --- a/rust/kernel/lib.rs
> >> +++ b/rust/kernel/lib.rs
> >> @@ -80,6 +80,18 @@ impl ThisModule {
> >>      }
> >>  }
> >>  
> >> +/// Returns the current module.
> >> +#[macro_export]
> >> +macro_rules! this_module {
> >> +    () => {
> >> +        if cfg!(MODULE) {
> >> +            Some(unsafe { $crate::ThisModule::from_ptr(&mut $crate::bindings::__this_module) })
> >> +        } else {
> >> +            None
> >> +        }
> >> +    };
> >> +}
> >
> >While this is handy, what exactly will it be used for?  The C
> >wrappers/shim/whatever should probably handle this for you already when
> >you save this pointer into a structure right?
> >
> >Surely you aren't trying to increment your own module's reference count,
> >right?  That just doesn't work :)
> >
> >thanks,
> >
> >greg k-h
> 
> This was meant for setting the owner field of a file_operations struct
> or the cra_owner field of crypto_alg and many other structs.

But shouldn't the macro kernel::declare_file_operations() do this for
you automagically?  You should never have to manually say "this module!"
to any structure or function call if we do things right.

Yes, many "old school" structures in the kernel do this, but we have
learned from the 1990's, see the fun wrappers around simple things like
usb_register_driver(); as an example of how the driver author themselves
should never see a module pointer anywhere.

> I know that increfing a module without a good reason is dead dumb, so
> I'm not trying to send things in a downwards spiral. @@@

That's good, but let's not add housekeeping requirements when we do not
have to do so if at all possible please.

thanks,

greg k-h
