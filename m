Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CBE6C2A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCUGNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCUGNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:13:13 -0400
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9AC31E23;
        Mon, 20 Mar 2023 23:13:09 -0700 (PDT)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 21 Mar
 2023 09:13:06 +0300
Received: from [10.0.253.157] (10.0.253.157) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 21 Mar
 2023 09:13:06 +0300
Message-ID: <2c3701ba-da8e-b67f-059f-79a52f20beec@fintech.ru>
Date:   Mon, 20 Mar 2023 23:13:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] HID: wiimote: check completion in
 wiimod_battery_get_property
To:     David Rheinsberg <david.rheinsberg@gmail.com>
CC:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <20230320153419.9185-1-n.zhandarovich@fintech.ru>
 <CADyDSO6nvFaC8dZKuSYcqgdiL8oub+eKU-PqYSeH2cXnVw-=Uw@mail.gmail.com>
Content-Language: en-US
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <CADyDSO6nvFaC8dZKuSYcqgdiL8oub+eKU-PqYSeH2cXnVw-=Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.253.157]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/23 12:08, David Rheinsberg wrote:
> Hi
> 
> On Mon, 20 Mar 2023 at 16:34, Nikita Zhandarovich
> <n.zhandarovich@fintech.ru> wrote:
>>
>> wiimote_cmd_wait() in wiimod_battery_get_property() may signal that the
>> task of getting specific battery property was interrupted or timed out.
>> There is no need to do any further computation in such cases, so just
>> return the error.
>>
>> Found by Linux Verification Center (linuxtesting.org) with static
>> analysis tool SVACE.
>>
>> Fixes: dcf392313817 ("HID: wiimote: convert BATTERY to module")
>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>> ---
>>  drivers/hid/hid-wiimote-modules.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
>> index dbccdfa63916..9755718d9856 100644
>> --- a/drivers/hid/hid-wiimote-modules.c
>> +++ b/drivers/hid/hid-wiimote-modules.c
>> @@ -220,8 +220,10 @@ static int wiimod_battery_get_property(struct power_supply *psy,
>>         wiiproto_req_status(wdata);
>>         spin_unlock_irqrestore(&wdata->state.lock, flags);
>>
>> -       wiimote_cmd_wait(wdata);
>> +       ret = wiimote_cmd_wait(wdata);
>>         wiimote_cmd_release(wdata);
>> +       if (ret)
>> +               return ret;
> 
> The current code returns cached battery-information in case a
> synchronous update did not succeed. Battery information is likely
> updated regularly, anyway, so the synchronous update is usually not
> required.
> 
> I don't think bailing out and returning the error to the caller is
> required or gains us anything but more complexity. Or am I missing
> something here?
> 
> Thanks
> David

Hi. I think you are right, my change is not that essential to begin with
and there is no urgency to patch this.

Thanks for your patience,
Nikita
