Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC20704266
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245652AbjEPAq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEPAq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:46:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151CA30FD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:46:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643990c5319so9751768b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684197989; x=1686789989;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDi9QiH87Cp3PZCo0IhMsN8Lc2HnE+P0EXXDhwfZN0c=;
        b=gMu50Zwsoi8EzEHaZxngzpik/gB9iLHwjS8tqvV5YCmtn1ZyBl4/M9lYcorbZ3dARm
         TAVThDJelNk8PVeB6mDftPyOzlMM3fvm3tcm4zVS+o6fGy4ViDQ31HENRCK0SEEYDFiZ
         YmiciDZyJi+oZH2BTuJM030ra7IQE1yz8nGcaVJmGFI2AQ8hd8LDTil0NNuAFXjhMTL+
         ALNHma6I3Cj94KE9UCFzPfNAzfw5IJOrpFRjFuTCsn0zt+IW46ndr/uX9r0RDvkitoGI
         qk3pPfAl1Bd59TP7mpgFw5zJWNt3JASIEreb427prVVQ7RoSGvPowWujg5FHevREQ2tR
         L3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684197989; x=1686789989;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SDi9QiH87Cp3PZCo0IhMsN8Lc2HnE+P0EXXDhwfZN0c=;
        b=jvxMzLoGv37pmjcqq/qAbl1MeU3Qs9uCcrUHWA9VVa3EZ/280ZDWnrCt4qDv0dbpYU
         kWDqW9i27T+nBYAK2W/sXbHAfzVTMcud6/kF6DlxMfQwazMhDZVjQMFIJP0jCedDe6HL
         rmnqqwivCUoL98k+kOqaJd9vRrWWyRB+YqGugxUvUj9uFsBPh70AjMjCkTZGl0Xxrnih
         zCmQE7rxdFhdFWbJuu/TB6NcVxHjGGR6s7Eb2X9Rg6wkPpV4QLYvlZz2Lv6HvpkftiuO
         jUjRB9IMI7skJpRUm7Denk6mGb7VYU/S1iUUgNSS0ZoSDF01dlSnD3Xc4HWrSt1ysbea
         PvNw==
X-Gm-Message-State: AC+VfDzPe+PJZmejnW0dcGXkgSJwYYPA19ipNm2ZrfUoxIds6TcTBXw1
        AboB0AP/NiNYeES+4ldbfEKU0Q==
X-Google-Smtp-Source: ACHHUZ5FMGE/25OnGZtMdcIC2G/2MrggSWbZvRMQRCWqYWZ65/rE2QTrrfWw9IK1WAEn4Dt8TUGGRg==
X-Received: by 2002:a05:6a00:1503:b0:643:96e:666b with SMTP id q3-20020a056a00150300b00643096e666bmr48701812pfu.34.1684197989589;
        Mon, 15 May 2023 17:46:29 -0700 (PDT)
Received: from [10.200.9.178] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id a5-20020aa780c5000000b006439bc7d791sm12343787pfn.57.2023.05.15.17.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 17:46:29 -0700 (PDT)
Message-ID: <830328dd-ddb6-bdc5-2d74-35b5212cc569@bytedance.com>
Date:   Tue, 16 May 2023 08:46:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 06/10] maple_tree: Wrap the replace operation with an
 inline function.
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-7-zhangpeng.00@bytedance.com>
 <20230515170722.6eqyckjaggw5wijq@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230515170722.6eqyckjaggw5wijq@revolver>
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



在 2023/5/16 01:07, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
>> To make mas_wr_modify() cleaner, wrap the replace operation with an
>> inline function.
> 
> mas_wr_modify() is already pretty small.  Is there any reason you want
> this in its own function besides it looking cleaner?
I just want to make the four fast paths in mas_wr_modify()
look uniform without any functional effect.
> 
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 4c649d75a4923..ce695adc670ec 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -4288,6 +4288,19 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
>>   	}
>>   }
>>   
>> +static inline bool mas_wr_replace(struct ma_wr_state *wr_mas)
>> +{
>> +	struct ma_state *mas = wr_mas->mas;
>> +
>> +	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
>> +		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
>> +		if (!!wr_mas->entry ^ !!wr_mas->content)
>> +			mas_update_gap(mas);
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>>   static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>>   {
>>   	unsigned char end = wr_mas->node_end;
>> @@ -4347,13 +4360,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>>   	unsigned char node_size;
>>   	struct ma_state *mas = wr_mas->mas;
>>   
>> -	/* Direct replacement */
>> -	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
>> -		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
>> -		if (!!wr_mas->entry ^ !!wr_mas->content)
>> -			mas_update_gap(mas);
>> +	/* Attempt to direct replace */
>> +	if (mas_wr_replace(wr_mas))
>>   		return;
>> -	}
>>   
>>   	/* Attempt to append */
>>   	node_slots = mt_slots[wr_mas->type];
>> -- 
>> 2.20.1
>>
