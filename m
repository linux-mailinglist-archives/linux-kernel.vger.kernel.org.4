Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672A674FFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjGLGrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjGLGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:47:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CD1A19B;
        Tue, 11 Jul 2023 23:47:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F4212F4;
        Tue, 11 Jul 2023 23:47:59 -0700 (PDT)
Received: from [10.162.42.6] (unknown [10.162.42.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9CF93F67D;
        Tue, 11 Jul 2023 23:47:14 -0700 (PDT)
Message-ID: <6e473d64-fbbc-db12-99ee-d32768d8af85@arm.com>
Date:   Wed, 12 Jul 2023 12:17:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] mm/memory_hotplug: document the signal_pending() check
 in offline_pages()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230711174050.603820-1-david@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230711174050.603820-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/23 23:10, David Hildenbrand wrote:
> Let's update the documentation that any signal is sufficient, and
> add a comment that not only checking for fatal signals is historical
> baggage: changing it now could break existing user space. although
> unlikely.
> 
> For example, when an app provides a custom SIGALRM handler and triggers
> memory offlining, the timeout cmd would no longer stop memory offlining,
> because SIGALRM would no longer be considered a fatal signal.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/admin-guide/mm/memory-hotplug.rst | 2 +-
>  mm/memory_hotplug.c                             | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index 1b02fe5807cc..bd77841041af 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -669,7 +669,7 @@ when still encountering permanently unmovable pages within ZONE_MOVABLE
>  (-> BUG), memory offlining will keep retrying until it eventually succeeds.
>  
>  When offlining is triggered from user space, the offlining context can be
> -terminated by sending a fatal signal. A timeout based offlining can easily be
> +terminated by sending a signal. A timeout based offlining can easily be
>  implemented via::
>  
>  	% timeout $TIMEOUT offline_block | failure_handling
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 3f231cf1b410..7cfd13c91568 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1843,6 +1843,11 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	do {
>  		pfn = start_pfn;
>  		do {
> +			/*
> +			 * Historically we always checked for any signal and
> +			 * can't limit it to fatal signals without eventually
> +			 * breaking user space.> +			 */

Just curious, could 'signal type' to stop memory offline process be considered
an ABI and cannot be changed in kernel ever if required ? Just wondering if an
additional '!fatal_signal_pending()' check be introduced to warn about support
being deprecated, before finally replacing it with fatal_signal_pending().

>  			if (signal_pending(current)) {
>  				ret = -EINTR;
>  				reason = "signal backoff";
