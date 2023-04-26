Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A916EED88
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 07:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbjDZF2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 01:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjDZF22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 01:28:28 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0E01702
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 22:28:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b51fd2972so5278200b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 22:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682486882; x=1685078882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxdQSe72d3sjq+Prr4mwyPnfSSkLPwhzfDnldlQ4qk4=;
        b=fDYawT5vqUlOtaRh1EOPfxUV9+CjQfLaHmQT3OZlTb2X+Diy2M+p+l4YVuPj57dXs7
         BkM3anEZkn7XVQZZW9enjlZXWrr9+CR7ajfSVVyQ+wNWHAa9vy7lfOonyQARdinKv+yB
         cMXKuqJ9wX9bnDFiIyDRVT8bls7XQ5LxzT7KpqZn+Wn5VNIiuUJsmJULlL9Vowd6jxiE
         A/fMun+XkJmK0xbL4I2TJ1J3/SGIDwNMxYWEQzmrhsT+7SOcqvlf/YBjil6uGaG7JSCP
         Ivv8PIYRvU6iFXLhzHJn82CpRYnTyIuvjp3FxM1uCthYqZoY2k1Q0lZjsnkWoKU37xK0
         F2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682486882; x=1685078882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CxdQSe72d3sjq+Prr4mwyPnfSSkLPwhzfDnldlQ4qk4=;
        b=WcdMM6PznEDdtKNygtmFgyuHSPBSyKsxE5vG6QLG9QsloaqmiDMC/2/g4W0dBl5Yig
         SdlSkA2yf4Ee/gr9x3cW2u7BsuuElNYThJ51ISIlyiPPbNDzpLvyDnVA1olu684b/ful
         /ZRIOdTJjddcBH39jF1aZp1T/Rd3EjEGDnEavDeIu3gg8EWaJ8uWpuWEaWaQyeGOdIhR
         XSJcYxZbTUlllOhJS58De/4tUfifEcg/4XIxPHFv48p4X86tQOiew7Wx1mhstXrt9G5J
         Qmfpi5H5aPWQLZ0Aa8vmL9wIUEELWclqFupMru4aSTc0yetnQqGvgut2QYBF08K+FQHy
         uRHA==
X-Gm-Message-State: AAQBX9d1A9cauKKI+WlfNPoFsqYBGLjEg4QFRLVawcTyfoeo21ty+LoV
        EN8hv2AsLdoaTyNemCqGwor7xUkU64ufMib8RdQ=
X-Google-Smtp-Source: AKy350ZMLKluC5EfzL5S2N9tE1EkG8ZgnFTB4pb6O7Vf48KbS830aXZAy9Css9lqbTdXUeWlxDg/jA==
X-Received: by 2002:a05:6a00:194c:b0:63d:2680:94dd with SMTP id s12-20020a056a00194c00b0063d268094ddmr24783165pfk.6.1682486882290;
        Tue, 25 Apr 2023 22:28:02 -0700 (PDT)
Received: from [10.200.11.252] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id u26-20020a056a00099a00b0062e0c39977csm10260586pfg.139.2023.04.25.22.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 22:28:02 -0700 (PDT)
Message-ID: <25ea9d02-a941-3ab6-8ffb-e6394e2bc027@bytedance.com>
Date:   Wed, 26 Apr 2023 13:27:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 03/34] maple_tree: Avoid unnecessary ascending
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-4-Liam.Howlett@oracle.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230425140955.3834476-4-Liam.Howlett@oracle.com>
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
> The maple tree node limits are implied by the parent.  When walking up
> the tree, the limit may not be known until a slot that does not have
> implied limits are encountered.  However, if the node is the left-most
> or right-most node, the walking up to find that limit can be skipped.
>
> This commit also fixes the debug/testing code that was not setting the
> limit on walking down the tree as that optimization is not compatible
> with this change.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>   lib/maple_tree.c                 | 6 ++++++
>   tools/testing/radix-tree/maple.c | 4 ++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index ac0245dd88dad..60bae5be008a6 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1132,6 +1132,12 @@ static int mas_ascend(struct ma_state *mas)
>   		return 0;
>   	}
>   
> +	if (!mas->min)
> +		set_min = true;
> +
> +	if (mas->max == ULONG_MAX)
> +		set_max = true;
> +
>   	min = 0;
>   	max = ULONG_MAX;
>   	do {
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 9286d3baa12d6..75df543e019c9 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -35259,6 +35259,7 @@ static void mas_dfs_preorder(struct ma_state *mas)
>   
>   	struct maple_enode *prev;
>   	unsigned char end, slot = 0;
> +	unsigned long *pivots;
>   
>   	if (mas->node == MAS_START) {
>   		mas_start(mas);
> @@ -35291,6 +35292,9 @@ static void mas_dfs_preorder(struct ma_state *mas)
>   		mas_ascend(mas);
>   		goto walk_up;
>   	}
> +	pivots = ma_pivots(mte_to_node(prev), mte_node_type(prev));
> +	mas->max = mas_safe_pivot(mas, pivots, slot, mte_node_type(prev));
> +	mas->min = mas_safe_min(mas, pivots, slot);
>   
>   	return;
>   done:
