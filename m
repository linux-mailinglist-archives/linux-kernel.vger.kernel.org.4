Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D172F6EF390
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbjDZLoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDZLoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:44:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9FE5261
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:43:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a682eee3baso53311885ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682509431; x=1685101431;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SffcOdPFYwFBhUJALuYvbVJpxK8qpMoV7ZnXznDGJxU=;
        b=aiKsoFcuQ3/rvu7ijYNZLVivEeqZwES90MiJVM7/pm+XuKpyc1P/K36Nyz8bphEPuD
         f47kr6cdI0l5OTvvxLNoZdd6L47KyPEbUmcLnAom/60XFqhoFa12cmt9m8Rr5ePJFTbD
         G+5Y4IxsaEPUTCKVu+/0nVVFfRQhLU26MuT16euC3Gq5+d5Genz6rJuv3I0cPxDjkDrZ
         lMnUMpTlvBGxQIGy/kyHTzbL3NJ81OWq1hqFid1JRDsc35WRaAmiWR0Dz/TveRolN/gO
         64Z5A+xhhrSfjJ0SJROlPh7yS6C0MUoKbWCwzfYoR/s2EzVjBoW7SPnizZSE5jhVL7rI
         9A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682509431; x=1685101431;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SffcOdPFYwFBhUJALuYvbVJpxK8qpMoV7ZnXznDGJxU=;
        b=GxXq+xs0Hm5L/v0d38N0f166QV7Yyj1FlygNi1/0GTA18r60UCdVES11hnsSEWHGlZ
         LUyTVhF/fi/tVVzWnstskTzlygbkeH0oSRdNgGSFpGTVyTUiH4f7ljtyTHtewRekV91M
         JIVHQasXTmQ1bYjkBa2m5TrReNMJIcGPon6qzpq2JeYpMLhCtQhcJocaHWnnamlgty9Y
         StpJat+W5qCM+4jdQ7gfqAWKb4JTf/GOyKG3SrjzXXQTjzmOFggzAQ7ypNG6+TlZYnv7
         2m/B7NME5bGskkVZEpizpPsUofhBFvEVThNPUTqyMh5Mfzj8Ycr9UYNhzBfHdvcKpk4Y
         pzrA==
X-Gm-Message-State: AC+VfDyuvefIlUbl19qDCer47jpz5vJwX2DadHh5Eg4CFySeL+eac1/9
        Sj/gF7dM4fKVB9kSYCjQ5K9DV26Pga8plplDO/M=
X-Google-Smtp-Source: ACHHUZ48IbgMVJXJeGs36QJMmIaB7yhNYon5UCBibgZxmSqy/qWbJ58UNy97GbLoop2nzlqpHuPfvg==
X-Received: by 2002:a17:902:ea02:b0:1a9:7bf4:17c0 with SMTP id s2-20020a170902ea0200b001a97bf417c0mr11250862plg.4.1682509431419;
        Wed, 26 Apr 2023 04:43:51 -0700 (PDT)
Received: from [10.200.11.252] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902ee8d00b001a66bf1406bsm9814008pld.144.2023.04.26.04.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 04:43:51 -0700 (PDT)
Message-ID: <19049997-7971-f39c-a466-dd4ba498a902@bytedance.com>
Date:   Wed, 26 Apr 2023 19:43:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 7/9] maple_tree: Delete redundant code in mas_next_node()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
 <20230425110511.11680-8-zhangpeng.00@bytedance.com>
 <20230425164507.dulntzwtkm5mp4ia@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230425164507.dulntzwtkm5mp4ia@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/26 00:45, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230425 07:05]:
>
> The title of the patch seems wrong.
>
> This isn't redundant code and you aren't deleting it.. you are moving a
> block of code outside a loop.  You did modify the check though, is that
> the redundant code?
>
>> When offset == node_end is satisfied, go to the parent node, mas->max
>> will not change. So there is no need to update min on the move.
> Please try not to state the code in your commit message.
>
> I have moved this block of code in patch 27/34 [1]
>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 83441ef2e1f57..8bfa837b7b752 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -4616,7 +4616,8 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
>>   	enum maple_type mt;
>>   	void __rcu **slots;
>>   
>> -	if (mas->max >= max)
>> +	min = mas->max + 1;
>> +	if (min > max)
>>   		goto no_entry;
> What happens on overflow?
Yes, I made a mistake.
I will drop this patch since you have updated the code in patch 27/34.
>
>>   
>>   	level = 0;
>> @@ -4624,10 +4625,6 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
>>   		if (ma_is_root(node))
>>   			goto no_entry;
>>   
>> -		min = mas->max + 1;
>> -		if (min > max)
>> -			goto no_entry;
>> -
>>   		if (unlikely(mas_ascend(mas)))
>>   			return 1;
>>   
>> -- 
>> 2.20.1
>>
> [1] https://lore.kernel.org/linux-mm/20230425140955.3834476-28-Liam.Howlett@oracle.com/
