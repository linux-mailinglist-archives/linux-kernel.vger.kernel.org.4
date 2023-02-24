Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C0D6A1F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBXQXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBXQXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:23:21 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB52974C;
        Fri, 24 Feb 2023 08:23:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BF43641A42;
        Fri, 24 Feb 2023 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677255797;
        bh=ppJgjG6AVDSHdCLzKa1dvmoQquidHlhJVF2XEiOWA2Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Fog4wuylvsX9NweBom1FqmwafWOdqSmxe3/sHpDh/j103jqbrUq+w4DCdxnNyzBP8
         DbVmLYD6Ga4vWLlcufBgZzGMg6ZY1oqafaMMV9RQwyMt2cfo8xP2kSzNF+8aPPRubw
         JMvMyYZ+NyDXOlqvVyZrF/uT4W+gBQBwRi9WpHlYwyNvD9QPheBt5r0gWXXwwPsZMi
         GgcCfyXQ+z4wVBcK+prv9TSqFGLwgvlUOzM7/4UaTbfguZl/DhH00KYHK0MfZQ8Udi
         Qn8sqLOQNS+JiRNaNjd/JnVUOgI8cmD5I/PwFLETMhqO5+unWU4agZ9DdAOoK3/+Ex
         K1s0u0IxBUULQ==
Message-ID: <5a00dcb1-8368-c3ce-6fcb-5932f5eb50a5@asahilina.net>
Date:   Sat, 25 Feb 2023 01:23:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
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
 <87de1cd0-a57a-3391-a4b8-599ee0307491@asahilina.net>
 <59a61ddc-4a96-c846-c12b-0d1e3789683c@arm.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <59a61ddc-4a96-c846-c12b-0d1e3789683c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2023 00.14, Robin Murphy wrote:
> On 2023-02-24 14:48, Asahi Lina wrote:
>>
>>
>> On 2023/02/24 23:32, Robin Murphy wrote:
>>> FWIW the DMA API *has* to know which specific device it's operating
>>> with, since the relevant properties can and do vary even between
>>> different devices within a single bus_type (e.g. DMA masks).
>>>
>>> In the case of io-pgtable at least, there's no explicit refcounting
>>> since the struct device must be the one representing the physical
>>> platform/PCI/etc. device consuming the pagetable, so if that were to
>>> disappear from underneath its driver while the pagetable is still in
>>> use, things would already have gone very very wrong indeed :)
>>
>> There's no terribly good way to encode this relationship in safe Rust as
>> far as I know. So although it might be "obvious" (and I think my driver
>> can never violate it as it is currently designed), this means the Rust
>> abstraction will have to take the device reference if the C side does
>> not, because safe rust abstractions have to actually make these bugs
>> impossible and nothing stops a Rust driver from, say, stashing an
>> io_pgtable reference into a global and letting the device go away.
> 
> If someone did that, then simply holding a struct device reference 
> wouldn't guarantee much, since it only prevents the pointer itself from 
> becoming invalid - it still doesn't say any of the data *in* the 
> structure is still valid and "safe" for what a DMA API call might do 
> with it.
> 
> At the very least you'd probably have to somehow also guarantee that the 
> device has a driver bound (which is the closest thing to a general 
> indication of valid DMA ops across all architectures) and block it from 
> unbinding for the lifetime of the reference, but that would then mean a 
> simple driver which expects to tear down its io-pgtable from its .remove 
> callback could never be unbound due to the circular dependency :/

I'd like to hear from the other Rust folks about ideas on how to solve
this ^^. I think it might fit into the Revocable model for device
resources, but it's going to be a bit of an issue for my driver because
for me, the io_pgtable objects are deep in the Vm object that has its
own refcounting, and those are created and destroyed dynamically at
runtime, not just during device probe...

But it's also possible that we have to resign ourselves to a somewhat
leaky/unsound abstraction under the understanding that the C API has
requirements that are difficult to encode in the Rust type system...

There's actually a much longer story to tell here though... I've done a
lot of thinking about what "safe" means in the context of the kernel,
what the useful safety boundaries are, and things like that. Especially
within complex drivers, the answer is a lot greyer than what you tend to
get with Rust userspace code. But at the end of the day, Rust lets you
make things much safer and reduce the chances of bugs creeping in
dramatically, even if you have some slightly unsound abstractions and
other issues. Maybe I should write a long form blog post about this,
would people find that useful?

For whatever this anecdote is worth, my GPU driver is about 16000 lines
of Rust and has ~100 unsafe blocks, and has been in a few downstream
distro repos since December with actual users and nobody has ever
managed to oops it as far as I know, including other Mesa developers who
have been feeding it all kinds of broken command buffers and things like
that. It has survived OOMs leading to untested error paths, UAPI
fuzzing, and endless GPU faults/timeouts... and I definitely am not a
genius who writes bug-free code! The firmware itself is also very easy
to crash (raw unsafe pointers everywhere in shared memory), and crashes
are unrecoverable (you need to reboot), but I try to use Rust's type
system and ownership model to extend safety to that interface as much as
possible and I think people other than me have only managed to get the
GPU firmware to crash twice (both cache coherency related, I *think*
I've finally eliminated that issue at the root now). The uptime on my M2
streaming machine running a decent GPU workload for 20 hours or so
weekly is 44 days and counting... I think that old kernel even has some
minor memory leaks that I've since fixed (you *can* get those in Rust
with circular references), but it's so minor it's going to be at least a
few more months before it becomes a problem.

So I guess what I'm saying is that at the end of the day, if we can't
get an interface to be 100% safe and sound and usable, that's probably
okay. We're still getting a lot of safe mileage out of the other 99%! ^^

~~ Lina
