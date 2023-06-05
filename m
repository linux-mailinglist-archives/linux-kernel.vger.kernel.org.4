Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00DF7224A8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjFELdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjFELdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF67A113
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685964743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAZyxjHSKhdNxeHRuvnFvS4kEsJUoO6wNay6Vh0Axqo=;
        b=ZrzObrYtQX3hNDNhM6KLzVrwAtg6Mj2D9XxmSA7kCzUSjD7Bc93KseZg8cnYzM9yq6ki+s
        ysud7k57WE46TNAmpY1aBP3Y2EoKyW5IdWk5aDtFoMQyZvErDGsez/j5AWFV4WJJXosvxb
        +4yCcbE/UTc3W9texzyLpc1GjJdJQKc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-zHhuJQQLNzKw868YpXLHzw-1; Mon, 05 Jun 2023 07:32:22 -0400
X-MC-Unique: zHhuJQQLNzKw868YpXLHzw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f72720c592so18914255e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964741; x=1688556741;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAZyxjHSKhdNxeHRuvnFvS4kEsJUoO6wNay6Vh0Axqo=;
        b=bUnWIaL4tMcZVayYNlYRT5myBC5sJsQes3vPmPJtnGvQGCWQOOcfHVBsHRRLTfc6u4
         7fBC+mkDiSGscKcSpcMQFjBFfI3kVwAyGpRq2Iu4G42WGahsETWfdzdRamH2tcC6aEVc
         w6eLYy7c55mwK0ULu6+Mp4790dViyn3H+U1TzSi/Q6fxkD63zGeVDb6RxQDwghUEdIgy
         VJ5dV45XJTWQq+7lLJKSm5I0HX126sa9DA46rM1jgtRvCORDF6IZjsAiDWxVjUMeSAjq
         s3D8aTHD5SsQUSb0Qrp8vHUs6UhpqG54Hc12JpMdkJ1DphRvmLJDbMyvJXy8OwooMcRO
         wGPw==
X-Gm-Message-State: AC+VfDzMSQZTJNlHgPAGKTVOmg3YIAQUX6Vqpbhj8/t3qtx5+kDLnIGt
        VU36Xu7hRyVoBNlQGsMyABPk9c3cHwyGnKO2kgyeQ2G9Wr7YOX8RFMT7GunztV531ymH/w3fF9V
        xkp0l0OjhCGDKu6ehi3eQ/3Rl
X-Received: by 2002:a05:600c:2905:b0:3f5:6e5:1688 with SMTP id i5-20020a05600c290500b003f506e51688mr7427339wmd.2.1685964741218;
        Mon, 05 Jun 2023 04:32:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mW82eHh7p214lzYwmPeZPeyww9PqtRhoOvnp/Rsfiwhziy/+p6f2DqyHQKoMf4q/8eUiq4Q==
X-Received: by 2002:a05:600c:2905:b0:3f5:6e5:1688 with SMTP id i5-20020a05600c290500b003f506e51688mr7427319wmd.2.1685964740822;
        Mon, 05 Jun 2023 04:32:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:8f00:ed9:16b8:4e22:5820? (p200300cbc7378f000ed916b84e225820.dip0.t-ipconnect.de. [2003:cb:c737:8f00:ed9:16b8:4e22:5820])
        by smtp.gmail.com with ESMTPSA id w11-20020a1cf60b000000b003f423f5b659sm10491925wmc.10.2023.06.05.04.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:32:20 -0700 (PDT)
Message-ID: <9c475907-0c58-98a2-adaa-6c94b671db9e@redhat.com>
Date:   Mon, 5 Jun 2023 13:32:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] memcg: use helper macro FLUSH_TIME
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230603072116.1101690-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230603072116.1101690-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.23 09:21, Miaohe Lin wrote:
> Use helper macro FLUSH_TIME to indicate the flush time to improve the
> readability a bit. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/memcontrol.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d8569594239c..f204c9f2e69c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5397,7 +5397,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>   
>   	if (unlikely(mem_cgroup_is_root(memcg)))
>   		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
> -				   2UL*HZ);
> +				   FLUSH_TIME);
>   	lru_gen_online_memcg(memcg);
>   	return 0;
>   offline_kmem:

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

