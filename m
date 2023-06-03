Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1772102A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjFCNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFCNWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 09:22:24 -0400
X-Greylist: delayed 270 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Jun 2023 06:22:23 PDT
Received: from sasl.smtp.pobox.com (pb-sasl1.pobox.com [64.147.108.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300C1C2;
        Sat,  3 Jun 2023 06:22:23 -0700 (PDT)
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-sasl1.pobox.com (Postfix) with ESMTP id 9C58D996A3;
        Sat,  3 Jun 2023 09:17:50 -0400 (EDT)
        (envelope-from mlord@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=subject:to
        :cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=OZUDGYxRTwe6
        bb82E3UXGydn6LlFxW0xP2ntyWrNLkI=; b=Ysv8gOvUXWDhc2szzbDZ6FjR8VWk
        uiL7x05oQ7ohLe4uuH01lHPcqvGBWC5DwYn/P59IbCNm0JrrmvLErok/kDaldnAl
        OO5/Lx8zelINeM+KnVx5humJRaXb7WkyQ/7qAHYIp7gDeIFfUTzdoa1vQDBCcXrs
        3RPbDx8q52Dj8yg=
Received: from pb-sasl1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-sasl1.pobox.com (Postfix) with ESMTP id 89018996A0;
        Sat,  3 Jun 2023 09:17:50 -0400 (EDT)
        (envelope-from mlord@pobox.com)
Received: from [10.0.0.9] (unknown [24.156.181.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-sasl1.pobox.com (Postfix) with ESMTPSA id 8DEB69969E;
        Sat,  3 Jun 2023 09:17:49 -0400 (EDT)
        (envelope-from mlord@pobox.com)
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
To:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
From:   Mark Lord <mlord@pobox.com>
Message-ID: <ccae168a-4be0-f085-8d8e-03bfbd71ac8f@pobox.com>
Date:   Sat, 3 Jun 2023 09:17:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 09FCAC5E-0211-11EE-B4CA-8E2B5958DECB-82205200!pb-sasl1.pobox.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-03 08:41 AM, Jiri Kosina wrote:
> On Wed, 31 May 2023, Jiri Kosina wrote:
> 
>>> If an attempt at contacting a receiver or a device fails because the
>>> receiver or device never responds, don't restart the communication, only
>>> restart it if the receiver or device answers that it's busy, as originally
>>> intended.
>>>
>>> This was the behaviour on communication timeout before commit 586e8fede795
>>> ("HID: logitech-hidpp: Retry commands when device is busy").
>>>
>>> This fixes some overly long waits in a critical path on boot, when
>>> checking whether the device is connected by getting its HID++ version.
>>>
>>> Signed-off-by: Bastien Nocera <hadess@hadess.net>
>>> Suggested-by: Mark Lord <mlord@pobox.com>
>>> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217412
>>> ---
>>>  drivers/hid/hid-logitech-hidpp.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
>>> index 0fcfd85fea0f..2246044b1639 100644
>>> --- a/drivers/hid/hid-logitech-hidpp.c
>>> +++ b/drivers/hid/hid-logitech-hidpp.c
>>> @@ -314,6 +314,7 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
>>>  			dbg_hid("%s:timeout waiting for response\n", __func__);
>>>  			memset(response, 0, sizeof(struct hidpp_report));
>>>  			ret = -ETIMEDOUT;
>>> +			goto exit;
>>>  		}
>>>  
>>
>> I have applied this even before getting confirmation from the reporters in 
>> bugzilla, as it's the right thing to do anyway.
> 
> Unfortunately it doesn't seem to cure the reported issue (while reverting 
> 586e8fede79 does): https://bugzilla.kernel.org/show_bug.cgi?id=217523#c2

I wonder if this code could be re-worked to not even do this (waiting)
from the _probe() function?  It ought to be able to throw it on a workqueue
or something, rather than stalling system boot for a minimum of 5-seconds
(or much longer as as-is).
-- 
Mark Lord
