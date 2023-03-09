Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F71D6B2FDF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjCIVwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCIVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:52:48 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DDC103398
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 13:52:43 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 132so1927686pgh.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 13:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678398763;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7nNOXbc+WHd5NABSbnw3+9ZkEtpuzcZoSp/LFLBByFA=;
        b=kfiM9MxY8vR15n0P+Q9WMzoNqzsyX/K61E9+p64hTU3fdlTpBiuHXT+QL4MCiMCwsZ
         /E0QrLsMb4Nut3KwGFTkPx82xRKD0Q6tg521BAsaxSjjgi0jp10LyKT4VcO3Ym5Nfp8j
         K99lBPkT863bgMXn81mWM52Y3HAXsnbgQXC/cQhkIUADsx8eC8BCkaezk1jyf3KnMbxe
         5cey5kg6qiEDTnH7o5tkCNFGPtIcoIWnQj/s/71D62MPVHbi+/Yi6G5hwJTKjNnOycuD
         8thUDBETxoMKd3r5r6WznnZXgw5w/5YPtXbhqUPh2vkm0LV7k6n6vMb+6MRMEVomuEWI
         oINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398763;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nNOXbc+WHd5NABSbnw3+9ZkEtpuzcZoSp/LFLBByFA=;
        b=Gg5Y12GKQRMz11Q4XhHpYlpWckAUUxbZp9xEInRCmr2X0/cIPooHNLTHTr/FEKOGoS
         Tw6w6lFrflEbtj6ArlMov/tCIFz4JO9UOB4V4znK/lFIz6y120T6xSoxhAG1ZC3ybczR
         KYf93FDJXTXT0rnhNBROAuUfKv7lxxSHZdAKrdQnVLLlGnUrxuG9ZChzTu2KETYpig0W
         tZkJe8doaZOeEnw82J+fFeQysk700s5x019Tw9NF/Meucch2auKe5ZMIMBqNl6rfytc0
         11zDLyun1RedcJ9jx+4xm8sbCDM71QSJRkvyVjdwt+ZzNgqpCGqzpTkRPAYt+tezIbNR
         g1cQ==
X-Gm-Message-State: AO0yUKW8A9yeArYFd+sU3QKs+Ju7UjTVfvernbn5YOcGf1hkXCgkB64T
        v39ETk2nSi+V8em6YzL6yG3gUjAxkX0Z8E75NUM=
X-Google-Smtp-Source: AK7set8Rgzrxi+ZGmbJxKNg4wUXFIFO8nTaU1MxHwhO6m2S5MjEM74yH44rUOwLH5ZFNysgyUIXqOg==
X-Received: by 2002:aa7:980c:0:b0:5dc:2064:f7c4 with SMTP id e12-20020aa7980c000000b005dc2064f7c4mr22346879pfl.10.1678398762740;
        Thu, 09 Mar 2023 13:52:42 -0800 (PST)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id 2-20020aa79142000000b00592543d7363sm69953pfi.1.2023.03.09.13.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:52:42 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1 0/3] Meson A1 32-bit support
In-Reply-To: <20230228084952.mgx3d3nw65yo5ebu@CAB-WSD-L081021>
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
 <8e5f9bfa-d612-cd43-d722-d04c40938c62@linaro.org>
 <20230227142809.kujmrraf3pcdhqyn@CAB-WSD-L081021>
 <f3e42012-609c-4085-b4f4-bd32bfc34aff@app.fastmail.com>
 <20230227155100.hhl4yvkyfqfyoa6h@CAB-WSD-L081021>
 <a5fa8b23-4ec8-475f-be5e-538b53d6f82d@app.fastmail.com>
 <33b58877-5167-c453-e686-1d10cdca66c0@linaro.org>
 <20230227165049.4y7jx5nnnlibe6kg@CAB-WSD-L081021>
 <7d29f3fd-b8c8-4687-b6a0-b8956dd39f0b@app.fastmail.com>
 <20230228084952.mgx3d3nw65yo5ebu@CAB-WSD-L081021>
Date:   Thu, 09 Mar 2023 13:52:41 -0800
Message-ID: <7hedpxwq1i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Rokosov <ddrokosov@sberdevices.ru> writes:

> On Mon, Feb 27, 2023 at 07:19:38PM +0100, Arnd Bergmann wrote:
>> On Mon, Feb 27, 2023, at 17:50, Dmitry Rokosov wrote:
>> > On Mon, Feb 27, 2023 at 05:38:49PM +0100, Neil Armstrong wrote:
>> >> On 27/02/2023 17:15, Arnd Bergmann wrote:
>> >> > On Mon, Feb 27, 2023, at 16:51, Dmitry Rokosov wrote:
>> >> > 
>> >> > Most of these don't apply in userspace, so the incentive to
>> >> > run smaller 32-bit userland on systems with less than 1GB of
>> >> > RAM usually outweighs the benefits of 64-bit userspace.
>> >> 
>> >> Thanks for the details!
>> >
>> > Looks like Thomas has already prepared a basic patch series for buildroot,
>> > but maintainers declined it.
>> >
>> > https://lore.kernel.org/all/20220730194331.GA2515056@scaer/
>> 
>> I see. I know very little about buildroot, but it sounds like
>> there are other ways of doing the same thing here. In general,
>> this is pretty much an Arm specific problem. While you clearly
>> want compat mode for small userland on any architecture but don't
>> want 32-bit kernels, arm is the only one that has a different
>> kernel "ARCH=" value and needs a separate gcc toolchain.
>> 
>> If the problem is only the toolchain, an easy way out may
>> be to use clang instead of gcc as your compiler, as a single
>> clang binary can target both 32-bit userland and 64-bit kernel
>> on all supported architectures.
>
> Agreed with you. We will try different local approaches to support
> compat build configurations. For now, prebuilt toolchain (buildroot make
> sdk goal) is best way from my point of view. Anyway, we will try to
> solve this problem in the our sandbox and stay on the 64-bit kernel.
> Thank you for all the helpful details you shared, appreciate it!

Just to clarify one thing...

More specifically, this is a buildroot *build system* problem.  If you
build the kernel separately from the rootfs, it works fine. 

I use 32-bit buildroot (and debian) rootfs images all the time on
Amlogic SoCs with 64-bit kernels and it works fine.  

Kevin
