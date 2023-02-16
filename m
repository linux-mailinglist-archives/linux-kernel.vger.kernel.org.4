Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C891F699A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBPQzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBPQzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:55:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB92135
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:55:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35E4EB82922
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2764EC4339C;
        Thu, 16 Feb 2023 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676566514;
        bh=j40lAfOGkYAWZrfnC2JLolxDDNUNCyY2yYONJ77J6eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGfq53E8knZz63Z/Z1BUIIQouGs6NmKzkS5GvuZ0VXxmkJBAYMyX2cg8yDYEkDnXV
         EOnpHaTw5WLfjp00KpXtWJbwQF+z10XlMT95sO3BOUtQz0gNoQUB141IhJsOxr4WV6
         Ktt9UksOczzASr3JjyLTqTWAjYxuAZv+GAd9NuQkZQU3mub9IbaOZzxBhxxz6e9TR7
         S3wV0VTkUM4k044ISB8ktQ4g4Q3JlqoYL9rKFC6g+2cpeMHoVHBm0TRDOVmAVI4Ki3
         9sS/WAW6bRZ9HRuaOZoc2vkR37+F8BuWbuVvPfksDKOEEuYJ3EdweTyHEeFT8lUVoW
         jXoPtNDpeCL9A==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: return nothing from do_migrate_range()
Date:   Thu, 16 Feb 2023 16:55:12 +0000
Message-Id: <20230216165512.64177-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <af96ecf7-3039-784d-c276-5fc6b72611c4@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On Thu, 16 Feb 2023 18:53:34 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 2/16/2023 7:02 AM, SeongJae Park wrote:
> > Return value mechanism of do_migrate_range() is not very simple, while
> > no caller of the function checks the return value.  Make the function
> > return nothing to be more simple.
> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >   mm/memory_hotplug.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index bcb0dc41c2f2..6c615ba1a5c7 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1620,8 +1620,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
> >   	return 0;
> >   }
> >   
> > -static int
> > -do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> > +static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> >   {
> >   	unsigned long pfn;
> >   	struct page *page, *head;
> > @@ -1721,8 +1720,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> >   			putback_movable_pages(&source);
> >   		}
> >   	}
> > -
> > -	return ret;
> 
> Nit: while we are at it, can we also remove the "TODO" comment in 
> offline_pages()?
> 
> ret = scan_movable_pages(pfn, end_pfn, &pfn);
> if (!ret) {
> 	/*
> 	 * TODO: fatal migration failures should bail
> 	 * out
> 	 */
> 	do_migrate_range(pfn, end_pfn);
> }
> 
> With David's comments:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

As David mentioned we're just still unclear what issues are fatal[1], I was
thinking we didn't forgive the future work, so left the comment.  If anyone has
different opinion or I'm getting something wrong, please let me know.

[1] https://lore.kernel.org/linux-mm/388b9a93-423f-33f8-0495-2a4a290fd1aa@redhat.com/


Thanks,
SJ
