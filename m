Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7E67B5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjAYPQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjAYPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:16:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3F30E6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93946B819F3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96ECC433D2;
        Wed, 25 Jan 2023 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674659765;
        bh=Zt0hwcWMjhLMy3JdqkGQgWhC1Ciy6pFM0efPSsej1wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fh4BElSULrGSmv8v/ouQFNF/uQNYjb0bTNz7xEJ+cwUNF8UwMCuWqh3z/JvEttukb
         vkLwr2XezWDp0O7ObAd2yoMv0p9gVHxVTpGPl2IRvUQZa9U/Cc+wBGwZmIWIOiqZEk
         wxjRkuAe4RDfQx4GbkL+L51ApceJ/kxxeT5wVHmo=
Date:   Wed, 25 Jan 2023 16:16:02 +0100
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
Message-ID: <Y9FHsvVoPbgMR2s3@kroah.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9FDZPV7qENtNNyk@work-vm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 02:57:40PM +0000, Dr. David Alan Gilbert wrote:
> * Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> > On Wed, Jan 25, 2023 at 01:42:53PM +0000, Dr. David Alan Gilbert wrote:
> > > * Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> > > > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > > > Hi Greg, 
> > > > > 
> > > > > You mentioned couple of times (last time in this recent thread:
> > > > > https://lore.kernel.org/all/Y80WtujnO7kfduAZ@kroah.com/) that we ought to start
> > > > > discussing the updated threat model for kernel, so this email is a start in this direction. 
> > > > 
> > > > Any specific reason you didn't cc: the linux-hardening mailing list?
> > > > This seems to be in their area as well, right?
> > > > 
> > > > > As we have shared before in various lkml threads/conference presentations
> > > > > ([1], [2], [3] and many others), for the Confidential Computing guest kernel, we have a 
> > > > > change in the threat model where guest kernel doesn’t anymore trust the hypervisor. 
> > > > 
> > > > That is, frankly, a very funny threat model.  How realistic is it really
> > > > given all of the other ways that a hypervisor can mess with a guest?
> > > 
> > > It's what a lot of people would like; in the early attempts it was easy
> > > to defeat, but in TDX and SEV-SNP the hypervisor has a lot less that it
> > > can mess with - remember that not just the memory is encrypted, so is
> > > the register state, and the guest gets to see changes to mapping and a
> > > lot of control over interrupt injection etc.
> > 
> > And due to the fact that SEV and TDX really do not work, how is anyone
> > expecting any of this to work?  As one heckler on IRC recently put it,
> > if you squint hard enough, you can kind of ignore the real-world issues
> > here, so perhaps this should all be called "squint-puting" in order to
> > feel like you have a "confidential" system?  :)
> 
> I agree the original SEV was that weak; I've not seen anyone give a good
> argument against SNP or TDX.

Argument that it doesn't work?  I thought that ship sailed a long time
ago but I could be wrong as I don't really pay attention to that stuff
as it's just vaporware :)

> > > > So what do you actually trust here?  The CPU?  A device?  Nothing?
> > > 
> > > We trust the actual physical CPU, provided that it can prove that it's a
> > > real CPU with the CoCo hardware enabled.
> > 
> > Great, so why not have hardware attestation also for your devices you
> > wish to talk to?  Why not use that as well?  Then you don't have to
> > worry about anything in the guest.
> 
> There were some talks at Plumbers where PCIe is working on adding that;
> it's not there yet though.  I think that's PCIe 'Integrity and Data
> Encryption' (IDE - sigh), and PCIe 'Security Prtocol and Data Model' -
> SPDM.   I don't know much of the detail of those, just that they're far
> enough off that people aren't depending on them yet.

Then work with those groups to implement that in an industry-wide way
and then take advantage of it by adding support for it to Linux!  Don't
try to reinvent the same thing in a totally different way please.

> > > Both the SNP and TDX hardware
> > > can perform an attestation signed by the CPU to prove to someone
> > > external that the guest is running on a real trusted CPU.
> > 
> > And again, do the same thing for the other hardware devices and all is
> > good.  To not do that is to just guess and wave hands.  You know this :)
> 
> That wouldn't help you necessarily for virtual devices - where the
> hypervisor implements the device (like a virtual NIC).

Then create a new bus for that if you don't trust the virtio bus today.

> > > > I hate the term "hardening".  Please just say it for what it really is,
> > > > "fixing bugs to handle broken hardware".  We've done that for years when
> > > > dealing with PCI and USB and even CPUs doing things that they shouldn't
> > > > be doing.  How is this any different in the end?
> > > > 
> > > > So what you also are saying here now is "we do not trust any PCI
> > > > devices", so please just say that (why do you trust USB devices?)  If
> > > > that is something that you all think that Linux should support, then
> > > > let's go from there.
> > > 
> > > I don't think generally all PCI device drivers guard against all the
> > > nasty things that a broken implementation of their hardware can do.
> > 
> > I know that all PCI drivers can NOT do that today as that was never
> > anything that Linux was designed for.
> 
> Agreed; which again is why I only really worry about the subset of
> devices I'd want in a CoCo VM.

Everyone wants a subset, different from other's subset, which means you
need them all.  Sorry.

> > > The USB devices are probably a bit better, because they actually worry
> > > about people walking up with a nasty HID device;  I'm skeptical that
> > > a kernel would survive a purposely broken USB controller.
> > 
> > I agree with you there, USB drivers are only starting to be fuzzed at
> > the descriptor level, that's all.  Which is why they too can be put into
> > the "untrusted" area until you trust them.
> > 
> > > I'm not sure the request here isn't really to make sure *all* PCI devices
> > > are safe; just the ones we care about in a CoCo guest (e.g. the virtual devices) -
> > > and potentially ones that people will want to pass-through (which
> > > generally needs a lot more work to make safe).
> > > (I've not looked at these Intel tools to see what they cover)
> > 
> > Why not just create a whole new bus path for these "trusted" devices to
> > attach to and do that instead of tyring to emulate a protocol that was
> > explicitly designed NOT to this model at all?  Why are you trying to
> > shoehorn something here and not just designing it properly from the
> > beginning?
> 
> I'd be kind of OK with that for the virtual devices; but:
> 
>   a) I think you'd start reinventing PCIe with enumeration etc

Great, then work with the PCI group as talked about above to solve it
properly and not do whack-a-mole like seems to be happening so far.

>   b) We do want those pass through NICs etc that are PCIe
>     - as long as you use normal guest crypto stuff then the host
>     can be just as nasty as it likes with the data they present.

Great, work with the PCI spec for verified devices.

>   c) The world has enough bus protocols, and people understand the
>    basics of PCI(e) - we really don't need another one.

Great, work with the PCI spec people please.

> > > Having said that, how happy are you with Thunderbolt PCI devices being
> > > plugged into your laptop or into the hotplug NVMe slot on a server?
> > 
> > We have protection for that, and have had it for many years.  Same for
> > USB devices.  This isn't new, perhaps you all have not noticed those
> > features be added and taken advantage of already by many Linux distros
> > and system images (i.e. ChromeOS and embedded systems?)
> 
> What protection?  I know we have an IOMMU, and that stops the device
> stamping all over RAM by itself - but I think Intel's worries are more
> subtle, things where the device starts playing with what PCI devices
> are expected to do to try and trigger untested kernel paths.  I don't
> think there's protection against that.
> I know we can lock by PCI/USB vendor/device ID - but those can be made
> up trivially; protection like that is meaningless.

Then combine it with device attestation and you have a solved solution,
don't ignore others working on this please.

> > > We're now in the position we were with random USB devices years ago.
> > 
> > Nope, we are not, again, we already handle random PCI devices being
> > plugged in.  It's up to userspace to make the policy decision if it
> > should be trusted or not before the kernel has access to it.
> > 
> > So a meta-comment, why not just use that today?  If your guest OS can
> > not authenticate the PCI device passed to it, don't allow the kernel to
> > bind to it.  If it can be authenticated, wonderful, bind away!  You can
> > do this today with no kernel changes needed.
> 
> Because:
>    a) there's no good way to authenticate a PCI device yet
>      - any nasty device can claim to have a given PCI ID.
>    b) Even if you could, there's no man-in-the-middle protection yet.

Where is the "man" here in the middle of?

And any PCI attestation should handle that, if not, work with them to
solve that please.

Thunderbolt has authenticated device support today, and so does PCI, and
USB has had it for a decade or so.  Use the in-kernel implementation
that we already have or again, show us where it is lacking and we will
be glad to take patches to cover the holes (as we did last year when
ChromeOS implemented support for it in their userspace.)

> > > Also we would want to make sure that any config data that the hypervisor
> > > can pass to the guest is validated.
> > 
> > Define "validated" please.
> 
> Lets say you get something like a ACPI table or qemu fw.cfg table
> giving details of your devices; if the hypervisor builds those in a
> nasty way what happens?

You tell me, as we trust ACPI tables today, and if we can not, again
then you need to change the model of what Linux does.  Why isn't the
BIOS authentication path working properly for ACPI tables already today?
I thought that was a long-solved problem with UEFI (if not, I'm sure the
UEFI people would be interested.)

Anyway, I'll wait until I see real patches as this thread seems to be
totally vague and ignores our current best-practices for pluggable
devices for some odd reason.

thanks,

greg k-h
