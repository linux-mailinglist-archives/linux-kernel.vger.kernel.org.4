Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCFE63F6CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiLARta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLARs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:48:57 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA53BBBC6;
        Thu,  1 Dec 2022 09:46:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 008D242600;
        Thu,  1 Dec 2022 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669916777; bh=5FyH3OS+pK5R8cX27N/PSU5p4zkEL3o4KXlC2krsXmk=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=NpFKctwEt7JN6dhPWhMLros6WSZW6BaHehKhc6GHEdzofYSXkzpXlC76PmRxmaBY/
         y9FmPugJSrcKkCp4ccjf67XLQFsPxJbzP83V9zX5SFjftC0g27lz/rcgySG9LnNioQ
         ooUP9CsLY2zOJLzvrFct54AOMvE2zBquGA7VDZ1SOK5K0djKeTWB9Sg+EfQvS8hS/C
         1yIj1vFy35v4qaa/p2kFZGxSHlglBANgDCsaID40mAQNo48fwwvC8Z39jdEA8tpA5P
         wqxPlDAyZjjqfLlvN7VXMZFK2EqIm5/lLGMHcV1pTV+sSWMo/PZEq9njJe9asZnZbI
         AQq3bLIq/H02Q==
Message-ID: <647b6572-e5d1-d243-283e-616cef15a1f5@marcan.st>
Date:   Fri, 2 Dec 2022 02:46:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Akihiko Odaki <akihiko.odaki@daynix.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        alyssa@rosenzweig.io, sven@svenpeter.dev
References: <20221201103651.27807-1-akihiko.odaki@daynix.com>
 <877czb42wk.fsf@bloch.sibelius.xs4all.nl>
 <c3b0cee9-032c-0447-37df-3ce5ce280e41@daynix.com>
 <ae89b38f-fd67-e0e5-1439-f376da985be8@marcan.st>
 <8b3c4fe0-4a81-ba47-2f01-3686cfdbd519@daynix.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] arch: arm64: dts: apple: Remove stdout-path
In-Reply-To: <8b3c4fe0-4a81-ba47-2f01-3686cfdbd519@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 01.38, Akihiko Odaki wrote:
>  >> In contrary, if you boot the kernel without the hypervisor
>  >> feature and this change, you will completely lose the console.
>  >
>  > How so? The console goes to both places with stdout-path set to serial0.
>  > What it *does* change is where input is accepted prior to getty startup
>  > (which is why u-boot specifically conditions this on keyboard presence,
>  > modulo the USB issue - because if you *don't* have a keyboard then tty
>  > keyboard input is useless). But if you're booting kernels without u-boot
>  > along the way, you're probably doing it from the hypervisor or linux.py
>  > anyway, especially if you plan to do something like "init=/bin/sh",
>  > because without u-boot (+ optionally some EFI loader) there is no way of
>  > editing command line arguments at boot time stand-alone.
> 
> Well, that is not exactly the behavior I saw. In my case, if stdout-path 
> is pointed to serial, there is no output on the framebuffer, and it just 
> printed "_".
> 
> It looks like the kernel only outputs to either of serial and 
> framebuffer, not both.

That is not what I've seen in all of my hypervisor runs since the dawn
of time. You get log output on both.

> What I experienced is that when I directly booted the kernel from m1n1 
> without hypervisor, it showed no output to the display even though the 
> same kernel worked with U-Boot. While I could tell it used wrong console 
> by running the hypervisor, I wondered why it behaves differently without 
> U-Boot, and found the aforementioned U-Boot change, coming up with this 
> patch.

Then it sounds like something else is different about our setups,
because I've booted the kernel from linux.py hundreds of times and I get
output on both. Looking through the console code, the VT console gets
added and enabled really early, and the subsequent serial console
registration later does not disable it.

Look for "console: colour dummy device 80x25". It should be immediately
followed by "printk: console [tty0] enabled", and this should all come
well before the ttySAC0 serial stuff shows up.

- Hector
