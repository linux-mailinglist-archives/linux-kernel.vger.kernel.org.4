Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30DE6FEFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbjEKKaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbjEKKaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:30:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473998A78
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:30:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QH7Rn152Vz67dY8;
        Thu, 11 May 2023 18:29:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 11 May
 2023 11:30:10 +0100
Date:   Thu, 11 May 2023 11:30:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Huang Ying <ying.huang@intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 0/6] mm: improve page allocator scalability via splitting
 zones
Message-ID: <20230511113009.00004821@Huawei.com>
In-Reply-To: <20230511065607.37407-1-ying.huang@intel.com>
References: <20230511065607.37407-1-ying.huang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 14:56:01 +0800
Huang Ying <ying.huang@intel.com> wrote:

> The patchset is based on upstream v6.3.
> 
> More and more cores are put in one physical CPU (usually one NUMA node
> too).  In 2023, one high-end server CPU has 56, 64, or more cores.
> Even more cores per physical CPU are planned for future CPUs.  While
> all cores in one physical CPU will contend for the page allocation on
> one zone in most cases.  This causes heavy zone lock contention in
> some workloads.  And the situation will become worse and worse in the
> future.
> 
> For example, on an 2-socket Intel server machine with 224 logical
> CPUs, if the kernel is built with `make -j224`, the zone lock
> contention cycles% can reach up to about 12.7%.
> 
> To improve the scalability of the page allocation, in this series, we
> will create one zone instance for each about 256 GB memory of a zone
> type generally.  That is, one large zone type will be split into
> multiple zone instances.  Then, different logical CPUs will prefer
> different zone instances based on the logical CPU No.  So the total
> number of logical CPUs contend on one zone will be reduced.  Thus the
> scalability is improved.
> 
> With the series, the zone lock contention cycles% reduces to less than
> 1.6% in the above kbuild test case when 4 zone instances are created
> for ZONE_NORMAL.
> 
> Also tested the series with the will-it-scale/page_fault1 with 16
> processes.  With the optimization, the benchmark score increases up to
> 18.2% and the zone lock contention reduces from 13.01% to 0.56%.
> 
> To create multiple zone instances for a zone type, another choice is
> to create zone instances based on the total number of logical CPUs.
> We choose to use memory size because it is easier to be implemented.
> In most cases, the more the cores, the larger the memory size is.
> And, on system with larger memory size, the performance requirement of
> the page allocator is usually higher.
> 
> Best Regards,
> Huang, Ying
> 
Hi,

Interesting idea.  I'm curious though on whether this can suffer from
imbalance problems where due to uneven allocations from particular CPUs
you can end up with all page faults happening in one zone and the original
contention problem coming back?  Or am I missing some process that will
result in that imbalance being corrected?

Jonathan
