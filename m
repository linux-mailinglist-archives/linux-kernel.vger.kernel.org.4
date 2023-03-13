Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5944C6B79E2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCMOHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCMOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:07:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D545B5FC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:07:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x11so13036520pln.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678716446;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpNmDIT5jExbIEVleb42Psi9b8FogiNN1+q174Ze0To=;
        b=VFC2eSmXAG503SIMXYYmNhpxyAshX+ESHFXxkkMaskT6J2qJ7yvfJ40B4q1gHfMGhL
         S8rb7C7MLsutlQ8iiGRnPBOz2L0fuP1z+PaSkp60vlyMZeF/jWzaL3pB8pXMvPofPk0S
         mkqD9dgEs4Uj3xAlxXJE5S4aVVD7j0ko/qTJ/NCswttK9xNDnRKktsqrt57GN80bs6ky
         y0lC3Xdd+vIuKV6juHWGroQDBXwuZm9ILoQDkuEUbEiimX2YUerunXPdY037l22iBdT+
         KA9XMF1RBD6ZKJjZPyAndPnkM/SBZkqJ7Jc8vyLWnlU/LAZuVN5v3mBHYueCS4T4rSjT
         WPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678716446;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EpNmDIT5jExbIEVleb42Psi9b8FogiNN1+q174Ze0To=;
        b=AH16dB3UW7zHwPo1d8sUAUke+2dZ+DwlWjiq4HM86ICLGA8iV4s9C8Irrcu8aP1d1h
         oz3thXe+gUSbadlfCPDjQ/vobLU5scH6ldqFDCJV95z4d34ikcU8orxo2wHhChH0htzv
         TdqV+s3CPzpvK4LMEfxn6s2xNRGz7lfh794UHJ0asVIsUvYYalhdnu/a54jiVbvAZIEk
         xNOB3DUxmgDRYGU0gdbW3J2VYhJQQU1BZLrwH5a8m3tllXP+beFQBWBBwk8KA7AI/h4o
         7042pbi/qWhAaANeDTtbw4acRhl0FpPRAmtYuJool2rsldMk7f7RhpAuG8KEegF99Bor
         fjgA==
X-Gm-Message-State: AO0yUKUgWsHHzTsFNNK3kq14odpR9k+yyFw3rhMGuWlFebTa00Kedlyq
        k2u3d7Dfaaa/yT2T0F5DbvLV4Q==
X-Google-Smtp-Source: AK7set9mmNIvJzKbRr8sSYGCHS2NczcLqdaRVqEotjRTBNz1Zz7QFbJnhFtCpJVBuk1mVXIpRuJOfg==
X-Received: by 2002:a05:6a20:6a1d:b0:c7:6f26:ca0 with SMTP id p29-20020a056a206a1d00b000c76f260ca0mr36520088pzk.54.1678716446279;
        Mon, 13 Mar 2023 07:07:26 -0700 (PDT)
Received: from [10.200.11.19] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id i26-20020aa7909a000000b005a8b28c644esm4488847pfa.4.2023.03.13.07.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 07:07:25 -0700 (PDT)
Message-ID: <5a0698e9-cd01-714d-2c46-36397444d17a@bytedance.com>
Date:   Mon, 13 Mar 2023 22:07:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] maple_tree: Simplify mas_wr_node_walk()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
 <20230310140848.94485-3-zhangpeng.00@bytedance.com>
 <20230310192004.iruharoxh5lajg7g@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230310192004.iruharoxh5lajg7g@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/11 03:20, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230310 09:09]:
>> Simplify code of mas_wr_node_walk() without changing functionality,
>> and improve readability.
> The change log needs to be updated to

Hi,

Update to what? Did you not finish typing?

>
> I like this change, thanks.
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 34 +++++-----------------------------
>>   1 file changed, 5 insertions(+), 29 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index b3164266cfde..4d15202a0692 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -2251,9 +2251,7 @@ static inline struct maple_enode *mte_node_or_none(struct maple_enode *enode)
>>   static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
>>   {
>>   	struct ma_state *mas = wr_mas->mas;
>> -	unsigned char count;
>> -	unsigned char offset;
>> -	unsigned long index, min, max;
>> +	unsigned char count, offset;
>>   
>>   	if (unlikely(ma_is_dense(wr_mas->type))) {
>>   		wr_mas->r_max = wr_mas->r_min = mas->index;
>> @@ -2266,34 +2264,12 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
>>   	count = wr_mas->node_end = ma_data_end(wr_mas->node, wr_mas->type,
>>   					       wr_mas->pivots, mas->max);
>>   	offset = mas->offset;
>> -	min = mas_safe_min(mas, wr_mas->pivots, offset);
>> -	if (unlikely(offset == count))
>> -		goto max;
>> -
>> -	max = wr_mas->pivots[offset];
>> -	index = mas->index;
>> -	if (unlikely(index <= max))
>> -		goto done;
>> -
>> -	if (unlikely(!max && offset))
>> -		goto max;
>>   
>> -	min = max + 1;
>> -	while (++offset < count) {
>> -		max = wr_mas->pivots[offset];
>> -		if (index <= max)
>> -			goto done;
>> -		else if (unlikely(!max))
>> -			break;
>> -
>> -		min = max + 1;
>> -	}
>> +	while (offset < count && mas->index > wr_mas->pivots[offset])
>> +		offset++;
>>   
>> -max:
>> -	max = mas->max;
>> -done:
>> -	wr_mas->r_max = max;
>> -	wr_mas->r_min = min;
>> +	wr_mas->r_max = offset < count ? wr_mas->pivots[offset] : mas->max;
>> +	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, offset);
>>   	wr_mas->offset_end = mas->offset = offset;
>>   }
>>   
>> -- 
>> 2.20.1
>>
