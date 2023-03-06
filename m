Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFD66AB6D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCFHNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCFHNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:13:46 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF2AD3D;
        Sun,  5 Mar 2023 23:13:44 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=0443564136=fe@dev.tdt.de>)
        id 1pZ52Q-000MKE-GB; Mon, 06 Mar 2023 08:13:38 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pZ52P-000MJm-Fi; Mon, 06 Mar 2023 08:13:37 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id ED503240049;
        Mon,  6 Mar 2023 08:13:36 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 5BC8E240040;
        Mon,  6 Mar 2023 08:13:36 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id D65D82D022;
        Mon,  6 Mar 2023 08:13:35 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Mar 2023 08:13:35 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: Re: [PATCH v7 2/2] trigger: ledtrig-tty: add additional modes
In-Reply-To: <be7c90cf-4c65-1cf0-3001-8706415c3d34@kernel.org>
References: <20230222083335.847655-1-fe@dev.tdt.de>
 <20230222083335.847655-3-fe@dev.tdt.de>
 <20230303141139.GP2420672@google.com>
 <be7c90cf-4c65-1cf0-3001-8706415c3d34@kernel.org>
Message-ID: <4e8661601efcdcf8b5a42de8c80ac7d8@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1678086818-C3FE6839-286E5715/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-06 07:57, Jiri Slaby wrote:
> On 03. 03. 23, 15:11, Lee Jones wrote:
>> On Wed, 22 Feb 2023, Florian Eckert wrote:
>>> @@ -113,21 +207,38 @@ static void ledtrig_tty_work(struct work_struct 
>>> *work)
>>>   		trigger_data->tty = tty;
>>>   	}
>>>   -	ret = tty_get_icount(trigger_data->tty, &icount);
>>> -	if (ret) {
>>> -		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped 
>>> polling\n");
>>> -		mutex_unlock(&trigger_data->mutex);
>>> -		return;
>>> -	}
>>> -
>>> -	if (icount.rx != trigger_data->rx ||
>>> -	    icount.tx != trigger_data->tx) {
>>> -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
>>> -
>>> -		trigger_data->rx = icount.rx;
>>> -		trigger_data->tx = icount.tx;
>>> -	} else {
>>> -		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
>>> +	switch (trigger_data->mode) {
>>> +	case TTY_LED_CTS:
>>> +		ledtrig_tty_flags(trigger_data, TIOCM_CTS);
>>> +		break;
>>> +	case TTY_LED_DSR:
>>> +		ledtrig_tty_flags(trigger_data, TIOCM_DSR);
>>> +		break;
>>> +	case TTY_LED_CAR:
>>> +		ledtrig_tty_flags(trigger_data, TIOCM_CAR);
>>> +		break;
>>> +	case TTY_LED_RNG:
>>> +		ledtrig_tty_flags(trigger_data, TIOCM_RNG);
>>> +		break;
>>> +	case TTY_LED_CNT:
>> 
>> I believe this requires a 'fall-through' statement.
> 
> I don't think this is the case. Isn't fallthrough required only in
> cases when there is at least one statement, i.e. a block?

Jiri thanks for the advice

I also understood that I only need the /* Fall through */ comment if I 
also have at least one statement.
Which is not the case there. So I would say that fits.

For all other things, I am in the process of fixing that and sending a 
v8 patchset.

> 
>> Documentation/process/deprecated.rst
>> 
>>> +	default:
>>> +		ret = tty_get_icount(trigger_data->tty, &icount);
>>> +		if (ret) {
>>> +			dev_info(trigger_data->tty->dev, "Failed to get icount, stopped 
>>> polling\n");
>>> +			mutex_unlock(&trigger_data->mutex);
>>> +			return;
>>> +		}
>>> +
