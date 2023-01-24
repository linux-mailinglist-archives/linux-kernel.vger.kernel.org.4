Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61882679F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbjAXQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjAXQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:42:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4D449016;
        Tue, 24 Jan 2023 08:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=f2QwDBCRkjIoI1eRk0NhRpprEVHoo7j/WMAGdB9m0G0=; b=uUa4De/111kykqZ7gkmQCJMCzW
        7gx6TgezII6JxQX6iA23JCjXHBsdP31wU4/RvHVOezOkEW7NbyPRSG5qZkj3UAzog2OxZ8dYtcUur
        AH11JFLzlN8DVZIs+lukDTNF+oC0e+U5akGWlFrA6WNDi9n6jVsYKnNCpabELbwCbTKL3Xs8mGI5Z
        Iv6G9UKv6bE7XeYZGQPM3EW7LE2kWVn8m2Vmn7uv9iSR3eb5MYfvez6yWh2L/EThPDl9APbSI3MPT
        giECdmUoI4pDI6S9prFZUd9beuc2w4/J4wcNwcEh+O6mSG6jLRx7sTGjRKjP1dCBuShl3je/3oG5H
        /ac0fA/w==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKMMN-004i5l-8M; Tue, 24 Jan 2023 16:41:23 +0000
Message-ID: <7c6991e3-9288-d336-d6f9-487e8ce46941@infradead.org>
Date:   Tue, 24 Jan 2023 08:41:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/1] arch/sh: avoid spurious sizeof-pointer-div warning
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <9d3bd61a-725c-db40-b3bd-78460bc7e719@mkarcher.dialup.fu-berlin.de>
 <17abaf48-9ef3-72e2-010a-7e707d253fa8@physik.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <17abaf48-9ef3-72e2-010a-7e707d253fa8@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/23 00:11, John Paul Adrian Glaubitz wrote:
> Hello!
> 
> On 1/23/23 21:05, Michael Karcher wrote:
>> Gcc warns about the pattern sizeof(void*)/sizeof(void), as it looks like
>> the abuse of a pattern to calculate the array size. This pattern appears
>> in the unevaluated part of the ternary operator in _INTC_ARRAY if the
>> parameter is NULL.
>>
>> The replacement uses an alternate approach to return 0 in case of NULL
>> which does not generate the pattern sizeof(void*)/sizeof(void), but still
>> emits the warning if _INTC_ARRAY is called with a nonarray parameter.
>>
>> This patch is required for successful compilation with -Werror enabled.
>>
>> The idea to use _Generic for type distinction is taken from Comment #7
>> inhttps://gcc.gnu.org/bugzilla/show_bug.cgi?id=108483  by Jakub Jelinek
>>
>> Signed-off-by: Michael Karcher<kernel@mkarcher.dialup.fu-berlin.de>
>> ---
>> History:
>> v5:
>>    - Cleanly generated the patch
>> v4:
>>    - Put the case distinction into the numerator instead of the denominator
>>    - Refactor the case disctinction into a second macro
>> v3:
>>    - I had a stern discussion with Thunderbird about not mangling the
>>      space characters in my email, and I hope spaces get sent as standard
>>      spaces now
>> v2:
>>    - improve title and remove mostly redundant first sentence of the
>>      description
>>    - adjust formatting of the _Generic construction
>>
>> diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
>> index c255273b0281..37ad81058d6a 100644
>> --- a/include/linux/sh_intc.h
>> +++ b/include/linux/sh_intc.h
>> @@ -97,7 +97,10 @@ struct intc_hw_desc {
>>          unsigned int nr_subgroups;
>>   };
>>
>> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
>> +#define _INTC_SIZEOF_OR_ZERO(a) (_Generic(a,                 \
>> +                                 typeof(NULL):  0,           \
>> +                                 default:       sizeof(a)))
>> +#define _INTC_ARRAY(a) a, _INTC_SIZEOF_OR_ZERO(a)/sizeof(*a)
>>
>>   #define INTC_HW_DESC(vectors, groups, mask_regs,       \
>>                       prio_regs, sense_regs, ack_regs)   \
> 
> Can anyone suggest which tree to pick this up through until we have established a
> new linux-sh tree?
> 
> Shall this go through Andrew's tree?

I think Andrew or Arnd could merge it.

-- 
~Randy
