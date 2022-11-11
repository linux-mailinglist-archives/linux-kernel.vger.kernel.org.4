Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B75625885
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiKKKjq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Nov 2022 05:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiKKKjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:39:40 -0500
Received: from smtp.220.in.ua (smtp.220.in.ua [89.184.67.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC521654CC;
        Fri, 11 Nov 2022 02:39:39 -0800 (PST)
Received: from smtpclient.apple (unknown [95.67.115.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id AA8051A25F73;
        Fri, 11 Nov 2022 12:39:37 +0200 (EET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH 02/13] leds: el15203000: Fix devm vs. non-devm ordering
From:   Oleh Kravchenko <oleg@kaa.org.ua>
In-Reply-To: <c53e4614-eb06-cda8-f9da-2ca58396df54@huawei.com>
Date:   Fri, 11 Nov 2022 12:39:22 +0200
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <AA4E5187-59BC-4E04-B392-7BD48F0443A1@kaa.org.ua>
References: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
 <1667983694-15040-3-git-send-email-wangyufen@huawei.com>
 <5D15416B-1866-4031-9958-7CD763C0BD6E@kaa.org.ua>
 <bbd67e6a-8ce0-dbe8-6ab1-9d4a015f4ee9@huawei.com>
 <6D18A607-EC63-495F-BA2D-78E0DB056D3C@kaa.org.ua>
 <c53e4614-eb06-cda8-f9da-2ca58396df54@huawei.com>
To:     wangyufen <wangyufen@huawei.com>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wang,

> 11 лист. 2022 р. о 11:21 wangyufen <wangyufen@huawei.com> написав(ла):
> 
> 
> 在 2022/11/9 18:43, Oleh Kravchenko 写道:
>> 
>> 
>>> 9 лист. 2022 р. о 12:25 wangyufen <wangyufen@huawei.com> написав(ла):
>>> 
>>> 
>>> 在 2022/11/9 17:39, Oleh Kravchenko 写道:
>>> 
>>>>> -static void el15203000_remove(struct spi_device *spi)
>>>>> 
>>>> Is remove() callback from struct spi_driver deprecated?
>>>> 
>>> It is not that remove() callback is deprecated,
>>> it's that after wrapping mutex_destroy() call with devm_add_action_or_reset(),
>>> remove() callback is unnecessary here.
>>> 
>> When remove() is called, the memory allocated by devm_*() is valid.
>> So what you try to fix here?
> 
> Fix the &priv->lock used after destroy, for details, please see patch #0
> LKML: Wang Yufen: [PATCH 00/13] leds: Fix devm vs. non-devm ordering

It doesn’t make any sense for me.
You saying that remove() called before devm_* allocation
if it true then set_brightness_delayed() will crash the system in anyway.

LED device has a parent SPI device; LED device can’t exist without SPI device.

So deallocation order should be next:
1. LED device devm_*()
2. SPI device remove()

