Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB3613943
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiJaOrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJaOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:47:11 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36A9101CB;
        Mon, 31 Oct 2022 07:47:08 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D824A5FD02;
        Mon, 31 Oct 2022 17:47:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1667227625;
        bh=SeJYjN77aPqX/3EXkPRnl1QHObia9YG9ubqX8i1Rtus=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=mACcP4LNjmwzSPF1W5P46YOa0c5TjJiAGp+Zb9IKHcd+HBIgYCcFBJuRJsUVCmSwN
         CcIowButSgXyytXGbJGbwM4WTnI36xUivMoHSXx8gow3j+OlvE3g6uDgVeehJgqKNI
         iRdrHJ1lBvK0N6PYzFV2zU62YcVGYowuv7ljvBa790dEbdkNULbDXgNO1zSku5UuRI
         u369MglWYEtM7rTJrV5C0dhZfqNctzeJ52o8wbupy+RE02lXdNQjx8lLQJJzdreSJi
         67yzr4udlHddVkxo7/KWJIOKdkoYhc3UaghVZVjfKi14IGJ/9g4nMKtXx1cL4Pr3o6
         hGLjAb0Ufo7Zg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 31 Oct 2022 17:47:05 +0300 (MSK)
Date:   Mon, 31 Oct 2022 17:47:04 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/1] leds: support to use own workqueue for each
 LED
Message-ID: <20221031144704.ir5iks6ohh3negsx@CAB-WSD-L081021>
References: <9a0a70a8-0886-1115-6151-72d2cba842cf@sberdevices.ru>
 <33d05330-7c52-e873-bf32-209d40c77632@sberdevices.ru>
 <20221030122029.GA8017@duo.ucw.cz>
 <b7304844-a654-2120-2159-29f6134dbadb@sberdevices.ru>
 <20221030201527.GA23195@duo.ucw.cz>
 <03bc76b5-4e2e-5d4d-96b5-53a1f95ffd0c@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <03bc76b5-4e2e-5d4d-96b5-53a1f95ffd0c@sberdevices.ru>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/10/31 05:11:00 #20539587
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel and Arseniy,

Please find my thoughts below.

On Mon, Oct 31, 2022 at 10:01:28AM +0300, Arseniy Krasnov wrote:
> On 30.10.2022 23:15, Pavel Machek wrote:
> > Hi!
> > 
> >>>> This allows to set own workqueue for each LED. This may be useful, because
> >>>> default 'system_wq' does not guarantee execution order of each work_struct,
> >>>> thus for several brightness update requests (for multiple leds), real
> >>>> brightness switch could be in random order.
> >>>
> >>> So.. what?
> >>>
> >>> Even if execution order is switched, human eye will not be able to
> >>> tell the difference.
> >> Hello,
> >>
> >> Problem arises on one of our boards where we have 14 triples of leds(each
> >> triple contains R G B). Test case is to play complex animation on all leds:
> >> smooth switch from on RGB state to another. Sometimes there are glitches in
> >> this process - divergence from expectable RGB state. We fixed this by using
> >> ordered workqueue.
> > 
> > Are there other solutions possible? Like batch and always apply _all_
> > the updates you have queued from your the worker code?
> 
> IIUC You, it is possible to do this if brightness update requests are performed using
> write to "brightness" file in /sys/class/led/. But if pattern trigger mode is used(in my
> case) - I can't synchronize these requests as they are created internally in kernel on
> timer tick.

Even more, system_wq is used when you push brightness changing requests
to sysfs node, and it could be re-ordered as well. In other words, from
queue perspective sysfs iface and trigger iface have the same behavior.

Also we can be faced with another big problem here: let's imagine you have
I2C based LED controller driver. Usually, in such drivers you're stuck
to the one driver owned mutex, which protects I2C transactions from each
other.

When you change brightness very often (let's say a hundred thousand times
per minute) you schedule many workers to system_wq. Due to system_wq is
multicore and unordered it creates many kworkers. Each kworker stucks on
the driver mutex and goes to TASK_UNINTERRUPTIBLE state. It affects Load
Average value so much. On the our device LA maximum could reach 30-35
units due to such idle kworkers.

I'm not sure custom workqueue initialization from specific HW driver is
a good solution... But it's much better than nothing.

Pavel, please share your thoughts about above problems? Maybe you have
more advanced and scalable solution idea, I would appreciate if you
could share it with us.

-- 
Thank you,
Dmitry
