Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942C56A1D81
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBXOdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjBXOdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:33:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D55DAEC4F;
        Fri, 24 Feb 2023 06:32:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 960481042;
        Fri, 24 Feb 2023 06:33:37 -0800 (PST)
Received: from [10.57.16.161] (unknown [10.57.16.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFA923F71A;
        Fri, 24 Feb 2023 06:32:51 -0800 (PST)
Message-ID: <e6d6d928-4514-55b9-346d-2e5e82220729@arm.com>
Date:   Fri, 24 Feb 2023 14:32:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Asahi Lina <lina@asahilina.net>
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
 <Y/jFeZzZVCpBGvGv@kroah.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y/jFeZzZVCpBGvGv@kroah.com>
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

On 2023-02-24 14:11, Greg Kroah-Hartman wrote:
> Thanks for the detailed rust explainations, I'd like to just highlight
> one thing:
> 
> On Fri, Feb 24, 2023 at 10:15:12PM +0900, Asahi Lina wrote:
>> On 24/02/2023 20.23, Greg Kroah-Hartman wrote:
>>> And again, why are bindings needed for a "raw" struct device at all?
>>> Shouldn't the bus-specific wrappings work better?
>>
>> Because lots of kernel subsystems need to be able to accept "any" device
>> and don't care about the bus! That's what this is for.
> 
> That's great, but:
> 
>> All the bus
>> wrappers would implement this so they can be used as an argument for all
>> those subsystems (plus a generic one when you just need to pass around
>> an actual owned generic reference and no longer need bus-specific
>> operations - you can materialize that out of a RawDevice impl, which is
>> when get_device() would be called). That's why I'm introducing this now,
>> because both io_pgtable and rtkit need to take `struct device` pointers
>> on the C side so we need some "generic struct device" view on the Rust side.
> 
> In looking at both ftkit and io_pgtable, those seem to be good examples
> of how "not to use a struct device", so trying to make safe bindings
> from Rust to these frameworks is very ironic :)
> 
> rtkit takes a struct device pointer and then never increments it,
> despite saving it off, which is unsafe.  It then only uses it to print
> out messages if things go wrong (or right in some cases), which is odd.
> So it can get away from using a device pointer entirely, except for the
> devm_apple_rtkit_init() call, which I doubt you want to call from rust
> code, right?
> 
> for io_pgtable, that's a bit messier, you want to pass in a device that
> io_pgtable treats as a "device" but again, it is NEVER properly
> reference counted, AND, it is only needed to try to figure out the bus
> operations that dma memory should be allocated from for this device.  So
> what would be better to save off there would be a pointer to the bus,
> which is constant and soon will be read-only so there are no lifetime
> rules needed at all (see the major struct bus_type changes going into
> 6.3-rc1 that will enable that to happen).

FWIW the DMA API *has* to know which specific device it's operating 
with, since the relevant properties can and do vary even between 
different devices within a single bus_type (e.g. DMA masks).

In the case of io-pgtable at least, there's no explicit refcounting 
since the struct device must be the one representing the physical 
platform/PCI/etc. device consuming the pagetable, so if that were to 
disappear from underneath its driver while the pagetable is still in 
use, things would already have gone very very wrong indeed :)

Cheers,
Robin.

> So the two subsystems you want to call from rust code don't properly
> handle the reference count of the object you are going to pass into it,
> and only need it for debugging and iommu stuff, which is really only the
> bus that the device is on, not good examples to start out with :)
> 
> Yeah, this is yack-shaving, sorry, but it's how we clean up core
> subsystems for apis and implementations that are not really correct and
> were not noticed at the time.
> 
> Can we see some users of this code posted so I can see how struct device
> is going to work in a rust driver?  That's the thing I worry most about
> the rust/C interaction here as we have two different ways of thinking
> about reference counts from the two worlds and putting them together is
> going to be "interesting", as can be seen here already.
> 
> thanks,
> 
> greg k-h
