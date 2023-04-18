Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C706E5CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjDRJAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjDRJAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:00:23 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C5E40D2;
        Tue, 18 Apr 2023 02:00:22 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 2784487;
        Tue, 18 Apr 2023 11:00:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1681808418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xvvRB86AQVxOlD3RtO02pISStAPqaDuG7j7JHADtm5o=;
        b=gmlX31n9YMYDUtWphYdGkIco9r5NaX9mwotHkGiTKllOEnDIuuubO4vMFqRzAYyRx6YeH7
        jopwzCirZzYaxIGYzoQjwxvk4G8lGflMjUO5SZSUtQTEC7j7H6yDDKHQ7CyddjA+6g7iGv
        w/VOAI1XI1dT4jEjkcYWclaOGtEI3ygQ4yHBv/Dq+g9cfoCKpVx0GZ7qhr2ts+YQzKRkoU
        3V3TMCafUHuILI94K5WG4+WV8X6dq4y+VQd2cbNBgpc+302rVfuEVxhLEW4tR1yMEIHoGW
        L1Fa30aCsKkadDewKh1uaLZKOtdUpCqMCrbhnYdAqQX6SrR2zOaGemCBnDbIgQ==
MIME-Version: 1.0
Date:   Tue, 18 Apr 2023 11:00:18 +0200
From:   Michael Walle <michael@walle.cc>
To:     VaibhaavRam.TL@microchip.com
Cc:     gregkh@linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        arnd@arndb.de
Subject: Re: [PATCH v9 char-misc-next 1/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX OTP via NVMEM sysfs
In-Reply-To: <49405ea2bb0bee16a41ce88b7d679ff714823585.camel@microchip.com>
References: <20230413105318.6070-1-vaibhaavram.tl@microchip.com>
 <20230413105318.6070-2-vaibhaavram.tl@microchip.com>
 <51847629489852d493af928580c5a2de@walle.cc>
 <49405ea2bb0bee16a41ce88b7d679ff714823585.camel@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8b7b98e60fd871cc7aafda6f9b4e146a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-04-17 14:47, schrieb VaibhaavRam.TL@microchip.com:
>> > +#include <linux/auxiliary_bus.h>
>> > +#include <linux/bio.h>
>> > +#include <linux/device.h>
>> > +#include <linux/iopoll.h>
>> > +#include <linux/kthread.h>
>> 
>> Is this needed? I don't see any threads. Also bio.h. Please double
>> check
>> your includes.
> Ok, Will remove in next version of patch
>> > +     if (priv != NULL)
>> > +             rb = priv->reg_base;
>> > +     else
>> > +             return -ENODEV;
>> 
>> Unneeded check, priv cannot be NULL, right?
> Ok, I think this can be removed
>> > +
>> > +             data = readl(rb +
>> > MMAP_OTP_OFFSET(OTP_PASS_FAIL_OFFSET));
>> > +             if (ret < 0 || data & OTP_FAIL_BIT)
>> > +                     break;
>> 
>> No error handling?
> We have implemented short read which returns count of successful bytes
> read and therefore userspace will recognise the situation when the
> requested count is not obtained.

I'll leave that up to Greg, but I'd prefer a proper error to userspace.
I'm not sure if you'd need to differentiate between a short read/write
and an error.

Maybe a short read or write is a valid situation where an access which
leads to the OTP_FAIL_BIT is for sure an error situation.

-michael
