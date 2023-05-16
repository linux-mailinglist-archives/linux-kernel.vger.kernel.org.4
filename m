Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB017704257
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbjEPAhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjEPAhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:37:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BF7F1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:36:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aad55244b7so102924295ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684197405; x=1686789405;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJoDWdNGnr8LfrrtOHTqflM+YgBUQb3SWktW3/kS37w=;
        b=BpM149hKj/TSgrXsWD9M6zauXFPC7+FfHKgadrWcRUWrMc7Zn0lMjno1yG/1dKCAUs
         2IzZ3PdEotteAKfOWca8JZZyj/Mb8eJagIMesi5Kh7G9cy7iMsGBG1UPd99zfCTkK2yZ
         7vskCWyG/7bHlyzVTp2ULOJBiUO/Ewl+qdxldFBqCHE+OjRG9+8lAchj7EKizcs17kI8
         5OaN4C0fmrkfw+RE+kFwF9lCGJRkWfP75+PTi6kYRmuMvxD0kq7Fmhgfrsq8PizmaDpg
         KqQcLRYL9hFnWyaKOPIe7zpJx8nD1No3Sut/UGobXHj68ygECqt9V3w7SvQQHCYxluw1
         gpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684197405; x=1686789405;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DJoDWdNGnr8LfrrtOHTqflM+YgBUQb3SWktW3/kS37w=;
        b=NXGDs1qj1IceONGKqmov2BT12gGfQzUhl8FyO820vKahd/AvPrh5GV85Yki07vCEmx
         v9Rq9TCaB59hMdhY9F+Mbcp4wYQu8ndmjrH4XP8HmdeeFWy7qlep/8cpQsSY8kRbm3RI
         3nDsMHIbAEI8jke4iNDVRc1B+pRR5eSb9MdS4JoHAIsH8viLwd0xCkK9NnidqqR6+huL
         0njLq+kjbfXGIEE3XB399Mo4wCU2kK9VVQgbPXPD5xB+ZJRIVTbyuAPXxf0+C1NL+CJe
         31+Z8kW3Onn3sdGh4rn5K64KpiOvM1vG/sQg2DhuV/U34+K0ycLiB8kpbscv+lTFNLE8
         HENg==
X-Gm-Message-State: AC+VfDxDyEaQGS+E2hgRIdOxch7/Mw0y2vDuvOKYKfvM/29NiDDYAgSi
        8y9UG7haoc5e4LHX1ZLZspBR7A==
X-Google-Smtp-Source: ACHHUZ4bEkFJsJH1f/G5K3iHhYh1Zc+OdBSb63DFKt5/hYRINYpfr7Ud+ZLQvwiSxnIfy2MU+HjJ/Q==
X-Received: by 2002:a17:902:9049:b0:1ab:19db:f2b with SMTP id w9-20020a170902904900b001ab19db0f2bmr37736748plz.36.1684197404921;
        Mon, 15 May 2023 17:36:44 -0700 (PDT)
Received: from [10.200.9.178] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170903054d00b001a641e4738asm14174195plb.1.2023.05.15.17.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 17:36:44 -0700 (PDT)
Message-ID: <7dd764a5-3543-0e5a-e57c-3d5c6707626d@bytedance.com>
Date:   Tue, 16 May 2023 08:36:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 10/10] maple_tree: Simplify and clean up
 mas_wr_node_store()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-11-zhangpeng.00@bytedance.com>
 <20230515185810.esnbqaybs5ivttwq@revolver>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230515185810.esnbqaybs5ivttwq@revolver>
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



在 2023/5/16 02:58, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
>> Simplify and clean up mas_wr_node_store(), remove unnecessary code.
> 
> This change fails the userspace testing for me.
Can you tell which commit this patchset is based on when you run
userspace testing? I'll have a look.
> 
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 75 +++++++++++++-----------------------------------
>>   1 file changed, 20 insertions(+), 55 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index d558e7bcb6da8..ff4aa01cf88b6 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -4066,46 +4066,21 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>>    *
>>    * Return: True if stored, false otherwise
>>    */
>> -static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>> +static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
>> +				     unsigned char new_end)
>>   {
>>   	struct ma_state *mas = wr_mas->mas;
>>   	void __rcu **dst_slots;
>>   	unsigned long *dst_pivots;
>>   	unsigned char dst_offset;
>> -	unsigned char new_end = wr_mas->node_end;
>> -	unsigned char offset;
>> -	unsigned char node_slots = mt_slots[wr_mas->type];
>>   	struct maple_node reuse, *newnode;
>> -	unsigned char copy_size, max_piv = mt_pivots[wr_mas->type];
>> +	unsigned char copy_size, node_pivots = mt_pivots[wr_mas->type];
>>   	bool in_rcu = mt_in_rcu(mas->tree);
>>   
>> -	offset = mas->offset;
>> -	if (mas->last == wr_mas->r_max) {
>> -		/* runs right to the end of the node */
>> -		if (mas->last == mas->max)
>> -			new_end = offset;
>> -		/* don't copy this offset */
>> +	if (mas->last == wr_mas->end_piv)
>>   		wr_mas->offset_end++;
>> -	} else if (mas->last < wr_mas->r_max) {
>> -		/* new range ends in this range */
>> -		if (unlikely(wr_mas->r_max == ULONG_MAX))
>> -			mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
>> -
>> -		new_end++;
>> -	} else {
>> -		if (wr_mas->end_piv == mas->last)
>> -			wr_mas->offset_end++;
>> -
>> -		new_end -= wr_mas->offset_end - offset - 1;
>> -	}
>> -
>> -	/* new range starts within a range */
>> -	if (wr_mas->r_min < mas->index)
>> -		new_end++;
>> -
>> -	/* Not enough room */
>> -	if (new_end >= node_slots)
>> -		return false;
>> +	else if (unlikely(wr_mas->r_max == ULONG_MAX))
>> +		mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
>>   
>>   	/* Not enough data. */
>>   	if (!mte_is_root(mas->node) && (new_end <= mt_min_slots[wr_mas->type]) &&
>> @@ -4128,47 +4103,36 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>>   	dst_pivots = ma_pivots(newnode, wr_mas->type);
>>   	dst_slots = ma_slots(newnode, wr_mas->type);
>>   	/* Copy from start to insert point */
>> -	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * (offset + 1));
>> -	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * (offset + 1));
>> -	dst_offset = offset;
>> +	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * mas->offset);
>> +	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * mas->offset);
>>   
>>   	/* Handle insert of new range starting after old range */
>>   	if (wr_mas->r_min < mas->index) {
>> -		mas->offset++;
>> -		rcu_assign_pointer(dst_slots[dst_offset], wr_mas->content);
>> -		dst_pivots[dst_offset++] = mas->index - 1;
>> +		rcu_assign_pointer(dst_slots[mas->offset], wr_mas->content);
>> +		dst_pivots[mas->offset++] = mas->index - 1;
>>   	}
>>   
>>   	/* Store the new entry and range end. */
>> -	if (dst_offset < max_piv)
>> -		dst_pivots[dst_offset] = mas->last;
>> -	mas->offset = dst_offset;
>> -	rcu_assign_pointer(dst_slots[dst_offset], wr_mas->entry);
>> +	if (mas->offset < node_pivots)
>> +		dst_pivots[mas->offset] = mas->last;
>> +	rcu_assign_pointer(dst_slots[mas->offset], wr_mas->entry);
>>   
>>   	/*
>>   	 * this range wrote to the end of the node or it overwrote the rest of
>>   	 * the data
>>   	 */
>> -	if (wr_mas->offset_end > wr_mas->node_end || mas->last >= mas->max) {
>> -		new_end = dst_offset;
>> +	if (wr_mas->offset_end > wr_mas->node_end)
>>   		goto done;
>> -	}
>>   
>> -	dst_offset++;
>> +	dst_offset = mas->offset + 1;
>>   	/* Copy to the end of node if necessary. */
>>   	copy_size = wr_mas->node_end - wr_mas->offset_end + 1;
>>   	memcpy(dst_slots + dst_offset, wr_mas->slots + wr_mas->offset_end,
>>   	       sizeof(void *) * copy_size);
>> -	if (dst_offset < max_piv) {
>> -		if (copy_size > max_piv - dst_offset)
>> -			copy_size = max_piv - dst_offset;
>> +	memcpy(dst_pivots + dst_offset, wr_mas->pivots + wr_mas->offset_end,
>> +	       sizeof(unsigned long) * (copy_size - 1));
>>   
>> -		memcpy(dst_pivots + dst_offset,
>> -		       wr_mas->pivots + wr_mas->offset_end,
>> -		       sizeof(unsigned long) * copy_size);
>> -	}
>> -
>> -	if ((wr_mas->node_end == node_slots - 1) && (new_end < node_slots - 1))
>> +	if (new_end < node_pivots)
>>   		dst_pivots[new_end] = mas->max;
>>   
>>   done:
>> @@ -4429,7 +4393,8 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>>   
>>   	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
>>   		return;
>> -	else if (mas_wr_node_store(wr_mas))
>> +
>> +	if (mas_wr_node_store(wr_mas, new_end))
>>   		return;
>>   
>>   	if (mas_is_err(mas))
>> -- 
>> 2.20.1
>>
