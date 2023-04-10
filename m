Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4DA6DCB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjDJS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:59:11 -0400
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C86F10C7;
        Mon, 10 Apr 2023 11:59:09 -0700 (PDT)
Received: from [10.36.2.154] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id F37982601F3;
        Mon, 10 Apr 2023 20:59:04 +0200 (CEST)
Message-ID: <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org>
Date:   Mon, 10 Apr 2023 20:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Content-Language: en-US
To:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org>
 <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 4/9/23 16:10, Daniel Almeida wrote:
> Hi Hans! Thank you for chiming in!
> 
> There's a few things in your email that I disagree with and that I'd
> like to
> address.
> 
>> I think V4L2 should be written in primarily one language.
> 
> It is, in C. This series is about adding *bindings* to write *drivers*
> in Rust
> *for those interested*. The v4l2 core remains untouched, and I don't
> think there
> are any plans to introduce Rust outside of drivers in the kernel at
> all, last I
> heard.

I see your point, but still I think it is better to have good examples, 
than to say, there is a room for everything, just come here :-)

Adding a dependency to build the Rust compiler even to build one or two 
V4L2 device drivers, would mean a lot to my small hselasky/webcamd 
project. It already has to fetch a copy of the Linux kernel, and now has 
to bootstrap Rust from stage0 to stageN. I personally say no. It's like 
XCode unfortunately. I download 100's of GBytes of upgrades to XCode, 
and barely upload one millionth worth of code back to Apple. It's not 
good. Software developers shouldn't have to download more stuff than 
they upload?

> 
>> You assume that all code is running inside the kernel and needs to be
> perfect.
> 
> No I do not assume that. In fact, Rust code is absolutely not
> guaranteed to be
> bug free and definitely not "perfect".

The definition of "bugs" may vary of course. I was thinking more like 
stack exploits, missing validation of arrays and so on.

> On the other hand, I would take Rust over C any day. Thus I am
> contributing some
> of the infrastructure to make this possible for me and for others.
I must admit I'm not a Rust guy and don't see the advantages of Rust 
like you do.

> IMHO I think you're approaching this from the wrong angle. It isn't
> that Linux
> *needs* Rust. It's more about providing a new and safer choice with
> modern ergonomics for developers, is all.

Why not move Linux-V4L2 drivers to user-space? In my opinion Rust is 
much more easy to get going there than at the kernel level.

> 
>> I would rather like more drive on that, than flowing down the Rust
> stream.
> 
> These two things are not mutually exclusive :)
> 
>> Rust is cool, Java is cool, VM's are cool.
> 
> I don't see why Java and virtual machines are being brought into the
> discussion
> for this patchset here. And compilation times are a part of life,
> sadly. Also,
> can you substantiate your claim that Rust is slow?

Rust is slow based on my observations building Firefox from sources. The 
Rust compiler spends a significant amount of time per source file.

>> Engineering energy would be much more focused, if hardware vendors
> could agree
> more about what binary formats to use for their device protocols,
> 
> I understand, but my patchset is not to blame here. In fact, I have no
> say at
> all over these things.
> 
>> than changing the coding language
> 
> This simply is not what is happening here. Again this is about giving
> kernel
> developers another *option* of programming language, not about ditching
> C.

I think this option belongs in user-space and not Linux (the kernel). 
More stuff should be moved there, that is my view.

> 
>> that now anyone can be let loose to program in the Linux kernel
> without
> risking any damage
> 
> Who's "anyone"? Plus the review process stays in place, so hardly any
> changes to
> code quality here.

Maybe the word "anyone" was a bit unclear in this regard. I take that 
back for now.

>> I'm glad if not everyone out there can do my job writing C-code for
> device
> drivers. We don't need more people to mess around there  simply.
> 
> Ok we differ strongly here. In particular, I am totally neutral to your
> first
> statement.
> 
> The reality is that it isn't up to anyone to say who should or
> shouldn't become
> a kernel developer. The resources are out there for anyone to try, and
> if
> maintainers take in their patches, then that's the end of the story.
The GPLv2 license should not be the only reason behind Linux developers 
putting drivers in the kernel-space. I think moving more stuff to 
user-space would benefit a greater purpose.

Summed up:

My main objection is Rust compiler support for _kernel_ V4L2 drivers. My 
opinion it belongs to user-space for now and why not do something there 
instead?

--HPS
