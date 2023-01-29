Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DEE67FDCA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjA2JOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjA2JOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:14:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB135199CA
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:14:24 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso11407023pju.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvZXshBhkFOaOT0XUCfjl/X1rjMudZFY6Jcz3H2Fvjk=;
        b=7sEWRN+DtsJULQyYetIXqgfFqzQTSG28y+n+YO2tEJuOlIEd+04fL8+NYfYULzgjZj
         88DQ9fFifn2jnEjqrW3LyWigwGF5xnONnum2K+XDz3Y8PI5eALcwFubOr+OSD/6qb3ni
         GllcMVNmKR1wIBzIiT6+x3hZAKoxkqkTpUD+gsHAAoV0PRNMtAHBJTUV8VXxENAGKrnI
         Z6r94GWqIxpphO9+p6Ijh4+POOcuTW7o11oCJdr7fvffWw8o5zkdfPeuPMm2GGKRgiiQ
         rRi4E9H5hdN2M4DCCA7VK6uaAoklDtv27Bvh+46MQ5DnfY1kdq44RieFJSBXc84Weox0
         hzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CvZXshBhkFOaOT0XUCfjl/X1rjMudZFY6Jcz3H2Fvjk=;
        b=2Dx5XeIc5ApP4giMnNOb+ZIup4YqDwqbIK/VUbDZEDf0X/beS5gpbx+P+MN4QcSljI
         W18lF3wx0WFk0mga/eWXd6UklCJn31UG/QMkB+7be/tBXBLcJKkcA9B1f1HP1JjXmaTG
         x6yINfnA1in/t3gr0UfaWAMbtCCxWLN/y0gCpw0OGX9f3wD1sL6vQ+9vLFgCMSdfDeYz
         394wEnYcuUb1n/icF/NJgXsGq2766eIX8qPEhxJPUSCXEFw+2gjLOYzoVSLqf6Kb6kIt
         nDPsMrEz4tbo1RSgAElQLw+3rk/gybFy1kw3XyQL3RJ40yg3DHHUAsWYPPxKi2ZlYtHi
         R/Mg==
X-Gm-Message-State: AO0yUKXcc4so3NWs0u3cyxe0pVDwqeFQ3dvPELSTK66s1ap4/OgTc3av
        rFxKKCQyjcTLBB0rs5fNWsQ2Hw==
X-Google-Smtp-Source: AK7set9YerGwEB43wgIaxdKCvFQJMVeXwa/2WvTbUi0xgmzodwgj+7wXHysW/KZqxfZbnMt2d9f7Dw==
X-Received: by 2002:a17:90a:1d7:b0:225:e9d9:63b2 with SMTP id 23-20020a17090a01d700b00225e9d963b2mr5563273pjd.42.1674983664265;
        Sun, 29 Jan 2023 01:14:24 -0800 (PST)
Received: from [10.90.35.114] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090a4e0200b00219463262desm5374916pjh.39.2023.01.29.01.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 01:14:24 -0800 (PST)
Message-ID: <2ee31efb-a07f-6132-88fd-d69ad180cf33@bytedance.com>
Date:   Sun, 29 Jan 2023 17:14:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] memblock: Avoid useless checks in
 memblock_merge_regions().
To:     rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230129090034.12310-1-zhangpeng.00@bytedance.com>
 <20230129090034.12310-3-zhangpeng.00@bytedance.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230129090034.12310-3-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike

> @@ -581,7 +586,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>   	bool insert = false;
>   	phys_addr_t obase = base;
>   	phys_addr_t end = base + memblock_cap_size(base, &size);
> -	int idx, nr_new;
> +	int idx, nr_new, start_rgn = -1, end_rgn;
>   	struct memblock_region *rgn;
>   
>   	if (!size)
> @@ -635,10 +640,14 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>   #endif
>   			WARN_ON(flags != rgn->flags);
>   			nr_new++;
> -			if (insert)
> +			if (insert) {
> +				if (start_rgn == -1)
We can't initialize start_rgn with 0 and use if(!start_rgn).

If start_rgn is equal to 0, it will be reassigned. It is possible that 
we will eventually need start_rgn to be equal to 0, and it may be 
reassigned to a larger value that does not meet expectations.

Thanks.

> +					start_rgn = idx;
> +				end_rgn = idx + 1;
>   				memblock_insert_region(type, idx++, base,
>   						       rbase - base, nid,
>   						       flags);
> +			}
>   		}
>   		/* area below @rend is dealt with, forget about it */
>   		base = min(rend, end);
> @@ -647,9 +656,13 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>   	/* insert the remaining portion */
>   	if (base < end) {
>   		nr_new++;
> -		if (insert)
> +		if (insert) {
> +			if (start_rgn == -1)
> +				start_rgn = idx;
> +			end_rgn = idx + 1;
>   			memblock_insert_region(type, idx, base, end - base,
>   					       nid, flags);
> +		}
>   	}
>   
>   	if (!nr_new)
> @@ -666,7 +679,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>   		insert = true;
>   		goto repeat;
>   	} else {
> -		memblock_merge_regions(type);
> +		memblock_merge_regions(type, start_rgn, end_rgn);
>   		return 0;
>   	}
>   }
> @@ -902,7 +915,7 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
>   			r->flags &= ~flag;
>   	}
>   
> -	memblock_merge_regions(type);
> +	memblock_merge_regions(type, start_rgn, end_rgn);
>   	return 0;
>   }
>   
> @@ -1275,7 +1288,7 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
>   	for (i = start_rgn; i < end_rgn; i++)
>   		memblock_set_region_node(&type->regions[i], nid);
>   
> -	memblock_merge_regions(type);
> +	memblock_merge_regions(type, start_rgn, end_rgn);
>   #endif
>   	return 0;
>   }
Sincerely yours,
Peng.
