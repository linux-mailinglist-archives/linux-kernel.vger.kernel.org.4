Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C951F60C58D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiJYHlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiJYHlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:41:03 -0400
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239221162C5;
        Tue, 25 Oct 2022 00:41:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VT2-i3n_1666683654;
Received: from 30.240.99.167(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VT2-i3n_1666683654)
          by smtp.aliyun-inc.com;
          Tue, 25 Oct 2022 15:40:57 +0800
Message-ID: <93a9e613-c4ee-e2f8-63d0-45119c031670@linux.alibaba.com>
Date:   Tue, 25 Oct 2022 15:40:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2 12/15] crypto: arm64/sm4 - add CE implementation for
 ESSIV mode
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221018071006.5717-1-tianjia.zhang@linux.alibaba.com>
 <20221018071006.5717-13-tianjia.zhang@linux.alibaba.com>
 <Y1DHb66VYPzFlTwh@sol.localdomain>
 <6d2a98f4-c50d-d05b-4a24-08fdd3ee20fa@linux.alibaba.com>
 <Y1dyNWSdCesQlWm8@sol.localdomain>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <Y1dyNWSdCesQlWm8@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 10/25/22 1:20 PM, Eric Biggers wrote:
> On Fri, Oct 21, 2022 at 10:47:14AM +0800, Tianjia Zhang wrote:
>> Hi Eric,
>>
>> On 10/20/22 11:58 AM, Eric Biggers wrote:
>>> On Tue, Oct 18, 2022 at 03:10:03PM +0800, Tianjia Zhang wrote:
>>>> This patch is a CE-optimized assembly implementation for ESSIV mode.
>>>> The assembly part is realized by reusing the CBC mode.
>>>>
>>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>>
>>> Is there still a use case for CBC-ESSIV mode these days, now that everyone is
>>> using XTS instead?
>>>
>>> - Eric
>>
>> The mainstream is already using XTS, but CBC-ESSIV is still an optional
>> backup algorithm, especially in block crypto and fscrypto, I'm currently
>> working on supporting the SM4 algorithm for these subsystems.
>>
> 
> The only reason that AES-CBC-ESSIV support was added to fs/crypto/ was because
> someone had a low-power embedded device with a hardware crypto accelerator that
> only supported AES-CBC.
> 
> Nothing like that is relevant here, as this is just a software implementation.
> 
> Please just don't include ESSIV.  There's no need to implement random useless
> algorithms.  It could always be added later if a use case actually arises.
> 
> - Eric

Thanks for this information, I will remove the ESSIV code in the next
patch.

Best regards,
Tianjia
