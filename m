Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569816587F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiL1X6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiL1X6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:58:33 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3A213FAC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 15:58:32 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2BSNwDZT740625
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 28 Dec 2022 15:58:14 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2BSNwDZT740625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022120601; t=1672271895;
        bh=g+vUQSWM8S+CJcD539vqhAMG4lCGgJ1msfXsb2Kc1bw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=SP9mXm3ejT+I8KWJp7ZU7QfEACk1fXjCLwlsr2JPh6kPi9vhWZyLPKUoDA7xez7Lj
         8mKL7hIh7LMUn+GDh4r3IL20SSFePUBHCj79Kdmm+ivgBlLmkBz3jMxk5j5lprW76Y
         4RionjIX8AniNu6B62nbeyVrI4zKOpabnl8x67U89CPZEVeWvW/i63LSu/kfSiHeeE
         LtelFnwDnjaGOOP5COPrE72KDcj9CZh5+4rm9JiyqWUPMXx4lsZK6U74GyOka5Q4A9
         BDPDdM/MVzJe1QovMZUoNWdk1yNeKU5Apd9EO0OZ0Rznt1fD7BK3oHyX6rJFan5Nby
         iGN3NMKleVkBg==
Date:   Wed, 28 Dec 2022 15:58:12 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, bp@alien8.de, philmd@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_qemu=5D_x86=3A_don=27t_let_decomp?= =?US-ASCII?Q?ressed_kernel_image_clobber_setup=5Fdata?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y6x1knb8udpSyMSp@zx2c4.com>
References: <20221228143831.396245-1-Jason@zx2c4.com> <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org> <Y6xvJheSYC83voCZ@zx2c4.com> <Y6x1knb8udpSyMSp@zx2c4.com>
Message-ID: <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 28, 2022 8:57:54 AM PST, "Jason A=2E Donenfeld" <Jason@zx2c4=2E=
com> wrote:
>HELLO H=2E PETER ANVIN,
>E
>L
>L
>O
>
>On Wed, Dec 28, 2022 at 05:30:30PM +0100, Jason A=2E Donenfeld wrote:
>> > Fix looks good, glad you figured out the problem=2E
>>=20
>> I mean, kind of=2E The solution here sucks, especially given that in th=
e
>> worst case, setup_data just gets dropped=2E I'm half inclined to consid=
er
>> this a kernel bug instead, and add some code to relocate setup_data
>> prior to decompression, and then fix up all the links=2E It seems like
>> this would be a lot more robust=2E
>>=20
>> I just wish the people who wrote this stuff would chime in=2E I've had
>> x86@kernel=2Eorg CC'd but so far, no input from them=2E
>
>Apparently you are the x86 boot guru=2E What do you want to happen here?
>Your input would be very instrumental=2E
>
>Jason

Hi!

Glad you asked=2E

So the kernel load addresses are parameterized in the kernel image setup h=
eader=2E One of the things that are so parameterized are the size and possi=
ble realignment of the kernel image in memory=2E

I'm very confused where you are getting the 64 MB number from=2E There sho=
uld not be any such limitation=2E

In general, setup_data should be able to go anywhere the initrd can go, an=
d so is subject to the same address cap (896 MB for old kernels, 4 GB on ne=
wer ones; this address too is enumerated in the header=2E)

If you want to put setup_data above 4 GB, it *should* be ok if and only if=
 the kernel supports loading the initrd high, too (again, enumerated in the=
 header=2E

TL;DR: put setup_data where you put the initrd (before or after doesn't ma=
tter=2E)

To be maximally conservative, link the setup_data list in order from lowes=
t to highest address; currently there is no such item of relevance, but in =
the future there may be setup_data items needed by the BIOS part of the boo=
tstrap in which case they would have to be < 1 MB and precede any items > 1=
 MB for obvious reasons=2E That being said, with BIOS dying it is not all t=
hat likely that such entries will ever be needed=2E

