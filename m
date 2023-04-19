Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ADB6E75EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjDSJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjDSJCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:02:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2E530E0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:02:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-246f856d751so2105975a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681894932; x=1684486932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79PwKIpTwwaVU82r+U4/sK48h5bR61sbuArdiDnpPEo=;
        b=VqMdtfuj6C2mrAI6yBezO+vvPulybbVN53rDsaeUShooyCwrV3Iz0fFfj07Utjp0cY
         mYqM4WGvsXfcjOFUlDUGwRwLZlh5xRogbtYBDh4E/TL2IDVIS8BKmwOiSIHdvXKIeXFK
         niMvIVIXWrzMxiw3/LcIdW4lZn4NgUZIw0i/1225WGpyMnIBrkJceWOg2AmJFiV4vS38
         W/b7q/KIVcvEsgGBkn4BChla5oOdA6TcS2a9WEH2+j6HLVg2qgVTU5O/1B0WjRcPeCK+
         lzmmBh+gaTXkzrb48EVnC1+V/aznAVBNVBY8QVw/fUDIH3JiZ9k3TRmmvhi5cp3XgjI8
         KMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681894932; x=1684486932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=79PwKIpTwwaVU82r+U4/sK48h5bR61sbuArdiDnpPEo=;
        b=YY7TRfPwzDOcuJDfG3OiCf9aiqWm/g2wlxyM7Htp5BL6/KQC7T6mHlcpjJHHRzQa01
         6GTt51PPjImE1u9OGV7/VlSJV9chxBjtRHLcsQTA1mB0up0ybSvOLDZj0oLFTS7EwT8j
         B+FClrlNyYOMN+WJ643CzWhDX3xbUillk519gPJ2LXVk50GucSPOj8DOVD6vfUzfvrIw
         5brW+q/rsVc2CZ7haf3LuM/2Pto7JDwAoXnuhbranLTvtnWxYZ+miR4BWZ2bZTbL3PRr
         dB6KPQn8R6+S4K7okaF9h5nr78v+ltWUxCrzbjVS+wpoc941fRh5tS1jzIki/SWxwDAK
         BJFg==
X-Gm-Message-State: AAQBX9ev2CUHqVAEgGax2WiXr5s3InacFgRzQJcnrgBnDSDkBVVONSFh
        rHQZ4/Q3huoZBKHQ5+lCq/iHdw==
X-Google-Smtp-Source: AKy350Zyon11ZRmLF1eWKBAifnjG/I/XA1S6Cs0fCVKPdxotC+oeh4/lZy4dm+NPRfZHbcK23TeLMw==
X-Received: by 2002:a17:90a:38a5:b0:246:818c:d8e4 with SMTP id x34-20020a17090a38a500b00246818cd8e4mr2493452pjb.11.1681894931889;
        Wed, 19 Apr 2023 02:02:11 -0700 (PDT)
Received: from [10.200.10.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id lx3-20020a17090b4b0300b00246cc751c6bsm929701pjb.46.2023.04.19.02.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:02:11 -0700 (PDT)
Message-ID: <90fd5cfa-5ed9-495f-fdef-0130adaf591b@bytedance.com>
Date:   Wed, 19 Apr 2023 17:02:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] maple_tree: Make maple state reusable after
 mas_empty_area_rev()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/14 22:57, Liam R. Howlett 写道:
> Stop using maple state min/max for the range by passing through pointers
> for those values.  This will allow the maple state to be reused without
> resetting.
>
> Also add some logic to fail out early on searching with invalid
> arguments.
>
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/maple_tree.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4df6a0ce1c1b..ed350aa293b2 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4938,7 +4938,8 @@ static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
>    * Return: True if found in a leaf, false otherwise.
>    *
>    */
> -static bool mas_rev_awalk(struct ma_state *mas, unsigned long size)
> +static bool mas_rev_awalk(struct ma_state *mas, unsigned long size,
> +		unsigned long *gap_min, unsigned long *gap_max)
>   {
>   	enum maple_type type = mte_node_type(mas->node);
>   	struct maple_node *node = mas_mn(mas);
> @@ -5003,8 +5004,8 @@ static bool mas_rev_awalk(struct ma_state *mas, unsigned long size)
>   
>   	if (unlikely(ma_is_leaf(type))) {
>   		mas->offset = offset;
> -		mas->min = min;
> -		mas->max = min + gap - 1;
> +		*gap_min = min;
> +		*gap_max = min + gap - 1;
>   		return true;
>   	}
>   
> @@ -5280,6 +5281,9 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
>   	unsigned long *pivots;
>   	enum maple_type mt;
>   
> +	if (min >= max)
This can lead to errors, min == max is valid.
I think it's better to change it to this:
if (min > max || size == 0 || max - min < size - 1)
> +		return -EINVAL;
> +
>   	if (mas_is_start(mas))
>   		mas_start(mas);
>   	else if (mas->offset >= 2)
> @@ -5334,6 +5338,9 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>   {
>   	struct maple_enode *last = mas->node;
>   
> +	if (min >= max)
ditto.
> +		return -EINVAL;
> +
>   	if (mas_is_start(mas)) {
>   		mas_start(mas);
>   		mas->offset = mas_data_end(mas);
> @@ -5353,7 +5360,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>   	mas->index = min;
>   	mas->last = max;
>   
> -	while (!mas_rev_awalk(mas, size)) {
> +	while (!mas_rev_awalk(mas, size, &min, &max)) {
>   		if (last == mas->node) {
>   			if (!mas_rewind_node(mas))
>   				return -EBUSY;
> @@ -5368,17 +5375,9 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>   	if (unlikely(mas->offset == MAPLE_NODE_SLOTS))
>   		return -EBUSY;
>   
> -	/*
> -	 * mas_rev_awalk() has set mas->min and mas->max to the gap values.  If
> -	 * the maximum is outside the window we are searching, then use the last
> -	 * location in the search.
> -	 * mas->max and mas->min is the range of the gap.
> -	 * mas->index and mas->last are currently set to the search range.
> -	 */
> -
>   	/* Trim the upper limit to the max. */
> -	if (mas->max <= mas->last)
> -		mas->last = mas->max;
> +	if (max <= mas->last)
> +		mas->last = max;

We can get max as follows, without using pointers to track min, max in 
mas_rev_awalk().

mt = mte_node_type(mas->node); pivots = ma_pivots(mas_mn(mas), mt); max 
= mas_logical_pivot(mas, pivots, mas->offset, mt);
	if (max < mas->last) /* The equal sign here can be removed */
		mas->last = max;

>   
>   	mas->index = mas->last - size + 1;
>   	return 0;
