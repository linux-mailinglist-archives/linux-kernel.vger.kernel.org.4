Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7993735D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjFSSUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjFSSUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:20:12 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF8B91
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:20:11 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id BJU0qoYbZd5eyBJU0qfXGy; Mon, 19 Jun 2023 20:20:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687198809;
        bh=B/5FlROG/rPtzenJfdhoEzxZ2T0c2ssP3WxBw8vESxo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Pcjw461124GvHKxG5bilxvynrtkMKBkffxsU3Wl2J5YDmJfcUIDzAhVK7LkO6KVMh
         tWFn572qgb1PKTfxHNdHC4954DTdzodhANTteaM58M2aCrOINi1nlgpmTZX9Vpownt
         AqFr6zvMdCnwV22bEn+koqORjAoSFyh/PfI9UXIBTqV0h7EUGYzqY9BNtV6ePPI8SY
         xy7IsgKWWyZS6ca8WLPH4Ep6rqKMfBcT2bYV+uFusHAXkedG6bt3enSF2iMbMs+X4e
         wR8SR8vOal3363fSlqiZ8U9/+S6gmSPHIkc7ndp1sk7cUR47hGoX8QfjRMAfxj0tt+
         PE52QRzb4DZxQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Jun 2023 20:20:09 +0200
X-ME-IP: 86.243.2.178
Message-ID: <ba1a74ba-e91a-bf12-2d4e-7157e4519478@wanadoo.fr>
Date:   Mon, 19 Jun 2023 20:20:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] HID: Reorder fields in 'struct hid_field'
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
References: <a804f2e91bc32cc5e17e012ed90972415606db4e.1687075665.git.christophe.jaillet@wanadoo.fr>
 <d6026b7f-dc07-4d0c-9805-cc61d6b9a4b8@kadam.mountain>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <d6026b7f-dc07-4d0c-9805-cc61d6b9a4b8@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/06/2023 à 07:18, Dan Carpenter a écrit :
> On Sun, Jun 18, 2023 at 10:08:07AM +0200, Christophe JAILLET wrote:
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index 39e21e3815ad..5be5e671c263 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -480,9 +480,9 @@ struct hid_field {
>>   	__s32     physical_maximum;
>>   	__s32     unit_exponent;
>>   	unsigned  unit;
>> -	bool      ignored;		/* this field is ignored in this event */
>>   	struct hid_report *report;	/* associated report */
>>   	unsigned index;			/* index into report->field[] */
>> +	bool      ignored;		/* this field is ignored in this event */
>>   	/* hidinput data */
>>   	struct hid_input *hidinput;	/* associated input structure */
>>   	__u16 dpad;			/* dpad input code */
> 
> You could move the dpad next to the ignored to save another 4 bytes.
> I think it is still grouped logically that way but I don't really know
> what dpad is so I might be wrong.
> 
>    	struct hid_report *report;	/* associated report */
>    	unsigned index;			/* index into report->field[] */
> 	bool      ignored;		/* this field is ignored in this event */
>   	/* hidinput data */
>    	__u16 dpad;			/* dpad input code */
>    	struct hid_input *hidinput;	/* associated input structure */
> 
> regards,
> dan carpenter
> 
> 

In fact, not really,
It would fill a hole better, but would generate some padding at the end 
of the struct:

	bool                       ignored;              /*   108     1 */

	/* XXX 1 byte hole, try to pack */

	__u16                      dpad;                 /*   110     2 */
	struct hid_input *         hidinput;             /*   112     8 */
	unsigned int               slot_idx;             /*   120     4 */

	/* size: 128, cachelines: 2, members: 25 */
	/* sum members: 119, holes: 2, sum holes: 5 */
	/* padding: 4 */
};

CJ
