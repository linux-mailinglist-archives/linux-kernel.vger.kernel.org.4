Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAAA73FC07
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjF0MfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjF0MfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:35:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027C61FE2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:34:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E6CB218B1;
        Tue, 27 Jun 2023 12:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687869298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bLHM6V+tLDCMAr7fezZKJxujMeIsDp2nC0aWxIi/UN0=;
        b=SdD1LqmG7UCtzfPfjuKZH9l1tURYMo2FK5WDMGMap5Y4YvMKQRoQSvuJ2C9gLqrjZw4U5X
        ZZCH9MuKt2/yQMYC5KJ151+Dk2OYTYltPTmvh9Eq31au80+upsb8AhPW0LSQk9WyETR4cJ
        S5TLPXu4gO2EFzgv+BV3iedKQOJc4KM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 798D013462;
        Tue, 27 Jun 2023 12:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I7hnG3LXmmRiTAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 27 Jun 2023 12:34:58 +0000
Date:   Tue, 27 Jun 2023 14:34:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1 1/5] mm/memory_hotplug: check for fatal signals only
 in offline_pages()
Message-ID: <ZJrXcaGE6gCrmLqg@dhcp22.suse.cz>
References: <20230627112220.229240-1-david@redhat.com>
 <20230627112220.229240-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627112220.229240-2-david@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-06-23 13:22:16, David Hildenbrand wrote:
> Let's check for fatal signals only. That looks cleaner and still keeps
> the documented use case for manual user-space triggered memory offlining
> working. From Documentation/admin-guide/mm/memory-hotplug.rst:
> 
> 	% timeout $TIMEOUT offline_block | failure_handling
> 
> In fact, we even document there: "the offlining context can be terminated
> by sending a fatal signal".

We should be fixing documentation instead. This could break users who do
have a SIGALRM signal hander installed.

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e0fa209d533..0d2151df4ee1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1879,7 +1879,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	do {
>  		pfn = start_pfn;
>  		do {
> -			if (signal_pending(current)) {
> +			if (fatal_signal_pending(current)) {
>  				ret = -EINTR;
>  				reason = "signal backoff";
>  				goto failed_removal_isolated;
> -- 
> 2.40.1

-- 
Michal Hocko
SUSE Labs
