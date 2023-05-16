Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA61704A11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjEPKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjEPKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:07:39 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E82530F3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:06:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaf21bb427so99217485ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684231617; x=1686823617;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZASQE1g5P6cFu6dDUxRyZ0nyLvt04lHADFrFzInVrco=;
        b=TvG2zV56+gkLfDn6F4lf1Cf4kRUu40XOC2rVQvP8Dvx9G7sv8FZ6BPp819PvMLwn0C
         ewD05qcv4Xli3wr4iwH1eM1nxB7cP1mpp+dgFXSgwW1e6AkAhxk3KZ4lrUne792T7x1k
         rX5q3+EnRT3MwM5vocxjAnr5FRzfAY0I1XR9VmixFQNfZyBoJGUqGrZCNZp+7vr6lmdV
         PpAgOAvhq3LV8KQ4rKJwMw6ti0uU58fh4e9C+U1OeoKyriDKX51eUe0mBzbLOBtoxhWv
         K90KXQmUhZHiv21HRYf+M7nWelmkR1zM7VQKkdRKAi7JK2r1gO1Btpb/vzJ3DBTpH+MO
         eStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684231617; x=1686823617;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZASQE1g5P6cFu6dDUxRyZ0nyLvt04lHADFrFzInVrco=;
        b=MO6RUjCYEKy0sjQ5y2HoVvw7PSnR7/jfAzCRahdfALtWllbFntFO+CDsnzy1fWdDxo
         /a4iyvSYPiJOSlg8UBj5pTFedg2poyCl+aqLFB5n6ANIaV4FpxN3fM67w+znwyNgVuuU
         FKagDO18NEDRA8+OzRmrI5czTFiUoLaR/P4T5ksJPsQrFQAwHQpiJYwLmDpAIbcOhqzg
         92o83x88IGQ11yzlkgMjBYT7sWye/J91U/9Oy/hAZdLWBOK4dNGDb5gEoZ7gqgan3qgl
         64YWDa8UqaQZtkpmMDs0VCS+s5nhNlVB8FOC3EYqh4h+leiJKLgGCvXPvPY5CGUNc2PY
         fuGQ==
X-Gm-Message-State: AC+VfDySTfrVhN0di2OSqJflVGs5oyDBtCiQfTStB8UfCNAt5oSLQ7YR
        yuZmzTeGUC/1b1HVCxE6Fmp1ClcCnZq44PgSGMQ=
X-Google-Smtp-Source: ACHHUZ6/p6cnqAO4Ph+uLwzXBTgqn1DJ0dE3rua33qSg4Te6BZHT3jANm6Rp7ghBTX5aiEPPrZetrg==
X-Received: by 2002:a17:902:d4c6:b0:1ac:8ad0:1707 with SMTP id o6-20020a170902d4c600b001ac8ad01707mr38886036plg.1.1684231617283;
        Tue, 16 May 2023 03:06:57 -0700 (PDT)
Received: from [10.200.9.178] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001ac68a87255sm15094123plq.93.2023.05.16.03.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 03:06:56 -0700 (PDT)
Message-ID: <b040c43b-d1cd-b84b-a9f3-0a68522dca5e@bytedance.com>
Date:   Tue, 16 May 2023 18:06:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 08/10] maple_tree: Add comments and some minor cleanups to
 mas_wr_append()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-9-zhangpeng.00@bytedance.com>
 <20230515172919.47rkp77cbtwy7pvn@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230515172919.47rkp77cbtwy7pvn@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/16 01:29, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
>> Add comment for mas_wr_append(), move mas_update_gap() into
>> mas_wr_append(), and other cleanups to make mas_wr_modify() cleaner.
> 
> Sorry, no.
> 
> I won't accept cases in the comments and referencing it in the code.
> I'm not making any vma_adjust() or vma_merge()-like comment blocks.
> 
> Please change Case 1/2 to "Append to start of range"/"Append to end of
> range"
> 
> This path leads to chaos.
I'll remove these comments in v2.
> 
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 52 ++++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 39 insertions(+), 13 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 20082ef8c396c..538e49feafbe4 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -4315,6 +4315,31 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>>   	return new_end;
>>   }
>>   
>> +/*
>> + * mas_wr_append: Attempt to append
>> + * @wr_mas: the maple write state
>> + *
>> + * Return: True if appended, false otherwise
>> + *
>> + * Case 1:
>> + *                       r_min   r_max/end_piv
>> + *                 +-------+-------+
>> + * original range: |       |offset |
>> + *                 +-------+-------+
>> + *                             +---+
>> + *      overwrite:             |   |
>> + *                             +---+
>> + *                           index last
>> + * Case 2:
>> + *                       r_min   r_max/end_piv
>> + *                 +-------+-------+
>> + * original range: |       |offset |
>> + *                 +-------+-------+
>> + *                         +---+
>> + *      overwrite:         |   |
>> + *                         +---+
>> + *                       index last
>> + */
>>   static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>>   {
>>   	unsigned char end = wr_mas->node_end;
>> @@ -4322,7 +4347,11 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>>   	struct ma_state *mas = wr_mas->mas;
>>   	unsigned char node_pivots = mt_pivots[wr_mas->type];
>>   
>> +	if (!(mas->offset == wr_mas->node_end))
>> +		return false;
>> +
>>   	if ((mas->index != wr_mas->r_min) && (mas->last == wr_mas->r_max)) {
>> +		/* Case 1 */
>>   		if (new_end < node_pivots)
>>   			wr_mas->pivots[new_end] = wr_mas->pivots[end];
>>   
>> @@ -4330,13 +4359,10 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>>   			ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
>>   
>>   		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->entry);
>> -		mas->offset = new_end;
>>   		wr_mas->pivots[end] = mas->index - 1;
>> -
>> -		return true;
>> -	}
>> -
>> -	if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
>> +		mas->offset = new_end;
>> +	} else if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
>> +		/* Case 2 */
>>   		if (new_end < node_pivots)
>>   			wr_mas->pivots[new_end] = wr_mas->pivots[end];
>>   
>> @@ -4346,10 +4372,13 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>>   
>>   		wr_mas->pivots[end] = mas->last;
>>   		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
>> -		return true;
>> +	} else {
>> +		return false;
>>   	}
>>   
>> -	return false;
>> +	if (!wr_mas->content || !wr_mas->entry)
>> +		mas_update_gap(mas);
>> +	return  true;
>>   }
>>   
>>   /*
>> @@ -4385,12 +4414,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>>   	if (new_end >= mt_slots[wr_mas->type])
>>   		goto slow_path;
>>   
>> -	if (wr_mas->entry && (wr_mas->node_end < mt_slots[wr_mas->type] - 1) &&
>> -	    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
>> -		if (!wr_mas->content || !wr_mas->entry)
>> -			mas_update_gap(mas);
>> +	/* Attempt to append */
>> +	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
>>   		return;
>> -	}
>>   
>>   	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
>>   		return;
>> -- 
>> 2.20.1
>>
> 
