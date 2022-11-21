Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1AD631AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiKUICI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKUICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:02:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3AED65
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669017665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0AQyYFfo+9gxGliawJp4LGdOeDV+4qepnwYb6KBjwmI=;
        b=OIJKTikzlC7Jh0SFK50q+prNKV8ajOtQkNvL+62QBxZj1PoYytVACuGQFqxbMuGGgIWh7x
        3M3Mjap/KIjz4oiuTDQepMndYWSpbim20ZpsH/Wt972iRDHMOt1j+vfkv7hSAlU9ll9pLW
        T7R/sip4FLgXv1euoW96c2LBwiOCGhg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-wqSqx7G3NSKKskZSqr7vIw-1; Mon, 21 Nov 2022 03:01:03 -0500
X-MC-Unique: wqSqx7G3NSKKskZSqr7vIw-1
Received: by mail-wr1-f72.google.com with SMTP id u24-20020adfa198000000b00241da98e057so427002wru.22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AQyYFfo+9gxGliawJp4LGdOeDV+4qepnwYb6KBjwmI=;
        b=gfWWPwOpsZBaCOV1JxCMi4o8q65qQZenk8J14PNAlazdNj9TQ9GafzAzB0WJEEZxz3
         Kr0jsqSWc7cZH03hQmBBAHWvskerboaQkz0pSnb5ghpxyOql6z3bsOmtRVw70GR0U4q4
         5f/Bo1yWeZ7EyZDMNjwfJyYZhvw2tImhi0B0tb0JpfrQQJMRPWWBBiTdLtLoH5lqXI9i
         f4vAVtkBO8mSAyhAtGMBv8wI5yefc2OwG3AuEtF+yTi7w6tPXCyqIF3hiI2o6U0FnUIH
         PnBOOCcxcS0lKjJsvq/OVWJA6SMT0b/55Hg6AArmcTymHjS45KMWrPXzo9Q6BG2C8Kl6
         CAuA==
X-Gm-Message-State: ANoB5pmbNgDjokeGUKTzHzX6XYU5s/za14wntFEotWqvvsrse0JjEnPx
        0MNiCRH6PV8dpQ2EL5B09eefGKm+qRzvnhCoL0php6cpq0mUJwOCCHvJqflX2XgTfCXMS5JbMhK
        m9aAb/QR/Bcynmdr7+FF5cQGG
X-Received: by 2002:adf:eb0c:0:b0:236:6deb:4498 with SMTP id s12-20020adfeb0c000000b002366deb4498mr10407214wrn.52.1669017661951;
        Mon, 21 Nov 2022 00:01:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf77j1WiPf/k1EzdHh95eZGoSHc+IIaDgk6glybs/fguxmE2Lp2ljuzCpa/dLBDvV3elHKQL7A==
X-Received: by 2002:adf:eb0c:0:b0:236:6deb:4498 with SMTP id s12-20020adfeb0c000000b002366deb4498mr10407175wrn.52.1669017661507;
        Mon, 21 Nov 2022 00:01:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:dc00:2571:c3c2:c6ea:84ef? (p200300cbc702dc002571c3c2c6ea84ef.dip0.t-ipconnect.de. [2003:cb:c702:dc00:2571:c3c2:c6ea:84ef])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b003cf878c4468sm19240074wms.5.2022.11.21.00.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:01:01 -0800 (PST)
Message-ID: <7b2055f2-f5ce-be01-7c39-edcc4be6a7aa@redhat.com>
Date:   Mon, 21 Nov 2022 09:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
References: <202211211037.2b2e5e1f-yujie.liu@intel.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [linus:master] [mm] 088b8aa537: vm-scalability.throughput -6.5%
 regression
In-Reply-To: <202211211037.2b2e5e1f-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.22 04:03, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -6.5% regression of vm-scalability.throughput due to commit:
> 
> commit: 088b8aa537c2c767765f1c19b555f21ffe555786 ("mm: fix PageAnonExclusive clearing racing with concurrent RCU GUP-fast")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: vm-scalability
> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory
> with following parameters:
> 
> 	thp_enabled: never
> 	thp_defrag: never
> 	nr_task: 1
> 	nr_pmem: 2
> 	priority: 1
> 	test: swap-w-seq
> 	cpufreq_governor: performance
> 
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> 

Yes, page_try_share_anon_rmap() might now be a bit more expensive now, 
turning try_to_unmap_one() a bit more expensive. However, that patch 
also changes the unconditional TLB flush into a conditional TLB flush, 
so results might vary heavily between machines/architectures.

smp_mb__after_atomic() is a NOP on x86, so the smp_mb() before the 
page_maybe_dma_pinned() check would have to be responsible.

While there might certainly be ways for optimizing that further (e.g., 
if the ptep_get_and_clear() already implies a smp_mb()), the facts that:

(1) It's a swap micro-benchmark
(2) We have 3% stddev

Don't make me get active now ;)

-- 
Thanks,

David / dhildenb

