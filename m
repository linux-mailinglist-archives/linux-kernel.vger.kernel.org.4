Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC3F661F26
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjAIHXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbjAIHWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:22:52 -0500
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A8F12767;
        Sun,  8 Jan 2023 23:22:48 -0800 (PST)
Message-ID: <ca5e2372-073d-b501-dd5b-0e9d815ab9b2@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1673248967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qi7XWMTLxe25hXbTV7C8cWw5otw2UzqwTCA5OnSGc/o=;
        b=IFGV2d8OYWAVr5WNLmQfhlTKLgFIGxz4gTkJePFN1wAInQBqCX0n0qLWoyzCGO4yzOhy+Y
        bt310m//7Bo5tKdMsG8tH48MISPE55ZfXiylbrOrpVAR8mYSJi6dTwVun7B79GEOheett1
        b9MrEel8Lj1dCDHw05JtemGD/5PzCqsyO2Sk3Ny+En9CZByKmDs2HZQhk7LXJ9fT4NfaLA
        b771/cMsKUTylApcASC4EAlzKnOOHIqBYoWPglVciJS8RWcWP5NlTzJNRC4Of6dSehvbKl
        z1NDFQj7pua++x2Iavqxe3zEVOL8l3oKs7TRiULzarpCWWxNzw1xWWdyxyTzwQ==
Date:   Mon, 9 Jan 2023 08:22:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] serial: atmel: fix incorrect baudrate setup
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230109070200.200181-1-t.schramm@manjaro.org>
 <Y7u9SAX++YsXvnVC@kroah.com>
Content-Language: en-US-large
From:   Tobias Schramm <t.schramm@manjaro.org>
In-Reply-To: <Y7u9SAX++YsXvnVC@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 09.01.23 um 08:07 schrieb Greg Kroah-Hartman:
> On Mon, Jan 09, 2023 at 08:02:00AM +0100, Tobias Schramm wrote:
>> Commit ba47f97a18f2 ("serial: core: remove baud_rates when serial console
>> setup") changed uart_set_options to select the correct baudrate
>> configuration based on the absolute error between requested baudrate and
>> available standard baudrate settings.
>> Prior to that commit the baudrate was selected based on which predefined
>> standard baudrate did not exceed the requested baudrate.
>> This change of selection logic was never reflected in the atmel serial
>> driver. Thus the comment left in the atmel serial driver is no longer
>> accurate.
>> Additionally the manual rounding up described in that comment and applied
>> via (quot - 1) requests an incorrect baudrate. Since uart_set_options uses
>> tty_termios_encode_baud_rate to determine the appropriate baudrate flags
>> this can cause baudrate selection to fail entirely because
>> tty_termios_encode_baud_rate will only select a baudrate if relative error
>> between requested and selected baudrate does not exceed +/-2%.
>> Fix that by requesting actual, exact baudrate used by the serial.
>>
>> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
>> ---
> What commit id does this fix?  Please list that as a the "Fixes:" tag.

Commit ba47f97a18f2 ("serial: core: remove baud_rates when serial console
setup") is the one that breaks the assumptions made in the driver.
I'll send a v2 and include that.

>
> Also, does this need to go to older/stable kernels?
Yep,  this should go to older kernels as a fix, too.
>
> thanks,
>
> greg k-h
