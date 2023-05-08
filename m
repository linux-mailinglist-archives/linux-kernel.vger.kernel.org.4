Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A245B6FB6B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjEHTTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjEHTTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CBD49F6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 12:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CFFE61135
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6A4C433EF;
        Mon,  8 May 2023 19:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683573579;
        bh=gXuIcArko6fN66zmSZm/MZ5axXHXd40gsdGwdOET9/w=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=sMAFIY3SkjmQsvMIVMxpKRbg3/UgByj6KNcyIXKipm9mFQ+IvJt3A1R362Njy/nCU
         vUUXV3dp63C9vLiik+3uoAelqnJkqgvdOFfpt7z1O/sORnk+fv5Vl0Ocl1h+c4Y0Qk
         1/yt7d0xw6AazZI5sgTX3H/G9T0nxncEgLz1qEcloPMo8XfAyYXtazJaOD0R6WW5Wm
         s9dH0/uGXWSurwAX/vgu5y4Fkxf5Qn/QNg8jqPAfDJh4ceEIwmpTRcXcy2HM3rtt+F
         7lzCLqDYoOoU3kC4vosSoGm7o1sF1BqGZhlb3+yo1WY1vpRVdaxnWIoquutsOE+uXA
         Mn/isP3rt3bjg==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Arnd Bergmann" <arnd@kernel.org>, Netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireless: ath: work around false-positive stringop-overread warning
References: <20230417205447.1800912-1-arnd@kernel.org>
        <87ttwnnrer.fsf@kernel.org>
        <504c5a7d-0bfd-4b1e-a7f0-65d072657e0a@app.fastmail.com>
        <87mt2eoopo.fsf@kernel.org>
        <c7f88295-2e22-4100-b9c8-feb380b64359@app.fastmail.com>
Date:   Mon, 08 May 2023 22:19:35 +0300
In-Reply-To: <c7f88295-2e22-4100-b9c8-feb380b64359@app.fastmail.com> (Arnd
        Bergmann's message of "Mon, 08 May 2023 17:07:49 +0200")
Message-ID: <87ild2ocl4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Mon, May 8, 2023, at 16:57, Kalle Valo wrote:
>> "Arnd Bergmann" <arnd@arndb.de> writes:
>>>
>>> I uploaded gcc-13.1.0 binaries last week, but still need to
>>> update the html page, so it's not yet linked. You can navigate
>>> the directories from the gcc-12 builds.
>>
>> Thanks! I was able to find the build[1] but having an issue:
>>
>> $ ./x86_64-linux-gcc -v
>> ./x86_64-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version 
>> `GLIBC_2.35' not found (required by ./x86_64-linux-gcc)
>> ./x86_64-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version 
>> `GLIBC_2.32' not found (required by ./x86_64-linux-gcc)
>> ./x86_64-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version 
>> `GLIBC_2.33' not found (required by ./x86_64-linux-gcc)
>> ./x86_64-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version 
>> `GLIBC_2.36' not found (required by ./x86_64-linux-gcc)
>> ./x86_64-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version 
>> `GLIBC_2.34' not found (required by ./x86_64-linux-gcc)
>>
>> With older GCC versions from your page I don't have this problem. I'm
>> using Debian 10 still so so is my libc too old?
>
> (dropping most Cc)
>
> Indeed, thanks for the report, I forgot about that issue. I used
> to build the cross toolchains in an old Ubuntu 16.04 chroot to avoid
> that issue, and I linked all other dependencies statically.
>
> The gcc-13.1.0 builds are the first ones I did on an arm64 machine,
> so I had to create a new build environment and started out with
> just my normal Debian testing rootfs, which caused me enough issues
> to figure out first.
>
> I had previously experimented with linking statically against
> musl to avoid all other dependencies, but that ended up with
> slower binaries because the default memory allocator in musl
> doesn't work that well for gcc, and I never quite figured out
> how to pick a different memory allocator, or which one to use.
>
> I should probably just pick an older Debian release that is new
> enough to contain cross compilers for arm64 and x86 and then
> set up the same kind of chroot I had in before.

Thanks! I really should update to Debian 11 but I have been lazy :) But
I doubt that would have helped either as it looks like it has libc6
v2.31:

https://packages.debian.org/bullseye/libc6

I'm disappointed glibc creates so uncompatible binaries, feels like they
don't create about backwards compatibility :/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
