Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151D4678429
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjAWSHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjAWSHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:07:32 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6724130B2F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:07:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1E40C434C6;
        Mon, 23 Jan 2023 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1674497237;
        bh=Is7K/HK01r2VTfdx6SQV+9Ry5+75txzgJ9japxHlt9w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ySWmV6wXPK6Sfl04leiA66xW02qJEF1oflNPWlK3Jf8HI4YWHt6zNHJmi04lhuAqD
         o3KJ8nkscYb+B1rxBZvnE2/gjwL/hMekItZHmzHUc/Lkcn5bpeBgKt9jsZIMqu8RSE
         bWXaBcZQIWKIGGXmUWT9m9+penIt+2CROZBfumXWqhdZ8ChGqUWeq9Cslu64iedPoG
         ZZ+xjUJKM4y/PYMjgljPbtk3B4b73eHIzGDkHY33Lir6GlDYWM9+/ynXO7BFlMJaP5
         f7rIBi7rq8wyaL6Dovf/tX6+MqK9F0FBOgKOX1JnSOc7SSut+d1FDezK7KwJcpa8a5
         fp0FpYk8Ar4pA==
Message-ID: <23f25ccd-64a3-5b27-6016-fe6fd653d1cc@asahilina.net>
Date:   Tue, 24 Jan 2023 03:07:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] iommu/io-pgtable: Add Apple UAT variant format
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20230121084758.31875-1-lina@asahilina.net>
 <4559b97f-1761-9652-8ee1-a3c52959cf9b@arm.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <4559b97f-1761-9652-8ee1-a3c52959cf9b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin, thank you for the review!

On 24/01/2023 00.39, Robin Murphy wrote:
> On 2023-01-21 08:47, Asahi Lina wrote:
>> The prot bits are interpreted as follows:
>>
>> - IOMMU_READ and IOMMU_WRITE have the usual meaning.
>>
>> - IOMMU_PRIV creates firmware-only mappings (no GPU access)
>> - IOMMU_NOEXEC creates GPU-only structures (no FW access)
>> - Otherwise structures are accessible by both GPU and FW
>>
>> - IOMMU_MMIO creates Device mappings for firmware
>> - IOMMU_CACHE creates Normal-NC mappings for firmware (cache-coherent
>>    from the point of view of the AP, but slower)
>> - Otherwise creates Normal mappings for firmware (this requires manual
>>    cache management on the firmware side, as it is not coherent with the
>>    SoC fabric)
> 
> Please don't abuse the prot flags by overloading them with 
> caller-specific meanings, especially if that ends up completely 
> reversing the expected meaning. They represent fairly generic semantics 
> which IOMMU drivers, and thus io-pgtable implementations, are expected 
> to match if the underlying format supports it, or ignore if not. If a 
> pagetable format has other functionality which a caller wants to make 
> use of, then we can look at extending that (possibly even as far as 
> reserving some prot values for format-specific definitons, if need be), 
> but the point is still to represent the functionality of the 
> MMU/pagetable itself, not encode higher-level use-cases.

That's fair, I wasn't sure which option would be preferable!

I think for this hardware, I'd have naturally expressed it as something
like PRIV_READ and PRIV_WRITE instead of PRIV, where this represents the
firmware side permissions to be ORed with the regular (GPU side)
permissions. But since we already have IOMMU_PRIV, it becomes a bit
harder...

Another option would be to just add IOMMU_UNPRIV which implies
unprivileged-only, and map that to GPU access. Then having no flag would
create GPU+FW mappings, or you could restrict it to FW only with PRIV or
GPU only with UNPRIV.

Neither of those options is a "perfect" match for what is really going
on, but I can't really think of a better way, other than just using
format-specific options... do you have a particular preference?

I think the MMIO/CACHE flags do map well enough so we probably don't
need to touch those, right?. CACHE is a bit weird in that it winds up
meaning "uncached by the firmware", but the comment in iommu.h
specifically calls its meaning out as "DMA cache coherency" and that is
what this achieves, coherency between (uncached) firmware accesses and
the AP CPU cache (which is coherent with the memory controller and
therefore coherent with the uncached view from the firmware side). Plus
by all appearances this mode does mean properly cached/coherent from the
GPU side (though that could just be implied either way).

>> Drivers are expected to fully manage per-user (TTBR0) page tables, but
>> ownership of shared kernel (TTBR1) page tables is shared between the
>> firmware and the AP OS. We handle this by simply using a smaller IAS to
>> drop down one level of page tables, so the driver can install a PTE in
>> the top-level (firmware-initialized) page table directly and just add an
>> offset to the VAs passed into the io_pgtable code. This avoids having to
>> have any special handling for this here. The firmware-relevant data
>> structures are small, so we do not expect to ever require more VA space
>> than one top-level PTE covers (IAS=36 for the next level, 64 GiB).
> 
> I don't quite follow what you're saying there.... however, since 
> io-pgtable-arm already supports the TTB0/TTB1 distinction, on the face 
> of it it would seem simpler to make use of the existing 
> IO_PGTABLE_QUIRK_ARM_TTBR1 than play weird non-obvious tricks to pretend 
> TTB1 somehow lives inside the TTB0 VA range (or is it the other way round?)

What I'm doing for the upper address space half is using the io_pgtable
code to manage a set of sub page tables rooted at a PT that is not
managed by io_pgtable. Unfortunately, that means that the address range
covered doesn't match either natural TTBR0/TTBR1 range...

More specifically, we have a 40-bit VA range split as follows:

(000000)0000000000..7fffffffff: Unprivileged, nonglobal ("TTBR0")
(ffffff)8000000000..ffffffffff: Privileged/firmware, (mostly) global
("TTBR1")

Within the user range there are certain special purpose VA ranges, but
that's not something io_pgtable has to care about (that half works as
normal and is fully managed by the driver). However, the top level
privileged PT is partially initialized for us (the system bootloader
actually gives us a static allocation for it before Linux runs at all,
and the GPU firmware initializes some PTEs on startup). When the driver
starts up, it then adds its own PTEs. We end up with it split into
firmware-managed and kernel-managed regions like this:

(ffffff)8000000000..9fffffffff: Firmware-owned (FW code/data/mmio)
(ffffff)a000000000..ffffffffff: Kernel-owned (driver<->FW shared data &
some extra driver-managed mmio)

And the way I handle the kernel owned region in practice is by creating
an io_pgtable with IAS=36, and installing its pointer into a PTE
(directly in the driver code) at index 2 in the top-level page table,
which is not used by the firmware itself. So then the io_pgtable's VA
span ends up being (ffffff)a000000000..afffffffff, which is not what
IO_PGTABLE_QUIRK_ARM_TTBR1 would do...

This is for a GPU driver though, and not a generic IOMMU driver, so it's
going to call directly into io_pgtable anyway and it's trivial to have
it add an offset to the VAs at that point. That's why I figured it's not
worth adding more special-case code or quirks to io_pgtable to handle
this. The existing Panfrost driver (which uses the Mali format and
similarly calls in directly to this code) is the closest analogue to
what I'm doing in spirit, though it doesn't need to do weird things with
VAs and firmware regions for that particular platform.

>> -	if (data->iop.fmt == ARM_64_LPAE_S1 ||
>> +	if (data->iop.fmt == APPLE_UAT) {
>> +		/*
>> +		 * This bit enables GPU access and the particular permission
>> +		 * rules that follow. Without it, access is firmware-only and
>> +		 * permissions follow the firmware's Apple SPRR configuration.
>> +		 */
>> +		pte = APPLE_UAT_GPU_ACCESS;
>> +		if (prot & IOMMU_PRIV) {
>> +			/* Firmware structures */
>> +			pte |= APPLE_UAT_AP0;
>> +			if (prot & IOMMU_WRITE) {
>> +				/* Firmware RW */
>> +				pte |= APPLE_UAT_UXN;
>> +			} else if (!(prot & IOMMU_READ)) {
>> +				/* No access */
>> +				pte |= APPLE_UAT_PXN;
>> +			}
>> +		} else if (prot & IOMMU_NOEXEC) {
>> +			/* GPU structures (no FW access) */
>> +			pte |= APPLE_UAT_AP1 | ARM_LPAE_PTE_nG;
>> +			if (!(prot & IOMMU_READ)) {
>> +				pte |= APPLE_UAT_PXN;
>> +				if (!(prot & IOMMU_WRITE))
>> +					pte |= APPLE_UAT_UXN;
>> +			} else if (prot & IOMMU_WRITE) {
>> +				pte |= APPLE_UAT_UXN;
>> +			}
>> +		} else {
>> +			pte |= ARM_LPAE_PTE_nG;
> 
> So coprocessor-only mappings are global, but any shared or GPU-only 
> mappings are per-ASID? I guess that kind of makes sense, but it's not 
> the easiest to follow. Would you even have firmware-only mappings in the 
> "user context" pagetable, or is this an artefact of the TTB1 trickery 
> (assuming the typical usage model where the upper address space stays 
> constant, and the lower half is context-switched) which could perhaps be 
> expressed a better way?

Yeah, this is a bit of a hack... ideally we'd probably have another PROT
bit to specify nG directly. The logic I use here happens to match what
the driver needs, but it does encode "magic policy" to an extent... but
yes, you'd never have firmware-only mappings in a lower user context,
because then there'd be no reason for them to be there (and it would
likely cause a security issue for any actual application). All GPU-only
user context (lower) mappings are necessarily nonglobal, and all shared
GPU/firmware mappings are either in user context (lower, so necessarily
nonglobal), or in a few specific cases in upper kernel context and
restricted to GPU context slot #0 (and then those also need to be
nonglobal from the GPU point of view for security reasons, to make sure
they don't become visible from any other context/ASID - see the next
bit). Only firmware-only structures (which exist only in the upper half)
are truly global.

Basically the way the firmware manages this is the "typical" setup where
its TTBR1_EL1 is fixed and TTBR0_EL0 changes for context switching, but
the way the GPU sees it is that there is a table in memory of 64
TTB0/TTB1 pairs (called the TTBAT, I assume it means Translation Table
Base Address Table), and it makes no distinction between both halves
(and there is also no explicit privilege separation and no actual
kernel/user permission bits). The firmware reads the same table too, but
only to fetch a TTB0 entry and switch its TTBR0_EL0 to it. It always
ignores the TTB1 entry.

The way the driver sets the TTBAT up is:

#0:TTB0 -> empty PT (required as it becomes the firmware's default
TTBR0_EL0 when no specific user context needs to be mapped, and it
panics if it's invalid)
#0:TTB1 -> equal to the firmware TTBR1_EL1, containing the firmware's
own mappings, kernel firmware-only mappings, and a few firmware/GPU
shared things to be accessed from GPU context #0 (which we consider
privileged, and it is those few GPU-shared things that this entry is
here for)
#1:TTB0 -> user context #1
#1:TTB1 -> unset (invalid)
#2:TTB0 -> user context #2
#2:TTB1 -> unset (invalid)
[...]

And user contexts are dynamically allocated and swapped in and out of
TTBAT slots as required (if you have <= 63 GPU active client apps, there
will be no swapping). Then the user VA space view from the point of view
of a GPU shader program becomes the user context in the lower half, and
an invalid upper half (which is similar to the EL0 view in typical ARM64
OS convention where ~everything in the upper half is inaccessible to EL0
anyway).

Though nothing would stop us from using the upper TTB1 half to double
the user VA space for GPU programs, at the cost of firmware never being
able to see those mappings since it doesn't switch its TTBR1_EL0 (but
that's okay for most use cases), and an awkward gap between both halves
that cannot be safely straddled except where it can (since the GPU
sometimes really does use 40-bit VAs internally with no sign extension
requirement!)... but I don't think we need to worry about this until
Apple releases a Mac with 1TB of RAM and the same old 40-bit GPU MMU
design, which is probably unlikely.

>> +			/* GPU structures (also FW accessible) */
>> +			if (prot & IOMMU_WRITE)
>> +				pte |= APPLE_UAT_UXN;
>> +			if (prot & IOMMU_READ)
>> +				pte |= APPLE_UAT_PXN;
>> +		}
> 
> More than that, though, if there is "no real noexec control" as the 
> commit message claims, howcome the great majority of the complexity here 
> is dedicated to setting XN bits?

Apple overloads the AP[1:0]/PXN/UXN bits for their own
implementation-defined permission schemes, both for the SPRR mechanism
[1] (which is what the GPU firmware uses for its own private
code/data/MMIO PTEs) and for the special GPU-specific permissions used
here, so their usual standard ARM meaning does not apply. This is
supported in their AP CPU cores too, which also have SPRR (which of
course we don't enable in Linux because that'd be ridiculous... but in
principle we could just like macOS does, and you can do some neat tricks
like fast secure EL0 JIT code permission remapping with it!).

So far everywhere else in the code touching these things (like our m1n1
bootloader, which uses SPRR in some cases) we've been keeping the
"original" bit names even when describing SPRR permissions, where you
basically take [AP1][AP0][PXN][UXN] as an opaque 0-15 index into a
configurable permissions table. Here those 16 values instead represent
specific combinations of GPU/FW access permissions. I guess if we were
making new bit names up, we could just call them AP0-3... but I fear
that might be more confusing given AP0/1 already exist in the standard
and are in the wrong logical bit position in the set of 4...

[1] https://blog.svenpeter.dev/posts/m1_sprr_gxf/

>> +	} else if (data->iop.fmt == ARM_64_LPAE_S1 ||
>>   	    data->iop.fmt == ARM_32_LPAE_S1) {
>>   		pte = ARM_LPAE_PTE_nG;
>>   		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
>> @@ -421,7 +465,14 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>>   	 * Note that this logic is structured to accommodate Mali LPAE
>>   	 * having stage-1-like attributes but stage-2-like permissions.
>>   	 */
>> -	if (data->iop.fmt == ARM_64_LPAE_S2 ||
>> +	if (data->iop.fmt == APPLE_UAT) {
>> +		if (prot & IOMMU_MMIO)
>> +			pte |= APPLE_UAT_MEMATTR_DEV;
>> +		else if (prot & IOMMU_CACHE)
>> +			pte |= APPLE_UAT_MEMATTR_SHARED;
>> +		else
>> +			pte |= APPLE_UAT_MEMATTR_PRIV;
>> +	} else if (data->iop.fmt == ARM_64_LPAE_S2 ||
>>   	    data->iop.fmt == ARM_32_LPAE_S2) {
>>   		if (prot & IOMMU_MMIO)
>>   			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
>> @@ -444,12 +495,14 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>>   	 * "outside the GPU" (i.e. either the Inner or System domain in CPU
>>   	 * terms, depending on coherency).
>>   	 */
>> -	if (prot & IOMMU_CACHE && data->iop.fmt != ARM_MALI_LPAE)
>> +	if (data->iop.fmt == APPLE_UAT)
>> +		pte |= ARM_LPAE_PTE_SH_NS;
> 
> This doesn't make much sense... it's cache-coherent yet everything is 
> always non-shareable? I'm going to guess that bits 9:8 probably do 
> something else and you're actually just trying to make sure they aren't 
> set; if so, please express that semantic appropriately.

SH should have the normal meaning for the firmware CPU MMU, but
unfortunately setting it to OS doesn't actually get us cache coherency
as far as I can tell, so my understanding is the interconnect between
the coprocessor and the SoC fabric just does not support coherency.
Therefore, we set it to NS since it's pointless (this is the same thing
macOS does). "Cache coherency" from the firmware point of view is
achieved with non-cacheable mappings instead (which is a shame, because
they measurably slow things down, so we don't want to use them
everywhere... but using cached mappings requires cache maintenance from
the firmware). I've been having endless corner cases with cached
mappings where the firmware ends up with a dirty stale cache line that
clobbers some other data structure reusing that memory later... this is
something I'm still working on by tweaking allocation patterns to avoid
bad situations without having to force flush everything constantly.

For the GPU side, I get the feeling it just ignores the shareability
bits, though we haven't had a chance to properly explore the
performance/coherency behavior of the GPU side yet (I only just got
compute shaders working last week, which we'd need to do any serious
experiments). It definitely ignores the memattr stuff or at least
doesn't treat it the same way as the firmware, since all GPU buffers are
mapped using the attribute that selects non-cacheable from the firmware
POV but the GPU itself obviously has working caches for these buffers.
It's possible this could change in the future as we understand things
better...

Please keep in mind that all of this is reverse engineered by black-box
observing what macOS does (we run it inside a thin hypervisor and snoop
on its page tables/etc) and blind experimentation, so it's very
difficult for me to give confident answers... we're doing our best with
zero documentation, so sometimes the answer is just "we do the same
thing macOS does" because diverging just explodes the potential problem
space, and doesn't make sense to do until we fully understand each
specific mechanism. For example, for the access permissions, I do
diverge there because I understand them (I tried all possible
combinations and mapped out what faulted and what didn't from both
firmware and GPU), so my driver locks things down quite a bit more than
Apple's does! But caching (and previously TLB) issues have been a
never-ending source of pain and frustration... so I'm inclined to
default to emulating what macOS does here, even if we don't fully
understand the nuance yet. I actually had this as OS for a while, but
switched to NS while debugging some (ultimately unrelated) issues and
I'm inclined to leave it like that absent evidence that OS works better
in practice.

I don't have all the answers yet... however, I do want to push forward
with upstreaming, because this is already a real, fully OpenGL ES 2.0
conformant driver (and close to ES 3.0 conformance) that can run real
desktops and games and which many users are using downstream. I hope
that's okay!

>> @@ -148,6 +149,10 @@ struct io_pgtable_cfg {
>>   			u64 ttbr[4];
>>   			u32 n_ttbrs;
>>   		} apple_dart_cfg;
>> +
>> +		struct {
>> +			u64	ttbr;
> 
> The comment further up implies it's called TTBAT?

Kind of both. Maybe it should just be "ttb", since it's the base address
which (together with a valid bit and the ASID added by the driver) goes
into the TTBAT slot and then eventually/potentially into the firmware
TTBR0. Except for the special case sub-PT hack for the kernel/upper PT,
but even then "ttb" probably makes sense as the base of the (next level)
page table. Does that work?

~~ Lina
