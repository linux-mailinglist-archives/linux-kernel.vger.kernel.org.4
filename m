Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9F95EB1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiIZUSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIZUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:17:56 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973A7A2ABC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:17:55 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id cj27so4844768qtb.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Rb6GCSM0rwMC7RphxcUXfyqWbEmBirE3kuWoVyJY+cY=;
        b=BfqAKVMYHwwYZlynoiuAig5Xy2Kdzo5zoE97xzlkhJtpZlgY6aZRsOLngb0mU81mzx
         rqMWYXhmK571fJgC9+6FFnapEECf/M1HNnBLUxIAm+CKuO2pl3HpFwUt7FJLx9nvWIck
         0N8ksIzX+BcVla6pNEeOM5ZZeUdRClM65JHAOaqUmKkkPvikNjdBMYp/tejc6e/9DQao
         Nb5H27jYOQUtsn217pCfbyElzmGfKlkcGs/iCCBGV6LLwXbc/4cJQDcB9ZAKu6+HKWNf
         yzaCfICJ/k3lHghsjVGukSBn7Z0XSi6LDdgGQUfwd9SJMAOtkj/nm4sanptK4u2ajYUm
         9yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Rb6GCSM0rwMC7RphxcUXfyqWbEmBirE3kuWoVyJY+cY=;
        b=jRgSGRm4QBbhy6LjptTLeo/ROnEM0pRx2iAlaLCkrw/k2dQvkx4JnlCRtKPIEvFih7
         Rki1jZoLxQP+5nc2L4A6fBZ+RdGXBh9njroih6RSFBvKOxpTIzZSXJP6a5ammID5+nNy
         eKhRGagnnUrwKi4qiH4X9dSiXsogUXk7TlIxIIPqDyL2tMuC3GBQvIc7tvnDzyIZT9Z8
         dTQQwHHZTZZk8YQf+LzKym67il/1LdggH5on4nJ1BRpiGour7zGlh5tVSNn+9Q6s+UmX
         qzmlgwZzwPI7j6wJtPebCmlA+ZyZvVV6GTPZdDtU/FUDuGBJID4oXkN3hng925m7gLW9
         PXqw==
X-Gm-Message-State: ACrzQf1DsdMgI+PnsjuTcTOvrm8PSyK6ZEwWimGV0NX6Aw+4eFFUpn2b
        uHHS/7FPVyvzviyeMUQJ73Q=
X-Google-Smtp-Source: AMsMyM7dXkVsI53zsTHjVazN0L4nTZwfw3Egu112f2V6A2p5syCdTWicJSfE8bpvboXBkQ/IK1mgZQ==
X-Received: by 2002:a05:622a:1355:b0:35c:e9e5:6cda with SMTP id w21-20020a05622a135500b0035ce9e56cdamr19721462qtk.91.1664223474553;
        Mon, 26 Sep 2022 13:17:54 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:155c:f237:bceb:6273])
        by smtp.gmail.com with ESMTPSA id 20-20020ac85654000000b0035bb8168daesm11618783qtt.57.2022.09.26.13.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:17:54 -0700 (PDT)
Date:   Mon, 26 Sep 2022 13:17:53 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
Subject: Re: [PATCH v15 10/10] lib/nodemask: Optimize node_random for
 nodemask with single NUMA node
Message-ID: <YzII8VrYmIowfbgA@yury-laptop>
References: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
 <20220818131042.113280-11-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818131042.113280-11-aneesh.kumar@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aneesh,

Please CC maintainers in your recipient list.

On Thu, Aug 18, 2022 at 06:40:42PM +0530, Aneesh Kumar K.V wrote:
> The most common case for certain node_random usage (demotion nodemask) is with
> nodemask weight 1. We can avoid calling get_random_init() in that case and
> always return the only node set in the nodemask.

Can you move the comment about get_random_int() to the code?.
 
> A simple test as below
>   before = rdtsc_ordered();
>   for (i= 0; i < 100; i++) {
>       rand = node_random(&nmask);
>   }
>   after = rdtsc_ordered();
> 
> Without fix after - before : 16438
> With fix after - before : 816
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/nodemask.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 4b71a96190a8..ac5b6a371be5 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -504,12 +504,21 @@ static inline int num_node_state(enum node_states state)
>  static inline int node_random(const nodemask_t *maskp)
>  {
>  #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
> -	int w, bit = NUMA_NO_NODE;
> +	int w, bit;
>  
>  	w = nodes_weight(*maskp);
> -	if (w)
> +	switch (w) {
> +	case 0:
> +		bit = NUMA_NO_NODE;
> +		break;

Why not 'return NUMA_NO_NODE' instead of break thing?

> +	case 1:
> +		bit = first_node(*maskp);
> +		break;
> +	default:
>  		bit = bitmap_ord_to_pos(maskp->bits,
> -			get_random_int() % w, MAX_NUMNODES);
> +					get_random_int() % w, MAX_NUMNODES);

Don't fix tabs - it trashes the history.

> +		break;
> +	}
>  	return bit;
>  #else
>  	return 0;
> -- 
> 2.37.2
> 
> 
