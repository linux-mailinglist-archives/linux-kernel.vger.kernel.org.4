Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0306BF781
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 04:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCRDKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 23:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCRDKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 23:10:07 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7B4D4F47
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 20:10:06 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id E5F6CE02AB; Sat, 18 Mar 2023 03:10:04 +0000 (UTC)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     hannes@cmpxchg.org
Cc:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next] mm: workingset: simplify the calculation of workingset size
Date:   Sat, 18 Mar 2023 03:10:04 +0000
Message-Id: <20230318031004.19012-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317140952.GA153257@cmpxchg.org>
References: <20230317140952.GA153257@cmpxchg.org>
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

> On Fri, Mar 17, 2023 at 01:59:03AM +0000, Yang Yang wrote:
>> I see in this patch "mm: vmscan: enforce inactive:active ratio at the
>> reclaim root", reclaim will be done in the combined workingset of
>> different workloads in different cgroups.
>>
>> So if current cgroup reach it's swap limit(mem_cgroup_get_nr_swap_pages(memcg) == 0),
>> but other cgroup still has swap slot, should we allow the refaulting page
>> to active and give pressure to other cgroup?
>
> That's what we do today.
>
> The shadow entry remembers the reclaim root, so that refaults can
> later evaluated at the same level. So, say you have:
>
> root - A - A1
>         `- A2

> and A1 and A2 are reclaimed due to a limit in A. The shadow entries of
> evictions from A1 and A2 will actually refer to A.
>
> When they refault later on, the distance is interpreted based on
> whether A has swap (eviction_lruvec).

Much appreciate to your patient explanation.

Still a question:
In the example above, if (NR_ACTIVE_FILE + NR_INACTIVE_FILE) <
refault_distance < (NR_ACTIVE_FILE + NR_INACTIVE_FILE + NR_ACTIVE_ANON),
and swap slot is full, the refault page is not set active. Then if some
swap slots is freed, the newly refault page might be early reclaimed
since it's inactive.
And if we let the refault page be set active evenif swap slot is full,
when swap slot is freed, the refault page is protected from being early
relcaimed.
