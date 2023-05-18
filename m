Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9CC707CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjERJ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjERJ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:27:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B30212D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:27:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so1402107b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684402028; x=1686994028;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU7aBsTo13peSnxAr13S+9sSOP5G0yxxrZ4nKy4EJms=;
        b=dTzSjl3dOxjVr7eoBVRCE6ql5PPkW7WsDyDigFAecrP+DqunYSG4+U2dkL5/GDhcBE
         Q00PrQlKeKCiPgsl5WvUBneMn7dSc8Nr3I/o2MxbHnJUDNlRYlGYmXU5STP0kcF09a2D
         AqMbPPJsMCJyVs2w1TDGdhRmySqVfi/RY7gVNMKSHRRN4H35i+Y1bIgYPqTDez06XzZB
         woh1bK1EH2gzmqcY7Z6oIANqWMeLZsT7kcrCzBeTdnD73jWDC1kNJA6Lz5HC0cLirBjo
         ej+RAWGasQcb/FMWzPRuCQyiBdJs02CnTkwa4Wfy0iTTTVwTTiYXZvIUyAQUmiPD5IVE
         njlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684402028; x=1686994028;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AU7aBsTo13peSnxAr13S+9sSOP5G0yxxrZ4nKy4EJms=;
        b=kR6nnCvOUDsL6n3S9I3U/xPJRFyd6x3SiGySG34ZzjvRKBVTnCz7UcqJJ7i2TinLK5
         nEmLmmka3mLtZf6LQ14T4Gjq6E9FMXzBkG552xA9HfWAIoWrl+ml+1hrkIrj+5YBsuZc
         sEeZqm+P+sHSp/Z62cSuX6hQC69hQFs+FxPMWNS/jxTDJAh9HQX6ZsS+jLevwB0wi4cb
         lyx1fT6QJ5EuBApXlcK91MFdR04hXXrH3HjVJBCQJHAj6o5a4Tiv7RNon4jPG6jM/OAr
         uVQK3zx8WKXQIQRyJTb9fvrn4+AXqUkqeILA2JEuiKNE0ZsQ1bjn871BsAsAduiI4rXm
         oqrw==
X-Gm-Message-State: AC+VfDxJthoZE/EnkBM4gSlbmHaNhIgVVk5LmY+RNUTxGTUmNHjQp/87
        O+h0aOtDTZ7HWyanELa7WY/KoQ==
X-Google-Smtp-Source: ACHHUZ7elpSRZPKDv+KEMNrC6bEC76p7PXUPoZORuJEY0LJ+LvI0E2tjfDj/MNboWzhsTgb8PgYa7Q==
X-Received: by 2002:a05:6a00:1404:b0:647:b6c9:179d with SMTP id l4-20020a056a00140400b00647b6c9179dmr3709020pfu.21.1684402028597;
        Thu, 18 May 2023 02:27:08 -0700 (PDT)
Received: from [10.200.9.101] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m8-20020aa79008000000b0064ca36ebb50sm950648pfo.93.2023.05.18.02.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 02:27:08 -0700 (PDT)
Message-ID: <8a52ce18-823c-7d75-30b7-e72a8bcf5665@bytedance.com>
Date:   Thu, 18 May 2023 17:27:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2 07/10] maple_tree: Add comments and some minor cleanups
 to mas_wr_append()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
 <20230517085809.86522-8-zhangpeng.00@bytedance.com>
 <20230517193353.xwd6vztfjqxesyl6@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230517193353.xwd6vztfjqxesyl6@revolver>
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



在 2023/5/18 03:33, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230517 04:59]:
>> Add comment for mas_wr_append(), move mas_update_gap() into
>> mas_wr_append(), and other cleanups to make mas_wr_modify() cleaner.
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 33 ++++++++++++++++++++-------------
>>   1 file changed, 20 insertions(+), 13 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 3b9d227f3d7d..bbe4c6f2858c 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -4308,6 +4308,12 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>>   	return new_end;
>>   }
>>   
>> +/*
>> + * mas_wr_append: Attempt to append
>> + * @wr_mas: the maple write state
>> + *
>> + * Return: True if appended, false otherwise
>> + */
>>   static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>>   {
>>   	unsigned char end = wr_mas->node_end;
>> @@ -4315,7 +4321,11 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>>   	struct ma_state *mas = wr_mas->mas;
>>   	unsigned char node_pivots = mt_pivots[wr_mas->type];
>>   
>> +	if (!(mas->offset == wr_mas->node_end))
>> +		return false;
>> +
>>   	if ((mas->index != wr_mas->r_min) && (mas->last == wr_mas->r_max)) {
>> +		/* Append to end of range */
>>   		if (new_end < node_pivots)
>>   			wr_mas->pivots[new_end] = wr_mas->pivots[end];
>>   
>> @@ -4323,13 +4333,10 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>>   			ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
>>   
>>   		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->entry);
>> -		mas->offset = new_end;
>>   		wr_mas->pivots[end] = mas->index - 1;
>> -
>> -		return true;
>> -	}
>> -
>> -	if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
>> +		mas->offset = new_end;
>> +	} else if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
>> +		/* Append to start of range */
>>   		if (new_end < node_pivots)
>>   			wr_mas->pivots[new_end] = wr_mas->pivots[end];
>>   
>> @@ -4339,10 +4346,13 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>>   
>>   		wr_mas->pivots[end] = mas->last;
>>   		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
>> -		return true;
>> +	} else {
>> +		return false;
> 
> I don't think we can get here with your changes, what do you think?  If
> so, we can move the metadata setting to the outside of the if/else.  I
> checked by adding a BUG_ON() and the test code never gets here.
> 
> My thinking is, we know offset == node_end and new_end == node_end + 1..
> so we must be inserting into the last slot and only adding one entry.
Yes, I'll address this in v3. Thanks.
> 
>>   	}
>>   
>> -	return false;
>> +	if (!wr_mas->content || !wr_mas->entry)
>> +		mas_update_gap(mas);
>> +	return  true;
>>   }
>>   
>>   /*
>> @@ -4382,12 +4392,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>>   	if (new_end >= mt_slots[wr_mas->type])
>>   		goto slow_path;
>>   
>> -	if (wr_mas->entry && (wr_mas->node_end < mt_slots[wr_mas->type] - 1) &&
>> -	    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
>> -		if (!wr_mas->content || !wr_mas->entry)
>> -			mas_update_gap(mas);
>> +	/* Attempt to append */
>> +	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
>>   		return;
>> -	}
>>   
>>   	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
>>   		return;
>> -- 
>> 2.20.1
>>
