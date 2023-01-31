Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718DA68332C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjAaQ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjAaQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:59:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B5D36FDD;
        Tue, 31 Jan 2023 08:59:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5484B615AE;
        Tue, 31 Jan 2023 16:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225A0C433EF;
        Tue, 31 Jan 2023 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675184361;
        bh=BZZ3iOKvgr/L8SPBWZpeauGddSKSM+jvubWcKKW0WEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2EZWS1TcdW9aEWcy/YODbZ5dND6rwsVwiWrZbfF6TNRYYqSS/6quGlhQdghmzuJv
         Sj4mAp7RRkUHtCckW/H8cxOd1+VSRYSVWjdEBbJw5TZsedKxMD2JHMhwETyRN5kshy
         w6FJOmND/DsCh+DLHHY/UborwycqCFH2nme/C4b0=
Date:   Tue, 31 Jan 2023 17:59:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH] rust: add this_module macro
Message-ID: <Y9lI5iXD2RrdK43a@kroah.com>
References: <Y9kwpw18SVx9GZC4@kroah.com>
 <20230131160728.400481-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131160728.400481-1-yakoyoku@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 01:07:28PM -0300, Martin Rodriguez Reboredo wrote:
> On Tue, Jan 31, 2023 at 04:15:51PM +0100, Greg KH wrote:
> >On Tue, Jan 31, 2023 at 12:07:45PM -0300, Martin Rodriguez Reboredo wrote:
> >> On Tue, Jan 31, 2023 at 02:42:08PM +0100, Greg KH wrote:
> >> >On Tue, Jan 31, 2023 at 10:08:41AM -0300, Martin Rodriguez Reboredo wrote:
> >> >> Adds a Rust equivalent to the handy THIS_MODULE macro from C.
> >> >> 
> >> >> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> >> >> ---
> >> >>  rust/kernel/lib.rs | 12 ++++++++++++
> >> >>  1 file changed, 12 insertions(+)
> >> >> 
> >> >> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> >> >> index e0b0e953907d..afb6b0390426 100644
> >> >> --- a/rust/kernel/lib.rs
> >> >> +++ b/rust/kernel/lib.rs
> >> >> @@ -80,6 +80,18 @@ impl ThisModule {
> >> >>      }
> >> >>  }
> >> >>  
> >> >> +/// Returns the current module.
> >> >> +#[macro_export]
> >> >> +macro_rules! this_module {
> >> >> +    () => {
> >> >> +        if cfg!(MODULE) {
> >> >> +            Some(unsafe { $crate::ThisModule::from_ptr(&mut $crate::bindings::__this_module) })
> >> >> +        } else {
> >> >> +            None
> >> >> +        }
> >> >> +    };
> >> >> +}
> >> >
> >> >While this is handy, what exactly will it be used for?  The C
> >> >wrappers/shim/whatever should probably handle this for you already when
> >> >you save this pointer into a structure right?
> >> >
> >> >Surely you aren't trying to increment your own module's reference count,
> >> >right?  That just doesn't work :)
> >> >
> >> >thanks,
> >> >
> >> >greg k-h
> >> 
> >> This was meant for setting the owner field of a file_operations struct
> >> or the cra_owner field of crypto_alg and many other structs.
> >
> >But shouldn't the macro kernel::declare_file_operations() do this for
> >you automagically?  You should never have to manually say "this module!"
> >to any structure or function call if we do things right.
> >
> >Yes, many "old school" structures in the kernel do this, but we have
> >learned from the 1990's, see the fun wrappers around simple things like
> >usb_register_driver(); as an example of how the driver author themselves
> >should never see a module pointer anywhere.
> >
> >> I know that increfing a module without a good reason is dead dumb, so
> >> I'm not trying to send things in a downwards spiral. @@@
> >
> >That's good, but let's not add housekeeping requirements when we do not
> >have to do so if at all possible please.
> >
> >thanks,
> >
> >greg k-h
> 
> *kicks can*, at least I can take some ideas out of this, anyways, thanks
> for your reviews.

I don't mean to reject this out-of-hand, it's just that without a real
user, it's impossible to review this and say "this is ok" instead of
"perhaps you should do it this other way"?

Right now the rust framework is just that, a framework.  Perhaps we
should not be adding anything else to it until there is a real user of
it?  Otherwise this will keep coming up again and again.

Treat this like any other kernel feature/addition, you can't add apis
until you submit a user for it at the same time.  That's one way we have
been able to evolve and maintain the kernel source tree for so long.
Without an api user, we have no way to know how it's being used or if
it's even being used at all.

thanks,

greg k-h
