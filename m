Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAE6ABCBF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCFKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjCFKa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:30:29 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3362365B;
        Mon,  6 Mar 2023 02:29:59 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=0443564136=fe@dev.tdt.de>)
        id 1pZ7pZ-0008Sa-Ue; Mon, 06 Mar 2023 11:12:33 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pZ7pZ-000KIO-5R; Mon, 06 Mar 2023 11:12:33 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id B9CB8240049;
        Mon,  6 Mar 2023 11:12:32 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 30F6D240040;
        Mon,  6 Mar 2023 11:12:32 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id E542B20806;
        Mon,  6 Mar 2023 11:12:31 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Mar 2023 11:12:31 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH v7 2/2] trigger: ledtrig-tty: add additional modes
In-Reply-To: <20230306093524.amm7o4ppa7gon4ew@pengutronix.de>
References: <20230222083335.847655-1-fe@dev.tdt.de>
 <20230222083335.847655-3-fe@dev.tdt.de>
 <20230306093524.amm7o4ppa7gon4ew@pengutronix.de>
Message-ID: <706dcb23af15223489dd7d0d34f5a64c@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate: clean
X-purgate-ID: 151534::1678097553-AA6876AC-A6198408/0/0
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

>> +		  LED on if line is high.
>> +		* RNG:   DCE has detected an incoming ring signal.
>> +		  LED on if line is high.
> 
> Something I (still) don't like about this approach is that you cannot
> make the LED flash on TX only (or CAR and DSR). Something like:
> 
> 	led=/sys/class/leds/<led>/
> 	echo 1 > $led/TX
> 	echo 0 > $led/RX
> 	echo 1 > $led/CAR
> 
> would be a more flexible and IMHO nicer interface. (Maybe with improved
> file names.)

The question is whether it makes sense to combine several states on one
LED. We can add TTY_LED_RX or TTY_LED_TX to meet your requirements.
The only led trigger I know that combines multiple states is 
ledtrig-netdev.

If so, I can only imagine that we handle it the same way as with
ledtrig-netdev. For the states CTS/DSR/CAR/RNG, the LED goes on or off
and when data is transmitted (rx/tx), the LED flashes.

I have personally have a usecase where I need to indicate whether
I am getting CTS from the mode or not.

If that's how we want to do it, then I can only imagine that:

led=/sys/class/leds/<led>/
  	echo 1 > $led/rx
  	echo 0 > $led/tx
  	echo <CTS|DSR|CAR|RNG> > $led/tty_led_mode

I think it only makes sense to always display only one mode

This are "CTS|DSR|CAR|RNG".


Personally, I think
it complicates things because the LED shows several states.

Best regards
Florian
