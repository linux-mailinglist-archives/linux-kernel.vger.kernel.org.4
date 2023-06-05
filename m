Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6850722448
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjFELLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjFELLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:11:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C6B8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:11:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d44b198baso3338786b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685963480; x=1688555480;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZA9xVvU90GCNIRUDkgV/PBm5ZYz8HGxVKo2ZS+Bcd8=;
        b=b25Pwf6yLu6Q6JBfAfwR5TQKvn9BVcrrNVTcrUPe4ie4aQob1BX/ZJ5//5Y5zkXJgi
         JXs8Y22LjOgv2iSJhJDzevCPPPcrPGBDQTqHkwmR61lnMnlE45RdxKOvquZ/Cy7RklN7
         STfp8FrHMKXgr4mXu0KY1ApzbIwXqabDioUsJspbpaA9syNzacIfFBBfccqyboM2k0X0
         lS2Al6UH/zLPSuLiOwE9jKZAwVZHi3ANXvcRvrnS/mgXvGQpdc5ryUNZ9Z3/okYOkCQU
         Hhsj7jF/iX1FJsrpeoQmy18fQXcbCDqEhnddA7wHdaC8y4N5QlOof0a7TdO9f3jyz1Rg
         0BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963480; x=1688555480;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ZA9xVvU90GCNIRUDkgV/PBm5ZYz8HGxVKo2ZS+Bcd8=;
        b=eefkPhRM5V6fL3y3RAMyeJNj8jcj+OExU4bdaYLTqXmN2xIa9Y6LsydPy0yLOIi7cm
         Ti64dGVdjQTX3z47Eh0RRrR4BqaaHjAYfzG6o8Lff3z/wWtbwmZQ51JY54ywF0pqRiOO
         f7+ihzQt6j2Xw6EVunvnrrCwxqIXsryaAu8E+2zYngB+ZsWikaxJQB6SH8MeBAujK8h8
         Yl0zyFb5Tes0z8Vv0AYGXiP7S4G8mPHTo3ay9juXOB97Dn2xY92//wi3gv4KBcAmwUNY
         lJ494zOMiNWgaREjZmzAzLYw5Higc+HKj0qU7CC3ZKOi8JwzUf314udbaxNZetTo9WCT
         rgMQ==
X-Gm-Message-State: AC+VfDyUSLE8z8zxe84tIkgE5jGjDnBaxVsEly7Jc6TUpj9RYoIIF3nJ
        89bGL4yCFRj0V8KR1tVGNqmcfw==
X-Google-Smtp-Source: ACHHUZ6mXSnZ+lTmPQNBad5AL9+d+d9OVW3za+AXaDp4fePpblzITGZkFv/GSaEXI6ZrppJ/caxbJg==
X-Received: by 2002:a05:6a00:369b:b0:64d:42b9:6895 with SMTP id dw27-20020a056a00369b00b0064d42b96895mr13464096pfb.5.1685963480222;
        Mon, 05 Jun 2023 04:11:20 -0700 (PDT)
Received: from [10.200.9.101] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b0065017055cb4sm4992656pfa.203.2023.06.05.04.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:11:19 -0700 (PDT)
Message-ID: <39952baf-9bda-5b22-5ba0-1b6b377d238a@bytedance.com>
Date:   Mon, 5 Jun 2023 19:11:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] maple_tree: add a fast path case in
 mas_wr_slot_store()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230602075353.5917-1-zhangpeng.00@bytedance.com>
 <20230602075353.5917-2-zhangpeng.00@bytedance.com>
 <20230602164134.uw6m7t2pb3zhydkl@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
In-Reply-To: <20230602164134.uw6m7t2pb3zhydkl@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/3 00:41, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230602 03:54]:
>> When the new range overwrites three ranges and does not touch the
>> boundaries on both sides, the number of entries will not be increased,
>> so we can just update the pivots as a fast path. However, it may
>> introduce potential risks in RCU mode (although it can pass the test),
>> because it updates two pivots. We only enable it in non-RCU mode for now.
> 
> So what you are saying is that you are expanding one entry to consume
> portions of the previous and next into a new entry.  We know this is the
> case because the end of the node is not moving and we are modifying more
> than one slot (so it must be 2 slots)
> 
> This scenario is not tested in the testing framework.  We should add
> testing before we can add this.
> 
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 33 +++++++++++++++++++++------------
>>   1 file changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index cfd9fad308a2..ec82441ca3e8 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -4100,23 +4100,32 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
>>   {
>>   	struct ma_state *mas = wr_mas->mas;
>>   	unsigned char offset = mas->offset;
>> +	void __rcu **slots = wr_mas->slots;
>>   	bool gap = false;
>>   
>> -	if (wr_mas->offset_end - offset != 1)
>> -		return false;
>> -
>> -	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
>> -	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
>> +	gap |= !mt_slot_locked(mas->tree, slots, offset);
>> +	gap |= !mt_slot_locked(mas->tree, slots, offset + 1);
>>   
>> -	if (mas->index == wr_mas->r_min) {
>> -		/* Overwriting the range and over a part of the next range. */
>> -		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
>> -		wr_mas->pivots[offset] = mas->last;
>> -	} else {
>> -		/* Overwriting a part of the range and over the next range */
>> -		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
>> +	if (wr_mas->offset_end - offset == 1) {
>> +		if (mas->index == wr_mas->r_min) {
>> +			/* Overwriting the range and a part of the next one */
>> +			rcu_assign_pointer(slots[offset], wr_mas->entry);
>> +			wr_mas->pivots[offset] = mas->last;
>> +		} else {
>> +			/* Overwriting a part of the range and the next one */
>> +			rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
>> +			wr_mas->pivots[offset] = mas->index - 1;
>> +			mas->offset++; /* Keep mas accurate. */
>> +		}
>> +	} else if (!mt_in_rcu(mas->tree)) {
>> +		/* Overwriting three ranges, but don't touch the boundaries */
> 
> I find this comment misleading.  You actually touch both boundaries for
> the entry in this case (start and end).  We are just increasing the
> space in both directions.  You are also not overwriting two of the three
> entries or ranges, you are expanding one entry in two directions, so
> both the previous and next ranges will shrink but they will remain. It's
> more of a "modify three ranges but don't change the outside limits." The
> similar statement in the commit message should also be changed.
Yes, your understanding is correct.
Sorry my comment is not well written, I mean the left boundary of the
leftmost range and the right boundary of the rightmost range are not
touched, I will fix it in v2.

> 
> Right now, I don't see this code executed by the test program.
> Inserting a BUG_ON() here and it will not be hit.
Yes, the current test program does not run to this branch, I will add
the corresponding test cases in v2.

> 
>> +		gap |= !mt_slot_locked(mas->tree, slots, offset + 2);
>> +		rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
>>   		wr_mas->pivots[offset] = mas->index - 1;
>> +		wr_mas->pivots[offset + 1] = mas->last;
>>   		mas->offset++; /* Keep mas accurate. */
>> +	} else {
> 
> We are hitting this else in check_locky at maple.c:35780 only, I think.
> You've identified a lack of testing here by the looks of it.
> 
> The VMA code does not do this today, and I don't know of any other users
> which expand/contract entries like this.  Do you think this will be
> common enough for the optimisation vs a node store?
I also thought about this problem, but I still regard it as an
optimization of the slot store. Although it is useless for VMA
now, I don't know if it will be used in the future. I think that
if we enter this function, we will most likely enter the first if
branch now, which will not cause additional overhead and have no
negative impact, so try to add this case.

> 
>> +		return false;
>>   	}
>>   
>>   	trace_ma_write(__func__, mas, 0, wr_mas->entry);
>> -- 
>> 2.20.1
>>
>>
