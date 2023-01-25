Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8078967B641
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjAYPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjAYPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:51:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8654FC21
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674661842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0g5sRLzmZMRmj3MKoDt9TvnE1vB8yteHz01D5AhG2w=;
        b=hnJIR6lsBHNCMAcGIRiqa1pXezDAqztJdWEgnCfHkgJlmAES7aMfbL1cl5BebEfK7E88rc
        iEsJhAg2RNUJ0PzFpThZGJ9VBNW71ygjU+N6TFzuVkulBbOEMrCxQpnoI+kLs4umaJUiAn
        X1B2CUGCG+ii25VhWHX9pojCi54lVaE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-373-Skhp3bleOq6cFH1PpGNtgQ-1; Wed, 25 Jan 2023 10:50:40 -0500
X-MC-Unique: Skhp3bleOq6cFH1PpGNtgQ-1
Received: by mail-wm1-f72.google.com with SMTP id z22-20020a05600c0a1600b003db00dc4b69so1276160wmp.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0g5sRLzmZMRmj3MKoDt9TvnE1vB8yteHz01D5AhG2w=;
        b=HN7makrRqZVS1XYLYHnoe9n/nAKNMu73PQlfI7jfds3mHD0+sBhTHwp1iNlDX0G2Q8
         JkeRw7dDq49f+4DpB43aAV1xd9ttOs0DnDg4pFYGCKcJWPAC6+dHyIw8hTK1fkW2+xhy
         ioDnsQbrWyrWNvGFiqIW5F6c7htr60xDvZlPF/Y+7tI5rahPQ7RJB1R3P/K+2tqVRNqI
         wTywSPA38qp6D+Ylz9jrne4D2ZLg0zzyPEDDvps8vlny7IgCJFvY4NQRz5NzWEd4/b0P
         QDqKM7wxvMF1Bo5a3L6cQt6614W0bxPPkYjDOHgpTzoAktHp11Sd7PpZbtcj8JAg+z2r
         Du+A==
X-Gm-Message-State: AO0yUKUw5FPvHp/MRZQg/TgFdOeVkgOZSYClw7esLfn8oeNH9N8JqR3q
        x6YNVzzDRxP8+0FrtvrhJHCNG2bG2663hlHHh3sMHiOqF0nrO+V+AmX6Ad3ZwHTb/dlWMmNDU4N
        nlmC8Kgr6X5onB6xsB+nB7yoC
X-Received: by 2002:adf:decc:0:b0:2bf:b119:e6e2 with SMTP id i12-20020adfdecc000000b002bfb119e6e2mr5540881wrn.47.1674661839505;
        Wed, 25 Jan 2023 07:50:39 -0800 (PST)
X-Google-Smtp-Source: AK7set/+r6DsJPuErihqA+tO1J7DJ2kesK8pm/oqfIMtJ/I/TWTofImR6SytbgfxfFqO/2H973FMeA==
X-Received: by 2002:adf:decc:0:b0:2bf:b119:e6e2 with SMTP id i12-20020adfdecc000000b002bfb119e6e2mr5540866wrn.47.1674661839168;
        Wed, 25 Jan 2023 07:50:39 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id q6-20020adff946000000b002bdd155ca4dsm4727652wrr.48.2023.01.25.07.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 07:50:38 -0800 (PST)
Date:   Wed, 25 Jan 2023 15:50:36 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <Y9FPzD/kpL4sI/Qa@work-vm>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <Y9FHsvVoPbgMR2s3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9FHsvVoPbgMR2s3@kroah.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> On Wed, Jan 25, 2023 at 02:57:40PM +0000, Dr. David Alan Gilbert wrote:
> > * Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> > > On Wed, Jan 25, 2023 at 01:42:53PM +0000, Dr. David Alan Gilbert wrote:
> > > > * Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> > > > > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > > > > Hi Greg, 
> > > > > > 
> > > > > > You mentioned couple of times (last time in this recent thread:
> > > > > > https://lore.kernel.org/all/Y80WtujnO7kfduAZ@kroah.com/) that we ought to start
> > > > > > discussing the updated threat model for kernel, so this email is a start in this direction. 
> > > > > 
> > > > > Any specific reason you didn't cc: the linux-hardening mailing list?
> > > > > This seems to be in their area as well, right?
> > > > > 
> > > > > > As we have shared before in various lkml threads/conference presentations
> > > > > > ([1], [2], [3] and many others), for the Confidential Computing guest kernel, we have a 
> > > > > > change in the threat model where guest kernel doesn’t anymore trust the hypervisor. 
> > > > > 
> > > > > That is, frankly, a very funny threat model.  How realistic is it really
> > > > > given all of the other ways that a hypervisor can mess with a guest?
> > > > 
> > > > It's what a lot of people would like; in the early attempts it was easy
> > > > to defeat, but in TDX and SEV-SNP the hypervisor has a lot less that it
> > > > can mess with - remember that not just the memory is encrypted, so is
> > > > the register state, and the guest gets to see changes to mapping and a
> > > > lot of control over interrupt injection etc.
> > > 
> > > And due to the fact that SEV and TDX really do not work, how is anyone
> > > expecting any of this to work?  As one heckler on IRC recently put it,
> > > if you squint hard enough, you can kind of ignore the real-world issues
> > > here, so perhaps this should all be called "squint-puting" in order to
> > > feel like you have a "confidential" system?  :)
> > 
> > I agree the original SEV was that weak; I've not seen anyone give a good
> > argument against SNP or TDX.
> 
> Argument that it doesn't work?  I thought that ship sailed a long time
> ago but I could be wrong as I don't really pay attention to that stuff
> as it's just vaporware :)

You're being unfair claiming it's vaporware.  You can go out and buy SNP
hardware now (for over a year), the patches are on list and under review
(and have been for quite a while).
If you're claiming it doesn't, please justify it.

> > > > > So what do you actually trust here?  The CPU?  A device?  Nothing?
> > > > 
> > > > We trust the actual physical CPU, provided that it can prove that it's a
> > > > real CPU with the CoCo hardware enabled.
> > > 
> > > Great, so why not have hardware attestation also for your devices you
> > > wish to talk to?  Why not use that as well?  Then you don't have to
> > > worry about anything in the guest.
> > 
> > There were some talks at Plumbers where PCIe is working on adding that;
> > it's not there yet though.  I think that's PCIe 'Integrity and Data
> > Encryption' (IDE - sigh), and PCIe 'Security Prtocol and Data Model' -
> > SPDM.   I don't know much of the detail of those, just that they're far
> > enough off that people aren't depending on them yet.
> 
> Then work with those groups to implement that in an industry-wide way
> and then take advantage of it by adding support for it to Linux!  Don't
> try to reinvent the same thing in a totally different way please.

Sure, people are working with them; but those are going to take time
and people want to use existing PCIe devices; and given that the hosts
are available that seems reasonable.   

> > > > Both the SNP and TDX hardware
> > > > can perform an attestation signed by the CPU to prove to someone
> > > > external that the guest is running on a real trusted CPU.
> > > 
> > > And again, do the same thing for the other hardware devices and all is
> > > good.  To not do that is to just guess and wave hands.  You know this :)
> > 
> > That wouldn't help you necessarily for virtual devices - where the
> > hypervisor implements the device (like a virtual NIC).
> 
> Then create a new bus for that if you don't trust the virtio bus today.

It's not that I distrust the virtio bus - just that we need to make sure
it's implementation is pessimistic enough for CoCo.

> > > > > I hate the term "hardening".  Please just say it for what it really is,
> > > > > "fixing bugs to handle broken hardware".  We've done that for years when
> > > > > dealing with PCI and USB and even CPUs doing things that they shouldn't
> > > > > be doing.  How is this any different in the end?
> > > > > 
> > > > > So what you also are saying here now is "we do not trust any PCI
> > > > > devices", so please just say that (why do you trust USB devices?)  If
> > > > > that is something that you all think that Linux should support, then
> > > > > let's go from there.
> > > > 
> > > > I don't think generally all PCI device drivers guard against all the
> > > > nasty things that a broken implementation of their hardware can do.
> > > 
> > > I know that all PCI drivers can NOT do that today as that was never
> > > anything that Linux was designed for.
> > 
> > Agreed; which again is why I only really worry about the subset of
> > devices I'd want in a CoCo VM.
> 
> Everyone wants a subset, different from other's subset, which means you
> need them all.  Sorry.

I think for CoCo the subset is fairly small, even including all the
people discussing it.  It's the virtual devices, and a few of their
favourite physical devices, but a fairly small subset.

> > > > The USB devices are probably a bit better, because they actually worry
> > > > about people walking up with a nasty HID device;  I'm skeptical that
> > > > a kernel would survive a purposely broken USB controller.
> > > 
> > > I agree with you there, USB drivers are only starting to be fuzzed at
> > > the descriptor level, that's all.  Which is why they too can be put into
> > > the "untrusted" area until you trust them.
> > > 
> > > > I'm not sure the request here isn't really to make sure *all* PCI devices
> > > > are safe; just the ones we care about in a CoCo guest (e.g. the virtual devices) -
> > > > and potentially ones that people will want to pass-through (which
> > > > generally needs a lot more work to make safe).
> > > > (I've not looked at these Intel tools to see what they cover)
> > > 
> > > Why not just create a whole new bus path for these "trusted" devices to
> > > attach to and do that instead of tyring to emulate a protocol that was
> > > explicitly designed NOT to this model at all?  Why are you trying to
> > > shoehorn something here and not just designing it properly from the
> > > beginning?
> > 
> > I'd be kind of OK with that for the virtual devices; but:
> > 
> >   a) I think you'd start reinventing PCIe with enumeration etc
> 
> Great, then work with the PCI group as talked about above to solve it
> properly and not do whack-a-mole like seems to be happening so far.
> 
> >   b) We do want those pass through NICs etc that are PCIe
> >     - as long as you use normal guest crypto stuff then the host
> >     can be just as nasty as it likes with the data they present.
> 
> Great, work with the PCI spec for verified devices.
> 
> >   c) The world has enough bus protocols, and people understand the
> >    basics of PCI(e) - we really don't need another one.
> 
> Great, work with the PCI spec people please.

As I say above; all happening - but it's going to take years.
It's wrong to leave users with less secure solutions if there are simple
fixes available.  I agree that if it involves major pain all over then
I can see your dislike - but if it's small fixes then what's the
problem?

> > > > Having said that, how happy are you with Thunderbolt PCI devices being
> > > > plugged into your laptop or into the hotplug NVMe slot on a server?
> > > 
> > > We have protection for that, and have had it for many years.  Same for
> > > USB devices.  This isn't new, perhaps you all have not noticed those
> > > features be added and taken advantage of already by many Linux distros
> > > and system images (i.e. ChromeOS and embedded systems?)
> > 
> > What protection?  I know we have an IOMMU, and that stops the device
> > stamping all over RAM by itself - but I think Intel's worries are more
> > subtle, things where the device starts playing with what PCI devices
> > are expected to do to try and trigger untested kernel paths.  I don't
> > think there's protection against that.
> > I know we can lock by PCI/USB vendor/device ID - but those can be made
> > up trivially; protection like that is meaningless.
> 
> Then combine it with device attestation and you have a solved solution,
> don't ignore others working on this please.
> 
> > > > We're now in the position we were with random USB devices years ago.
> > > 
> > > Nope, we are not, again, we already handle random PCI devices being
> > > plugged in.  It's up to userspace to make the policy decision if it
> > > should be trusted or not before the kernel has access to it.
> > > 
> > > So a meta-comment, why not just use that today?  If your guest OS can
> > > not authenticate the PCI device passed to it, don't allow the kernel to
> > > bind to it.  If it can be authenticated, wonderful, bind away!  You can
> > > do this today with no kernel changes needed.
> > 
> > Because:
> >    a) there's no good way to authenticate a PCI device yet
> >      - any nasty device can claim to have a given PCI ID.
> >    b) Even if you could, there's no man-in-the-middle protection yet.
> 
> Where is the "man" here in the middle of?

I'm worried what a malicious hypervisor could do.

> And any PCI attestation should handle that, if not, work with them to
> solve that please.

I believe the two mechanisms I mentioned above would handle that; when
it eventually gets there.

> Thunderbolt has authenticated device support today, and so does PCI, and
> USB has had it for a decade or so.  Use the in-kernel implementation
> that we already have or again, show us where it is lacking and we will
> be glad to take patches to cover the holes (as we did last year when
> ChromeOS implemented support for it in their userspace.)

I'd appreciate pointers to the implementations you're referring to.

> > > > Also we would want to make sure that any config data that the hypervisor
> > > > can pass to the guest is validated.
> > > 
> > > Define "validated" please.
> > 
> > Lets say you get something like a ACPI table or qemu fw.cfg table
> > giving details of your devices; if the hypervisor builds those in a
> > nasty way what happens?
> 
> You tell me, as we trust ACPI tables today, and if we can not, again
> then you need to change the model of what Linux does.  Why isn't the
> BIOS authentication path working properly for ACPI tables already today?
> I thought that was a long-solved problem with UEFI (if not, I'm sure the
> UEFI people would be interested.)

If it's part of the BIOS image that's measured/loaded during startup
then we're fine; if it's a table dynamically generated by the hypervisor
I'm more worried.

> Anyway, I'll wait until I see real patches as this thread seems to be
> totally vague and ignores our current best-practices for pluggable
> devices for some odd reason.

Please point people at those best practices rather than just ranting
about how pointless you feel all this is!

The patches here from Intel are a TOOL to find problems; I can't see the
objections to having a tool like this.

(I suspect some of these fixes might make the kernel a bit more robust
against unexpected hot-remove of PCIe devices as well; but that's more
of a guess)

Dave

> thanks,
> 
> greg k-h
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

