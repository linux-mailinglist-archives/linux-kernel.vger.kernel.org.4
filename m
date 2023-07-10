Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D241274D24F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjGJJwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjGJJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:51:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6E6E1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:47:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666eec46206so3714975b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688982452; x=1691574452;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPkF6Xq3Ksijok8XA9MFZkl+XulMiyDQGCTonazggUI=;
        b=chWhcN2sCCKyIM62U4NNuyElv0S591nGVkHfn7ERn5edStuEQ2czSUcv1RhSdMYq8p
         PCMNK6flxO4+nZu7UdNmgnTg8EKiHOYOw8QCqMDxf5IHg+j7MnIGBl4k06eVXpcSRe/k
         D++cWj7qdgTU1H37SOkwVY4mnMrI7ZZf31TF7M36BFH/B5X88gSTcWTkJngI6OYiRAxe
         W3JuV1IjNeClf95lwsFZgNcLvuyXmUj/XOKfssb9Z4CHdyyMa2IK2DWyzVD4igwx5Rv+
         NONFBIAE9h2+TA8ZwMbj+5UGvRsVExbwXCkucEsf3HacYgBFkwUJ7BQo0PhFWqeIjItX
         DcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982452; x=1691574452;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CPkF6Xq3Ksijok8XA9MFZkl+XulMiyDQGCTonazggUI=;
        b=Pm63Oc4Jv5SzWaUpiIVcJFbUfmfmYftWt0c8ll+eRtiXBuZA5ka9MKKzHMXKZie9hX
         X3ISBLXWyv8WAeUOQfb7SBDCwRMtM636QR7+KCVG4p9KoQhFjxE1ALnEllXmYTB52v9m
         ymmd884ikH6tsN9AIs3hrx46qfmrmbddkl5wit22TJTeeqh7OYL7I2IABT/vaqdCQpR3
         cOf6JClVvL5EXT9ArZXAbSQGeY9KQ+6hlU5dlZV+wGBJAb8iouhuMOUG0sqFuEC4Zgod
         ak9N+vixRr98Qa7uzj5Xv7BpKVVyr0ryl3M56K5isO8YDSiNhNNMtkDF2XeTP2yoFmTL
         5D0w==
X-Gm-Message-State: ABy/qLaITD6md3pth53hnhU+bECQeGIFhE3OxLArElGCp6z8Sbx8Nq6X
        rfHgP9tTa9sXZM++cZjJrtdqFOuIZlxw54MOVvE=
X-Google-Smtp-Source: APBJJlEwo2b8KRHKhBXpmIt5ZbfZfUN8PfLA2p0hJW3qVCx5qBfqz8w0fmkSjNdKFGJjSMvo+LlV/g==
X-Received: by 2002:a05:6a20:1589:b0:12c:6268:cd31 with SMTP id h9-20020a056a20158900b0012c6268cd31mr15162952pzj.47.1688982451780;
        Mon, 10 Jul 2023 02:47:31 -0700 (PDT)
Received: from [10.90.35.114] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jc3-20020a17090325c300b001b03f208323sm7812883plb.64.2023.07.10.02.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:47:31 -0700 (PDT)
Message-ID: <217a8c6b-a4d9-dba3-5a31-6f69414e0c46@bytedance.com>
Date:   Mon, 10 Jul 2023 17:47:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH 6/8] maple_tree: update mt_validate()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-7-zhangpeng.00@bytedance.com>
 <20230707150217.2ppiuemszsd5okfa@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230707150217.2ppiuemszsd5okfa@revolver>
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



在 2023/7/7 23:02, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
>> Instead of using mas_first_entry() to find the leftmost leaf, use a
>> simple loop instead. Remove an unneeded check for root node. To make
>> the error message more accurate, check pivots first and then slots,
>> because checking slots depend on the node limit pivot to break the loop.
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index e84a042b6d84..3aede7deaa26 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -7260,21 +7260,22 @@ void mt_validate(struct maple_tree *mt)
>>   	if (!mas_searchable(&mas))
>>   		goto done;
>>   
>> -	mas_first_entry(&mas, mas_mn(&mas), ULONG_MAX, mte_node_type(mas.node));
>> +	while (!mte_is_leaf(mas.node))
>> +		mas_descend(&mas);
>> +
>>   	while (!mas_is_none(&mas)) {
>>   		MAS_WARN_ON(&mas, mte_dead_node(mas.node));
>> -		if (!mte_is_root(mas.node)) {
>> -			end = mas_data_end(&mas);
>> -			if (MAS_WARN_ON(&mas,
>> -					(end < mt_min_slot_count(mas.node)) &&
>> -					(mas.max != ULONG_MAX))) {
>> -				pr_err("Invalid size %u of %p\n", end,
>> -				       mas_mn(&mas));
>> -			}
>> +		end = mas_data_end(&mas);
>> +		if (MAS_WARN_ON(&mas,
>> +				(end < mt_min_slot_count(mas.node)) &&
>> +				(mas.max != ULONG_MAX))) {
> 
> This line can be reformatted now that it is not as nested.
> 
>> +			pr_err("Invalid size %u of %p\n", end,
>> +				mas_mn(&mas));
> 
> Ditto here.
Thanks, I'll reformat it.
> 
>>   		}
>> +
>>   		mas_validate_parent_slot(&mas);
>> -		mas_validate_child_slot(&mas);
>>   		mas_validate_limits(&mas);
>> +		mas_validate_child_slot(&mas);
>>   		if (mt_is_alloc(mt))
>>   			mas_validate_gaps(&mas);
>>   		mas_dfs_postorder(&mas, ULONG_MAX);
>> -- 
>> 2.20.1
>>
>>
