Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0B6A1E47
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjBXPP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjBXPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:15:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FA7254A0A;
        Fri, 24 Feb 2023 07:14:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 335B21042;
        Fri, 24 Feb 2023 07:15:01 -0800 (PST)
Received: from [10.57.16.161] (unknown [10.57.16.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AE7D3FB75;
        Fri, 24 Feb 2023 07:14:15 -0800 (PST)
Message-ID: <59a61ddc-4a96-c846-c12b-0d1e3789683c@arm.com>
Date:   Fri, 24 Feb 2023 15:14:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
Content-Language: en-GB
To:     Asahi Lina <lina@asahilina.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
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
 <87de1cd0-a57a-3391-a4b8-599ee0307491@asahilina.net>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <87de1cd0-a57a-3391-a4b8-599ee0307491@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-24 14:48, Asahi Lina wrote:
> 
> 
> On 2023/02/24 23:32, Robin Murphy wrote:
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
>>>> on the C side so we need some "generic struct device" view on the
>>>> Rust side.
>>>
>>> In looking at both ftkit and io_pgtable, those seem to be good examples
>>> of how "not to use a struct device", so trying to make safe bindings
>>> from Rust to these frameworks is very ironic :)
>>>
>>> rtkit takes a struct device pointer and then never increments it,
>>> despite saving it off, which is unsafe.  It then only uses it to print
>>> out messages if things go wrong (or right in some cases), which is odd.
>>> So it can get away from using a device pointer entirely, except for the
>>> devm_apple_rtkit_init() call, which I doubt you want to call from rust
>>> code, right?
>>>
>>> for io_pgtable, that's a bit messier, you want to pass in a device that
>>> io_pgtable treats as a "device" but again, it is NEVER properly
>>> reference counted, AND, it is only needed to try to figure out the bus
>>> operations that dma memory should be allocated from for this device.  So
>>> what would be better to save off there would be a pointer to the bus,
>>> which is constant and soon will be read-only so there are no lifetime
>>> rules needed at all (see the major struct bus_type changes going into
>>> 6.3-rc1 that will enable that to happen).
>>
>> FWIW the DMA API *has* to know which specific device it's operating
>> with, since the relevant properties can and do vary even between
>> different devices within a single bus_type (e.g. DMA masks).
>>
>> In the case of io-pgtable at least, there's no explicit refcounting
>> since the struct device must be the one representing the physical
>> platform/PCI/etc. device consuming the pagetable, so if that were to
>> disappear from underneath its driver while the pagetable is still in
>> use, things would already have gone very very wrong indeed :)
> 
> There's no terribly good way to encode this relationship in safe Rust as
> far as I know. So although it might be "obvious" (and I think my driver
> can never violate it as it is currently designed), this means the Rust
> abstraction will have to take the device reference if the C side does
> not, because safe rust abstractions have to actually make these bugs
> impossible and nothing stops a Rust driver from, say, stashing an
> io_pgtable reference into a global and letting the device go away.

If someone did that, then simply holding a struct device reference 
wouldn't guarantee much, since it only prevents the pointer itself from 
becoming invalid - it still doesn't say any of the data *in* the 
structure is still valid and "safe" for what a DMA API call might do 
with it.

At the very least you'd probably have to somehow also guarantee that the 
device has a driver bound (which is the closest thing to a general 
indication of valid DMA ops across all architectures) and block it from 
unbinding for the lifetime of the reference, but that would then mean a 
simple driver which expects to tear down its io-pgtable from its .remove 
callback could never be unbound due to the circular dependency :/

Cheers,
Robin.
