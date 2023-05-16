Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F8770464F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjEPH1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjEPH1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:27:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9B592
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:27:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643912bca6fso10785607b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684222054; x=1686814054;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VrihHlX4gfqH1aDetunLHoNMhaVXNYRIMdChx9m30s=;
        b=C5zki00OG/Di/cP+PHSnsCOkSCPbwkL4V81xLbfY4pVggsLfdhYrskvUIALYYFgql6
         4gJqNkWTfTYZofZdCzKb3LABW4xcuqkL4A3fOK6hOUmEKUn0PhouTh/3QB8i4JSyqlQq
         G25+HtHqiwNVmHPkr/4aORinBDAQE+ckCW+eriH7AfPr+AWdFHjnou/WxnrZdFJB93Mr
         52XHHE9BUlRe9djIkCBmR4vQfSg3BKd7LAdz+zhw6NY+EwkbNUPlMUny45/n/13ORKCR
         nuL5XG90LWPhvKwXDYjv3Asc4n8XdNsePhSv/KTlkHc9VHMzCfRbR5iz5y68/ZvPd1xk
         tdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684222054; x=1686814054;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3VrihHlX4gfqH1aDetunLHoNMhaVXNYRIMdChx9m30s=;
        b=ZDYRfKzCfl/4MiKp7zSC1Zk+znpU050SitLLNV+JpAHHA3Nj3OpHKx/UdOKR9rimfC
         E1BBUi9uHnuoU0iqBNzExOTIp2Etg96YSiZ9Z8620ksokguPxRoVeDiHBxoo6a/xkxVm
         atL5YSU83m6J6Bv2oTPu1S6JZy+yLCjXXUKzgWkIn+pCUwUCI4lGrCloWoi0EATmtknZ
         BN7J/JpNV5O/Bai66P8vpO1LrniDXOesMb3k2sqsb0v//EqWtI9HcGmcjzLA5+vwx3IS
         btNWaXwkpqEN6izJhR4b5w2raarCo5EuyP2xr7Rcsx6M5Z5QS24RUbRuBwYYYOy1I/9W
         rtCg==
X-Gm-Message-State: AC+VfDyyM671hBNV/UFWOsBY+FYXYR7NnM3n3lAxeBWOREULptuxuGWq
        kJtYKT9MiYG6BOpt0mmk4yYnTw==
X-Google-Smtp-Source: ACHHUZ4Ij3/JcncsA3FDxe3yhdEY6/kPht/VxPatiLCmVCATaxIua2fY071UHEQt47R+beIWtFjjAA==
X-Received: by 2002:a05:6a00:1821:b0:644:d77:a2c5 with SMTP id y33-20020a056a00182100b006440d77a2c5mr50250878pfa.29.1684222054509;
        Tue, 16 May 2023 00:27:34 -0700 (PDT)
Received: from [10.200.9.178] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id s26-20020aa7829a000000b0063b6cccd5dcsm12429514pfm.194.2023.05.16.00.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:27:34 -0700 (PDT)
Message-ID: <4e40b88c-4419-56df-d720-177cf76e95a6@bytedance.com>
Date:   Tue, 16 May 2023 15:27:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 09/10] maple_tree: Rework mas_wr_slot_store() to be
 cleaner and more efficient.
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-10-zhangpeng.00@bytedance.com>
 <20230515180147.hgwk2vccsph7poxa@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
In-Reply-To: <20230515180147.hgwk2vccsph7poxa@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/16 02:01, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
>> The code of mas_wr_slot_store() is messy, make it clearer and concise,
>> and add comments. In addition, get whether the two gaps are empty to
>> avoid calling mas_update_gap() all the time.
> 
> Please drop the cases from the comments.  These aren't that complicated
> to need diagrams.
> 
> Case 1: Overwriting the range and over a part of the next range
> Case 2: Overwriting a part of the range and over the entire next range
> 
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 79 +++++++++++++++++++++++++++---------------------
>>   1 file changed, 44 insertions(+), 35 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 538e49feafbe4..d558e7bcb6da8 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -4190,53 +4190,62 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>>    * @wr_mas: the maple write state
>>    *
>>    * Return: True if stored, false otherwise
>> + *
>> + * Case 1:
>> + *                       r_min   r_max    lmax
>> + *                 +-------+-------+-------+
>> + * original range: |       |offset | end   |
>> + *                 +-----------------------+
>> + *                         +-----------+
>> + * overwrite:              |           |
>> + *                         +-----------+
>> + *                        index       last
>> + *
>> + * Case 2:
>> + *                       r_min   r_max    lmax
>> + *                 +-------+-------+-------+
>> + * original range: |       |offest | end   |
>> + *                 +-------+---------------+
>> + *                             +-----------+
>> + * overwrite:                  |           |
>> + *                             +-----------+
>> + *                           index        last
>>    */
>>   static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
>>   {
>>   	struct ma_state *mas = wr_mas->mas;
>> -	unsigned long lmax; /* Logical max. */
>>   	unsigned char offset = mas->offset;
>> +	unsigned char offset_end = wr_mas->offset_end;
>> +	unsigned long lmax = wr_mas->end_piv; /* Logical max. */
>> +	bool gap = false;
>>   
>> -	if ((wr_mas->r_max > mas->last) && ((wr_mas->r_min != mas->index) ||
>> -				  (offset != wr_mas->node_end)))
>> -		return false;
>> -
>> -	if (offset == wr_mas->node_end - 1)
>> -		lmax = mas->max;
>> -	else
>> -		lmax = wr_mas->pivots[offset + 1];
>> -
>> -	/* going to overwrite too many slots. */
>> -	if (lmax < mas->last)
>> +	if (offset_end - offset != 1)
>>   		return false;
>>   
>> -	if (wr_mas->r_min == mas->index) {
>> -		/* overwriting two or more ranges with one. */
>> -		if (lmax == mas->last)
>> -			return false;
>> -
>> -		/* Overwriting all of offset and a portion of offset + 1. */
>> +	if (mas->index == wr_mas->r_min && mas->last < lmax) {
>> +		/* Case 1 */
>> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
>> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
>>   		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
>>   		wr_mas->pivots[offset] = mas->last;
>> -		goto done;
>> -	}
>> -
>> -	/* Doesn't end on the next range end. */
>> -	if (lmax != mas->last)
>> +	} else if (mas->index > wr_mas->r_min && mas->last == lmax) {
>> +		/* Case 2 */
>> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
>> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
>> +		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
>> +		wr_mas->pivots[offset] = mas->index - 1;
> 
> These two lines need to be in opposite order to ensure a reader sees
> either the value or the previous value.  If you overwrite something with
> a new value, it is possible that a reader looking for the next range
> will get the value stored at offset (but not entry).
Please think again, did you think wrong?
It doesn't happen, swapping the order introduces the problem.
If we update the pivot first, it will cause a part of the value
of the range indexed by offset to change to the value of the
range indexed by offset+1, which is illegal.

My assignment order remains the same as the previous version.

> 
>> +		mas->offset++; /* Keep mas accurate. */
>> +	} else {
>>   		return false;
>> +	}
>>   
>> -	/* Overwriting a portion of offset and all of offset + 1 */
>> -	if ((offset + 1 < mt_pivots[wr_mas->type]) &&
>> -	    (wr_mas->entry || wr_mas->pivots[offset + 1]))
>> -		wr_mas->pivots[offset + 1] = mas->last;
>> -
>> -	rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
>> -	wr_mas->pivots[offset] = mas->index - 1;
>> -	mas->offset++; /* Keep mas accurate. */
>> -
>> -done:
>>   	trace_ma_write(__func__, mas, 0, wr_mas->entry);
>> -	mas_update_gap(mas);
>> +	/*
>> +	 * Only update gap when the new entry is empty or there is an empty
>> +	 * entry in the original two ranges.
>> +	 */
>> +	if (!wr_mas->entry || gap)
>> +		mas_update_gap(mas);
>>   	return true;
>>   }
>>   
>> @@ -4418,7 +4427,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>>   	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
>>   		return;
>>   
>> -	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
>> +	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
>>   		return;
>>   	else if (mas_wr_node_store(wr_mas))
>>   		return;
>> -- 
>> 2.20.1
>>
> 
