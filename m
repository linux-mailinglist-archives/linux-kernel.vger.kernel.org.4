Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D9E6BDE6D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 03:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCQCGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 22:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQCG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 22:06:29 -0400
X-Greylist: delayed 443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 19:06:27 PDT
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77093FBBC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 19:06:27 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id 81A84E0518; Fri, 17 Mar 2023 01:59:03 +0000 (UTC)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     hannes@cmpxchg.org
Cc:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, yang.yang29@zte.com.cn
Subject: Re:  [PATCH linux-next] mm: workingset: simplify the calculation of workingset size
Date:   Fri, 17 Mar 2023 01:59:03 +0000
Message-Id: <20230317015903.16978-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316143007.GC116016@cmpxchg.org>
References: <20230316143007.GC116016@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_NON_FQDN_1,
        HEADER_FROM_DIFFERENT_DOMAINS,HELO_NO_DOMAIN,NO_DNS_FOR_FROM,
        RCVD_IN_PBL,RDNS_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL_NO_RDNS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Mar 16, 2023 at 05:23:05PM +0800, yang.yang29@zte.com.cn wrote:
>> From: Yang Yang <yang.yang29@zte.com.cn>
>> 
>> After we implemented workingset detection for anonymous LRU[1],
>> the calculation of workingset size is a little complex. Actually there is
>> no need to call mem_cgroup_get_nr_swap_pages() if refault page is
>> anonymous page, since we are doing swapping then should always
>> give pressure to NR_ACTIVE_ANON.
>
> This is false.
>
> (mem_cgroup_)get_nr_swap_pages() returns the *free swap slots*. There
> might be swap, but if it's full, reclaim stops scanning anonymous
> pages altogether. That means that refaults of either type can no
> longer displace existing anonymous pages, only cache.

I see in this patch "mm: vmscan: enforce inactive:active ratio at the
reclaim root", reclaim will be done in the combined workingset of
different workloads in different cgroups.

So if current cgroup reach it's swap limit(mem_cgroup_get_nr_swap_pages(memcg) == 0),
but other cgroup still has swap slot, should we allow the refaulting page
to active and give pressure to other cgroup?
