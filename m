Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0608C6F1662
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbjD1LHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345398AbjD1LHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:07:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B87448C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:07:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 856CF2005F;
        Fri, 28 Apr 2023 11:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682680048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ow3aw4xOvVLC6jge2IF3IgMxcgiXds6JLxSLB6q5HcY=;
        b=ANKTYutrVBEqWMZ9swOBzcpO+F6v3VRWJC1kQxIr/LVvQP0QCuY9D3iPITCsOaBFWNZZFK
        xrQ5XqTmePAdS/VRHMDhFOc+a4W4wNPP41J9/qLBapFguH8ljQYPlbAnZ44ibKfGPnJj11
        YG0OfLhuROKznSSfMhFBRuxiDn8kqCY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75289138FA;
        Fri, 28 Apr 2023 11:07:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PRjDG/CoS2SBTgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 28 Apr 2023 11:07:28 +0000
Date:   Fri, 28 Apr 2023 13:07:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     david@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: fix dead loop in offline_pages()
Message-ID: <ZEuo8PiA3EzVnrEi@dhcp22.suse.cz>
References: <20230428100846.95535-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428100846.95535-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-04-23 18:08:46, Yajun Deng wrote:
> When migration failure in do_migrate_range() and then the
> scan_movable_pages() will most likely return the same movable pfn.
> In this case, there is no condition to bail out, they will
> always run like this:
> 
> ...
> [878020.623959] migrating pfn 1727813 failed ret:1
> [878020.623960] page:00000000faa9673c refcount:3 mapcount:0 mapping:00000000144ccd79 index:0x14280025 pfn:0x1727813
> [878020.623962] memcg:ffffa0ff82d5a000
> [878020.623962] aops:def_blk_aops ino:fd00001
> [878020.623964] flags: 0x17ffffc000206a(referenced|dirty|active|workingset|private|node=0|zone=2|lastcpupid=0x1fffff)
> [878020.623966] raw: 0017ffffc000206a ffffb0d14f50fbd8 ffffb0d14f50fbd8 ffffa0ff9c155018
> [878020.623967] raw: 0000000014280025 ffffa10327d702d8 00000003ffffffff ffffa0ff82d5a000
> [878020.623968] page dumped because: migration failure
> [878020.626196] migrating pfn 1727813 failed ret:1
> [878020.626198] page:00000000faa9673c refcount:3 mapcount:0 mapping:00000000144ccd79 index:0x14280025 pfn:0x1727813
> [878020.626200] memcg:ffffa0ff82d5a000
> [878020.626200] aops:def_blk_aops ino:fd00001
> [878020.626202] flags: 0x17ffffc000206a(referenced|dirty|active|workingset|private|node=0|zone=2|lastcpupid=0x1fffff)
> [878020.626204] raw: 0017ffffc000206a ffffb0d14f50fbd8 ffffb0d14f50fbd8 ffffa0ff9c155018
> [878020.626205] raw: 0000000014280025 ffffa10327d702d8 00000003ffffffff ffffa0ff82d5a000
> [878020.626206] page dumped because: migration failure
> ...
> 
> Bail out when migration failures reach 3 times.
> 
> Fixes: bb8965bd82fd ("mm, memory_hotplug: deobfuscate migration part of offlining")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Any hard coded failure retry limit will lead to premature failures. Have
a look at 72b39cfc4d75 ("mm, memory_hotplug: do not fail offlining too
early"). A proper way to deal with this is to implement termination from
the userspace (e.g. timeout $TIMEOUT /bin/echo 0 > $PATH_TO_MEM/online)
Nacked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e0fa209d533..72dd385b8892 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1800,11 +1800,12 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  			struct zone *zone, struct memory_group *group)
>  {
>  	const unsigned long end_pfn = start_pfn + nr_pages;
> -	unsigned long pfn, system_ram_pages = 0;
> +	unsigned long pfn, tmp_pfn, system_ram_pages = 0;
>  	const int node = zone_to_nid(zone);
>  	unsigned long flags;
>  	struct memory_notify arg;
>  	char *reason;
> +	int count = 0;
>  	int ret;
>  
>  	/*
> @@ -1887,12 +1888,20 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  
>  			cond_resched();
>  
> +			tmp_pfn = pfn;
>  			ret = scan_movable_pages(pfn, end_pfn, &pfn);
>  			if (!ret) {
> -				/*
> -				 * TODO: fatal migration failures should bail
> -				 * out
> -				 */
> +				if (pfn == tmp_pfn)
> +					count++;
> +				else
> +					count = 0;
> +
> +				if (unlikely(count == 3)) {
> +					ret = -EBUSY;
> +					reason = "migration failure";
> +					goto failed_removal_isolated;
> +				}
> +
>  				do_migrate_range(pfn, end_pfn);
>  			}
>  		} while (!ret);
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
