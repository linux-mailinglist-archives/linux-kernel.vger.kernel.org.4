Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01676A21D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBXSwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBXSwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:52:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D18686A7A6;
        Fri, 24 Feb 2023 10:52:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 793501FB;
        Fri, 24 Feb 2023 10:52:55 -0800 (PST)
Received: from [10.57.16.161] (unknown [10.57.16.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E89953FB75;
        Fri, 24 Feb 2023 10:52:08 -0800 (PST)
Message-ID: <590134fc-a6fd-9d86-ba3f-c621332b65fc@arm.com>
Date:   Fri, 24 Feb 2023 18:52:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-2-49ced3391295@asahilina.net>
 <Y/ieQ0UX/niAG1Hg@kroah.com>
 <ef3a3638-6381-87ab-d674-644306b6b6ce@asahilina.net>
 <Y/jFeZzZVCpBGvGv@kroah.com> <e6d6d928-4514-55b9-346d-2e5e82220729@arm.com>
 <Y/jYdTrsrCyCPXHT@kroah.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y/jYdTrsrCyCPXHT@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-24 15:32, Greg Kroah-Hartman wrote:
> On Fri, Feb 24, 2023 at 02:32:47PM +0000, Robin Murphy wrote:
>> On 2023-02-24 14:11, Greg Kroah-Hartman wrote:
>>> Thanks for the detailed rust explainations, I'd like to just highlight
>>> one thing:
>>>
>>> On Fri, Feb 24, 2023 at 10:15:12PM +0900, Asahi Lina wrote:
>>>> On 24/02/2023 20.23, Greg Kroah-Hartman wrote:
>>>>> And again, why are bindings needed for a "raw" struct device at all?
>>>>> Shouldn't the bus-specific wrappings work better?
>>>>
>>>> Because lots of kernel subsystems need to be able to accept "any" device
>>>> and don't care about the bus! That's what this is for.
>>>
>>> That's great, but:
>>>
>>>> All the bus
>>>> wrappers would implement this so they can be used as an argument for all
>>>> those subsystems (plus a generic one when you just need to pass around
>>>> an actual owned generic reference and no longer need bus-specific
>>>> operations - you can materialize that out of a RawDevice impl, which is
>>>> when get_device() would be called). That's why I'm introducing this now,
>>>> because both io_pgtable and rtkit need to take `struct device` pointers
>>>> on the C side so we need some "generic struct device" view on the Rust side.
>>>
>>> In looking at both ftkit and io_pgtable, those seem to be good examples
>>> of how "not to use a struct device", so trying to make safe bindings
>>> from Rust to these frameworks is very ironic :)
>>>
>>> rtkit takes a struct device pointer and then never increments it,
>>> despite saving it off, which is unsafe.  It then only uses it to print
>>> out messages if things go wrong (or right in some cases), which is odd.
>>> So it can get away from using a device pointer entirely, except for the
>>> devm_apple_rtkit_init() call, which I doubt you want to call from rust
>>> code, right?
>>>
>>> for io_pgtable, that's a bit messier, you want to pass in a device that
>>> io_pgtable treats as a "device" but again, it is NEVER properly
>>> reference counted, AND, it is only needed to try to figure out the bus
>>> operations that dma memory should be allocated from for this device.  So
>>> what would be better to save off there would be a pointer to the bus,
>>> which is constant and soon will be read-only so there are no lifetime
>>> rules needed at all (see the major struct bus_type changes going into
>>> 6.3-rc1 that will enable that to happen).
>>
>> FWIW the DMA API *has* to know which specific device it's operating with,
>> since the relevant properties can and do vary even between different devices
>> within a single bus_type (e.g. DMA masks).
> 
> What bus_type has different DMA masks depending on the device on that
> bus today?

Certainly PCI and platform, which are about 99% of what matters in terms 
of DMA. You may say "ewww" again, but even on something as "normal" as a 
PCIe GPU chip, the audio codec function may well have a different DMA 
mask from the GPU function, let alone distinct devices across 
cards/slots/segments/etc. differing - e.g. some PCIe USB controllers are 
still limited to 32 bits, where your more-capable GPU/NVMe/NIC etc. 
would definitely not be cool with a lowest-common-denominator constraint.

> And the iommu ops are on the bus, not the device, but there is a
> iommu_group on the device, is that what you are referring to?
> 
> Am I getting iommu and dma stuff confused here?  A bus also has dma
> callbacks, but yet the device itself has dma_ops?

Confusion is excusable here - the bus "dma_configure" callbacks are 
mostly actually IOMMU configuration, which is a bit of historical legacy 
that still needs more cleaning up (because it makes things happen in the 
wrong order from what the IOMMU API really wants). I'm hoping to get to 
that soon once we land my current series finishing the bus->iommu_ops 
removal.

(FWIW what I want to do is flip things around so the buses just provide 
a method for the IOMMU API to to retrieve whatever bus-defined IDs it 
needs to associate with a given device, rather than having the bus code 
call into the IOMMU API itself as currently.)

>> In the case of io-pgtable at least, there's no explicit refcounting since
>> the struct device must be the one representing the physical
>> platform/PCI/etc. device consuming the pagetable, so if that were to
>> disappear from underneath its driver while the pagetable is still in use,
>> things would already have gone very very wrong indeed :)
> 
> But that could happen at any point in time, the device can be removed
> from the system with no warning, how do you guarantee that io-pgtable is
> being initialized with a device that can NOT be removed?
> 
> Think of drawers containing CPUs and PCI devices and memory, Linux
> has supported hot-removal of those for decades.  (well, not for memory,
> we could only hot-add that...)
> 
> Again, passing in a pointer to a struct device, and saving it off
> WITHOUT incrementing the reference count is not ok, that's not how
> reference counts work...

io-pgtable is just a utility library which that device's driver is 
calling into. It never does anything with that pointer by itself, and 
it's implicitly expected that the ops are only going to be called by 
whoever allocated them. If the driver needs to cope with a surprise 
removal event while bound, that's on the driver, but I'd assume the bus 
code is still expected to at least give it a chance to clean up 
gracefully before the struct device completely disappears. I don't think 
I've ever seen a driver explicitly take a reference on its own device 
for "normal" operation, so either everything's wrong, or that guarantee 
must already come from deeper in the driver core.

Yes, *technically* someone could invoke io-pgtable ops from some context 
other than the driver which allocated them, but it would be wrong and 
the answer would be "don't do that". We've got a huge quantity of APIs 
all over Linux where the expected usage model is intuitive, but 
impractical to formally assert, so it's just assumed that you do the 
right thing and expect fireworks if you don't. I do fully appreciate 
that "don't do that" is not an easy thing for Rust to nail down.

There's nothing inherently special about saving a pointer in a structure 
either - if someone's failing to respect the expected conventions, then 
the lifetime of a pointer *anywhere* matters, and even something as 
innocuous as dev_name() should strictly take a reference on its argument 
in case it's called concurrently with the device being freed. In fact, 
consider if get_device() is pre-empted right on entry, and by the time 
it comes back to dereference the kobject, someone else has racily 
dropped the last reference and already freed it. Unless we can draw a 
line of reasonable expectations somewhere, we've no pretence of being 
able to guarantee *anything*.

> But again, let's see about disconnecting the iommu ops entirely from the
> device and just relying on the bus, that should work better, rigth?

Um, other way - iommu_ops have almost finished moving *off* the bus to 
be per-device. You acked the patch the other week and seemed pleased 
with it ;)

But either way that's orthogonal to this case, since the device that 
io-pgtable deals with cannot have iommu_ops of its own (it *is* the 
IOMMU, or at least a GPU MMU acting as one).

Cheers,
Robin.
