Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB116B5063
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCJSxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCJSxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:53:46 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BFF51F9A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:53:19 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i5so6650516pla.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678474399;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT2yApvZ05ViO2Ujgfyy8OwtpBDoNA1MoVGcEzXFvq8=;
        b=AjRRfFxfnM9DHay0pkQxIkp37uekmHK71/nKoOHAkn3POQJDK5MSEvon3PBijUSCnk
         RjzE1Q7Mm5SB7uweAngWOtxSR9GBhWZECWs0EVtmjVR4kdR/MhvnNNYYISnV32GbxYtr
         m2mThagspaT34bR34pR+FNWEVynHk6qSefOdLoeCZGDyYbPU9+vER/TMroh3lnLtpG9P
         IFJ2xbh511ryRszkRvAuSPd4u5nVsdjOWH3ErVohUySVuzFC+ymgbyIe12lT1+W579al
         l/x0Szjv2n7AVyNzoMoxqblMa+ks+xt5KQu4Kn9T8fehpGbuP37mCRF/3mHL4TYGxE0P
         toxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678474399;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MT2yApvZ05ViO2Ujgfyy8OwtpBDoNA1MoVGcEzXFvq8=;
        b=WDhhdwxcWNiKvIXeE6FVfVWfV8ijVdWzJIDry3eEmnzHPR8T+qFRjsuL607I/ATvD+
         lwOWTOy2UYZ7E3V2OaGh3/ccew9TZErhYg8HJ4ReZaWV2DZBprbsrOBbqZzw+mclu96o
         maw/6c1hc9Ggxr57srwFCRAKkBck6NWdA6B/cYc/rZTDaWvxzU4rUveJyrMayojf5ZEG
         TKiOvCGG3Dyh5lLDesV6Gt5g6RfIxvdcJUualpZK7XW6Tuot1yPILFv6j7hW3ECDkjl7
         K0SZpKJgREPNzMeO6qoWGr6FVn8m/foyNV4U2Z2jAi66avTc+ape7O6AShnfLrfvg/TL
         XEMQ==
X-Gm-Message-State: AO0yUKUVo57dlvY1e9kEIPEoz7kUo2x44zWfFjti0OrEiL3GY3jbahMZ
        zUTgc1VVuX+lnG6hadAgB4nr4w==
X-Google-Smtp-Source: AK7set+3WFxKSxNoJcqhbZ55LB27r3MrFan52xLzSmHwFrMMtBSUpqHxoiMSO1GeuiuUu8+XlwGdtA==
X-Received: by 2002:a17:903:32ca:b0:19c:e937:6d04 with SMTP id i10-20020a17090332ca00b0019ce9376d04mr33916246plr.0.1678474398820;
        Fri, 10 Mar 2023 10:53:18 -0800 (PST)
Received: from [10.200.11.19] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id ko7-20020a17090307c700b0019309be03e7sm353307plb.66.2023.03.10.10.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 10:53:18 -0800 (PST)
Message-ID: <9f6ed89e-3456-28d1-0c27-0925b7238f97@bytedance.com>
Date:   Sat, 11 Mar 2023 02:53:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] maple_tree: Fix get wrong data_end in
 mtree_lookup_walk()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
 <20230310140848.94485-2-zhangpeng.00@bytedance.com>
 <20230310175842.qkw54rj6zg7dkymd@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230310175842.qkw54rj6zg7dkymd@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/11 01:58, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230310 09:09]:
>> if (likely(offset > end))
>> 	max = pivots[offset];
>>
>> The above code should be changed to if (likely(offset < end)), which is
>> correct. This affects the correctness of ma_data_end().
> No.  The way it is written is correct.  If we are not at the last slot,
> then we take the pivot as the max for the next level of the tree.  If we
> are at the last slot, then the max is already the correct value.

As you said, If we are not at the last slot, we take the pivot as the max
 for the next level of the tree. At this time, “offset < end” is satisfied, 
but in the original code, when offset > end, take the pivot as the max.
 Please *think again*, it is wrong. The code may have been written 
incorrectly
by mistake, not what you said it was written.

>> Now it seems
>> that the final result will not be wrong, but it is best to change it.
> Why is it best to change it?
>
>> This patch does not change the code as above, because it simplifies the
>> code by the way.
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 15 +++++----------
>>   1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 646297cae5d1..b3164266cfde 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -3875,18 +3875,13 @@ static inline void *mtree_lookup_walk(struct ma_state *mas)
>>   		end = ma_data_end(node, type, pivots, max);
>>   		if (unlikely(ma_dead_node(node)))
>>   			goto dead_node;
>> -
>> -		if (pivots[offset] >= mas->index)
>> -			goto next;
>> -
>>   		do {
>> -			offset++;
>> -		} while ((offset < end) && (pivots[offset] < mas->index));
>> -
>> -		if (likely(offset > end))
>> -			max = pivots[offset];
>> +			if (pivots[offset] >= mas->index) {
>> +				max = pivots[offset];
> You can overflow the pivots array here because offset can actually be
> larger than the array.  I am surprised this passes the maple tree test
> program, but with a full node and walking to the end, it will address
> the pivots array out of bounds.
>
> I wrote it the way I did to minimize the instructions in the loop by
> avoiding the overflow check.

It is not possible overflow pivots array, because only when
"while (++offset < end)" is satisfied, we enter the loop body.
So if we access pivots[offset], “offset < end” must be satisfied.
Maybe you need to read the code to know, instead of looking at
the diff.

The modified code looks like this:

         do {
             if (pivots[offset] >= mas->index) {
                 max = pivots[offset];
                 break;
             }
         } while (++offset < end);

>> +				break;
>> +			}
>> +		} while (++offset < end);
>>   
>> -next:
>>   		slots = ma_slots(node, type);
>>   		next = mt_slot(mas->tree, slots, offset);
>>   		if (unlikely(ma_dead_node(node)))
>> -- 
>> 2.20.1
>>
