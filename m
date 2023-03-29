Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3215D6CD70B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjC2Jzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC2Jzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:55:37 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D3793
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:55:34 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 4057F5FD18;
        Wed, 29 Mar 2023 12:55:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1680083731;
        bh=Xu3w+5oD+GiV9rELaqeOQYTNoX/ncfYGivas4K/Z+CY=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=dwxOga/UDbxGtFpeNNCOLtYUISG5pZeXKljMzUszi/PHkgdCGVKzLroMmp6KczZbQ
         7qdLFPl0paX9Pbqj3WtNzPsQWX6dV+1STVpqav0oHsWcaZxI9QRC8MTYY+pTJFTVFR
         Pl0KHb8eAz8uCorr5HFAtZ2Jw9tlZQc6jqWED99P7UN24008Q54yk2y9mfoBLHDyon
         cbVjjbauC0WTmnSF5I8pE7Mc0XAPXBy8THVxhfi0Ej5DqMKK+Z79bbdjM0dmHlwqyu
         JRYlk7qFRdWENoAdiKgjo/6ltvkmcj6H6ua5JghpbmXKeW3GNEMqtHnBCtNp7tg/8b
         YvrogJIyFwT4Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 29 Mar 2023 12:55:30 +0300 (MSK)
Date:   Wed, 29 Mar 2023 12:55:29 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Arseniy Krasnov <avkrasnov@sberdevices.ru>,
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
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix bitmask for length in
 command word
Message-ID: <20230329095529.4hcydqsmtxin2d4h@CAB-WSD-L081021>
References: <CAFBinCB3yuyNJD=7UJ7jzf45Masms_PD4sm42YNjO8M4cr+4wg@mail.gmail.com>
 <fe2ed378-cdac-dbb3-acd2-ff542bd7e887@sberdevices.ru>
 <81632eee-533e-5e44-1520-5321a06c6797@sberdevices.ru>
 <20230328185001.5661132b@xps-13>
 <e8edcbc8-5c72-b29e-21d7-6f4438391924@sberdevices.ru>
 <CAFBinCCCNYJV4RBbM78r3yGPnY4oNKySEFRkzBgUD3xYJGkJmw@mail.gmail.com>
 <2fed42ad-11cb-6199-6adb-d9272209f5e2@sberdevices.ru>
 <20230329093145.52790647@xps-13>
 <20230329081734.v2kl4okq3ewimvzh@CAB-WSD-L081021>
 <9c7ef736-527b-1659-88d8-cedf56458c30@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c7ef736-527b-1659-88d8-cedf56458c30@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/29 07:09:00 #21026578
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:20:14AM +0100, Tudor Ambarus wrote:
> 
> 
> On 3/29/23 09:17, Dmitry Rokosov wrote:
> > On Wed, Mar 29, 2023 at 09:31:45AM +0200, Miquel Raynal wrote:
> >> Hello,
> >>
> >> avkrasnov@sberdevices.ru wrote on Wed, 29 Mar 2023 10:12:10 +0300:
> >>
> >>> On 28.03.2023 23:25, Martin Blumenstingl wrote:
> >>>> Hi Arseniy,
> >>>>
> >>>> On Tue, Mar 28, 2023 at 8:39 PM Arseniy Krasnov
> >>>> <avkrasnov@sberdevices.ru> wrote:
> >>>> [...]  
> >>>>>>
> >>>>>> By the way any reason not to have Cc'ed stable?  
> >>>>>
> >>>>> Sorry, what do You mean? I've included linux-mtd mailing lists, there is
> >>>>> one more list for mtd reviews? I will appreciate if You can point me  
> >>>> "stable" typically refers to the stable tree where fixes for already
> >>>> released kernel versions are maintained.
> >>>> When Miquel applies the patch it will either land in the next -rc of
> >>>> the current development cycle (typically applies to fixes - currently
> >>>> 6.3-rc5) or -rc1 of the next kernel version (typically applies to new
> >>>> features, cleanups, etc. - currently 6.4-rc1).
> >>>>
> >>>> Let's say you are fixing a bug now but want the fix to be included in
> >>>> 6.1 LTS (long term stable) or other stable release.
> >>>> In this case it's recommended to Cc the maintainers of the stable
> >>>> trees as part of your patch, see [0].
> >>>> That way once the commit with your fix hits Linus Torvalds linux tree
> >>>> it will be backported by the stable team within a few days (assuming
> >>>> of course that the patch applies cleanly to older versions, if not
> >>>> they're notifying you).
> >>>> Note: even without Cc'ing the stable maintainers your commit may be
> >>>> backported (semi-automatically) if it has a Fixes tag and the stable
> >>>> maintainers find your commit. But my understanding is that it's
> >>>> easiest for them if they're explicitly Cc'ed on the patch.
> >>>>
> >>>> I hope this makes sense. If not: don't hesitate to ask.  
> >>
> >> That is an excellent summary, I should copy/paste it sometimes :)
> >>
> > 
> > Finally I fully understand why 'Fixes' tag is so helpful!
> > Thank you Martin!
> > 
> 
> Here's the official documentation:
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Tudor thank you for suggestion!

I don't see anything about Fixes: tag on this page, but looks like
'Submitting patches' tutorial has it:

"""
A Fixes: tag indicates that the patch fixes an issue in a previous
commit. It is used to make it easy to determine where a bug originated,
which can help review a bug fix. This tag also assists the stable kernel
team in determining which stable kernel versions should receive your
fix. This is the preferred method for indicating a bug fixed by the
patch. See Describe your changes for more details.
"""
-- 
Thank you,
Dmitry
