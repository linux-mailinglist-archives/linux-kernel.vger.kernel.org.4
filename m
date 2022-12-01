Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBC763F476
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiLAPrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiLAPqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:46:49 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132DC2185;
        Thu,  1 Dec 2022 07:46:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 91EF941A42;
        Thu,  1 Dec 2022 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669909604; bh=sweJNKsjr4ljoYIjuQ98l2QsA987tki/vb90mAoNacE=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=vqwoRo3rh1Gn9uAlzocc7qmZjr3RgtGrOSjTt3SrXhOaEJpHr9imroBJp7n/egHjW
         kKg0vs6Clj52HIV9QnzBYzvz4PkD/6h1KU64FyQCrwbzmgzqJeJ4HfjCjA1YE7RyYh
         WVpf2cl7tiFnPU2RWpttyvFoBIYzLyqcTcR5v0UnZrYoove1b6eS7xfJAYMH90acOR
         +Q3dzpOgE5u4STNQUmGJRwVLNlov0cuaefHWZKD0JCK+UMfJdBhU/9Cja3DToH4A2B
         fR4ua1/7wQjrIYHsvnwsASSGuAaePovgNCFZdu23dBU9JoGJR5+5JOe5wN/gyb3Tay
         hurVUC5Ydudig==
Message-ID: <ae89b38f-fd67-e0e5-1439-f376da985be8@marcan.st>
Date:   Fri, 2 Dec 2022 00:46:38 +0900
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
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] arch: arm64: dts: apple: Remove stdout-path
In-Reply-To: <c3b0cee9-032c-0447-37df-3ce5ce280e41@daynix.com>
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

On 02/12/2022 00.19, Akihiko Odaki wrote:
> So I think we should think more about the case when the kernel is booted 
> from m1n1. When using its hypervisor feature, it is more likely that you 
> want console on serial and and that is the opposite of this change. 
> However, it is still possible to get the console on framebuffer with 
> keyboard.

Except if the framebuffer is broken, or everything is broken and it
hangs on early boot, which happens all the time when I'm debugging using
the hypervisor. Or maybe I'm just SSHing in remotely and not physically
in front of the machine, which is also often the case. Or maybe I'm just
booting headless because I didn't feel like swapping around the HDMI cable.

> In contrary, if you boot the kernel without the hypervisor 
> feature and this change, you will completely lose the console.

How so? The console goes to both places with stdout-path set to serial0.
What it *does* change is where input is accepted prior to getty startup
(which is why u-boot specifically conditions this on keyboard presence,
modulo the USB issue - because if you *don't* have a keyboard then tty
keyboard input is useless). But if you're booting kernels without u-boot
along the way, you're probably doing it from the hypervisor or linux.py
anyway, especially if you plan to do something like "init=/bin/sh",
because without u-boot (+ optionally some EFI loader) there is no way of
editing command line arguments at boot time stand-alone.

However, while having stdout-path gives you both serial + tty output and
serial input, *not* having stdout-path kills serial entirely. It also
kills earlycon, and makes it so that you have to specify a bunch of
obscure arguments to get earlycon to work, instead of just a plain
"earlycon" argument which is much easier.

So for this to be considered at all, you would first need to propose a
m1n1 patch to re-add stdout-path in boots under the hypervisor and
(optionally?) on linux.py boots, so you don't regress tools that our
developers use every day.

But I still fail to see the benefit of this change. What scenario are
you envisioning that this would improve (something people actually do,
not a hypothetical)?

- Hector
