Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13917699A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBPQvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBPQvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:51:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8963422F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:51:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60794B828EE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DDCC4339C;
        Thu, 16 Feb 2023 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676566264;
        bh=WV879P792kJsz5SaPeIjsyqXQTDsaVQ+LnKlf858IWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhxMfgpoRyg1L/xuvXXWMx23CzWRC5drIzOh51SnRipAVzc/qvv5xbyMSJW9v0U12
         rOPlEF8P3fivVfY2kVT6h3gbL53YZH0UZHPUgruXcvdQXeq4floSjJEJUJu5FmBbsw
         Po3Nga6EjuuyWiK9MNnvQ0bm6pFFzOX0NURCXlz/9VhzTTwOe7mD2mP0D1cr9ak2MU
         x9FTF7dOiWFurVDaxafY9g27V+11h3q24eG9ZLw2X7Wcmq0rDU1e6AYVHDxh6O03EQ
         CsMtwEFELmz7AlL5bG4Kxo0MIfrKiNnGX1jbzSU6vwRyMi9Lva4sQ60HpMa8FAatG5
         CLrSnlw4Mq95A==
From:   SeongJae Park <sj@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: return nothing from do_migrate_range()
Date:   Thu, 16 Feb 2023 16:51:02 +0000
Message-Id: <20230216165102.64115-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9c274928-1118-1b31-9aff-07cd246cbbcf@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, 16 Feb 2023 10:46:59 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 16.02.23 00:02, SeongJae Park wrote:
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
> >   }
> 
> I think this patch should also stop initializing ret = 0 inside that 
> function.

The second patch does it, and I read your reply to the patch asking squashing
it in this one.  I will send the new version soon.

> 
> With that
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks you.


Thanks,
SJ

> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 
