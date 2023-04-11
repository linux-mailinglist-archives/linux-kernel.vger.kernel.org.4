Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE2A6DD73D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDKJwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDKJwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:52:22 -0400
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4E710C3;
        Tue, 11 Apr 2023 02:52:19 -0700 (PDT)
Received: from [10.36.2.154] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 7295226027D;
        Tue, 11 Apr 2023 11:52:17 +0200 (CEST)
Message-ID: <9f896097-8410-4d09-b614-6e792b2160f4@selasky.org>
Date:   Tue, 11 Apr 2023 11:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org>
 <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
 <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org>
 <CANiq72m812+L6dc4Qs2wUXW85eBQwgrjWYYKc1MSsqN5AG_sFw@mail.gmail.com>
Content-Language: en-US
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <CANiq72m812+L6dc4Qs2wUXW85eBQwgrjWYYKc1MSsqN5AG_sFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 01:41, Miguel Ojeda wrote:
> On Mon, Apr 10, 2023 at 8:59 PM Hans Petter Selasky <hps@selasky.org> wrote:
>>
>> Adding a dependency to build the Rust compiler even to build one or two
>> V4L2 device drivers, would mean a lot to my small hselasky/webcamd
>> project. It already has to fetch a copy of the Linux kernel, and now has
>> to bootstrap Rust from stage0 to stageN. I personally say no. It's like
> 
> Do you mean you need to compile `rustc`? Could you please explain why?
> Could you use your distribution's, or fetch the standalone installers
> or cache your own toolchain?

Hi Miguel,

Assume you need to update both the kernel and the rust compiler at the 
same time. How do you do that? In the binary download case you have two 
machines. One to build rust and one to build the kernel, so it is 
technically not possible?

The Rust compiler has a dependency on the kernel and the kernel has a 
dependency on the Rust compiler. That just means, some kind of changes 
can never happen. This is the ingredient for never ending problems. It's 
like you put some rock into the system: If this ever needs to change ...

I'll give you a real-life example to emphasis this. Apple and Microsoft 
has done something very bad in the file system area. They mistreat what 
happens to be the Norwegian character "å" (0xE5). Norway is where I 
live. Their solution is to split the "å" character into the "a" 
character (0x61) and the combining ring-over character (0x30A).

There are three problems:

1) Many Unicode implementations only expect one combining ring-over 
character. Either this leads directly to a stack exploit or a denial of 
service, depending on the actual code: CVE-2023-25193 (ongoing).

2) The proper solution would be to deny this kind of combining 
characters, also called umlauts in Germany. Only that requires both 
Apple and Microsoft to change and update both their filesystem and 
kernel at the same time! The "å" character (0xE5) is essential for 
quickly deleting files. Or disable this feature, and rewrite the 
directory table every time a file is deleted.

3) Apple and Microsoft managed to screw this up, so that you can create 
files under Microsoft (exFat-disk), that don't show up under MacOS. In 
iOS they show up however, but can't be copied or moved anywhere. And if 
you think your files are backed up in the iCloud, think again!

The consequences can be quite serious, that you could end up being 
unfairly judged by the Police in Norway, because court documents "just 
got lost" they say.

Do you think Microsoft and Apple will ever change this dependency, if a 
change means you need to re-format filesystems live or risk a serious 
performance degradation? I have my personal doubts.

I think the problem with the "å" character I've described above, is a 
forever problem created by Apple and Microsoft and IBM and who knows 
what more. It's not possible to solve, without a serious cost, and 
having this secret automagic trashbin for files that just a few people 
use, compared to the big picture, is not an issue for them. Even a few 
people going to jail for 21 years, is not an issue. Who cares, is the 
impression I get from customer support at both Microsoft and Apple. And 
not at least, who knows about this really!

Daniel and Miguel: By saying it is not a good thing to build systems 
completely from source, both kernel and toolchain and everything that 
goes with it, you basically say that permanent "dependencies" between 
the compilers and the kernel will never be a problem. You are building 
on a rock, and only the future knows if what you consider a rock today 
is really a problem tomorrow.

In my example the unicode alphabet is a problem. So tell me: How would 
you update a system, if the value of every single letter in the unicode 
alphabet would change?

> 
>> XCode unfortunately. I download 100's of GBytes of upgrades to XCode,
>> and barely upload one millionth worth of code back to Apple. It's not
>> good. Software developers shouldn't have to download more stuff than
>> they upload?
> 
> The Rust standalone installers are 2+ orders of magnitude lighter.

For people that build stuff on their laptops it still matters. If you 
have a beefy machine, it is a different case.

> 
>> The definition of "bugs" may vary of course. I was thinking more like
>> stack exploits, missing validation of arrays and so on.
> 
> The kernel definitely needs to avoid those. What do you mean?

I thought that Rust didn't allow you to write outside the bounds of 
arrays, similarly to the old Turbo Pascal language?

> 
>> I must admit I'm not a Rust guy and don't see the advantages of Rust
>> like you do.
> 
> The advantages are fairly clear. The question has always been whether
> the cost is worth those benefits.

If there could be one base compiler and toolchain, I would be happy.

> 
>> Why not move Linux-V4L2 drivers to user-space? In my opinion Rust is
>> much more easy to get going there than at the kernel level.
> 
> That sounds like an orthogonal discussion.

Sure.

> 
> In any case, please note that you would need to install the same Rust
> toolchain to compile them in userspace. So, if you are concerned about
> the size of the toolchain (as you mention above), it would not really
> make a difference.
> 
>> Rust is slow based on my observations building Firefox from sources. The
>> Rust compiler spends a significant amount of time per source file.
> 
> It is slower than compiling C, but it also provides more features, so
> it seems fair for what we are getting in exchange.

Right, so think about where that slowness may end up one day, if you 
suddenly need to re-build everything from sources so to say :-)

Thanks for your input!

--HPS
