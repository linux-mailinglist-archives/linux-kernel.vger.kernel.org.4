Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3796E890D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 06:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjDTEVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 00:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTEVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 00:21:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C025B2D4A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:21:07 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52160b73bdfso405997a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681964467; x=1684556467;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ifhg/4wKiyjaXBSAZD8UD8hDN/wBg/sQQRUVu3etZ9U=;
        b=TtlvBqWoc2jm36vCVOCH5P/7+aPiHvKY5fUkMmMVZLDOlb1oKJVyLbeL4Kk06vyQGI
         r9wkAZRY0NiIkgMBhnPvYCiQQlzGt5E2zyAENCjvb5hTHTWF/iXVz5F+nzDEcn7xGegP
         Zqaw7LFr+jKjChSXdom3OHQYKoHeUXGQWtR+qzkI1+QAHknV5IptncMaD9O+w2lximD9
         QzPxFZqYK4plIElw/F5urQX4n3yPZ0xQsBsSHHtPwR3sJMLX/yZORSYsSl3lgTwrDLNa
         QDW3/pFdH0VKYjKF3mhaMpdiFaPpssp0KTV7pZjPXVZUE3eS3gEgk5MbnQbeaK5Nc2w4
         XBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681964467; x=1684556467;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ifhg/4wKiyjaXBSAZD8UD8hDN/wBg/sQQRUVu3etZ9U=;
        b=I1GvxzCPBllF0ZwH0+50p8B9p3/98N7qjs/Q59c4LGQVcWVrwrYOvNz3j9j+7bZ2cW
         N2RhlSaDVZEGI61zPA/GFptPDawT956I9lH0x3ygvmtZBuC+ma6EsNasiiwIDVJcZSDs
         gbAur2TeWE7ZPsRzS2g5fTa0T5ahyky8gNzIBi9PDdmLmTNiCYAAvbuLNDO5mdYaZeHU
         HyeDY6xTgD0x5QFed7RiqN+w65trjStQY0s8nK2E0MlEFvtBwcHQbbZBF1CLuyvI8yiQ
         lIWRmecWt7jxH5nfg+jTXe/6Qh/LUqpYGNHQqUs0Yll/wM12s00A0xeSl691n/MsSwJr
         DVNw==
X-Gm-Message-State: AAQBX9cPCQo7+Wi8epKROCSg0eU9cb04Gbl+mhsiK0NAF4j25/WFU7NQ
        pXTYGPtpwtw47CMHY0kUOiAoi1AzOkayxzpE3N8=
X-Google-Smtp-Source: AKy350YyORwot+Rvti/LnKfw18XvtNb12HK6l4jBCdFe36mk9B5f8g4bF230dGemqsCnHpYFsQQmNQ==
X-Received: by 2002:a05:6a20:729a:b0:ef:ead5:6fdf with SMTP id o26-20020a056a20729a00b000efead56fdfmr386294pzk.33.1681964467173;
        Wed, 19 Apr 2023 21:21:07 -0700 (PDT)
Received: from [10.200.10.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id r78-20020a632b51000000b00520f316ebe3sm181883pgr.62.2023.04.19.21.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 21:21:06 -0700 (PDT)
Message-ID: <2c4f6226-7ae1-a60b-e468-2142db64ea97@bytedance.com>
Date:   Thu, 20 Apr 2023 12:21:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] maple_tree: Make maple state reusable after
 mas_empty_area_rev()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
 <90fd5cfa-5ed9-495f-fdef-0130adaf591b@bytedance.com>
 <20230419225419.czzwbdgys367fax2@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230419225419.czzwbdgys367fax2@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/20 06:54, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230419 05:02]:
>> 在 2023/4/14 22:57, Liam R. Howlett 写道:
>>> Stop using maple state min/max for the range by passing through pointers
>>> for those values.  This will allow the maple state to be reused without
>>> resetting.
>>>
>>> Also add some logic to fail out early on searching with invalid
>>> arguments.
>>>
>>> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>> ---
>>>    lib/maple_tree.c | 27 +++++++++++++--------------
>>>    1 file changed, 13 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>> index 4df6a0ce1c1b..ed350aa293b2 100644
>>> --- a/lib/maple_tree.c
>>> +++ b/lib/maple_tree.c
>>> @@ -4938,7 +4938,8 @@ static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
>>>     * Return: True if found in a leaf, false otherwise.
>>>     *
>>>     */
>>> -static bool mas_rev_awalk(struct ma_state *mas, unsigned long size)
>>> +static bool mas_rev_awalk(struct ma_state *mas, unsigned long size,
>>> +		unsigned long *gap_min, unsigned long *gap_max)
>>>    {
>>>    	enum maple_type type = mte_node_type(mas->node);
>>>    	struct maple_node *node = mas_mn(mas);
>>> @@ -5003,8 +5004,8 @@ static bool mas_rev_awalk(struct ma_state *mas, unsigned long size)
>>>    	if (unlikely(ma_is_leaf(type))) {
>>>    		mas->offset = offset;
>>> -		mas->min = min;
>>> -		mas->max = min + gap - 1;
>>> +		*gap_min = min;
>>> +		*gap_max = min + gap - 1;
>>>    		return true;
>>>    	}
>>> @@ -5280,6 +5281,9 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
>>>    	unsigned long *pivots;
>>>    	enum maple_type mt;
>>> +	if (min >= max)
>> This can lead to errors, min == max is valid.
>> I think it's better to change it to this:
>> if (min > max || size == 0 || max - min < size - 1)
> I am not sure what it means to search within a range of one.  I guess
> you would expect it to just return that value if it's empty?
Yes, if min==max, and the value pointed to by this index is empty,
we should return it.
>
> In any case, since we are dealing with pages of data for the VMAs,
> having min == max really makes no sense, even with the subtraction of
> one in the caller to reduce the max, the min and max should be at least
> PAGE_SIZE - 1 apart here.
>
> I think you are right, and I think this needs to be looked at for the
> tree on its own, but I don't think it's a problem for the VMA user. I'll
> write a testcase and ensure a search for a single entry in a single
> entry window works separately.  Thanks for pointing this out.
Yes, it's a problem with the tree itself.
>
>>> +		return -EINVAL;
>>> +
>>>    	if (mas_is_start(mas))
>>>    		mas_start(mas);
>>>    	else if (mas->offset >= 2)
>>> @@ -5334,6 +5338,9 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>>>    {
>>>    	struct maple_enode *last = mas->node;
>>> +	if (min >= max)
>> ditto.
> I'll do the search in both directions.
Here is also the same problem with the tree itself as above.
Maybe I didn't understand what you mean. I think the case of
min==max should still be considered in mas_empty_area_rev(),
because mas_empty_area_rev() is a separate interface.
>
>>> +		return -EINVAL;
>>> +
>>>    	if (mas_is_start(mas)) {
>>>    		mas_start(mas);
>>>    		mas->offset = mas_data_end(mas);
>>> @@ -5353,7 +5360,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>>>    	mas->index = min;
>>>    	mas->last = max;
>>> -	while (!mas_rev_awalk(mas, size)) {
>>> +	while (!mas_rev_awalk(mas, size, &min, &max)) {
>>>    		if (last == mas->node) {
>>>    			if (!mas_rewind_node(mas))
>>>    				return -EBUSY;
>>> @@ -5368,17 +5375,9 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>>>    	if (unlikely(mas->offset == MAPLE_NODE_SLOTS))
>>>    		return -EBUSY;
>>> -	/*
>>> -	 * mas_rev_awalk() has set mas->min and mas->max to the gap values.  If
>>> -	 * the maximum is outside the window we are searching, then use the last
>>> -	 * location in the search.
>>> -	 * mas->max and mas->min is the range of the gap.
>>> -	 * mas->index and mas->last are currently set to the search range.
>>> -	 */
>>> -
>>>    	/* Trim the upper limit to the max. */
>>> -	if (mas->max <= mas->last)
>>> -		mas->last = mas->max;
>>> +	if (max <= mas->last)
>>> +		mas->last = max;
>> We can get max as follows, without using pointers to track min, max in
>> mas_rev_awalk().
>>
>> mt = mte_node_type(mas->node); pivots = ma_pivots(mas_mn(mas), mt); max =
>> mas_logical_pivot(mas, pivots, mas->offset, mt);
> Yes, but why would we do this?  We have done all this work already in
> mas_rev_awalk(), and we have to do it there to get the offset in the
> first place.
Yes, both methods will work.
>
>> 	if (max < mas->last) /* The equal sign here can be removed */
> Thanks.  I'll keep this in mind when I revisit the function.  I don't
> want to re-spin the patch for this alone.
>
>> 		mas->last = max;
>>
>>>    	mas->index = mas->last - size + 1;
>>>    	return 0;
