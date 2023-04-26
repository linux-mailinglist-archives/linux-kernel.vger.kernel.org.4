Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE96F6EF178
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbjDZJzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbjDZJzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:55:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7ACE70
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:55:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b73203e0aso41812654b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682502906; x=1685094906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WcXXQ9El7bhpzRjBoXxi5W9GL1V2G+UTnr8MF+P28w=;
        b=jg2dhbfkTzUbfVin0XiCodsU8Wf3/shfbmdsWTF+WhtarAlHBcXcTHnDaQsHcpqmwc
         g4bx3d6+m/v2h7wXGPBX14ebyfCBbvhTkIevdRU60+VhuA0sTbGNFO0S6Sp1+Cn+XJja
         J0eF4VmPt0LRQ1EXw83tJPGz2GbaowPjlR1koJ2gOZCWpEqM3M237JAtI9m7ahQvty+x
         2LGROPH585NlUbMTiEE5MqNSdruPB4B/ifsS9Jxx/YGa4WkpXdbY0+c9fxa8HWp+Rrz7
         c8fjW3p7HFggE12OsbgXWaOGdW/3iDlV47FST4Za690KRkvkYVSlhIBS3Pf1pR7HI9R0
         fNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682502906; x=1685094906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4WcXXQ9El7bhpzRjBoXxi5W9GL1V2G+UTnr8MF+P28w=;
        b=JrZwjyi5Icsf8/3dNyqqEycUV6+I0KVFXk/bDteRo5zEtp8VGVHx69KqLF5WR8oF32
         2fDBAk89cKaC7lLTCB1PqTij1+Ghz1wdmH1P+pXIAM9C+p+JY3V0slp8gPdvaJ5K9+VB
         NgdpAoV8KPlCSpn3QpFl/8dXHcXCc+VbvqRrQjj68isVvdHm7l0N37Knyuvx5TPMUR/e
         Wfr4yO7oxYIGb3cn2Y/yTiRIVSTZifFoz/LTZH88Tp9iHTOqZ92CtnvXwkcp6sQfBLRU
         ZVZme59BWcD9knYuGXKHxRmhndW/MoEvCfDZVNpyhsH/vCucOqg+DMX0OXISf8JOqwV1
         Z1Gw==
X-Gm-Message-State: AC+VfDx6wZfJNUzRlkcGyXJNjYi2N5XrzJTT8ScB9+KAbi4IuN4Vfhr+
        raxJ0v6zyFMrf74OorB4eajgUD07GImY/dYfCmw=
X-Google-Smtp-Source: ACHHUZ7q5+Jo6ruEQ0ATLTis/CDwtKDXMtwWbwqRGLbxqxtp3LHBcunTamcuLGVSES+uw/oVgmvuag==
X-Received: by 2002:aa7:90d1:0:b0:63f:2959:a271 with SMTP id k17-20020aa790d1000000b0063f2959a271mr1925753pfk.6.1682502906555;
        Wed, 26 Apr 2023 02:55:06 -0700 (PDT)
Received: from [10.200.11.252] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id o8-20020a62f908000000b0062e23e81b24sm10718333pfh.114.2023.04.26.02.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 02:55:06 -0700 (PDT)
Message-ID: <6b507b20-f3d1-b82d-cb20-7354c8acd20e@bytedance.com>
Date:   Wed, 26 Apr 2023 17:55:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 15/34] maple_tree: Return error on mte_pivots() out of
 range
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-16-Liam.Howlett@oracle.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230425140955.3834476-16-Liam.Howlett@oracle.com>
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


在 2023/4/25 22:09, Liam R. Howlett 写道:
> Rename mte_pivots() to mas_pivots() and pass through the ma_state to set
> the error code to -EIO when the offset is out of range for the node
> type.  Change the WARN_ON() to MAS_WARN_ON() to log the maple state.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>   lib/maple_tree.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 41873d935cfa3..89e30462f8b62 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -663,22 +663,22 @@ static inline unsigned long *ma_gaps(struct maple_node *node,
>   }
>   
>   /*
> - * mte_pivot() - Get the pivot at @piv of the maple encoded node.
> - * @mn: The maple encoded node.
> + * mas_pivot() - Get the pivot at @piv of the maple encoded node.
> + * @mas: The maple state.
>    * @piv: The pivot.
>    *
>    * Return: the pivot at @piv of @mn.
>    */
> -static inline unsigned long mte_pivot(const struct maple_enode *mn,
> -				 unsigned char piv)
> +static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
>   {
> -	struct maple_node *node = mte_to_node(mn);
> -	enum maple_type type = mte_node_type(mn);
> +	struct maple_node *node = mas_mn(mas);
> +	enum maple_type type = mte_node_type(mas->node);
>   
> -	if (piv >= mt_pivots[type]) {
> -		WARN_ON(1);
> +	if (MAS_WARN_ON(mas, piv >= mt_pivots[type])) {
> +		mas_set_err(mas, -EIO);
>   		return 0;
>   	}
> +
>   	switch (type) {
>   	case maple_arange_64:
>   		return node->ma64.pivot[piv];
> @@ -5400,8 +5400,8 @@ static inline int mas_alloc(struct ma_state *mas, void *entry,
>   			return xa_err(mas->node);
>   
>   		if (!mas->index)
> -			return mte_pivot(mas->node, 0);
> -		return mte_pivot(mas->node, 1);
> +			return mas_pivot(mas, 0);
> +		return mas_pivot(mas, 1);
>   	}
>   
>   	/* Must be walking a tree. */
> @@ -5418,7 +5418,10 @@ static inline int mas_alloc(struct ma_state *mas, void *entry,
>   	 */
>   	min = mas->min;
>   	if (mas->offset)
> -		min = mte_pivot(mas->node, mas->offset - 1) + 1;
> +		min = mas_pivot(mas, mas->offset - 1) + 1;
> +
> +	if (mas_is_err(mas))
> +		return xa_err(mas->node);
>   
>   	if (mas->index < min)
>   		mas->index = min;
