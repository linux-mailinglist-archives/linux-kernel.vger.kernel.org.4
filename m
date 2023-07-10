Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C149B74D23C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjGJJve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGJJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:50:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA97D173A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:44:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-66c729f5618so3720643b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688982291; x=1691574291;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqM5Tg5znsJa61fz+y3eLpo4QkB80+ZsaFaKkQZI6jQ=;
        b=H+ZoOOqGWs4EIYa2TAsb9wreWdccJm1VMw1A+iibfRK5gKQ7DDjA3eFNgx0XP2Juww
         BNcEB3nQ0x1q9Kxt7+zmHj5H9rvZCi9oBIDMNPTaTRoKrRMS7Vc9qGkvbMuJ5bL67B4Q
         cVYX08gq3dnUt4vYC3i+mqP5FcvnsPdeiAx4Ssqo5yBpNKwWA3EkP9nKJHN5Dj90OtkT
         8cwzvu62Ekc2goKeuSp31NrrmjqLqVkw6Xz04mvnegsCYv9GdzMksDJghoRPqgiSHlNI
         3G4TOlbzmfCbA4PN7GkaAaZD6agDjQFUSaDVGQtyyCtYUPE9IN9i7hPRFyqKsonuZp1/
         /z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982291; x=1691574291;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VqM5Tg5znsJa61fz+y3eLpo4QkB80+ZsaFaKkQZI6jQ=;
        b=Y44iJZsSCoHxVApDJX4mEIIqywpwBhhme/1gjSptL9aNPtYl738qbcpakuvpZ4ZCSD
         aLfqO4oSrb8EzlBQKPxUWYtfHKQnETF+2W1KUMbkIMmPJ2Z6tEMnZjIaNT0YKhpNHOLR
         msV7zBo0b5FKOTlv+RjWiwegPuyJBkaSJay4cyPHdJOqlV9tUcqDpW2OsCMwjKhH+/IS
         M+Mz8ASapluqHp8GE1qZcV7tG++JFM3QsqQk5g3hS6JRiuS0dFxsLI/hVPTjgc+KQt0H
         zkXjJ3x0cLacga5uEvisq4dJB01lcX01MU5XuRdbT7u8jKLb7IxOqBkGi1L5Vrf7asP9
         hq6w==
X-Gm-Message-State: ABy/qLYQtcdNOciKuVu/UB1MOwQwfyQvfeQ+jzeqVWj4MgGj+diRhlAp
        M5cCiPBq+al3pXhMCk0xYTPC+g==
X-Google-Smtp-Source: APBJJlGTYwe9q2auhQ4W+w5xLWKQ3wcgumMmirwT+NyCvqcc59o3omWbC/P3K/jCwXqxpjse355bUg==
X-Received: by 2002:a05:6a20:4320:b0:118:e011:5e4c with SMTP id h32-20020a056a20432000b00118e0115e4cmr15874384pzk.57.1688982291369;
        Mon, 10 Jul 2023 02:44:51 -0700 (PDT)
Received: from [10.90.35.114] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001b7fd4de08bsm7821942pll.129.2023.07.10.02.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:44:51 -0700 (PDT)
Message-ID: <3c260876-2ee5-7659-0c02-17a68277567f@bytedance.com>
Date:   Mon, 10 Jul 2023 17:44:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH 3/8] maple_tree: make mas_validate_gaps() to check
 metadata
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-4-zhangpeng.00@bytedance.com>
 <20230707144550.eavqm7zcr6dofl73@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
In-Reply-To: <20230707144550.eavqm7zcr6dofl73@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/7 22:45, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
>> Make mas_validate_gaps() check whether the offset in the metadata points
>> to the largest gap. By the way, simplify this function.
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 68 +++++++++++++++++++++++-------------------------
>>   1 file changed, 33 insertions(+), 35 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 6a8982146338..1fe8b6a787dd 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -6983,15 +6983,16 @@ EXPORT_SYMBOL_GPL(mt_dump);
>>   static void mas_validate_gaps(struct ma_state *mas)
>>   {
>>   	struct maple_enode *mte = mas->node;
>> -	struct maple_node *p_mn;
>> +	struct maple_node *p_mn, *node = mte_to_node(mte);
>> +	enum maple_type mt = mte_node_type(mas->node);
>>   	unsigned long gap = 0, max_gap = 0;
>>   	unsigned long p_end, p_start = mas->min;
>> -	unsigned char p_slot;
>> +	unsigned char p_slot, offset;
>>   	unsigned long *gaps = NULL;
>> -	unsigned long *pivots = ma_pivots(mte_to_node(mte), mte_node_type(mte));
>> +	unsigned long *pivots = ma_pivots(node, mt);
>>   	int i;
>>   
>> -	if (ma_is_dense(mte_node_type(mte))) {
>> +	if (ma_is_dense(mt)) {
>>   		for (i = 0; i < mt_slot_count(mte); i++) {
>>   			if (mas_get_slot(mas, i)) {
>>   				if (gap > max_gap)
>> @@ -7004,52 +7005,51 @@ static void mas_validate_gaps(struct ma_state *mas)
>>   		goto counted;
>>   	}
>>   
>> -	gaps = ma_gaps(mte_to_node(mte), mte_node_type(mte));
>> +	gaps = ma_gaps(node, mt);
>>   	for (i = 0; i < mt_slot_count(mte); i++) {
>> -		p_end = mas_logical_pivot(mas, pivots, i, mte_node_type(mte));
>> +		p_end = mas_logical_pivot(mas, pivots, i, mt);
>>   
>>   		if (!gaps) {
>> -			if (mas_get_slot(mas, i)) {
>> -				gap = 0;
>> -				goto not_empty;
>> -			}
>> -
>> -			gap += p_end - p_start + 1;
>> +			if (!mas_get_slot(mas, i))
>> +				gap = p_end - p_start + 1;
>>   		} else {
>>   			void *entry = mas_get_slot(mas, i);
>>   
>>   			gap = gaps[i];
>> -			if (!entry) {
>> -				if (gap != p_end - p_start + 1) {
>> -					pr_err("%p[%u] -> %p %lu != %lu - %lu + 1\n",
>> -						mas_mn(mas), i,
>> -						mas_get_slot(mas, i), gap,
>> -						p_end, p_start);
>> -					mt_dump(mas->tree, mt_dump_hex);
>> -
>> -					MT_BUG_ON(mas->tree,
>> -						gap != p_end - p_start + 1);
>> -				}
>> -			} else {
>> -				if (gap > p_end - p_start + 1) {
>> -					pr_err("%p[%u] %lu >= %lu - %lu + 1 (%lu)\n",
>> -					mas_mn(mas), i, gap, p_end, p_start,
>> -					p_end - p_start + 1);
>> -					MT_BUG_ON(mas->tree,
>> -						gap > p_end - p_start + 1);
>> -				}
>> +			MT_BUG_ON(mas->tree, !entry);
>> +
>> +			if (gap > p_end - p_start + 1) {
>> +				pr_err("%p[%u] %lu >= %lu - %lu + 1 (%lu)\n",
>> +				mas_mn(mas), i, gap, p_end, p_start,
>> +				p_end - p_start + 1);
>> +				MT_BUG_ON(mas->tree,
>> +					gap > p_end - p_start + 1);
> 
> Your change above points out that we are not verifying all gaps are zero
> in non-leaf nodes after p_end >= mas->max.  If we don't have a 'no gap'
> indicator then this may be an issue, or maybe it already is an issue?
If we don't have a 'no gap' indicator, why is there an issue? Are you
worried that meta_gap is wrongly pointing to the gap after the node
limit? If so we can verify that meta_gap points to a gap within the node
limit.
> 
>>   			}
>>   		}
>>   
>>   		if (gap > max_gap)
>>   			max_gap = gap;
>> -not_empty:
>> +
>>   		p_start = p_end + 1;
>>   		if (p_end >= mas->max)
>>   			break;
>>   	}
>>   
>>   counted:
>> +	if (mt == maple_arange_64) {
> 
> We could loop through the remainder of the gaps here pretty easily.
In this way, it can be verified that the gaps after the node limit are
0.

> 
>> +		offset = ma_meta_gap(node, mt);
>> +		if (offset > mt_slots[mt]) {
>> +			pr_err("gap offset %p[%u] is invalid\n", node, offset);
>> +			MT_BUG_ON(mas->tree, 1);
>> +		}
>> +
>> +		if (gaps[offset] != max_gap) {
>> +			pr_err("gap %p[%u] is not the largest gap %lu\n",
>> +			       node, offset, max_gap);
>> +			MT_BUG_ON(mas->tree, 1);
>> +		}
>> +	}
>> +
>>   	if (mte_is_root(mte))
>>   		return;
>>   
>> @@ -7059,10 +7059,8 @@ static void mas_validate_gaps(struct ma_state *mas)
>>   	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
>>   		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
>>   		mt_dump(mas->tree, mt_dump_hex);
>> +		MT_BUG_ON(mas->tree, 1);
>>   	}
>> -
>> -	MT_BUG_ON(mas->tree,
>> -		  ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap);
>>   }
>>   
>>   static void mas_validate_parent_slot(struct ma_state *mas)
>> -- 
>> 2.20.1
>>
>>
>> -- 
>> maple-tree mailing list
>> maple-tree@lists.infradead.org
>> https://lists.infradead.org/mailman/listinfo/maple-tree
