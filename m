Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CF66F0751
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbjD0O00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243662AbjD0O0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:26:23 -0400
Received: from www484.your-server.de (www484.your-server.de [78.47.237.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518BA83;
        Thu, 27 Apr 2023 07:26:11 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www484.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <k.graefe@gateware.de>)
        id 1ps2ZS-0008uX-8N; Thu, 27 Apr 2023 16:26:06 +0200
Received: from [2003:ca:6730:e8f8:a2c4:4e1c:f83c:db4b]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <k.graefe@gateware.de>)
        id 1ps2ZR-0009eG-Hz; Thu, 27 Apr 2023 16:26:05 +0200
Message-ID: <b8ca96d0-d1e3-4f2f-5541-a6c82489243a@gateware.de>
Date:   Thu, 27 Apr 2023 16:26:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@ti.com>
Cc:     stable@vger.kernel.org
References: <2023042625-rendition-distort-fe06@gregkh>
 <20230427115120.241954-1-k.graefe@gateware.de>
 <d1a14976-5f53-3373-0695-e10e6a9371de@rasmusvillemoes.dk>
Content-Language: en-US
From:   =?UTF-8?Q?Konrad_Gr=c3=a4fe?= <k.graefe@gateware.de>
In-Reply-To: <d1a14976-5f53-3373-0695-e10e6a9371de@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: k.graefe@gateware.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26889/Thu Apr 27 09:25:48 2023)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        NO_DNS_FOR_FROM,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.04.23 14:35, Rasmus Villemoes wrote:
> On 27/04/2023 13.51, Konrad Gräfe wrote:
>> The CDC-ECM specification requires an USB gadget to send the host MAC
>> address as uppercase hex string. This change adds the appropriate
>> modifier.
>>
>> Cc: stable@vger.kernel.org
> 
> Why cc stable?

I believe the second patch matches the criteria but it uses this one.

> 
>> Signed-off-by: Konrad Gräfe <k.graefe@gateware.de>
>> ---
>> Added in v3
>>
>>   lib/vsprintf.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> The diffstat here, or for some other patch in the same series,
> definitely ought to mention lib/test_printf.c.
> 
>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>> index be71a03c936a..8aee1caabd9e 100644
>> --- a/lib/vsprintf.c
>> +++ b/lib/vsprintf.c
>> @@ -1269,9 +1269,10 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
>>   {
>>   	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
>>   	char *p = mac_addr;
>> -	int i;
>> +	int i, pos;
>>   	char separator;
>>   	bool reversed = false;
>> +	bool uppercase = false;
>>   
>>   	if (check_pointer(&buf, end, addr, spec))
>>   		return buf;
>> @@ -1281,6 +1282,10 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
>>   		separator = '-';
>>   		break;
>>   
>> +	case 'U':
>> +		uppercase = true;
>> +		break;
>> +
>>   	case 'R':
>>   		reversed = true;
>>   		fallthrough;
> 
> This seems broken, and I'm surprised the compiler doesn't warn about
> separator possibly being uninitialized further down. I'm also surprised
> your testing hasn't caught this. For reference, the full switch
> statement is currently
> 
>          switch (fmt[1]) {
>          case 'F':
>                  separator = '-';
>                  break;
> 
>          case 'R':
>                  reversed = true;
>                  fallthrough;
> 
>          default:
>                  separator = ':';
>                  break;
>          }
> 
>> @@ -1292,9 +1297,14 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
>>   
>>   	for (i = 0; i < 6; i++) {
>>   		if (reversed)
>> -			p = hex_byte_pack(p, addr[5 - i]);
>> +			pos = 5 - i;
>> +		else
>> +			pos = i;
>> +
>> +		if (uppercase)
>> +			p = hex_byte_pack_upper(p, addr[pos]);
>>   		else
>> -			p = hex_byte_pack(p, addr[i]);
>> +			p = hex_byte_pack(p, addr[pos]);
> 
> I think this becomes quite hard to follow. We have string_upper() in
> linux/string_helpers.h, so I'd rather just leave this loop alone and do
> 
>    if (uppercase)
>      string_upper(mac_addr, mac_addr);
> 
> after the nul-termination.
> 
> Rasmus
> 
