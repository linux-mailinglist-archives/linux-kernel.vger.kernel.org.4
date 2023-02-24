Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CB96A1DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjBXOtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjBXOtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:49:16 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B832453EE2;
        Fri, 24 Feb 2023 06:49:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B2A9C3FA55;
        Fri, 24 Feb 2023 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677250144;
        bh=9ldx9Szz+whOvxXhwLV1gjd7enNHNzspB3ZXUahx/bs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=y8hUWhe5Psa20R0C8vtHmx7YDAFLkA9Sqy/C9NZq7AhcKhFlqXR63+xEKbxPc8Axs
         umqkzWiNNK+LyhUfkEEP8lafaFrsaFbq/xecCk0g2Smyfpsjp9qxBGCNGkQTSE9fP2
         QPJ2K9EUPEqQ5562021rDvKP7NREziYJz1zuejrxHqkTu3zMf0NTdlpvaOPpH7mKW0
         sckO8cecEVnQrRkR9yam4t2xi0rJBGNatooQ2i1Wi5y79ilcaORSiUtsHd4LUaU9TM
         2tK4k95/4qvOGpoGzvQXRWxEAST4MI13YkkCgOq0A3EkwKiMIHvQLEQ5H4RAcCu8Qd
         sPjvP7kQ+0JAA==
Message-ID: <87de1cd0-a57a-3391-a4b8-599ee0307491@asahilina.net>
Date:   Fri, 24 Feb 2023 23:48:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
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
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <e6d6d928-4514-55b9-346d-2e5e82220729@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/02/24 23:32, Robin Murphy wrote:
> On 2023-02-24 14:11, Greg Kroah-Hartman wrote:
>> Thanks for the detailed rust explainations, I'd like to just highlight
>> one thing:
>>
>> On Fri, Feb 24, 2023 at 10:15:12PM +0900, Asahi Lina wrote:
>>> On 24/02/2023 20.23, Greg Kroah-Hartman wrote:
>>>> And again, why are bindings needed for a "raw" struct device at all?
>>>> Shouldn't the bus-specific wrappings work better?
>>>
>>> Because lots of kernel subsystems need to be able to accept "any" device
>>> and don't care about the bus! That's what this is for.
>>
>> That's great, but:
>>
>>> All the bus
>>> wrappers would implement this so they can be used as an argument for all
>>> those subsystems (plus a generic one when you just need to pass around
>>> an actual owned generic reference and no longer need bus-specific
>>> operations - you can materialize that out of a RawDevice impl, which is
>>> when get_device() would be called). That's why I'm introducing this now,
>>> because both io_pgtable and rtkit need to take `struct device` pointers
>>> on the C side so we need some "generic struct device" view on the
>>> Rust side.
>>
>> In looking at both ftkit and io_pgtable, those seem to be good examples
>> of how "not to use a struct device", so trying to make safe bindings
>> from Rust to these frameworks is very ironic :)
>>
>> rtkit takes a struct device pointer and then never increments it,
>> despite saving it off, which is unsafe.  It then only uses it to print
>> out messages if things go wrong (or right in some cases), which is odd.
>> So it can get away from using a device pointer entirely, except for the
>> devm_apple_rtkit_init() call, which I doubt you want to call from rust
>> code, right?
>>
>> for io_pgtable, that's a bit messier, you want to pass in a device that
>> io_pgtable treats as a "device" but again, it is NEVER properly
>> reference counted, AND, it is only needed to try to figure out the bus
>> operations that dma memory should be allocated from for this device.  So
>> what would be better to save off there would be a pointer to the bus,
>> which is constant and soon will be read-only so there are no lifetime
>> rules needed at all (see the major struct bus_type changes going into
>> 6.3-rc1 that will enable that to happen).
> 
> FWIW the DMA API *has* to know which specific device it's operating
> with, since the relevant properties can and do vary even between
> different devices within a single bus_type (e.g. DMA masks).
> 
> In the case of io-pgtable at least, there's no explicit refcounting
> since the struct device must be the one representing the physical
> platform/PCI/etc. device consuming the pagetable, so if that were to
> disappear from underneath its driver while the pagetable is still in
> use, things would already have gone very very wrong indeed :)

There's no terribly good way to encode this relationship in safe Rust as
far as I know. So although it might be "obvious" (and I think my driver
can never violate it as it is currently designed), this means the Rust
abstraction will have to take the device reference if the C side does
not, because safe rust abstractions have to actually make these bugs
impossible and nothing stops a Rust driver from, say, stashing an
io_pgtable reference into a global and letting the device go away.

~~ Lina
