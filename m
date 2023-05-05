Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD74F6F7B74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjEEDXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEEDXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:23:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F6512E;
        Thu,  4 May 2023 20:23:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1ab032d9266so11718555ad.0;
        Thu, 04 May 2023 20:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683257008; x=1685849008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1zI59DMPwElv3Pt8qHQPRARoujuK3z77nNH9VJstI0=;
        b=LxJaI/l/33pp4EkU9RxPz2ysCK1qnDvZNqromExIbQhMCW7q5QPFVbGJHK7EvtwL+d
         in0Ouxaz7FU2OYdhziplIhyDlEooIMyZNTZ/wTu5QY6jMorvjjaG5thYUF+f924YkrLn
         flWnUpAPnXNK6NLvvjS8hEPTmJGPAZyqNr8I+kwIZ50r6vp84vj1R5C1HSMRkU1sRDga
         jw9W8/t0Bg9PVIXSh8uXXW7m4c1eQKRr7DpqabLCmetYZK0ugJvUzDHQb0ganz10kiP0
         FXA3nxsnCfK02TaTwpG4KoiEEbEq0PvjP68PN/RLEggMJO/7nYhjWmZBYNUnMsr+xuGw
         /okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683257008; x=1685849008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W1zI59DMPwElv3Pt8qHQPRARoujuK3z77nNH9VJstI0=;
        b=MQ4v6A9iCNlE9YUrkTNw1oWwRPDagn3TqcF0AX17L1Kp/neuceo129r3n9XqndaFvq
         uyRpj5Qsim8w98Z0C+bdASGTbuaXhai31yxIjL1yrJrUIlz/ZykloJf6UU0383M0PkhN
         a77jL8iKvRiFWOf1HnbC7QV+0qaqR4jjwLOj9YCBGSOIswvbHh7R4EOF00HJ9ItYcMd3
         hEVxL0Qv6O27yNXMELMIbVZNLGPIzPohMnCBaEh85dGjEGM9by1zZWKFxStNdM7qMaZj
         vzfdOfVZxfV873g/dA4Je5xjbJILBfC2zdAvnIqVXn6SWTxdtFvwfHLzxvGZpYM+dfgv
         y2mQ==
X-Gm-Message-State: AC+VfDzYxqQsPFmuKCkpBug+2YK9rWARiRvgpAs7XUvRk+VrIWBxKEtw
        AFMxR3Y5cS7gKUIxm2BX7BM=
X-Google-Smtp-Source: ACHHUZ41IHoFMBo8xGwEV1vJVt/NKc6moH+fmC+BXkE7LhEz9gspAnlvYpkF61Ci8jJQHgE2VxWjPA==
X-Received: by 2002:a17:902:778a:b0:1aa:f612:cdf with SMTP id o10-20020a170902778a00b001aaf6120cdfmr5350391pll.37.1683257008322;
        Thu, 04 May 2023 20:23:28 -0700 (PDT)
Received: from [10.200.10.82] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id jh2-20020a170903328200b001ac38343438sm396075plb.176.2023.05.04.20.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 20:23:27 -0700 (PDT)
Message-ID: <4912002a-4fa8-c1c0-a8c4-690b6dd76449@gmail.com>
Date:   Fri, 5 May 2023 11:23:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] maple_tree: Make maple state reusable after
 mas_empty_area()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        Stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20230504175509.2195838-1-Liam.Howlett@oracle.com>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230504175509.2195838-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/5 01:55, Liam R. Howlett 写道:
> Do not update the min and max of the maple state to the slot of the leaf
> node.  Leaving the min and max to the node entry allows for the maple
> state to be used in other operations.
> 
> Users would get unexpected results from other operations on the maple
> state after calling the affected function.
> 
> Reported-by: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
> Reported-by: Tad <support@spotco.us>
> Reported-by: Michael Keyes <mgkeyes@vigovproductions.net>
> Link: https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc84366608624d.camel@intel.com/
> Link: https://lore.kernel.org/linux-mm/e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us/
> Fixes: Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/maple_tree.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 110a36479dced..1c4bc7a988ed3 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5285,10 +5285,6 @@ static inline int mas_sparse_area(struct ma_state *mas, unsigned long min,
>   int mas_empty_area(struct ma_state *mas, unsigned long min,
>   		unsigned long max, unsigned long size)
>   {
> -	unsigned char offset;
> -	unsigned long *pivots;
> -	enum maple_type mt;
> -
>   	if (min >= max)
>   		return -EINVAL;
>   
> @@ -5311,18 +5307,9 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
>   	if (unlikely(mas_is_err(mas)))
>   		return xa_err(mas->node);
>   
> -	offset = mas->offset;
> -	if (unlikely(offset == MAPLE_NODE_SLOTS))
> +	if (unlikely(mas->offset == MAPLE_NODE_SLOTS))
>   		return -EBUSY;
>   
> -	mt = mte_node_type(mas->node);
> -	pivots = ma_pivots(mas_mn(mas), mt);
> -	if (offset)
> -		mas->min = pivots[offset - 1] + 1;
> -
> -	if (offset < mt_pivots[mt])
> -		mas->max = pivots[offset];
> -
>   	if (mas->index < mas->min)
>   		mas->index = mas->min;
This will bring new bugs, mas->index should take the maximum
value with mas->index and mas_safe_min(mas, pivots, offset),
otherwise there will be overwriting allocation.

Maybe you have forgotten, I have posted a patch[1] with the same
function last week. I didn't know of a place where mas was used
after mas_empty_area() before. That patch does not introduce new
bugs, but the code style has not been updated yet. If using this
patch will bring more conflicts with my patch set, so what should
I do? 😁

[1] 
https://lore.kernel.org/lkml/20230425110511.11680-3-zhangpeng.00@bytedance.com/
>   
