Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF9267B440
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjAYOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjAYOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:23:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A19A4A200
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:22:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 084C6B819A2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B61BC433D2;
        Wed, 25 Jan 2023 14:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674656575;
        bh=NWNbPDzJqKIdUCzGbaHaDwxIGEt55x8en6Y9Q75bVcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qfkn5gFo27n1bxX9qip7Od5e/5Uc9S4wbjPRx1ayyiDpCWYCvnL4BzIha+oJdAgnD
         bD1FdXxhuFEn8wMzyaLMulLit/UaNZKudnahqNk9o+ScOehVr0OjzbsCoklrw2Vjpj
         bGGg1JlxTczQlaNg3xhQTHK7iSZPVrMvpTS6fzpY=
Date:   Wed, 25 Jan 2023 15:22:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
Message-ID: <Y9E7PNmSTP5w2zuw@kroah.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9Ex3ZUIFxwOBg1n@work-vm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 01:42:53PM +0000, Dr. David Alan Gilbert wrote:
> * Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > Hi Greg, 
> > > 
> > > You mentioned couple of times (last time in this recent thread:
> > > https://lore.kernel.org/all/Y80WtujnO7kfduAZ@kroah.com/) that we ought to start
> > > discussing the updated threat model for kernel, so this email is a start in this direction. 
> > 
> > Any specific reason you didn't cc: the linux-hardening mailing list?
> > This seems to be in their area as well, right?
> > 
> > > As we have shared before in various lkml threads/conference presentations
> > > ([1], [2], [3] and many others), for the Confidential Computing guest kernel, we have a 
> > > change in the threat model where guest kernel doesn’t anymore trust the hypervisor. 
> > 
> > That is, frankly, a very funny threat model.  How realistic is it really
> > given all of the other ways that a hypervisor can mess with a guest?
> 
> It's what a lot of people would like; in the early attempts it was easy
> to defeat, but in TDX and SEV-SNP the hypervisor has a lot less that it
> can mess with - remember that not just the memory is encrypted, so is
> the register state, and the guest gets to see changes to mapping and a
> lot of control over interrupt injection etc.

And due to the fact that SEV and TDX really do not work, how is anyone
expecting any of this to work?  As one heckler on IRC recently put it,
if you squint hard enough, you can kind of ignore the real-world issues
here, so perhaps this should all be called "squint-puting" in order to
feel like you have a "confidential" system?  :)

> > So what do you actually trust here?  The CPU?  A device?  Nothing?
> 
> We trust the actual physical CPU, provided that it can prove that it's a
> real CPU with the CoCo hardware enabled.

Great, so why not have hardware attestation also for your devices you
wish to talk to?  Why not use that as well?  Then you don't have to
worry about anything in the guest.

> Both the SNP and TDX hardware
> can perform an attestation signed by the CPU to prove to someone
> external that the guest is running on a real trusted CPU.

And again, do the same thing for the other hardware devices and all is
good.  To not do that is to just guess and wave hands.  You know this :)

> Note that the trust is limited:
>   a) We don't trust that we can make forward progress - if something
> does something bad it's OK for the guest to stop.

So the guest can stop itself?

>   b) We don't trust devices, and we don't trust them by having the guest
> do normal encryption; e.g. just LUKS on the disk and normal encrypted
> networking. [There's a lot of schemes people are working on about how
> the guest gets the keys etc for that)

How do you trust you got real data on the disk?  On the network?  Those
are coming from the host, how is any of that data to be trusted?  Where
does the trust stop and why?

> > I hate the term "hardening".  Please just say it for what it really is,
> > "fixing bugs to handle broken hardware".  We've done that for years when
> > dealing with PCI and USB and even CPUs doing things that they shouldn't
> > be doing.  How is this any different in the end?
> > 
> > So what you also are saying here now is "we do not trust any PCI
> > devices", so please just say that (why do you trust USB devices?)  If
> > that is something that you all think that Linux should support, then
> > let's go from there.
> 
> I don't think generally all PCI device drivers guard against all the
> nasty things that a broken implementation of their hardware can do.

I know that all PCI drivers can NOT do that today as that was never
anything that Linux was designed for.

> The USB devices are probably a bit better, because they actually worry
> about people walking up with a nasty HID device;  I'm skeptical that
> a kernel would survive a purposely broken USB controller.

I agree with you there, USB drivers are only starting to be fuzzed at
the descriptor level, that's all.  Which is why they too can be put into
the "untrusted" area until you trust them.

> I'm not sure the request here isn't really to make sure *all* PCI devices
> are safe; just the ones we care about in a CoCo guest (e.g. the virtual devices) -
> and potentially ones that people will want to pass-through (which
> generally needs a lot more work to make safe).
> (I've not looked at these Intel tools to see what they cover)

Why not just create a whole new bus path for these "trusted" devices to
attach to and do that instead of tyring to emulate a protocol that was
explicitly designed NOT to this model at all?  Why are you trying to
shoehorn something here and not just designing it properly from the
beginning?

> Having said that, how happy are you with Thunderbolt PCI devices being
> plugged into your laptop or into the hotplug NVMe slot on a server?

We have protection for that, and have had it for many years.  Same for
USB devices.  This isn't new, perhaps you all have not noticed those
features be added and taken advantage of already by many Linux distros
and system images (i.e. ChromeOS and embedded systems?)

> We're now in the position we were with random USB devices years ago.

Nope, we are not, again, we already handle random PCI devices being
plugged in.  It's up to userspace to make the policy decision if it
should be trusted or not before the kernel has access to it.

So a meta-comment, why not just use that today?  If your guest OS can
not authenticate the PCI device passed to it, don't allow the kernel to
bind to it.  If it can be authenticated, wonderful, bind away!  You can
do this today with no kernel changes needed.

> Also we would want to make sure that any config data that the hypervisor
> can pass to the guest is validated.

Define "validated" please.

> The problem seems reasonably well understood within the CoCo world - how
> far people want to push it probably varies; but it's good to make the
> problem more widely understood.

The "CoCo" world seems distant and separate from the real-world of Linux
kernel development if you all do not even know about the authentication
methods that we have for years for enabling access to PCI and USB
devices as described above.  If the impementations that we currently
have are lacking in some way, wonderful, please submit changes for them
and we will be glad to review them as needed.

Remember, it's up to you all to convince us that your changes make
actual sense and are backed up with working implementations.  Not us :)

good luck!

greg k-h
