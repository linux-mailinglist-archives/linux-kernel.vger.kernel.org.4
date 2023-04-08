Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A006DBCD6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 21:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDHTvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHTu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 15:50:59 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 08 Apr 2023 12:50:57 PDT
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A510DD
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 12:50:57 -0700 (PDT)
Received: from [10.36.2.154] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id C831D260025;
        Sat,  8 Apr 2023 21:43:22 +0200 (CEST)
Message-ID: <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org>
Date:   Sat, 8 Apr 2023 21:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
Content-Language: en-US
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <20230406215615.122099-1-daniel.almeida@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 23:56, Daniel Almeida wrote:
> Hi all, this is my first attempt at adding Rust support to the
> media subsystem.
> 
> 
> Please let me know your thoughts.
> 

Hi Daniel,

I think V4L2 should be written in primarily one language.

At first, I think Rust for V4L2 has no benefits for media drivers, 
webcams, DVB-S/T/T2, pointing tablets and so on. You assume that all 
code is running inside the kernel and needs to be perfect. But I think 
you could just aswell implement the next USB webcam V4L2 driver in Perl 
for that sake.

The reason for my point of view, is that I think most of the drivers in 
media/ should run in user-space, and not inside the kernel. The driver 
is killed when the device is detached, and all lost memory is reclaimed, 
automagically. Then there exist proper methods to lock-down all 
interfaces and file handles, so that device drivers will not do any 
harm, even if exploited. For example the Capsicum library, I'm using 
FreeBSD.

Debugging stuff using GDB in user-space, is so much more convenient than 
debugging stuff inside the kernel. And the development time is much faster.

The example of secure V4L2 programming is already here:
https://github.com/hselasky/webcamd

I would rather like more drive on that, than flowing down the Rust 
stream. Rust is cool, Java is cool, VM's are cool. The only bad about 
cool things, is that they are so slow. For many years I completely 
avoided C++ code for the sake it is very slow to compile, compared to 
bare C code. And when looking at how Firefox is building using Rust, I 
am a little worried, why we need so much code in there!

Engineering energy would be much more focused, if hardware vendors could 
agree more about what binary formats to use for their device protocols, 
than changing the coding language, so that now anyone can be let loose 
to program in the Linux kernel without risking any damage.

The goal for Linux driver development should be fewer drivers and not 
more. I'm glad if not everyone out there can do my job writing C-code 
for device drivers. We don't need more people to mess around there 
simply. I don't want Linux to become the next Microsoft, with gigabytes 
of drivers which are never used for anything.

The webcamd daemon already is close to 6 MBytes big on amd64 on FreeBSD. 
Inside there is support for 510 drivers (counting =y keywords), built 
straight off Linus Torvalds:

cat config | grep CONFIG | grep "=y" | wc -l
      510

ls -l `which webcamd`
-r-xr-xr-x  1 root  wheel  5915016 Mar 30 19:09 /usr/local/sbin/webcamd

The USB video class is great, instead of tons of GSPCA devices, then 
yeah, we don't need to drag around so much legacy binaries, just to make 
everyone happy. What did Apple do? Custom PCI webcam devices? Why can't 
they just stick with virtual USB devices, and then have a dual 
configured device, one config for their own HD codec, and one config for 
people like me, just needing the framebuffer.

You asked for a comment and now you got one!

--HPS
