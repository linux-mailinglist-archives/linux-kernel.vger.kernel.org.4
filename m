Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27033680689
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjA3Hez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjA3Hev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:34:51 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F8193D7;
        Sun, 29 Jan 2023 23:34:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VaP80-u_1675064083;
Received: from 30.240.100.113(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VaP80-u_1675064083)
          by smtp.aliyun-inc.com;
          Mon, 30 Jan 2023 15:34:44 +0800
Message-ID: <c7dbadbf-dade-fb1e-bda3-d23d567c620f@linux.alibaba.com>
Date:   Mon, 30 Jan 2023 15:34:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] crypto: arm64/sm4 - Fix possible crash in GCM cryption
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230118141928.48136-1-tianjia.zhang@linux.alibaba.com>
 <Y8gIC8Yn/E8Kwtf0@gondor.apana.org.au>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <Y8gIC8Yn/E8Kwtf0@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 1/18/23 10:54 PM, Herbert Xu wrote:
> On Wed, Jan 18, 2023 at 10:19:28PM +0800, Tianjia Zhang wrote:
>> When the cryption total length is zero, GCM cryption call
>> skcipher_walk_done() will cause an unexpected crash, so skip calling
>> this function to avoid possible crash when the GCM cryption length
>> is equal to zero.
>>
>> Fixes: ae1b83c7d572 ("crypto: arm64/sm4 - add CE implementation for GCM mode")
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   arch/arm64/crypto/sm4-ce-gcm-glue.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/crypto/sm4-ce-gcm-glue.c b/arch/arm64/crypto/sm4-ce-gcm-glue.c
>> index c450a2025ca9..9b63bcf9aa85 100644
>> --- a/arch/arm64/crypto/sm4-ce-gcm-glue.c
>> +++ b/arch/arm64/crypto/sm4-ce-gcm-glue.c
>> @@ -178,11 +178,13 @@ static int gcm_crypt(struct aead_request *req, struct skcipher_walk *walk,
>>   
>>   		kernel_neon_end();
>>   
>> -		err = skcipher_walk_done(walk, tail);
>> -		if (err)
>> -			return err;
>> -		if (walk->nbytes)
>> -			kernel_neon_begin();
>> +		if (walk->nbytes) {
> 
> Please do
> 		if (!walk->nbytes)
> 			break;

Thanks for the suggestion, a new patch has been sent.

> 
> As an additional improvement, the tail calculation can be removed
> entirely because you already set the chunksize so the walker should
> only be feeding you multiples of chunksize except at the end.
> 
> Cheers
I printed the walk->nbytes of each iteration of the walker, it is not
always multiples of chunksize except at the end when the algorithm test
manager is turned on.

For example, during a GCM encryption process, I get data like this:

     total = 4014, nbytes = 2078, tail = 14
     total = 1950, nbytes = 16, tail = 0
     total = 1934, nbytes = 311, tail = 7
     total = 1630, nbytes = 16, tail = 0
     total = 1614, nbytes = 16, tail = 0
     total = 1598, nbytes = 1598, tail = 14

Is my understanding wrong?

Best regards,
Tianjia
