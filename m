Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008EB5E6A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiIVR5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIVR5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2305F3726
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663869420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tzpm52sa8CSvL/F/FPIEyeRtTCXujozZJ/MwFvUSN40=;
        b=T4RNswjMlcYUJtfREq/C4g8T1YBYFvkoKhdk5J0N+E40WTH17RYCEYcuWpFrnBUBSBy7GU
        bzIsrNOUYKgft3G05uRUVRMnnq0JnSvQvlorNsRf/H+WNX+HeFDcyOxfo1IdaErEgke35f
        vdcdn5J4h6pP0ge/50ALPZrdCjzwsak=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-PAPI9SbWMcmzjyVzJrZjwA-1; Thu, 22 Sep 2022 13:56:59 -0400
X-MC-Unique: PAPI9SbWMcmzjyVzJrZjwA-1
Received: by mail-wm1-f70.google.com with SMTP id d5-20020a05600c34c500b003b4fb42ccdeso1445088wmq.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=tzpm52sa8CSvL/F/FPIEyeRtTCXujozZJ/MwFvUSN40=;
        b=qG0c+BeqCjMiBApeJceQ8x2fsa4eneYK5GpeXQCakLtiSWZeAiaZiMVHGoKL6BXn/e
         ZR0rBbdGzcxpyMBWYks2NZY/ypqBx0h4SeJT6ypYX6PEJNe4/spCnXkmij2ysPjlIGNY
         bv3KMPo2vumILlX1o9t85H9KsUiuRsFKdWTfqb6BulQLUpYI9R/MrfjaKH2JnsqnDgeS
         fzi2qF0RWc4is3KM861iwI5JifNMI7e0n+XDWZwCXTMl6nWOS5Se4GxZSbD25lsSr3VZ
         yE6NOdsoa/hQzt970vu6ZuUmxYuc3ceh0WAVDc643xxnPvnMYiN+UxidHaREDsvmlbcO
         5c2A==
X-Gm-Message-State: ACrzQf3/8rMug1N5TKUwhZokosupcaugxC709lJkUnJko5D6+SK8GyNz
        D93JDuU4XnSMtahv7l9Gkb3S1SRwVQJupO85Wf+wNY7zTbt9aHYekKNqpzXR7vF8jhLASoM/zTd
        Gt3lFfkKYGEGVQ6O3ajye2eB2
X-Received: by 2002:adf:de0b:0:b0:22a:c7f7:8eb4 with SMTP id b11-20020adfde0b000000b0022ac7f78eb4mr2828732wrm.195.1663869418105;
        Thu, 22 Sep 2022 10:56:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6OGCTJHunJL+DqcDW3fRlbR463/+1YhbnxMqKIz9UcWqkxpEEN923uRrQHr3cvs6ppcOpo+Q==
X-Received: by 2002:adf:de0b:0:b0:22a:c7f7:8eb4 with SMTP id b11-20020adfde0b000000b0022ac7f78eb4mr2828722wrm.195.1663869417843;
        Thu, 22 Sep 2022 10:56:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:2200:d595:cc20:2e3a:fc5f? (p200300cbc7082200d595cc202e3afc5f.dip0.t-ipconnect.de. [2003:cb:c708:2200:d595:cc20:2e3a:fc5f])
        by smtp.gmail.com with ESMTPSA id q17-20020a5d61d1000000b00228b3ff1f5dsm6297845wrv.117.2022.09.22.10.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:56:57 -0700 (PDT)
Message-ID: <f0675fe8-14dc-7890-357b-565c0a706932@redhat.com>
Date:   Thu, 22 Sep 2022 19:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 1/8] cgroup/cpuset: use hotplug_memory_notifier()
 directly
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Christoph Lameter <cl@linux.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20220922141904.3245505-1-liushixin2@huawei.com>
 <20220922141904.3245505-2-liushixin2@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220922141904.3245505-2-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.22 16:18, Liu Shixin wrote:
> Since patch 316346243be6 has already updated the minimum gcc version to 5.1.
> The previous problem mentioned in patch f02c69680088 is not existed. So we
> can now revert to use hotplug_memory_notifier() directly rather than
> register_hotmemory_notifier().
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b474289c15b8..0c6db6a4f427 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3630,11 +3630,6 @@ static int cpuset_track_online_nodes(struct notifier_block *self,
>   	return NOTIFY_OK;
>   }
>   
> -static struct notifier_block cpuset_track_online_nodes_nb = {
> -	.notifier_call = cpuset_track_online_nodes,
> -	.priority = 10,		/* ??! */
> -};
> -
>   /**
>    * cpuset_init_smp - initialize cpus_allowed
>    *
> @@ -3652,7 +3647,7 @@ void __init cpuset_init_smp(void)
>   	cpumask_copy(top_cpuset.effective_cpus, cpu_active_mask);
>   	top_cpuset.effective_mems = node_states[N_MEMORY];
>   
> -	register_hotmemory_notifier(&cpuset_track_online_nodes_nb);
> +	hotplug_memory_notifier(cpuset_track_online_nodes, 10);
>   
>   	cpuset_migrate_mm_wq = alloc_ordered_workqueue("cpuset_migrate_mm", 0);
>   	BUG_ON(!cpuset_migrate_mm_wq);


Please don't drop Reviewed-by or Acked-by tags. Otherwise reviewers have 
no clue which patch they already reviewed -- and they always have little 
time ;)

-- 
Thanks,

David / dhildenb

