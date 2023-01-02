Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754FC65B499
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjABQE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbjABQEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:04:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2959BF2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672675416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOa79JPMLDtsJKawOFwbLFa6Ffx1txwujF+5HHldqzI=;
        b=WrcBr5XW5lWCOjhUqV1s6ojwSXLfAFwgwjDzxbDVYs+ykvUN9iUUqw2I8uRStyPIhS25Dg
        wZx+/0BX724YmGsAOFR9PsieQILt9Bdid5LoRyOUHJh8ZkU8RBo8XqEMWxTlLxU+nvtfqE
        LefB8kFUgcYtPWwuLkIx8AoxhQkO/Bg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-601-msq8mG8NP469EXuQ4R8J0w-1; Mon, 02 Jan 2023 11:03:34 -0500
X-MC-Unique: msq8mG8NP469EXuQ4R8J0w-1
Received: by mail-wm1-f69.google.com with SMTP id ay32-20020a05600c1e2000b003d9730391b5so12730806wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOa79JPMLDtsJKawOFwbLFa6Ffx1txwujF+5HHldqzI=;
        b=K/E0n2h2t/zwNAyJcU4QN/D4k15C4Z1bQ6bjsuxdufySD+0s+DAtR370qrmG2r1Jjz
         lJP0tnDx8bAmwAtxDcBprAy7GCcbGoe5KAUY2dOmuui3bEIoJ9PcZem0Av+p7PiHO9dJ
         exPCHb3fNyZVxEfzdyz2U47/nowuJ37+nczFIdo48J8vrgvm4jrJNl1tH/bMLJzKKAw3
         bWFq48ocQbNpPD7/y6lYd7YyWWDvnctfx9BYziXv6c2MgzoKu4klU0/mMEI5oh3+DBZe
         /I7hGiuErLoRnbGZX87Vn5B3y+y+/KhT06pAe2K0yGEP5m9sIP8oRfwF+8TGjmukcKwn
         /dyg==
X-Gm-Message-State: AFqh2kr4wuWa3IzNcG92Na+8PQInBxUylcj2AYL3mn6fo0JuhiH1n2Qs
        3/DDK0xgBHBsfOFZI85bsruusMNhkTNgq5kLEt2wOoJ/CBIKlFq1Ip1LS1CSuDpBmmTndekIOoi
        ndRLM2FvrX4qq1vtmF30YovjZ
X-Received: by 2002:a05:600c:1c8e:b0:3d2:4234:e8fe with SMTP id k14-20020a05600c1c8e00b003d24234e8femr29586068wms.19.1672675413521;
        Mon, 02 Jan 2023 08:03:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvG4zXrWfeob47kId+BpVCv03evMMJAXlMCfRO2OVPhWP+j17yOmecGedHKT9737Wy4/mGwUw==
X-Received: by 2002:a05:600c:1c8e:b0:3d2:4234:e8fe with SMTP id k14-20020a05600c1c8e00b003d24234e8femr29586058wms.19.1672675413247;
        Mon, 02 Jan 2023 08:03:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id q16-20020a05600c46d000b003d1f3e9df3csm48584006wmo.7.2023.01.02.08.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:03:32 -0800 (PST)
Message-ID: <9d13393a-d203-23de-30ae-4d6476a94fd7@redhat.com>
Date:   Mon, 2 Jan 2023 17:03:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] selftest/vm: add mremap expand merge offset test
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
References: <420e491062db9151504aef5661c8a2d928ef6bd7.1672675224.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <420e491062db9151504aef5661c8a2d928ef6bd7.1672675224.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	mremap_expand_merge(page_size);
> +	maps_fp = fopen("/proc/self/maps", "r");
> +	if (maps_fp == NULL) {
> +		ksft_print_msg("Failed to read /proc/self/maps: %s\n", strerror(errno));
> +		exit(KSFT_FAIL);
> +	} else {

With the exit() in place, the else branch is implicit and the else can 
be dropped.

> +		mremap_expand_merge(maps_fp, page_size);
> +		mremap_expand_merge_offset(maps_fp, page_size);
> +
> +		fclose(maps_fp);
> +	}
>   
>   	if (run_perf_tests) {
>   		ksft_print_msg("\n%s\n",

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

