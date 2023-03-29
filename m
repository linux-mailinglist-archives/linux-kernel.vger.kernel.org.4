Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76826CD2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjC2HPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjC2HPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:15:39 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5BBA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:15:36 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A14135FD02;
        Wed, 29 Mar 2023 10:15:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1680074133;
        bh=I4syhipQ1flDROQ9dHS52fz4/zkKeopJfk070Erq43s=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=RBtZkhTzrqFTtWiMWULOGb5i6y7++DBWeypjF9eLxZ4GclqAuzx4W2eM7CkgN3i2r
         BtlbIkqL6xNplqyg1XeG52LopVjqai5cO6c8OkJRGGvjsYbLoX0C0274EuSU+qhfdt
         EdMLdD3Y/meL8UcbfVn2K7iDHqA+wRByEYhF+jg1HGNXm5BZGxgrrLI2fGAwHpnRSC
         +XgYKOkJnC+PufimVs3zgKLhl+HFrIMQ1dZvCh/j90Kn9M07bhFa3a+nfVKoqdgYgF
         GECddvrdcZuzhp2wMLbTqaYhfbImx9qJv+rBcsqm20Ncvh8ObRfrGAOAi1AppeRF5L
         bse3TpAhNJwmw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 29 Mar 2023 10:15:32 +0300 (MSK)
Message-ID: <2fed42ad-11cb-6199-6adb-d9272209f5e2@sberdevices.ru>
Date:   Wed, 29 Mar 2023 10:12:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix bitmask for length in command
 word
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
References: <d4338bd5-125c-a9e7-cb46-6f5e1da05cfa@sberdevices.ru>
 <CAFBinCB3yuyNJD=7UJ7jzf45Masms_PD4sm42YNjO8M4cr+4wg@mail.gmail.com>
 <fe2ed378-cdac-dbb3-acd2-ff542bd7e887@sberdevices.ru>
 <81632eee-533e-5e44-1520-5321a06c6797@sberdevices.ru>
 <20230328185001.5661132b@xps-13>
 <e8edcbc8-5c72-b29e-21d7-6f4438391924@sberdevices.ru>
 <CAFBinCCCNYJV4RBbM78r3yGPnY4oNKySEFRkzBgUD3xYJGkJmw@mail.gmail.com>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <CAFBinCCCNYJV4RBbM78r3yGPnY4oNKySEFRkzBgUD3xYJGkJmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/29 04:10:00 #21025776
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.03.2023 23:25, Martin Blumenstingl wrote:
> Hi Arseniy,
> 
> On Tue, Mar 28, 2023 at 8:39 PM Arseniy Krasnov
> <avkrasnov@sberdevices.ru> wrote:
> [...]
>>>
>>> By the way any reason not to have Cc'ed stable?
>>
>> Sorry, what do You mean? I've included linux-mtd mailing lists, there is
>> one more list for mtd reviews? I will appreciate if You can point me
> "stable" typically refers to the stable tree where fixes for already
> released kernel versions are maintained.
> When Miquel applies the patch it will either land in the next -rc of
> the current development cycle (typically applies to fixes - currently
> 6.3-rc5) or -rc1 of the next kernel version (typically applies to new
> features, cleanups, etc. - currently 6.4-rc1).
> 
> Let's say you are fixing a bug now but want the fix to be included in
> 6.1 LTS (long term stable) or other stable release.
> In this case it's recommended to Cc the maintainers of the stable
> trees as part of your patch, see [0].
> That way once the commit with your fix hits Linus Torvalds linux tree
> it will be backported by the stable team within a few days (assuming
> of course that the patch applies cleanly to older versions, if not
> they're notifying you).
> Note: even without Cc'ing the stable maintainers your commit may be
> backported (semi-automatically) if it has a Fixes tag and the stable
> maintainers find your commit. But my understanding is that it's
> easiest for them if they're explicitly Cc'ed on the patch.
> 
> I hope this makes sense. If not: don't hesitate to ask.

Hello! Thanks for this detailed explanation, that really helps!

Thanks, Arseniy

> 
> 
> Best regards,
> Martin
> 
> 
> [0] https://www.kernel.org/doc/html/v4.15/process/stable-kernel-rules.html#option-1
