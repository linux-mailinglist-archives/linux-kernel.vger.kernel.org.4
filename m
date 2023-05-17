Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7263E705DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjEQDKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjEQDKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:10:30 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51990171F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:10:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae54b623c2so627535ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684293027; x=1686885027;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZoF/wJDCGNcMTkF0pUC0GAGzPgIdnIwYVl8JN0n0rY=;
        b=aWunnB5rDJLGSsDHRVCLi6iPltH9ETubWn3SnOAG/kIKai58Kgq1GHR4dDEYjy+ViL
         FKqkC68vXL15CeoPvADLQs5JGc86eCR/470UwKyhmKN68mGoyQb0DkrU8MISkd6H374V
         3o7moxA1H3rA9/5+UUzX91miyYnO/vnbaXu+L1lyunrz8uu870k3+lJCIfdx/ie3Ova6
         8hNG1yh8v7o38iaF39e5f/UcJ2g+eoK6TlZlM8VZOHlXCfICWA4RnE50ozuaQYzHwgjn
         gPGMvBL4df1zmerlgvkuLvtQjVt6oJWcWTnqCKQ47yTYz73xTkT1FTO+Xed0SXiPD/kj
         d9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684293027; x=1686885027;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ZoF/wJDCGNcMTkF0pUC0GAGzPgIdnIwYVl8JN0n0rY=;
        b=aAAZ6zzxdLRl9U7CqXuMI+EHXT66X9iMW5CEr2dMGOLsnTcNPxToIecHPLG+z3Rha0
         aHH20oLSlLe12iU1wEP698h+OuMGRN3yZy07PptdoYTn6BjnoD3fvObqUKfOhyH6rMEE
         F3tOX5cMTS/iwYR/B0FfYjh0aXyTr7gBjgRHZ8GZaQJ9OfDohzuuhR0fiRXbA96yqXkn
         TT6ruxD/ch/r9FJ8fJLuWytcpInsPw5G1KddKZ1SL1hyIvCV7TfIWLG17T8q/yRa8Xhf
         8fIpAufkwy6L2Txf8zVYtZ9qe4LoJn98JI2HdEQwL2+ck9EhZL0Pgu+4sFWFBD0/ldCT
         ryfQ==
X-Gm-Message-State: AC+VfDwJJNyDduGWHQcCWg/4tMeb9if5gxpoH8GTa9RZew4anmtQrSnX
        kj5lcDsbHJY4aGf4xRl0RVj+kg==
X-Google-Smtp-Source: ACHHUZ7IJ0oNPZVKjENbP+n5jbaZR9hl3CpZADSKZBUrz2T6jc8A3DdRfm7D+WM2rbyQ//kOMGNefw==
X-Received: by 2002:a17:902:ee8a:b0:1ac:6c26:c32f with SMTP id a10-20020a170902ee8a00b001ac6c26c32fmr34713397pld.46.1684293026741;
        Tue, 16 May 2023 20:10:26 -0700 (PDT)
Received: from [10.200.9.178] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id k19-20020a170902761300b001aaecb74f82sm15920296pll.72.2023.05.16.20.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 20:10:26 -0700 (PDT)
Message-ID: <5d0f39cb-721f-b6eb-1c2b-c53485c90a3f@bytedance.com>
Date:   Wed, 17 May 2023 11:10:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 10/10] maple_tree: Simplify and clean up
 mas_wr_node_store()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-11-zhangpeng.00@bytedance.com>
 <20230515185810.esnbqaybs5ivttwq@revolver>
 <c0530aec-754b-f382-3c96-35437d5ec762@bytedance.com>
 <20230516155221.rfth4jui5e5q6bwb@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
In-Reply-To: <20230516155221.rfth4jui5e5q6bwb@revolver>
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



在 2023/5/16 23:52, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230516 06:53]:
>>
>>
>> 在 2023/5/16 02:58, Liam R. Howlett 写道:
>>> * Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
>>>> Simplify and clean up mas_wr_node_store(), remove unnecessary code.
>>>
>>> This change fails the userspace testing for me.
>>>
>>>>
>>>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>>>> ---
>>>>    lib/maple_tree.c | 75 +++++++++++++-----------------------------------
>>>>    1 file changed, 20 insertions(+), 55 deletions(-)
>>>>
>>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>>> index d558e7bcb6da8..ff4aa01cf88b6 100644
>>>> --- a/lib/maple_tree.c
>>>> +++ b/lib/maple_tree.c
>>>> @@ -4066,46 +4066,21 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>>>>     *
>>>>     * Return: True if stored, false otherwise
>>>>     */
>>>> -static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>>>> +static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
>>>> +				     unsigned char new_end)
>>>>    {
>>>>    	struct ma_state *mas = wr_mas->mas;
>>>>    	void __rcu **dst_slots;
>>>>    	unsigned long *dst_pivots;
>>>>    	unsigned char dst_offset;
>>>> -	unsigned char new_end = wr_mas->node_end;
>>>> -	unsigned char offset;
>>>> -	unsigned char node_slots = mt_slots[wr_mas->type];
>>>>    	struct maple_node reuse, *newnode;
>>>> -	unsigned char copy_size, max_piv = mt_pivots[wr_mas->type];
>>>> +	unsigned char copy_size, node_pivots = mt_pivots[wr_mas->type];
>>>>    	bool in_rcu = mt_in_rcu(mas->tree);
>>>> -	offset = mas->offset;
>>>> -	if (mas->last == wr_mas->r_max) {
>>>> -		/* runs right to the end of the node */
>>>> -		if (mas->last == mas->max)
>>>> -			new_end = offset;
>>>> -		/* don't copy this offset */
> 
> Can you re-add the comments that you removed?  I know the code was more
> lines, but the comments really help follow things through on what is
> going on.
> 
>>>> +	if (mas->last == wr_mas->end_piv)
>>>>    		wr_mas->offset_end++;
>> I guess there is a problem here? If we modify wr_mas->offset_end,
>> but this function fails to try the fast path, it will enter the
>> slow path with the modified offset_end. But it also has this
>> problem in the previous version.
> 
> I don't think we can enter the slow path if this is true.  We must have
> enough room, right?
> 
>>
>> I applied this patch to linux-next/master but it passed the
>> userspace tests. I need more information to confirm what the
>> problem is.
> 
> The failure was pretty consistent for me so I thought it wouldn't be an
> issue reproducing.  I tested against mm-unstable and it happened every
> time I ran the whole patch set yesterday.  Today is a different story
> and it isn't happening for me now.
> 
> Here is the failure log:
> 
> $ CC=gcc make maple && LSAN_OPTIONS="report_objects=1" ./maple
> gcc  -O2 -g -Wall -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o maple.o maple.c
> gcc -fsanitize=address -fsanitize=undefined  maple.o xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o slab.o  -lpthread -lurcu -o maple
> CC=gcc make maple  5.10s user 0.18s system 99% cpu 5.283 total
> maple_tree(0x7ffea7d35b00) flags 0, height 0 root (nil)
> 0: (nil)
> maple_tree(0x7ffea7d35b00) flags 0, height 0 root 0x1
> 0: value 0 (0x0) [0x1]
> maple_tree(0x7ffea7d35b00) flags 0, height 0 root 0x61500000010c
> 0: 0x61500000010c
> 0x61c000737100[14] should not have entry 0xfeadfeffe001
> BUG at mas_validate_limits:7110 (1)
> maple_tree(0x7ffea7d35b00) flags D, height 3 root 0x61e00099551e
> 
> ....<lots of tree stuff>...
>        7f56ecffa000-7f56ecffafff: value 140011320090624 (0x7f56ecffa000) [0xfeadd9ff4001]
>      7f56ecffb000-7f56efffffff: node 0x61e000989500 depth 2 type 1 parent 0x61c000736916 contents: 0xfeadd9ff6001 7F56ED7FAFFF 0xfeaddaff6001 7F56ED7FBFFF 0xfeaddaff8001 7F56EDFFBFFF 0xfeaddbff8001 7F56EDFFCFFF 0xfeaddbffa001 7F56EE7FCFFF 0xfeaddcffa001 7F56EE7FDFFF 0xfeaddcffc001 7F56EEFFDFFF 0xfeadddffc001 7F56EEFFEFFF 0xfeadddffe001 7F56EF7FEFFF 0xfeaddeffe001 7F56EF7FFFFF 0xfeaddf000001 7F56EFFFFFFF (nil) 0 (nil) 0 (nil) 0 (nil) 0 0xa
>        7f56ecffb000-7f56ed7fafff: value 140011320094720 (0x7f56ecffb000) [0xfeadd9ff6001]
>        7f56ed7fb000-7f56ed7fbfff: value 140011328483328 (0x7f56ed7fb000) [0xfeaddaff6001]
>        7f56ed7fc000-7f56edffbfff: value 140011328487424 (0x7f56ed7fc000) [0xfeaddaff8001]
>        7f56edffc000-7f56edffcfff: value 140011336876032 (0x7f56edffc000) [0xfeaddbff8001]
>        7f56edffd000-7f56ee7fcfff: value 140011336880128 (0x7f56edffd000) [0xfeaddbffa001]
>        7f56ee7fd000-7f56ee7fdfff: value 140011345268736 (0x7f56ee7fd000) [0xfeaddcffa001]
>        7f56ee7fe000-7f56eeffdfff: value 140011345272832 (0x7f56ee7fe000) [0xfeaddcffc001]
>        7f56eeffe000-7f56eeffefff: value 140011353661440 (0x7f56eeffe000) [0xfeadddffc001]
>        7f56eefff000-7f56ef7fefff: value 140011353665536 (0x7f56eefff000) [0xfeadddffe001]
>        7f56ef7ff000-7f56ef7fffff: value 140011362054144 (0x7f56ef7ff000) [0xfeaddeffe001]
>        7f56ef800000-7f56efffffff: value 140011362058240 (0x7f56ef800000) [0xfeaddf000001]
>      7f56f0000000-7f56ffffffff: node 0x61c000737100 depth 2 type 1 parent 0x61c00073691e contents: 0xfeade0000001 7F56F0020FFF 0xfeade0042001 7F56F3FFFFFF (nil) 7F56F5FFBFFF 0xfeadebff8001 7F56F5FFCFFF 0xfeadebffa001 7F56F67FCFFF 0xfeadecffa001 7F56F67FDFFF 0xfeadecffc001 7F56F6FFDFFF 0xfeadedffc001 7F56F6FFEFFF 0xfeadedffe001 7F56F7FFFFFF 0xfeadf0000001 7F56F8020FFF 0xfeadf0042001 7F56FBFFFFFF (nil) 7F56FE7FCFFF 0xfeadfcffa001 7F56FE7FDFFF 0xfeadfcffc001 7F56FFFFFFFF 0xfeadfeffe001 7F56FFFFFFFF 0xe
>        7f56f0000000-7f56f0020fff: value 140011370446848 (0x7f56f0000000) [0xfeade0000001]
>        7f56f0021000-7f56f3ffffff: value 140011370582016 (0x7f56f0021000) [0xfeade0042001]
>        7f56f4000000-7f56f5ffbfff: (nil)
>        7f56f5ffc000-7f56f5ffcfff: value 140011471093760 (0x7f56f5ffc000) [0xfeadebff8001]
>        7f56f5ffd000-7f56f67fcfff: value 140011471097856 (0x7f56f5ffd000) [0xfeadebffa001]
>        7f56f67fd000-7f56f67fdfff: value 140011479486464 (0x7f56f67fd000) [0xfeadecffa001]
>        7f56f67fe000-7f56f6ffdfff: value 140011479490560 (0x7f56f67fe000) [0xfeadecffc001]
>        7f56f6ffe000-7f56f6ffefff: value 140011487879168 (0x7f56f6ffe000) [0xfeadedffc001]
>        7f56f6fff000-7f56f7ffffff: value 140011487883264 (0x7f56f6fff000) [0xfeadedffe001]
>        7f56f8000000-7f56f8020fff: value 140011504664576 (0x7f56f8000000) [0xfeadf0000001]
>        7f56f8021000-7f56fbffffff: value 140011504799744 (0x7f56f8021000) [0xfeadf0042001]
>        7f56fc000000-7f56fe7fcfff: (nil)
>        7f56fe7fd000-7f56fe7fdfff: value 140011613704192 (0x7f56fe7fd000) [0xfeadfcffa001]
>        7f56fe7fe000-7f56ffffffff: value 140011613708288 (0x7f56fe7fe000) [0xfeadfcffc001]
>      7f5700000000-7f570c7f9fff: node 0x61c000737900 depth 2 type 1 parent 0x61c000736926 contents: 0xfeae00000001 7F5700020FFF 0xfeae00042001 7F5703FFFFFF (nil) 7F57047F8FFF 0xfeae08ff2001 7F5706FFDFFF 0xfeae0dffc001 7F5706FFEFFF 0xfeae0dffe001 7F57077FEFFF 0xfeae0effe001 7F57077FFFFF 0xfeae0f000001 7F5707FFFFFF 0xfeae10000001 7F5708020FFF 0xfeae10042001 7F570BFFFFFF (nil) 7F570C7F8FFF 0xfeae18ff2001 7F570C7F9FFF (nil) 0 (nil) 0 (nil) 0 0xb
> 
> ...<lots more tree stuff>...
> 
> Pass: 609373594 Run:609373595
> maple: ../../../lib/maple_tree.c:7110: mas_validate_limits: Assertion `0' failed.
> [1]    855591 IOT instruction (core dumped)  LSAN_OPTIONS="report_objects=1" ./maple
> LSAN_OPTIONS="report_objects=1" ./maple  128.63s user 66.12s system 444% cpu 43.818 total
> 
> The middle node in that output has the issue.  If you notice that slot
> 13 and 14 have the maximum limit here (7F56FFFFFFFF) so the verbose
> output of the last value/line is not printed.
> 
> The line "0x61c000737100[14] should not have entry 0xfeadfeffe001" is
> telling us that there is a value beyond what is expected, and it is at
> slot 14 of that node.
> 
> A bit of context for the test may help.  During the development, I was
> seeing odd errors and discovered that I was not clearing old data from
> free areas of a node sometimes.  It was not detected because the maximum
> value of a node is hit, until another modification caused that data to
> be re-introduced into the tree.  This test detects data beyond what is
> expected to be the end of the node.
> 
> This would also happen if you copy too far, but that shouldn't be
> intermittent, assuming the test is okay.
> 
> I re-tested today and it isn't happening for me now.  This is probably
> an RCU error that is intermittent.  The problem may not even be in this
> patch - if it is RCU it probably is not this patch.  It seemed to fail
> consistently on this patch - and I reverted the previous patch and also
> saw the failure because I suspected it had a potential RCU issue, which
> you pointed out was not an issue.  I wouldn't expect the issue to be
> this patch because we use a new node in RCU mode, so the node with data
> beyond the end would be in the tree for a longer time.
> 
> The failures I saw were always the same.
> 
> Could this be an append operation caught by RCU?  It might just be a
> test issue and your updates change the timing?
I may know why it fails. I don't know if this fix patch[1] was
applied to maple_tree when you tested. I revert this patch and
the same problem occurs. This is because wr_mas->end_piv may
be a wrong value without this fix patch, and then I used this
wrong value to cause the failure. Maybe in your failed tests,
this fix patch was not applied, and in your successful tests,
this fix patch was applied.

[1] 
https://lore.kernel.org/lkml/20230506024752.2550-1-zhangpeng.00@bytedance.com/
> 
>>
>> Thanks.
>>
>>>> -	} else if (mas->last < wr_mas->r_max) {
>>>> -		/* new range ends in this range */
>>>> -		if (unlikely(wr_mas->r_max == ULONG_MAX))
>>>> -			mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
>>>> -
>>>> -		new_end++;
>>>> -	} else {
>>>> -		if (wr_mas->end_piv == mas->last)
>>>> -			wr_mas->offset_end++;
>>>> -
>>>> -		new_end -= wr_mas->offset_end - offset - 1;
>>>> -	}
>>>> -
>>>> -	/* new range starts within a range */
>>>> -	if (wr_mas->r_min < mas->index)
>>>> -		new_end++;
>>>> -
>>>> -	/* Not enough room */
>>>> -	if (new_end >= node_slots)
>>>> -		return false;
>>>> +	else if (unlikely(wr_mas->r_max == ULONG_MAX))
>>>> +		mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
>>>>    	/* Not enough data. */
>>>>    	if (!mte_is_root(mas->node) && (new_end <= mt_min_slots[wr_mas->type]) &&
>>>> @@ -4128,47 +4103,36 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>>>>    	dst_pivots = ma_pivots(newnode, wr_mas->type);
>>>>    	dst_slots = ma_slots(newnode, wr_mas->type);
>>>>    	/* Copy from start to insert point */
>>>> -	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * (offset + 1));
>>>> -	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * (offset + 1));
>>>> -	dst_offset = offset;
>>>> +	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * mas->offset);
>>>> +	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * mas->offset);
>>>>    	/* Handle insert of new range starting after old range */
>>>>    	if (wr_mas->r_min < mas->index) {
>>>> -		mas->offset++;
>>>> -		rcu_assign_pointer(dst_slots[dst_offset], wr_mas->content);
>>>> -		dst_pivots[dst_offset++] = mas->index - 1;
>>>> +		rcu_assign_pointer(dst_slots[mas->offset], wr_mas->content);
>>>> +		dst_pivots[mas->offset++] = mas->index - 1;
>>>>    	}
>>>>    	/* Store the new entry and range end. */
>>>> -	if (dst_offset < max_piv)
>>>> -		dst_pivots[dst_offset] = mas->last;
>>>> -	mas->offset = dst_offset;
>>>> -	rcu_assign_pointer(dst_slots[dst_offset], wr_mas->entry);
>>>> +	if (mas->offset < node_pivots)
>>>> +		dst_pivots[mas->offset] = mas->last;
>>>> +	rcu_assign_pointer(dst_slots[mas->offset], wr_mas->entry);
>>>>    	/*
>>>>    	 * this range wrote to the end of the node or it overwrote the rest of
>>>>    	 * the data
>>>>    	 */
>>>> -	if (wr_mas->offset_end > wr_mas->node_end || mas->last >= mas->max) {
>>>> -		new_end = dst_offset;
>>>> +	if (wr_mas->offset_end > wr_mas->node_end)
>>>>    		goto done;
>>>> -	}
>>>> -	dst_offset++;
>>>> +	dst_offset = mas->offset + 1;
>>>>    	/* Copy to the end of node if necessary. */
>>>>    	copy_size = wr_mas->node_end - wr_mas->offset_end + 1;
>>>>    	memcpy(dst_slots + dst_offset, wr_mas->slots + wr_mas->offset_end,
>>>>    	       sizeof(void *) * copy_size);
>>>> -	if (dst_offset < max_piv) {
>>>> -		if (copy_size > max_piv - dst_offset)
>>>> -			copy_size = max_piv - dst_offset;
>>>> +	memcpy(dst_pivots + dst_offset, wr_mas->pivots + wr_mas->offset_end,
>>>> +	       sizeof(unsigned long) * (copy_size - 1));
>>>> -		memcpy(dst_pivots + dst_offset,
>>>> -		       wr_mas->pivots + wr_mas->offset_end,
>>>> -		       sizeof(unsigned long) * copy_size);
>>>> -	}
>>>> -
>>>> -	if ((wr_mas->node_end == node_slots - 1) && (new_end < node_slots - 1))
>>>> +	if (new_end < node_pivots)
>>>>    		dst_pivots[new_end] = mas->max;
>>>>    done:
>>>> @@ -4429,7 +4393,8 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>>>>    	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
>>>>    		return;
>>>> -	else if (mas_wr_node_store(wr_mas))
>>>> +
>>>> +	if (mas_wr_node_store(wr_mas, new_end))
>>>>    		return;
>>>>    	if (mas_is_err(mas))
>>>> -- 
>>>> 2.20.1
>>>>
> 
