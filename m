Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE86CD3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjC2HwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjC2Hvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:51:38 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5F83AAB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:51:26 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 63C595FD03;
        Wed, 29 Mar 2023 10:51:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1680076284;
        bh=1EpXE2p+9++IAW20D9jacIOjh/MMVTBYGoinNNmPdMQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=p3VmP8k++tSVzWe5WgQKers/1sKQ4QnPfP7pRqlQuxRWjEhPWCMBMT2CXMHOTBZR7
         5gWRX6V2U5oNP79v7MAh6LPXaVA5GIfaYlFCaxakibVMZAhIrLx/EmaVhN7sMgoKVv
         5/0wjruX9BxjLGEXtwoSdoCOfknMqL8VITrrX6/h0efZnC4RXEw6dCWUPo2HV40Zk0
         uxeiLEaVGvbBrOuJVzPRWfwOJYiHLflZYdP57NxCabLTvHRjzPXw+qEO89RsWrr7Rz
         q1d7aHVY4mE8640barURUOH3B8uCFdTv81zjycXYpknqyAYFyO/upvR/a1USBB62OI
         w8bEdI5w51Htw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 29 Mar 2023 10:51:24 +0300 (MSK)
Message-ID: <221e0556-761b-f1b1-abc0-ea3d2e6b884f@sberdevices.ru>
Date:   Wed, 29 Mar 2023 10:48:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix bitmask for length in command
 word
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
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
 <2fed42ad-11cb-6199-6adb-d9272209f5e2@sberdevices.ru>
 <20230329093145.52790647@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230329093145.52790647@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
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



On 29.03.2023 10:31, Miquel Raynal wrote:
> Hello,
> 
> avkrasnov@sberdevices.ru wrote on Wed, 29 Mar 2023 10:12:10 +0300:
> 
>> On 28.03.2023 23:25, Martin Blumenstingl wrote:
>>> Hi Arseniy,
>>>
>>> On Tue, Mar 28, 2023 at 8:39 PM Arseniy Krasnov
>>> <avkrasnov@sberdevices.ru> wrote:
>>> [...]  
>>>>>
>>>>> By the way any reason not to have Cc'ed stable?  
>>>>
>>>> Sorry, what do You mean? I've included linux-mtd mailing lists, there is
>>>> one more list for mtd reviews? I will appreciate if You can point me  
>>> "stable" typically refers to the stable tree where fixes for already
>>> released kernel versions are maintained.
>>> When Miquel applies the patch it will either land in the next -rc of
>>> the current development cycle (typically applies to fixes - currently
>>> 6.3-rc5) or -rc1 of the next kernel version (typically applies to new
>>> features, cleanups, etc. - currently 6.4-rc1).
>>>
>>> Let's say you are fixing a bug now but want the fix to be included in
>>> 6.1 LTS (long term stable) or other stable release.
>>> In this case it's recommended to Cc the maintainers of the stable
>>> trees as part of your patch, see [0].
>>> That way once the commit with your fix hits Linus Torvalds linux tree
>>> it will be backported by the stable team within a few days (assuming
>>> of course that the patch applies cleanly to older versions, if not
>>> they're notifying you).
>>> Note: even without Cc'ing the stable maintainers your commit may be
>>> backported (semi-automatically) if it has a Fixes tag and the stable
>>> maintainers find your commit. But my understanding is that it's
>>> easiest for them if they're explicitly Cc'ed on the patch.
>>>
>>> I hope this makes sense. If not: don't hesitate to ask.  
> 
> That is an excellent summary, I should copy/paste it sometimes :)
> 
>>
>> Hello! Thanks for this detailed explanation, that really helps!
> 
> So IOW, I am asking you to send a v2 with an additional line in the
> commit, right next "Fixes":
> 
> Cc: stable@vger.kernel.org

Done!

Thanks, Arseniy

> 
> Thanks,
> Miquèl
