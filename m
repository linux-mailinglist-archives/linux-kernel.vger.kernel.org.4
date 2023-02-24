Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094B86A1EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjBXPm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjBXPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:42:46 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51223658EB;
        Fri, 24 Feb 2023 07:42:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C97BF3FB17;
        Fri, 24 Feb 2023 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677253361;
        bh=rOI1KqpyrEccV+F71Te1pl2hQSvFhl4XVciYRUj961g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ya0N54PoupnZUSmattKujLxGbaACXfgOTqDzylYmSWBm3am0tdIU9aaRfx0bnzEbz
         BBRdXxORBkNFzWzQhA7pWGWFj2ZNTi+ZB1JERUQzIUiBRt0L5oN/720Mw2Wm0HgkIp
         A2BDmxSTqmhem74xKdhH6AHRrwVQYhezvK10+6+tw4MLwazF97LLQN778YZZ/fbRCM
         uypycDvJY+FJIDp1D079+Zd3BXnVkyaUvY/XSGr73Yp5DbLLoh5Vi40WufqxLVuM8K
         rhJA5CoB1I4MITCyKRqv4AhfNSCNaVOYpzNBrK13/Gkd/6QJv7c7pcmopASA/UO2x0
         HRDZmsG51aYBw==
Message-ID: <b1453175-3cd6-bdd1-5e71-9c0f341bf3e9@asahilina.net>
Date:   Sat, 25 Feb 2023 00:42:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
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
 <0e3c15bd-a1d6-a363-d7b6-087b6e4cddac@asahilina.net>
 <Y/jWtVr7JK/YKcsE@kroah.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <Y/jWtVr7JK/YKcsE@kroah.com>
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

On 25/02/2023 00.24, Greg Kroah-Hartman wrote:
>> What do you recommend for things that want to print device-associated
>> messages, if not holding a reference to the device?
> 
> If you aren't holding a reference to the device, that means you aren't
> associated to it at all, so you better not be printing out anything
> related to any device as that pointer could be invalid at any point in
> time.

The RTKit code talks to the firmware coprocessor that is part of the
device, so it definitely is associated to it... among other things it
prints out firmware logs from the device and crash logs, manages memory
buffers (which have default implementations but can be overridden by the
user driver), and more. It's essentially library code shared by all
device drivers that interact with devices with these coprocessors.

>> Or did I
>> misunderstand what you meant? Just pr_foo() isn't great because we have
>> a lot of instances of rtkit and then you wouldn't know which device the
>> messages are about...
> 
> Then the rtkit code needs to be changed to properly grab the reference
> and actually use it for something other than just a log message.  If it
> only wants it for a log message, then let's just drop it and have the
> rtkit code go quiet, as when kernel code is working properly, it should
> be quiet.  If something goes wrong, the code that called into rtkit can
> print out a message based on the error return values.

Keep in mind rtkit does things like print out crash logs, and you
wouldn't want the caller to be responsible for that (and we definitely
want those in dmesg since these coprocessors are non-recoverable, it's
almost as bad as a kernel panic: you will have to reboot to be able to
use the machine properly again). I find those crash logs very useful to
figure out what went wrong with the GPU (especially if combined with a
memory dump which we don't expose to regular users right now, but which
I have ideas for... but even without that, just assert messages from the
coprocessor or fault instruction pointers that I can correlate with the
firmware are very useful on their own).

Right now rtkit also prints out syslogs from the coprocessors. That's
noisy for some but I think very useful, since we're dealing with reverse
engineered drivers. We'll probably want to silence those for some noisy
coprocessors at some point, but I don't think we want to do that until
things are all upstream, stable, and with a larger user base... until
then I think we'd much rather be spammy and have a better chance of
debugging rare issues, which often happen with these coprocessors
running big firmware blobs... there are a lot of subtleties in getting
the interfaces right, never mind cache coherence issues!

> I have no idea what "rtkit" is, if it's an interface to hardware, why
> doesn't it have its own struct device that it creates and manages and
> uses instead?  In my quick glance, that feels like the real solution
> here instead of just "I hope this pointer is going to be valid" like it
> lives with today.  Odds are you can't remove a rtkit device at runtime,
> so no one has noticed this yet...

Well, they're all embedded into the SoC, yes.

RTKit is Apple's firmware RTOS, and also the name for the
semi-standardized mailbox/shared-memory interface shared by different
firmwares using it. The Linux code to drive it doesn't create its own
"struct device" because the rtkit code is just library code that is
extended by the downstream drivers (like mine). How each driver
interacts with rtkit varies widely... NVMe almost doesn't at all other
than for power management, there is actually a downstream "rtkit-helper"
driver that is a proper standalone device wrapper for one case (MTP)
where it really doesn't need to interact at all... in my case with the
GPU, almost everything is shared memory and doorbells over the mailbox.
Other drivers like DCP actually send pointers over multiple mailbox
endpoints, or do most of their data exchange directly over messages like
that (SMC).

So in a way, if we consider it driver library code, it's not
unreasonable for RTKit to require that the device you pass it outlives
it. Certainly, if the device is getting unbound from your driver, you'd
need to tear down RTKit as part of that in any reasonable situation.

>> I know it's hard to review without examples, but I also can't just post
>> the driver and everything else as one series now, there's still a lot to
>> be improved and fixed and I'm working with the Rust folks on figuring
>> out a roadmap for that... and waiting until "everything" is ready and
>> perfect would mean we don't get anything done in the meantime and fall
>> into a pit of endless rebasing and coordinating downstream trees, which
>> also isn't good...
> 
> Yeah, it's a chicken and egg issue right now, no worries, I understand.
> This is going to take some cycles to get right.
> 

Thank you ^^

~~ Lina
