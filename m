Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CF467B53E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjAYO6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAYO6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5493D55B2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674658667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ociYsRIOcqs1chHlUZYkLN67j5pvRMByvtLRcDsunuk=;
        b=io6VMfAu52qlL/QwJLW+UYYG1f1yIX23A4T2QIebu+nsV4SbdxNVELGkGRMw4Qxufqoad/
        RY5LJKR6ioGb1F9EQiru3XStkpvtephq8dSjoNA5TtpZKLGD0BXxYtfioLxqKMY+kyw2mR
        rhKbn+DkMv3Syd6g1+eljT+xKgAFZy0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-441-74YlIncFOueDm6OBojL6Yg-1; Wed, 25 Jan 2023 09:57:45 -0500
X-MC-Unique: 74YlIncFOueDm6OBojL6Yg-1
Received: by mail-wm1-f70.google.com with SMTP id l23-20020a7bc457000000b003db0cb8e543so645564wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ociYsRIOcqs1chHlUZYkLN67j5pvRMByvtLRcDsunuk=;
        b=fLIRSYEiKNNQM9bEhgXhPNa2UMDzLEgfSxMTTVZuhgd1NlEbkhniwGv7DlwGmr55uD
         N9yarVZYoTgnVTy7EEYbonzpTO2Pr9hfaS1GBUhsGP5ZvbEm84peTpD8SWkJT92GYkh0
         8LObqYiboFrE57RMOHpTo9AG+EcAW5QGFIuO9E9N9Z5AK5uC39wqcJbG5O6LE2mumyXD
         m/IdZXX8wW4nrRxyYy8pHBjYUopD2LixU9tQBir8i0NWZWzo7JazR7iS3DUw0/eZkF09
         I3jnbi793TXDGDdNl64IXXxWQc0+xxrioVEyU+/+q0YCIFFE11mhyslqEN5HYbwA1j6g
         Blvg==
X-Gm-Message-State: AFqh2konqe1rufjdXWxP2+ozjQpb1bbXyJCmaYRiZL5q8FdAaRRNCIDB
        qul46lf9dSm8pKb/jEyZbMUBOt/ECy3kK/U4ui8XEA9ERwHGmtHlawygsWQ6KIZKPgup+t/9wtc
        TTbDwQ48OVL0Th5B7QBMM7eH4
X-Received: by 2002:adf:c7cb:0:b0:2bc:48b3:f6de with SMTP id y11-20020adfc7cb000000b002bc48b3f6demr32863665wrg.0.1674658664553;
        Wed, 25 Jan 2023 06:57:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuXKMB7DVadoT6AZiGB/VCjx9ogi08Xmb1ZthHn0lER+hHf+ZyH1zfSzJQBPvZIBSn4/ihCPQ==
X-Received: by 2002:adf:c7cb:0:b0:2bc:48b3:f6de with SMTP id y11-20020adfc7cb000000b002bc48b3f6demr32863639wrg.0.1674658664181;
        Wed, 25 Jan 2023 06:57:44 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id c7-20020a056000104700b002be4ff0c917sm4555395wrx.84.2023.01.25.06.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:57:43 -0800 (PST)
Date:   Wed, 25 Jan 2023 14:57:40 +0000
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
Message-ID: <Y9FDZPV7qENtNNyk@work-vm>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9E7PNmSTP5w2zuw@kroah.com>
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
> On Wed, Jan 25, 2023 at 01:42:53PM +0000, Dr. David Alan Gilbert wrote:
> > * Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> > > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > > Hi Greg, 
> > > > 
> > > > You mentioned couple of times (last time in this recent thread:
> > > > https://lore.kernel.org/all/Y80WtujnO7kfduAZ@kroah.com/) that we ought to start
> > > > discussing the updated threat model for kernel, so this email is a start in this direction. 
> > > 
> > > Any specific reason you didn't cc: the linux-hardening mailing list?
> > > This seems to be in their area as well, right?
> > > 
> > > > As we have shared before in various lkml threads/conference presentations
> > > > ([1], [2], [3] and many others), for the Confidential Computing guest kernel, we have a 
> > > > change in the threat model where guest kernel doesn’t anymore trust the hypervisor. 
> > > 
> > > That is, frankly, a very funny threat model.  How realistic is it really
> > > given all of the other ways that a hypervisor can mess with a guest?
> > 
> > It's what a lot of people would like; in the early attempts it was easy
> > to defeat, but in TDX and SEV-SNP the hypervisor has a lot less that it
> > can mess with - remember that not just the memory is encrypted, so is
> > the register state, and the guest gets to see changes to mapping and a
> > lot of control over interrupt injection etc.
> 
> And due to the fact that SEV and TDX really do not work, how is anyone
> expecting any of this to work?  As one heckler on IRC recently put it,
> if you squint hard enough, you can kind of ignore the real-world issues
> here, so perhaps this should all be called "squint-puting" in order to
> feel like you have a "confidential" system?  :)

I agree the original SEV was that weak; I've not seen anyone give a good
argument against SNP or TDX.

> > > So what do you actually trust here?  The CPU?  A device?  Nothing?
> > 
> > We trust the actual physical CPU, provided that it can prove that it's a
> > real CPU with the CoCo hardware enabled.
> 
> Great, so why not have hardware attestation also for your devices you
> wish to talk to?  Why not use that as well?  Then you don't have to
> worry about anything in the guest.

There were some talks at Plumbers where PCIe is working on adding that;
it's not there yet though.  I think that's PCIe 'Integrity and Data
Encryption' (IDE - sigh), and PCIe 'Security Prtocol and Data Model' -
SPDM.   I don't know much of the detail of those, just that they're far
enough off that people aren't depending on them yet.

> > Both the SNP and TDX hardware
> > can perform an attestation signed by the CPU to prove to someone
> > external that the guest is running on a real trusted CPU.
> 
> And again, do the same thing for the other hardware devices and all is
> good.  To not do that is to just guess and wave hands.  You know this :)

That wouldn't help you necessarily for virtual devices - where the
hypervisor implements the device (like a virtual NIC).

> > Note that the trust is limited:
> >   a) We don't trust that we can make forward progress - if something
> > does something bad it's OK for the guest to stop.
> 
> So the guest can stop itself?

Sure.

> >   b) We don't trust devices, and we don't trust them by having the guest
> > do normal encryption; e.g. just LUKS on the disk and normal encrypted
> > networking. [There's a lot of schemes people are working on about how
> > the guest gets the keys etc for that)
> 
> How do you trust you got real data on the disk?  On the network?  Those
> are coming from the host, how is any of that data to be trusted?  Where
> does the trust stop and why?

We don't; you use LUKS2 on the disk and/or dm-verity; so there's no
trust in the disk.
You use whatever your favorite network encryption already is that
you're using to send data across the untrusted net.
So no trust in the data from the NIC.

> > > I hate the term "hardening".  Please just say it for what it really is,
> > > "fixing bugs to handle broken hardware".  We've done that for years when
> > > dealing with PCI and USB and even CPUs doing things that they shouldn't
> > > be doing.  How is this any different in the end?
> > > 
> > > So what you also are saying here now is "we do not trust any PCI
> > > devices", so please just say that (why do you trust USB devices?)  If
> > > that is something that you all think that Linux should support, then
> > > let's go from there.
> > 
> > I don't think generally all PCI device drivers guard against all the
> > nasty things that a broken implementation of their hardware can do.
> 
> I know that all PCI drivers can NOT do that today as that was never
> anything that Linux was designed for.

Agreed; which again is why I only really worry about the subset of
devices I'd want in a CoCo VM.

> > The USB devices are probably a bit better, because they actually worry
> > about people walking up with a nasty HID device;  I'm skeptical that
> > a kernel would survive a purposely broken USB controller.
> 
> I agree with you there, USB drivers are only starting to be fuzzed at
> the descriptor level, that's all.  Which is why they too can be put into
> the "untrusted" area until you trust them.
> 
> > I'm not sure the request here isn't really to make sure *all* PCI devices
> > are safe; just the ones we care about in a CoCo guest (e.g. the virtual devices) -
> > and potentially ones that people will want to pass-through (which
> > generally needs a lot more work to make safe).
> > (I've not looked at these Intel tools to see what they cover)
> 
> Why not just create a whole new bus path for these "trusted" devices to
> attach to and do that instead of tyring to emulate a protocol that was
> explicitly designed NOT to this model at all?  Why are you trying to
> shoehorn something here and not just designing it properly from the
> beginning?

I'd be kind of OK with that for the virtual devices; but:

  a) I think you'd start reinventing PCIe with enumeration etc

  b) We do want those pass through NICs etc that are PCIe
    - as long as you use normal guest crypto stuff then the host
    can be just as nasty as it likes with the data they present.

  c) The world has enough bus protocols, and people understand the
   basics of PCI(e) - we really don't need another one.

> > Having said that, how happy are you with Thunderbolt PCI devices being
> > plugged into your laptop or into the hotplug NVMe slot on a server?
> 
> We have protection for that, and have had it for many years.  Same for
> USB devices.  This isn't new, perhaps you all have not noticed those
> features be added and taken advantage of already by many Linux distros
> and system images (i.e. ChromeOS and embedded systems?)

What protection?  I know we have an IOMMU, and that stops the device
stamping all over RAM by itself - but I think Intel's worries are more
subtle, things where the device starts playing with what PCI devices
are expected to do to try and trigger untested kernel paths.  I don't
think there's protection against that.
I know we can lock by PCI/USB vendor/device ID - but those can be made
up trivially; protection like that is meaningless.

> > We're now in the position we were with random USB devices years ago.
> 
> Nope, we are not, again, we already handle random PCI devices being
> plugged in.  It's up to userspace to make the policy decision if it
> should be trusted or not before the kernel has access to it.
> 
> So a meta-comment, why not just use that today?  If your guest OS can
> not authenticate the PCI device passed to it, don't allow the kernel to
> bind to it.  If it can be authenticated, wonderful, bind away!  You can
> do this today with no kernel changes needed.

Because:
   a) there's no good way to authenticate a PCI device yet
     - any nasty device can claim to have a given PCI ID.
   b) Even if you could, there's no man-in-the-middle protection yet.

> > Also we would want to make sure that any config data that the hypervisor
> > can pass to the guest is validated.
> 
> Define "validated" please.

Lets say you get something like a ACPI table or qemu fw.cfg table
giving details of your devices; if the hypervisor builds those in a
nasty way what happens?

> > The problem seems reasonably well understood within the CoCo world - how
> > far people want to push it probably varies; but it's good to make the
> > problem more widely understood.
> 
> The "CoCo" world seems distant and separate from the real-world of Linux
> kernel development if you all do not even know about the authentication
> methods that we have for years for enabling access to PCI and USB
> devices as described above.  If the impementations that we currently
> have are lacking in some way, wonderful, please submit changes for them
> and we will be glad to review them as needed.

That's probably fair to some degree - the people looking at this are VM
people, not desktop people; I'm not sure what the overlap is; but as I
say above, I don't think the protection currently available really help
here.  Please show us where we're wrong.

> Remember, it's up to you all to convince us that your changes make
> actual sense and are backed up with working implementations.  Not us :)

Sure;  I'm seeing existing implementations being used in vendors clouds
at the moment, and they're slowly getting the security people want.
I'd like to see that being done with upstream kernels and firmware.

Dave


> good luck!
> 
> greg k-h
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

