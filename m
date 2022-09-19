Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BB75BD3C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiISRdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiISRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:33:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB143D594
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:33:33 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id aKeAoPhYzAOp2aKeAoyF6y; Mon, 19 Sep 2022 19:33:31 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Sep 2022 19:33:31 +0200
X-ME-IP: 90.11.190.129
Message-ID: <e4914aa5-3e42-235c-fd9e-65a907a92842@wanadoo.fr>
Date:   Mon, 19 Sep 2022 19:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Input: applespi - avoid wasting some memory
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
References: <0db94f84920663f3bd45a73e2ae73950627a377f.1663506472.git.christophe.jaillet@wanadoo.fr>
 <YygUFr5cSpZhYKOA@hovoldconsulting.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YygUFr5cSpZhYKOA@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/09/2022 à 09:02, Johan Hovold a écrit :
> On Sun, Sep 18, 2022 at 03:08:17PM +0200, Christophe JAILLET wrote:
>> When the 'struct applespi_data' structure is allocated at the beginning of
>> applespi_probe(), 2504 bytes are allocated.
>>
>> Because of the way memory is allocated, it ends to a 4096 bytes allocation.
>> So, about 1500 bytes are wasted.
>>
>> Later in this function, when 'tx_buffer', 'tx_status', 'rx_buffer' and
>> 'msg_buf' are allocated, 256, 4, 256 and 512 bytes are requested (~1 ko).
>> A devm_ memory allocation has a small overhead of 40 bytes. So, for the
>> same reason as above, it ends to allocate 512, 64, 512 and 1024 (~2 ko).
>>
>> All that said, defining these 4 arrays as part of 'struct applespi_data'
>> saves 2 ko of runtime memory.
>>
>> 3504 bytes are now requested, and 4096 really allocated. All these 4
>> arrays fit in the 'wasted' memory of the first allocation.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested only.
>> ---
>>   drivers/input/keyboard/applespi.c | 23 ++++-------------------
>>   1 file changed, 4 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
>> index fab5473ae5da..bee4ccfa2b05 100644
>> --- a/drivers/input/keyboard/applespi.c
>> +++ b/drivers/input/keyboard/applespi.c
>> @@ -373,11 +373,11 @@ struct applespi_data {
>>   	struct input_dev		*keyboard_input_dev;
>>   	struct input_dev		*touchpad_input_dev;
>>   
>> -	u8				*tx_buffer;
>> -	u8				*tx_status;
>> -	u8				*rx_buffer;
>> +	u8				tx_buffer[APPLESPI_PACKET_SIZE];
>> +	u8				tx_status[APPLESPI_STATUS_SIZE];
>> +	u8				rx_buffer[APPLESPI_PACKET_SIZE];
>>   
>> -	u8				*msg_buf;
>> +	u8				msg_buf[MAX_PKTS_PER_MSG * APPLESPI_PACKET_SIZE];
>>   	unsigned int			saved_msg_len;
>>   
>>   	struct applespi_tp_info		tp_info;
> 
> This kind of change is generally broken in case DMA can be involved.
> 
> Allocating the transfer buffers separately makes sure that alignment
> requirements are met and avoids hard-to-debug memory corruption issues.
> 
> Johan
> 

Got it. I'll keep away from it.

Thanks for the feed-back and explanation.

CJ
