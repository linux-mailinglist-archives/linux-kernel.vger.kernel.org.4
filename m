Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7148768E8D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBHHTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjBHHTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:19:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812F125E31
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:19:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E064B81AD2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC81BC433D2;
        Wed,  8 Feb 2023 07:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675840757;
        bh=jby8Xxn/15WsuRZjRZSBnkQZd9v+pbrfsSuYH8XaaOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocMio9Gtnjd9XRhc2/ylEDSRvu41H9M3y5S6XyVWe3+I4t8vrEej+Us8sikBhVHy1
         7USpOYPsJwqHjiVqwNqPvJvKR1aL1wDQu+iDVJyzRCH5jqwmmH8nzzE92yqZ/c/s0Q
         zlGItFTNE6E1xKW8O+Ftecq6MRdVdqoyzu17cbgE=
Date:   Wed, 8 Feb 2023 08:19:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y+NM8a2r97qNR1hu@kroah.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com>
 <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:53:34PM -0600, Carlos Bilbao wrote:
> On 2/7/23 00:03, Greg Kroah-Hartman wrote:
> 
> > On Mon, Feb 06, 2023 at 06:27:48PM -0600, Carlos Bilbao wrote:
> > > On 1/25/23 6:28 AM, Reshetova, Elena wrote:
> > > > 2) One of the described in the above doc mitigations is "hardening of the enabled
> > > > code". What we mean by this, as well as techniques that are being used are
> > > > described in this document: > https://intel.github.io/ccc-linux-guest-hardening-docs/tdx-guest-hardening.html
> > > Regarding driver hardening, does anyone have a better filtering idea?
> > > 
> > > The current solution assumes the kernel command line is trusted and cannot
> > > avoid the __init() functions that waste memory.
> > That is two different things (command line trust and __init()
> > functions), so I do not understand the relationship at all here.  Please
> > explain it better.
> 
> 
> No relation other than it would be nice to have a solution that does not
> require kernel command line and that prevents __init()s.

Again, __init() has nothing to do with the kernel command line so I do
not understand the relationship here.  Have a specific example?

> > Also, why would an __init() function waste memory?  Memory usage isn't
> > an issue here, right?
> > 
> > > I don't know if the
> > > __exit() routines of the filtered devices are called, but it doesn't sound
> > > much better to allocate memory and free it right after.
> > What device has a __exit() function?  Drivers have module init/exit
> > functions but they should do nothing but register themselves with the
> > relevant busses and they are only loaded if the device is found in the
> > system.
> > 
> > And what exactly is incorrect about allocating memory and then freeing
> > it when not needed?
> 
> 
> Currently proposed device filtering does not stop the __init() functions
> from these drivers to be called. Whatever memory is allocated by
> blacklisted drivers is wasted because those drivers cannot ever be used.
> Sure, memory can be allocated and freed as soon as it is no longer needed,
> but these memory would never be needed.

Drivers are never even loaded if the hardware is not present, and a
driver init function should do nothing anyway if it is written properly,
so again, I do not understand what you are referring to here.

Again, a real example might help explain your concerns, pointers to the
code?

> More pressing concern than wasted memory, which may be unimportant, there's
> the issue of what are those driver init functions doing. For example, as
> part of device setup, MMIO regs may be involved, which we cannot trust. It's
> a lot more code to worry about from a CoCo perspective.

Again, specific example?

And if you don't want a driver to be loaded, don't build it into your
kernel as Ted said.  Or better yet, use the in-kernel functionality to
prevent drivers from ever loading or binding to a device until you tell
it from userspace that it is safe to do so.

So I don't think this is a real issue unless you have pointers to code
you are concerned about.

> > So again, I don't understand the question, sorry.
> 
> Given the limitations of current approach, does anyone have any other ideas
> for filtering devices prior to their initialization?

What is wrong with the functionality we have today for this very thing?
Does it not work properly for you?  If so, why not, for what devices and
drivers and busses do you still have problems with?

thanks,

greg k-h
