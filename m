Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D0A5EDEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiI1OVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiI1OVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E836CF44
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664374890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABN18yfHanO7kyNSoPzHC6Sw/2197qbN8zEEWo7VMtY=;
        b=MxjKE2FcPFZ99MEADDR6QfYq9xpR2GmHqia6IYia5bq/P8MN8D8Na9YZW+LIbU//pzwLvT
        in3Ez8khRzT8ursyUIx0oBg9rYXCNNghxzK2YiVdhG8qs9dBc2N5nv6BRJ1O9WRMqeVD8k
        yMJcjwvXAJQJacXUbZAzxhzJwSTZtzE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-385-4Po2m4T6M3iV_tN-4SPZ_A-1; Wed, 28 Sep 2022 10:21:28 -0400
X-MC-Unique: 4Po2m4T6M3iV_tN-4SPZ_A-1
Received: by mail-wr1-f70.google.com with SMTP id p7-20020adfba87000000b0022cc6f805b1so651764wrg.21
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ABN18yfHanO7kyNSoPzHC6Sw/2197qbN8zEEWo7VMtY=;
        b=BLAMEERUe3bReGfgHIffhNfRUZONjeM9tAJWHmvIi47L1udtNQ7ENpH71li4zlKvxQ
         5zK28aDk9yHuJRtGC2zK5Zo3WQjYqwcdOi6fHnOOnjLjnNXx01yKFTGwV7EouvRoWBV8
         4JbqMWqHWJ4sDLLdbbQbanbHe57Ahk2mqyTPZV5wgUBzjvOQ88Xa4o2jgG7G9L1QADL/
         rKXS8/qN+APAq6yp43jvOcfBK9rHMGETL2Sglt6XvubaqnfUA7yCt8dYCg2y0tYDGKnw
         ARcB48QV/7xra+drL13bVxMGZ9tYAJI9IgrYesZGdihqoQiCM3YYqhhNcmP4c8RfQONH
         oGWQ==
X-Gm-Message-State: ACrzQf33epbeC/8+NmD90rQQ+S4LvEQxFFmM6wD5iszht2AbzQBlNn20
        /h2ZqcK76yv2sp0YVdgX0QdG5OIfoFPzPMaYB0QUeFGk62wpxK4vGt8xYffa+CcTb0BBB4joHQ6
        9DtlwcijsmHFZ/SDQSmgnZsYC
X-Received: by 2002:a05:6000:15c5:b0:22a:49be:8000 with SMTP id y5-20020a05600015c500b0022a49be8000mr20744029wry.664.1664374886297;
        Wed, 28 Sep 2022 07:21:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4tIcpuiIyedOneJ1v6hq/Mzp3X1zKbADLxiYOcp0L2BRdElXCAhDOsv8YxCZ/j66uq4QtC2w==
X-Received: by 2002:a05:6000:15c5:b0:22a:49be:8000 with SMTP id y5-20020a05600015c500b0022a49be8000mr20744010wry.664.1664374885974;
        Wed, 28 Sep 2022 07:21:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:1100:add9:5f61:6b94:7540? (p200300cbc7041100add95f616b947540.dip0.t-ipconnect.de. [2003:cb:c704:1100:add9:5f61:6b94:7540])
        by smtp.gmail.com with ESMTPSA id bg14-20020a05600c3c8e00b003b341a2cfadsm1860497wmb.17.2022.09.28.07.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:21:25 -0700 (PDT)
Message-ID: <c4462af8-80a5-6cb6-8bfc-0e7ff1da6856@redhat.com>
Date:   Wed, 28 Sep 2022 16:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/3] THP Shrinker
Content-Language: en-US
To:     alexlzhu@fb.com, linux-mm@kvack.org
Cc:     willy@infradead.org, akpm@linux-foundation.org, riel@surriel.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1664347167.git.alexlzhu@fb.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cover.1664347167.git.alexlzhu@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.22 08:44, alexlzhu@fb.com wrote:
> From: Alexander Zhu <alexlzhu@fb.com>
> 
> Transparent Hugepages use a larger page size of 2MB in comparison to
> normal sized pages that are 4kb. A larger page size allows for fewer TLB
> cache misses and thus more efficient use of the CPU. Using a larger page
> size also results in more memory waste, which can hurt performance in some
> use cases. THPs are currently enabled in the Linux Kernel by applications
> in limited virtual address ranges via the madvise system call.  The THP
> shrinker tries to find a balance between increased use of THPs, and
> increased use of memory. It shrinks the size of memory by removing the
> underutilized THPs that are identified by the thp_utilization scanner.
> 
> In our experiments we have noticed that the least utilized THPs are almost
> entirely unutilized.
> 
> Sample Output:
> 
> Utilized[0-50]: 1331 680884
> Utilized[51-101]: 9 3983
> Utilized[102-152]: 3 1187
> Utilized[153-203]: 0 0
> Utilized[204-255]: 2 539
> Utilized[256-306]: 5 1135
> Utilized[307-357]: 1 192
> Utilized[358-408]: 0 0
> Utilized[409-459]: 1 57
> Utilized[460-512]: 400 13
> Last Scan Time: 223.98s
> Last Scan Duration: 70.65s
> 
> Above is a sample obtained from one of our test machines when THP is always
> enabled. Of the 1331 THPs in this thp_utilization sample that have from
> 0-50 utilized subpages, we see that there are 680884 free pages. This
> comes out to 680884 / (512 * 1331) = 99.91% zero pages in the least
> utilized bucket. This represents 680884 * 4KB = 2.7GB memory waste.
> 
> Also note that the vast majority of pages are either in the least utilized
> [0-50] or most utilized [460-512] buckets. The least utilized THPs are
> responsible for almost all of the memory waste when THP is always
> enabled. Thus by clearing out THPs in the lowest utilization bucket
> we extract most of the improvement in CPU efficiency. We have seen
> similar results on our production hosts.
> 
> This patchset introduces the THP shrinker we have developed to identify
> and split the least utilized THPs. It includes the thp_utilization
> changes that groups anonymous THPs into buckets, the split_huge_page()
> changes that identify and zap zero 4KB pages within THPs and the shrinker
> changes. It should be noted that the split_huge_page() changes are based
> off previous work done by Yu Zhao.
> 
> In the future, we intend to allow additional tuning to the shrinker
> based on workload depending on CPU/IO/Memory pressure and the
> amount of anonymous memory. The long term goal is to eventually always
> enable THP for all applications and deprecate madvise entirely.
> 
> In production we thus far have observed 2-3% reduction in overall cpu
> usage on stateless web servers when THP is always enabled.

What's the diff to the RFC?

-- 
Thanks,

David / dhildenb

