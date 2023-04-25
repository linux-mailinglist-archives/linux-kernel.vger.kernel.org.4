Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5B26EDEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjDYJF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjDYJFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:05:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6AB40F6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:05:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A94681FDA6;
        Tue, 25 Apr 2023 09:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682413513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xzm/BLxveH53hIE9Oz6LVwpRoYTc+NgPyMt/SoDBV7I=;
        b=ehMq1PnWzt3Pcx3ZmApqcxnJE9bPv/zpwbppcQMisK5Y8UT93KS82OwWv6dFkG7JEMltkp
        /TmvSS8JTJWGy7gDzXQRQVjsk9nJy94KCZM4JNV0/zxfFRZ6BjOccZIORez0lINaio8FRH
        Qu5uHgHrGtXkXrE28Re/yREDAz/HaWo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98FC213466;
        Tue, 25 Apr 2023 09:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XPi1JMmXR2S3dgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 25 Apr 2023 09:05:13 +0000
Date:   Tue, 25 Apr 2023 11:05:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
        rppt@kernel.org, mgorman@techsingularity.net, vbabka@suse.cz,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
Message-ID: <ZEeXyZuTGT7CDuU7@dhcp22.suse.cz>
References: <c3868b58c6714c09a43440d7d02c7b4eed6e03f6.1682342634.git.baolin.wang@linux.alibaba.com>
 <50b5e05dbb007e3a969ac946bc9ee0b2b77b185f.1682342634.git.baolin.wang@linux.alibaba.com>
 <87zg6wkdy8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <060aab79-8170-56ad-797d-9d339f6c0b61@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <060aab79-8170-56ad-797d-9d339f6c0b61@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-04-23 09:27:23, Baolin Wang wrote:
> 
> 
> On 4/25/2023 8:22 AM, Huang, Ying wrote:
> > Baolin Wang <baolin.wang@linux.alibaba.com> writes:
[...]
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 6457b64fe562..bd124390c79b 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -1502,6 +1502,15 @@ void __free_pages_core(struct page *page, unsigned int order)
> > >    * interleaving within a single pageblock. It is therefore sufficient to check
> > >    * the first and last page of a pageblock and avoid checking each individual
> > >    * page in a pageblock.
> > > + *
> > > + * Note: the function may return non-NULL struct page even for a page block
> > > + * which contains a memory hole (i.e. there is no physical memory for a subset
> > > + * of the pfn range). For example, if the pageblock order is MAX_ORDER, which
> > > + * will fall into 2 sub-sections, and the end pfn of the pageblock may be hole
> > > + * even though the start pfn is online and valid. This should be safe most of
> > > + * the time because struct pages are still zero pre-filled and pfn walkers
> > 
> > I don't think the pfn is just zero-filled even it's a hole.  Can you
> > confirm that?  In memmap_init() and memmap_init_zone_range(),
> > init_unavailable_range() is called to initialize the struct page.
> 
> Yes, what I mean is the page frames were initialized to zero firstly, and
> some fields were initialized to default value. The "zero pre-filled" seems
> confusing, may be change to "initialized"?

Huang Ying is correct. Holes should have struct pages initialized and
init_unavailable_range actually marks those pages reserved. Which
is really good because they mean "do not touch unless this page is
yours". For some reason I thought those struct pages are simply zero
filled. I was clearly wrong. Maybe it would be good to reference
init_unavailable_range in the comment so that it is easier to track the
whole code path.

Sorry about that!
-- 
Michal Hocko
SUSE Labs
