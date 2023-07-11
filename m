Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DBB74F94F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGKUr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGKUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:47:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463BD9B;
        Tue, 11 Jul 2023 13:47:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D32791FE45;
        Tue, 11 Jul 2023 20:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689108444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LaucvtloWCHpaXc2axnPFcfthuhw0RH1IRv8sUy6fI=;
        b=Az2OzX9RYGO8kSztwAv4FZoRnv5TOlOzw0ViMusf5VKfMCKXaADhC0TL7skKzP8DIheEch
        bWfai/uJzSP/rQvtcCOjTq3oQsYuJA704x2WmTkwkrMt39x3fItBjoXz1pHH9RDYLD0NOF
        Hxc172rmIwbv7DbuXntJ9W00Y1Slafs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFF7D1390F;
        Tue, 11 Jul 2023 20:47:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lGSQKNy/rWQOKQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 11 Jul 2023 20:47:24 +0000
Date:   Tue, 11 Jul 2023 22:47:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] mm/memory_hotplug: document the signal_pending()
 check in offline_pages()
Message-ID: <ZK2/3Kq8VlDwcCpc@dhcp22.suse.cz>
References: <20230711174050.603820-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711174050.603820-1-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-07-23 19:40:50, David Hildenbrand wrote:
> Let's update the documentation that any signal is sufficient, and
> add a comment that not only checking for fatal signals is historical
> baggage: changing it now could break existing user space. although
> unlikely.
> 
> For example, when an app provides a custom SIGALRM handler and triggers
> memory offlining, the timeout cmd would no longer stop memory offlining,
> because SIGALRM would no longer be considered a fatal signal.

Yes, and it is likely goot to mention here that this is an antipattern
for many other kernel operations like IO (e.g. write) but it is a long
term behavior that somebody might depend on and it is safer to reflect
the documentation to the realitity rather than other way around (which
would be imho better).

> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

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
> +			 * breaking user space.
> +			 */
>  			if (signal_pending(current)) {
>  				ret = -EINTR;
>  				reason = "signal backoff";
> -- 
> 2.41.0

-- 
Michal Hocko
SUSE Labs
