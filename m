Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D95967ED00
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjA0SD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjA0SDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:03:24 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB2415566
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:03:23 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30RI20YF011202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 13:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674842528; bh=3mHKkbAH+okU6AHANi/BzVdlU8mAUZv1+jT73lv1OWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=X1v0PvbJ7JWuw5yg30+68d4U5ZTtRAZLYMVxixtcRgMlJpDCVuQ6acpnX4iLkbDsd
         btZK2gFujU5B++TxM9WWiqcJnvMY3YDQOLTkglyI7gPbDbgt+uRnkG+bAMT7GNvgF4
         gPa1cz9Er2Fa6FEs2GNjBOWgxMeXlzMTgEgcxo0d/ItaSxnaGhiVq/AW7hBpuAcG95
         XNDVKl3+/oCV834rcRv6W+rt14HZj88Did3JOrps9zQJZJc8AALNSSEIHny5OxYppm
         NB3ucNdAYROr3ctQOUubvQTW+SCY+K4c20hdtOo6PvpbyzQfyOaO4kvIF8KZrfuk6a
         Ra3qTApqdc4vQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0407C15C358A; Thu, 26 Jan 2023 15:54:56 -0500 (EST)
Date:   Thu, 26 Jan 2023 15:54:55 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y9Lonw9HzlosUPnS@mit.edu>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9Jh2x9XJE1KEUg6@unreal>
 <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9JyW5bUqV7gWmU8@unreal>
 <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 01:28:15PM +0000, Reshetova, Elena wrote:
> > This is exactly what I said. You presented me the cases which exist in
> > your invented world. Mentioned unhandled page fault doesn't exist in real
> > world. If PCI device doesn't work, it needs to be replaced/blocked and not
> > left to be operable and accessible from the kernel/user.
> 
> Can we really assure correct operation of *all* pci devices out there? 
> How would such an audit be performed given a huge set of them available? 
> Isnt it better instead to make a small fix in the kernel behavior that would guard
> us from such potentially not correctly operating devices?

We assume that hardware works according to the spec; that's why we
have a specification.  Otherwise, things would be pretty insane, and
would lead to massive bloat *everywhere*.  If there are broken PCI
devices out there, then we can blacklist the PCI device.  If a
manufacturer is consistently creating devices which don't obey the
spec, we could block all devices from that manufacturer, and have an
explicit white list for those devices from that manufacturer that
actually work.

If we can't count on a floating point instruction to return the right
value, what are we supposed to do?  Create a code which double checks
every single floating point instruction just in case 2 + 2 = 3.99999999?   :-)

Ultimately, changing the trust boundary what is considered is a
fundamentally hard thing, and to try to claim that code that assumes
that things inside the trust boundary are, well, trusted, is not a
great way to win friends and influence people.

> Let's forget the trust angle here (it only applies to the Confidential Computing 
> threat model and you clearly implying the existing threat model instead) and stick just to
> the not-correctly operating device. What you are proposing is to fix *unknown* bugs
> in multitude of pci devices that (in case of this particular MSI bug) can
> lead to two different values being read from the config space and kernel incorrectly
> handing this situation.

I don't think that's what people are saying.  If there are buggy PCI
devices, we can put them on block lists.  But checking that every
single read from the config space is unchanged is not something we
should do, period.

> Isn't it better to do the clear fix in one place to ensure such
> situation (two subsequent reads with different values) cannot even happen in theory?
> In security we have a saying that fixing a root cause of the problem is the most efficient
> way to mitigate the problem. The root cause here is a double-read with different values,
> so if it can be substituted with an easy and clear patch that probably even improves
> performance as we do one less pci read and use cached value instead, where is the
> problem in this particular case? If there are technical issues with the patch, of course we 
> need to discuss it/fix it, but it seems we are arguing here about whenever or not we want
> to be fixing kernel code when we notice such cases...

Well, if there is a performance win to cache a read from config space,
then make the argument from a performance perspective.  But caching
values takes memory, and will potentially bloat data structures.  It's
not necessarily cost-free to caching every single config space
variable to prevent double-read from either buggy or malicious devices.

So it's one thing if we make each decision from a cost-benefit
perspective.  But then it's a *optimization*, not a *bug-fix*, and it
also means that we aren't obligated to cache every single read from
config space, lest someone wag their fingers at us saying, "Buggy!
Your code is Buggy!".

Cheers,

						- Ted
