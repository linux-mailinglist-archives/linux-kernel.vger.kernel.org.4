Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58A16FC69F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjEIMkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjEIMju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:39:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABDF49D7
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:39:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a516fb6523so54665055ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683635962; x=1686227962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSg39pJOZ91SeEigcRuN6jVIeNHw1ilok4weiuhyDQ4=;
        b=HLCxQEs3+pODJpg0ga0dpy157prnJ6SfufjjhrAGeFxNZ2lQmMmJHf22cbESLnIxTe
         VTD0mas+tFLOMshP8pygrGqkgm6XMwNpwbVICxepqmppdJGISDrm88qP3X1Co/RLI2D8
         70tZ7PRVAhqYwK5EPRkUasxy2TdtMXQMszd0EPHydscoL2S+hQDjyL1/MYVxE4XOzgxy
         BjflFVADvJ9Qdn9TH0hozxHZNynY9MlvJh/nzPGpD4nORG+bO922tbzPVkN/2eXBubMT
         Sdny4NDVe/qRNdnm5l2EZ91vfzicxFQT41wrJOqiPRo9DWnErCK9Uclr4jAIMYhKVgc0
         2PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683635962; x=1686227962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dSg39pJOZ91SeEigcRuN6jVIeNHw1ilok4weiuhyDQ4=;
        b=PkBGfWVoFYejiqL04/YDTHUOkc2glA4bCG7KCt3PGwjcZL7jcM+68e5MscLh9JNPV/
         S5FBUeAV6FLE53V3kCT2KYNhWLNcrjKQ6HjRGqTI+m0vs+xfsaGoqX2unaJ2YBk/uY5x
         tPhdx6+M6hmelvD9vVn4jMEVVxP52jOvaWU9HztX4/yxwqrJYG0IO33mCeSz7R8vG2ZY
         tMJOu8PP8vBW7lriOPO6R2L/mZdWSaQ6gRw/yLOc7+YYzOuyi+xTwm9dCIp0PJJlWCbj
         xMJocsAi0PixV6FiwEHvW0aZPrwfLR7++W/qJV3bwoJNv97uK9K9JKbiuuQg8+zYQZD6
         dj1Q==
X-Gm-Message-State: AC+VfDzczKBj1Sb4QGi4h3uOvShW0C82U23AwV6TbknganReuoikxkMx
        7gqlQZP8DN6VL3u5rwiayaKwnA==
X-Google-Smtp-Source: ACHHUZ7PDkAiktdvBVywP+icr+5g3Sv2XARVqAaJlQ/pQP33I6gzKrGH9bpQoAULAbwFcpsYw6KmoA==
X-Received: by 2002:a17:903:244c:b0:1ab:19ff:3a20 with SMTP id l12-20020a170903244c00b001ab19ff3a20mr16795752pls.54.1683635962003;
        Tue, 09 May 2023 05:39:22 -0700 (PDT)
Received: from [10.200.10.82] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id n6-20020a1709026a8600b001aad2910194sm1468042plk.14.2023.05.09.05.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 05:39:21 -0700 (PDT)
Message-ID: <5ca5da7f-1b17-b22b-58c4-eae41443e334@bytedance.com>
Date:   Tue, 9 May 2023 20:39:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2 32/36] maple_tree: Clear up index and last setting in
 single entry tree
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
 <20230505174204.2665599-33-Liam.Howlett@oracle.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230505174204.2665599-33-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/6 01:42, Liam R. Howlett 写道:
> When there is a single entry tree (range of 0-0 pointing to an entry),
> then ensure the limit is either 0-0 or 1-oo, depending on where the user
> walks.  Ensure the correct node setting as well; either MAS_ROOT or
> MAS_NONE.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/maple_tree.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index f060c71965c0d..914399519cf54 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5022,24 +5022,25 @@ void *mas_walk(struct ma_state *mas)
>   {
>   	void *entry;
>   
> +	if (mas_is_none(mas) || mas_is_paused(mas))
if (mas_is_none(mas) || mas_is_paused(mas) || mas_is_ptr(mas))
> +		mas->node = MAS_START;

Hi, Liam
There is an issue that it cannot pass the user space test program
with this patchset.
I tested it based on 47cba14ce6fc4(linux-next/master).

The reason is that mas_walk() does not handle the state that mas is
root. The root cause is that mas_start() only handles the start state,
and returns NULL for the root state. When encountering the root state,
we can reset to start so that it is handled in mas_start().

log:
BUG at check_state_handling:3076 (1)
maple_tree(0x55d6a9838ca0) flags 1, height 0 root 0x1234500
0: 0x1234500
Pass: 453406336 Run:453406337
maple: ../../../lib/test_maple_tree.c:3076: check_state_handling: 
Assertion `0' failed.
Aborted (core dumped)
>   retry:
>   	entry = mas_state_walk(mas);
> -	if (mas_is_start(mas))
> +	if (mas_is_start(mas)) {
>   		goto retry;
> -
> -	if (mas_is_ptr(mas)) {
> +	} else if (mas_is_none(mas)) {
> +		mas->index = 0;
> +		mas->last = ULONG_MAX;
> +	} else if (mas_is_ptr(mas)) {
>   		if (!mas->index) {
>   			mas->last = 0;
> -		} else {
> -			mas->index = 1;
> -			mas->last = ULONG_MAX;
> +			return entry;
>   		}
> -		return entry;
> -	}
>   
> -	if (mas_is_none(mas)) {
> -		mas->index = 0;
> +		mas->index = 1;
>   		mas->last = ULONG_MAX;
> +		mas->node = MAS_NONE;
> +		return NULL;
>   	}
>   
>   	return entry;
