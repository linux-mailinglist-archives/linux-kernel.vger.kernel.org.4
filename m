Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A3B628DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbiKNXyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKNXyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:54:51 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73837FCFB;
        Mon, 14 Nov 2022 15:54:48 -0800 (PST)
Date:   Tue, 15 Nov 2022 00:54:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1668470085;
        bh=Dz7/xSqh2npEbI5YMon1IgZkkovoLxEkmwyrvIsKcfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZQl1shnd/0ONXKAOB995YO/xSeXAuy2n3V0lHSrG000Y3kCEhAO3x5L82dszODRP
         /4W2589c3L2cBdRz4VkUE2TNSA4zUan4TamKaOu9vtqTsKsP6hL6jRlbjky+X6Y0v/
         5XvqQKeoIiWUL894SRs3sMVLCofVdfoYOzocjjbo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linux-input@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh/mac_hid.c: don't load by default
Message-ID: <9255deb3-6c66-444d-940d-77e721d950e5@t-8ch.de>
References: <20221113033022.2639-1-linux@weissschuh.net>
 <Y3KJ6SOD5PEwj1oe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3KJ6SOD5PEwj1oe@google.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Franz who wrote the driver originally.
(I hope I got the correct one)

Hi Dmitry,

On 2022-11-14 10:33-0800, Dmitry Torokhov wrote:
> On Sun, Nov 13, 2022 at 04:30:22AM +0100, Thomas Weißschuh wrote:
>> There should be no need to automatically load this driver on *all*
>> machines with a keyboard.
>> 
>> This driver is of very limited utility and has to be enabled by the user
>> explicitly anyway.
>> Furthermore its own header comment has deprecated it for 17 years.
> 
> I think if someone does not need a driver they can either not enable it
> or blacklist it in /etc/modprobe.d/... There is no need to break
> module loading in the kernel.

But nobody needs the driver as it is autoloaded in its current state.
Without manual configuration after loading the driver does not provide any
functionality.

Furthermore the autoloading should load the driver for a specific
hardware/resource that it can provide additional functionality for.
Right now the driver loads automatically for any system that has an input
device with a key and then just does nothing.

It only wastes memory and confuses users why it is loaded.

If somebody really needs this (fringe) driver it should be on them to load it
it instead of everybody else having to disable it.

Furthermore the file has the following comment since the beginning of the git
history in 2005:

    Copyright (C) 2000 Franz Sirl

    This file will soon be removed in favor of an uinput userspace tool.

>> Fixes: 99b089c3c38a ("Input: Mac button emulation - implement as an input filter")
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>  drivers/macintosh/mac_hid.c | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
>> index d8c4d5664145..d01d28890db4 100644
>> --- a/drivers/macintosh/mac_hid.c
>> +++ b/drivers/macintosh/mac_hid.c
>> @@ -149,8 +149,6 @@ static const struct input_device_id mac_hid_emumouse_ids[] = {
>>  	{ },
>>  };
>>  
>> -MODULE_DEVICE_TABLE(input, mac_hid_emumouse_ids);
>> -
>>  static struct input_handler mac_hid_emumouse_handler = {
>>  	.filter		= mac_hid_emumouse_filter,
>>  	.connect	= mac_hid_emumouse_connect,
>> 
>> base-commit: fef7fd48922d11b22620e19f9c9101647bfe943d
>> -- 
>> 2.38.1
