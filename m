Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29046A0644
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjBWKaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjBWK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:29:54 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D62ED52;
        Thu, 23 Feb 2023 02:29:52 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 39457123A;
        Thu, 23 Feb 2023 11:29:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1677148189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ce0djBkbgIfPJp0Z94KT92OljnaqxS9qhflvWJOeC8w=;
        b=CzegLmDGtXalVclPYQ2HDEDV4zmlUkIQ3F8o4lnGd0VtN5m+/l02eyMW+FUw+ukA9zTw3d
        0E5Uctt1F8mZSMrnrklOgRPqzKDjLXeF+eHVqMQC4ZpqrEzbfFv/f+tcNOQJY0pnil3AD+
        P8LXDnqgHYprGa+KZbEVwcccZ6o9yyiubWVAF6QI0AEYqCQFFMjvJg8gv2t69DVwYFFbbS
        Q9XQhwUXseZqtpiwZmTIhXgblcfBZ2xGP6CxvpXw0MaEBVZ+4G74xzSbWcP6uEUe7q4s6R
        VvQNPxLjGLXgV8K0jU0tK+oNwMfwFuMsEa/m8nChwBbcKRUoDqHhgIGH2MVuPA==
MIME-Version: 1.0
Date:   Thu, 23 Feb 2023 11:29:49 +0100
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kumaravel.thiagarajan@microchip.com, UNGLinuxDriver@microchip.com,
        arnd@arndb.de, derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 char-misc-next 2/5] misc: microchip: pci1xxxx: load
 gpio driver for the gpio controller auxiliary device enumerated by the
 auxiliary bus driver.
In-Reply-To: <CACRpkda5NjddOUdqjg4b9YmJizd7Q0576S-nj4M=aw3xPF2Ywg@mail.gmail.com>
References: <20220824200047.150308-3-kumaravel.thiagarajan@microchip.com>
 <20230217103116.2126311-1-michael@walle.cc>
 <CACRpkda5NjddOUdqjg4b9YmJizd7Q0576S-nj4M=aw3xPF2Ywg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <cbd3adea51843a4528506ded927f1023@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-02-23 11:23, schrieb Linus Walleij:
> On Fri, Feb 17, 2023 at 11:31 AM Michael Walle <michael@walle.cc> 
> wrote:
>> [+ GPIO maintainers]
>> 
>> > PIO function's auxiliary bus driver enumerates separate child devices for
>> > GPIO controller and OTP/EEPROM interface. This gpio driver implemented
>> > based on the gpio framework is loaded for the gpio auxiliary device.
>> >
>> > Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
>> > ---
>> >  MAINTAINERS                                   |   1 +
>> >  drivers/misc/mchp_pci1xxxx/Makefile           |   2 +-
>> >  .../misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c   | 163 ++++++++++++++++++
>> 
>> Why doesn't this file live in the GPIO subsystem? Seems like this 
>> haven't
>> got a proper review from the GPIO people (probably due to the "misc:"
>> subject). Maybe even GPIO_REGMAP could be used.
> 
> I agree, plese resend this patch with the linux-gpio mailing list and 
> the GPIO
> maintainers on CC.

This is already in drivers/misc. There should be a follow up patch.

-michael
