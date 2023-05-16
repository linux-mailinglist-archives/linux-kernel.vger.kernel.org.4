Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C2470507F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjEPOXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjEPOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:23:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC342E44
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:23:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab01bf474aso107877985ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684246980; x=1686838980;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kGeDB1FLLRTyGYaeMLX/shu6ixIOPxRjOLfucBTWSs=;
        b=Si9J8xh44DDlnAJIJcr2xQNuOXm5Gojua1R5DmKPohwEwQdPvLGbYd0iH+xZ0lk80g
         9WxrGqm6IFwbrjwYKal32Lx/elXzbTO+epmFw87n/Q0HU6znbMLPA/cnCyrpbCFJKmg8
         t6Oe7XvwrG1urBtzOu73NUwoSx488P3bQYqDIkmep0FLqjAt/J5fmo9AM8V2gIoAsDd6
         CZhSZ+X+ssIA3c/gpeltMreT9n19wy/IulbMCtAwBvdOjgLM2j44N5FcmVvqc9vOP9Vx
         UHpbblpQELsmD7bzK4sCuZi7u89IroDveefCKFqq0KTgTMjOi5TN0ZeItH1gmM7HMTPB
         Tb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684246980; x=1686838980;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3kGeDB1FLLRTyGYaeMLX/shu6ixIOPxRjOLfucBTWSs=;
        b=FMft3uvPdq0O5D820lRRTNDhjOo4UQPdBYflepdehgWaLVUiMeLMbwSVpbS5dqgINZ
         x72M3UkB1McplvxVo3cW55UJiC39Ru84VkmiKXkfUU4qc4uG18FdFAn9vLzjKoe0LZlt
         rg4XjbEvtVLye55Jesd28iuSL5NGf22vmluZg5PFADsgNvw0vhe8aFX2puyfY9gqk08g
         0zZRE6wr5Cy29QDm0SlTiuqclaYO2fxgARxwvbPZv3v2/PFaJB+d5IY11unP+BxTamx8
         Q+o8i/3jLA4TvaOhtTpRC6hpaf3hQZ1VILwND8lfeLx8OzAnINmsC393UKQtt1dMU3LE
         Xk/Q==
X-Gm-Message-State: AC+VfDwwwxvuBv7NAzBydm867/673BXXdWmvdQy1cGJPb+1CtGOJH6+S
        XFVSZ9e5T+bn2PG/7wMIoKsJOLIUP/pGdJso0tg=
X-Google-Smtp-Source: ACHHUZ7kVT7ZCAoxQt/vV9D61JAabjwEva1tCTzmTkXtKYDsdw6VtrhKn0U+QE6KBcj5TLi9k1Yzwg==
X-Received: by 2002:a17:902:778c:b0:1a6:3ffb:8997 with SMTP id o12-20020a170902778c00b001a63ffb8997mr2481520pll.42.1684246980349;
        Tue, 16 May 2023 07:23:00 -0700 (PDT)
Received: from [10.200.9.178] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902b78100b0019a5aa7eab0sm1380109pls.54.2023.05.16.07.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 07:23:00 -0700 (PDT)
Message-ID: <cb488d66-1cdc-67ef-27b1-fa75a8f86eb8@bytedance.com>
Date:   Tue, 16 May 2023 22:22:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 06/10] maple_tree: Wrap the replace operation with an
 inline function.
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-7-zhangpeng.00@bytedance.com>
 <20230515170722.6eqyckjaggw5wijq@revolver>
 <830328dd-ddb6-bdc5-2d74-35b5212cc569@bytedance.com>
 <20230516141626.4aqzxbmxdxc4d3ll@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230516141626.4aqzxbmxdxc4d3ll@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/16 22:16, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230515 20:46]:
>>
>>
>> 在 2023/5/16 01:07, Liam R. Howlett 写道:
>>> * Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
>>>> To make mas_wr_modify() cleaner, wrap the replace operation with an
>>>> inline function.
>>>
>>> mas_wr_modify() is already pretty small.  Is there any reason you want
>>> this in its own function besides it looking cleaner?
>> I just want to make the four fast paths in mas_wr_modify()
>> look uniform without any functional effect.
> 
> I'd like to keep it the way it is. I think the comment stating what is
> going on is clear enough and mas_wr_modify() isn't too big.
Ok, I'll drop this patch in v3.
> 
>>>
>>>>
>>>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>>>> ---
>>>>    lib/maple_tree.c | 21 +++++++++++++++------
>>>>    1 file changed, 15 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>>> index 4c649d75a4923..ce695adc670ec 100644
>>>> --- a/lib/maple_tree.c
>>>> +++ b/lib/maple_tree.c
>>>> @@ -4288,6 +4288,19 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
>>>>    	}
>>>>    }
>>>> +static inline bool mas_wr_replace(struct ma_wr_state *wr_mas)
>>>> +{
>>>> +	struct ma_state *mas = wr_mas->mas;
>>>> +
>>>> +	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
>>>> +		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
>>>> +		if (!!wr_mas->entry ^ !!wr_mas->content)
>>>> +			mas_update_gap(mas);
>>>> +		return true;
>>>> +	}
>>>> +	return false;
>>>> +}
>>>> +
>>>>    static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>>>>    {
>>>>    	unsigned char end = wr_mas->node_end;
>>>> @@ -4347,13 +4360,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>>>>    	unsigned char node_size;
>>>>    	struct ma_state *mas = wr_mas->mas;
>>>> -	/* Direct replacement */
>>>> -	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
>>>> -		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
>>>> -		if (!!wr_mas->entry ^ !!wr_mas->content)
>>>> -			mas_update_gap(mas);
>>>> +	/* Attempt to direct replace */
>>>> +	if (mas_wr_replace(wr_mas))
>>>>    		return;
>>>> -	}
>>>>    	/* Attempt to append */
>>>>    	node_slots = mt_slots[wr_mas->type];
>>>> -- 
>>>> 2.20.1
>>>>
