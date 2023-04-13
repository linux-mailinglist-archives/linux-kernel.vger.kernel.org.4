Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9625A6E16C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDMVyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMVyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:54:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE9B5BA2;
        Thu, 13 Apr 2023 14:54:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681422840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x/oQrWzCvRtz1mqUB5XvgFo2uRVyimMcYlXEJnvvl7o=;
        b=WGPuCo0PHZ8ZfmLA0HhbZoBAUEmMXrK2aqIZrrwhVw/JyFHr/716TqZE7Ywzw3lbDwGmPj
        97iykxeYDfCOmO+CQT1wow5vNOCHf6pYrt80VpEDfy1Oj+Xmdtvj4v6MnL3WZOyTSJqizD
        dTRJVN/PJAWOqn4on+pMhfl8kKaONa+GDMKtlO4G1uBUr3qVGQ+L5PY1s4xW80z2o9n0QA
        hXFdLg6bVt04ZrwlkbEY2zpY7zNAxn/N5iRcwsxOXE6rv5eCA0p9/I6IkorX16KiKQRZ+s
        XyXkoDUc0UiQU8EbXnLtmCbFYELgBcy+4KznZoLSubEj9L6bklawi4Dm/93ViQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681422840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x/oQrWzCvRtz1mqUB5XvgFo2uRVyimMcYlXEJnvvl7o=;
        b=ENHNA4alryhD8gDh4s4OxDJTzpw/LdDXU6er1PiIxtgj0HZhxeMhZUB9J4Wt6XaOZHTt8f
        tf/e+Xn7E9GsFhAQ==
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v3 0/8] Support ACPI PSP on Hyper-V
In-Reply-To: <8d39a9a1-4b7b-08fe-7b09-2ff0a419468f@linux.microsoft.com>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230322154655.GDZBsi75f6LnQStxSp@fat_crate.local>
 <1d25221c-eaab-0f97-83aa-8b4fbe3a53ed@linux.microsoft.com>
 <20230322181541.GEZBtFzRAMcH9BAzUe@fat_crate.local>
 <ecf005b1-ddb9-da4c-4526-28df4806426c@linux.microsoft.com>
 <20230323152342.GFZBxu/m3u6aFUDY/7@fat_crate.local>
 <105d019c-2249-5dfd-e032-95944ea6dc8c@linux.microsoft.com>
 <20230323163450.GGZBx/qpnclFnMaf7e@fat_crate.local>
 <c8458bfa-0985-f6a5-52a3-ef96c7669fe6@linux.microsoft.com>
 <20230402154425.GCZCmi2eiKYO2yYhNs@fat_crate.local> <877cutsczn.ffs@tglx>
 <8d39a9a1-4b7b-08fe-7b09-2ff0a419468f@linux.microsoft.com>
Date:   Thu, 13 Apr 2023 23:53:50 +0200
Message-ID: <87h6tjzbwx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremi!

On Wed, Apr 05 2023 at 09:56, Jeremi Piotrowski wrote:
> On 4/3/2023 8:20 AM, Thomas Gleixner wrote:

First of all. Thanks for writing this up!

> The goal of these patches is to operate all the hardware interfaces required
> to run AMD SEV-SNP VMs, but in the context of a Linux VM running on top of
> Hyper-V. This Linux VM is called the SNP-host VM. All the patches I submit 
> target the SNP-host VM kernel, which uses KVM to bring up SEV-SNP VMs. To get
> SEV-SNP working you need to combine this work with AMD's KVM SEV-SNP patches.
> I posted two patch sets: one that extends AMD's patches, and one that is
> independent of them (this one here) that could be merged sooner.
>
> Here are the design constraints:
> 1. the interfaces exposed to the SNP-host VM to operate SEV-SNP match real
>    hardware interface specifications defined by AMD. This is because we are
>    emulating/virtualizing a hardware feature, and not some made up virtual
>    thing.

Hardware/firmware folks design a lot of interfaces which are not well
thought out. The kernel has refused to implement support for those in
the past.

It's part of our development and review process to understand the
rationale behind these interfaces and if they do not make sense, tell
the vendor to fix them before we set them into stone and have to support
them forever.

And this interface _is_ fixable because it's a firmware interface and
not something cast in silicon. Firmware interfaces are versioned and
Linux has enough examples of not supporting early versions of such
interfaces.

I'm not saying it's wrong, but the lack of rationale makes me cautious.

> 2. the SNP-host VM may run either Windows(Hyper-V) or Linux, so the SEV-SNP
>    interfaces need to be supported by both.
>
> 3. Hyper-V Generation 2 VMs do not have a PCI bus. The SNP-host VM must be a
>    Hyper-V Gen 2 VM.

I wonder how that correlates with the patch series which adds PCI pass
through support to Hyper-V Confidential VMs....

     https://lore.kernel.org/lkml/1679838727-87310-1-git-send-email-mikelley@microsoft.com

But that's just me being confused about a gazillion hyperv related patch
series which all fiddle something in the name of confudential computing.

It's also not really relevant to the problem at hand.

> One of the components needed to operate SEV-SNP is the Platform Security
> Processor (PSP), aka AMD Secure Processor (ASP). The PSP is the root-of-trust on
> AMD systems. The PSP is specified as being discoverable either on the PCI bus,
> or through the presence of an ACPI table with the "ASPT" (AMD Secure Processor
> Table) signature.
>
> Here goes the design:
> Constraint 1 means that only the two specified ways of discovering and
> configuring a PSP inside the SNP-host VM were in the running: PCI or ASPT.
> Constraint 3 means that the PCI version of the PSP is not a viable option.
> Additionally, the ASPT is used on AMD hardware in Microsoft datacenters, which
> means it is supported in Hyper-V (constraint 2). The outcome is that the
> SNP-host VM sees an ASPT.
>
> The ASPT provides the following information: memory range of PSP registers and
> offsets of individual PSP registers inside that memory range. There are 7
> registers:
> - 6 are related to the "command submission" portion of the PSP; the ccp module
>   knows how to operate those.
> - the last one, "ACPI CmdResp" register, is used to configure the PSP interrupt
>   to the OS.
>
> The PSP interrupt configuration through the "ACPI CmdResp" register takes the
> following information:
> - APIC ID
> - interrupt vector
> - destination mode (physical/logical)
> - message type (fixed/lowest priority)

This part is exactly where I started questioning, as it requires to
provide the exact data which can be written into the X2APIC ICR MSR,
which is not necessarily the most brilliant abstraction and evades
interrupt remapping completely on bare metal.

> There is nothing Hyper-V specific about any of this code, it supports a hardware
> interface present in server grade hardware and would work on physical hardware if
> when (not if) someone removes the condition.

This is _not_ a hardware interface, it's a firmware interface. The
memory window is just the transport so the OS side can talk to the PSP
firmware provided interface.

An interface with a specification which has never seen the scrutiny of
kernel developers and maintainers before you started posting these
patches. The ASPT documentation, which I saw the first time when you
provided the link, describes that interface but is completely void of
any rationale.

That's not your fault of course.

> You asked "what makes this PSP device special". The PSP is the
> root-of-trust on the system, it controls memory encryption keys, it
> can encrypt/decrypt individual memory pages.

I'm well aware what the PSP is. My question was: Why does it need
special treatment for interrupts?

> SEV-SNP ties together a lot of system components and requires enabling
> support for it in the AMD IOMMU too, which is presumably why the PSP
> gets the same special treatment (as the AMD IOMMU).

That's a fallacy. The PSP when exposed via PCI, is not treated
special. It's just assigned a regular MSI message which is composed by
the IOMMUs interrupt remapping units irqdomain.

That PCI device is not a real PCI device. It's a PCI shim which is
enumerated via PCI and provides the usual config space and bars, but the
back-end is not what we assume if we read PCI. That's true for a lot of
integrated devices on x86 (all vendors) and it's that way because PCI is
a very convenient and (most of the time) consistent way of enumeration
and configuration.

This ASPT/PSP mechanism just creates a different form of enumeration and
works completely independent of PCI. The table provides the physical
base address of the memory window and the register offsets in that
window.

That's not really much different from PCI which provides the window base
address in a PCI bar and has hard-coded device ID dependent register
offsets.

What's actually different is how the PSP interrupt is configured in the
non PCI case because it obviously can't use PCI/MSI[-x], but it still
could utilize the generic concept of MSI in theory.

> The ASPT and AMD PSP interrupt configuration through the "ACPI
> CmdResp" register is based on a similar design of the AMD IOMMU.

Sorry no. Just because X does something does not mean that Y, which
wants to do something similar, is based on the same design.

> The AMD IOMMU is:
> - discovered through the presence of the IVRS ACPI table
> - the MMIO address of the IOMMU is parsed out of the IVRS table
> - if x2APIC support is enabled, the IOMMU interrupts are delivered based on
>   programming APIC-ID+vector+destination mode into an interrupt control register
>   in IOMMU MMIO space. This causes any PCI-MSI configuration present for the
>   IOMMU to   be ignored.

That's not entirely correct.

    - Interrupt remapping requires x2APIC support.

    - If interrupt remapping is enabled then the interrupts of the IOMMU
      and remapping unit, which deliver faults and errors, cannot go
      through the remapping unit itself for obvious reasons.

      So it has to have a mechanism which allows it to deliver an
      interrupt to a particular destination directly w/o going through
      its possibly faulty self.

      Obviously Linux supports that mechanism otherwise there would be
      no interrupt remapping support on Linux at all.

There is a very concise technical reason for this mechanism, but IOMMU
and PSP are technically completely different entities and the existance
of the IOMMU mechanims does not make an argument at all, that the PSP
firmware device is modeled the same way and needs to be treated the same
way.

PSP does not have the same requirement as the IOMMU. Otherwise it could
not work at all with the PCI interface which sends its interrupt message
through the interrupt remapping unit, unless the translation mechanism
does too ugly to envision nasties.

The direct firmware interface, which is just based on an ioremap'ed
address window instead of a shim PCI device, requires suddenly a
different way to configure the interrupts:

  It requires to provide a full extended APIC-ID, the vector and the
  control bits, ready for consumption to write into the x2APIC ICR MSR.

  Which in turn, when running on bare metal evades the interrupt
  remapping unit completely.

So it is _not_ the same thing as the PCI variant, which handles
bog-standard remapped MSI message format just fine. It would also handle
non-remapped format just fine _if_ IOMMU & interrupt remapping would not
be mandatory for SEV[-SNP].

There might be a concise technical reason why the direct firmware
interface can't use a regular MSI message, requires the plain x2APIC ICR
data and why it's required that the direct firmware interface can evade
interrupt remapping on bare metal, but so far nobody provided one.

Jeremi, I'm not asking you, to provide that.

There are enough AMD people on Cc who are in a better place to answer
that question. It's their specification and their firmware after all.

Though while I wrote all of this up, I found actually a technical
reason:

   The shim PCI device has obviously a device ID, aka PCI BDF (Bus,
   Device, Function), which allows the IOMMU/remapping code to find the
   associated IOMMU and remapping table. The table is associated to the
   device so the remapping unit can validate whether a particular
   interrupt message is originated from the device associated to it.

   The non-PCI variant does not have a device ID. That could probably be
   solved, like it is solved for IOAPIC and HPET, but that requires at
   least software support for IOMMU/remapping and might even require a
   change in hardware as far as my limited understanding goes. Whether
   that's worth it, is a completely different question.

   As a consequence, this variant as of today cannot send interrupts
   through the generic MSI mechanism which is routed through the
   IOMMU/remapping unit and the only remaining option is to issue
   interrupts directly via ICR, aka IPI.

   This makes a _concise_ technical argument for the interface provided
   under the following assumptions:

     - It's not worth to address that device ID problem because there is
       no real value as the PSP device is considered to be "correct".

     - I'm not completely off track with my analysis

   Let's assume those assumptions hold.

   Still the existence of the IOMMU mechanism does not make an argument
   for the PSP case on it's own.

   Those two are two completely different reasons. The consequence that
   both need a special irqdomain is the same, but that's it. See?

It's a sad state of affairs, that I had to decipher that myself, instead
of AMD folks providing this information in the documentation upfront or
at least having the courtesy of providing it in the context of this
discussion. That would have spared a lot of wasted time.

But why do I complain?

The concept of proper hardware/software co-design, which was postulated
at least 40 years ago, is still either unknown or in its infancy at the
vast majority of silicon vendors including my own employer.

The main concept is still to throw hardware/firmware over the fence and
let software folks deal with it. That's a complete disaster and paves
the way to death by complexity and unmaintainability.

As a consequence the only way for a responsible kernel maintainer is to
question the design at the point where patches are posted. Therefore
it's not unreasonable to ask for a rationale and concise technical
arguments at that point.

If the provided information does not make sense and the interface still
can be adjusted, as it is the case with pure firmware interfaces, then
there is no justification for hand-wavy arguments based on presumptions
and assumptions, really.

Again, I'm not blaming Jeremi, who has the same problem just at the
other side of the fence. First he has to make it work based on some
meager documentation and then he has to argue himself blue based on that
same meager documentation.

Can silicon folks finally get their act together and accept the fact
that the upstream Linux kernel is not there to cater to their technical
brain fart of the day?

It's the other way around. Silicon vendors rely on first class support
by the kernel, so it's their obligation to:

   - integrate upstream into their specification process _upfront_
   - provide concise technical documentation
   - take responsibility for the kernel as a whole

IOW, the Linux kernel community has to be considered as their primary
"customer" simply because _most_ of their actually paying important
customers are depending on that.

Offloading this after the fact to paying customers who want to enable
some new feature, whether it's well thought out or not, is really not
the way to go.

It's just wasting the time of _everyone_ who is involved, except for
those vendor associated folks who stand by and ignore or silently watch
the discussions others have to fight on their behalf.

Thanks,

        tglx
