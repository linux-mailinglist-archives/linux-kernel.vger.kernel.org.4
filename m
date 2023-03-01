Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972E16A67B4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 07:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCAGrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 01:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCAGq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 01:46:59 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA413802C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 22:46:58 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d7so13200708qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 22:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677653216;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4wPZF4CNsbWSynBrFcgIaSY0egkPPHLosV5c2A5sKE=;
        b=aN1xo625SNX4a+IGPlEI/k/zzV8b8809XXx9YiKlwBsfr8Q3+mWN8EWBDpH9QJhSEr
         EGUrhZWG7CXIU2/PkSmJfPS3n6BoHQH0qUytpnE7qgRcK2hoFvLBdFAq7XmEQDOj7x9F
         jYuF8jlB/cKV2cYy/u7Ix9+MQzeF4iKqffziw65wN1wFnbGxHsKVda7EsUgMXCcwAGSm
         AsEypPE5E776gVCexmId+MKXIv7CTASHUX7lPJyxZSn7SPMW3asRg/7JPQuTKCPIguNU
         ms1R2DhGNaI+/rOkrkg6yNtYVu7k6kIA2I5Tetv3ArW42wymlqNd84WiUjG5fi//oRY0
         ktxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677653216;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4wPZF4CNsbWSynBrFcgIaSY0egkPPHLosV5c2A5sKE=;
        b=d/265imAZ7l6bBAtwEiY/TUuyyMJBpzv5gOnBEbXYOAdRea7uYDbuBpVTdbxiDxIHb
         074Hxw/08IkDETdJiEp77m9pu8XsH2gij5n3bsa1Qbnnk4D2a5IW4XWSsD70tnA1Db7U
         U9Na3kak/1D9XEEV6a/y+0TjvnR5lUxW2nrrVNtoLhqWL4UNG9NZOYswOpPI8iEpsVPU
         iAP+FCK3l9qNLs/wOaGiidr2JMhmvbP9sFVWrBX2teyVwGNzpYF9WCqNRmC04rp9LdI6
         C3Z6CKxBrJSurZGmerI0lXWCn7/c5frRubFhi80jCzF3UzRqxpuObXUv4TVFXfoP90jb
         XcLA==
X-Gm-Message-State: AO0yUKUbn1d8/xwVSHX48Z7Vc2ynOdHkzYT91K8H7T7NYkxYIP83gv7X
        fKLnLsXZUX61Lbwl7zGtFGmckQ==
X-Google-Smtp-Source: AK7set/tYVT5D0UtWAI/7a8bpZlD3noJ/msNxV/h6vdxkkuBpxubPm3sw4EBjoo8zKASeKyjUaxM5A==
X-Received: by 2002:ac8:5f84:0:b0:3b8:2b94:5bf5 with SMTP id j4-20020ac85f84000000b003b82b945bf5mr9217394qta.55.1677653216338;
        Tue, 28 Feb 2023 22:46:56 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k13-20020ac8074d000000b003bfd27755d7sm5789695qth.19.2023.02.28.22.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 22:46:55 -0800 (PST)
Date:   Tue, 28 Feb 2023 22:46:47 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 3/3] migrate_pages: try migrate in batch asynchronously
 firstly
In-Reply-To: <874jr5atqf.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <c9de353-2420-d076-9fff-d6011611c2b@google.com>
References: <20230224141145.96814-1-ying.huang@intel.com> <20230224141145.96814-4-ying.huang@intel.com> <bdc873-3367-9aa7-79c6-91c68fecac41@google.com> <87cz5ub5dr.fsf@yhuang6-desk2.ccr.corp.intel.com> <070f71-9af-c29a-30b9-758b5cdf6766@google.com>
 <874jr5atqf.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023, Huang, Ying wrote:
> Hugh Dickins <hughd@google.com> writes:
> > On Tue, 28 Feb 2023, Huang, Ying wrote:
> >> Hugh Dickins <hughd@google.com> writes:
> >> > On Fri, 24 Feb 2023, Huang Ying wrote:
> >> >> 
> >> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> >> index 91198b487e49..c17ce5ee8d92 100644
> >> >> --- a/mm/migrate.c
> >> >> +++ b/mm/migrate.c
> >> >> @@ -1843,6 +1843,51 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
> >> >>  	return rc;
> >> >>  }
> >> >>  
> >> >> +static int migrate_pages_sync(struct list_head *from, new_page_t get_new_page,
> >> >> +		free_page_t put_new_page, unsigned long private,
> >> >> +		enum migrate_mode mode, int reason, struct list_head *ret_folios,
> >> >> +		struct list_head *split_folios, struct migrate_pages_stats *stats)
> >> >> +{
> >> >> +	int rc, nr_failed = 0;
> >> >> +	LIST_HEAD(folios);
> >> >> +	struct migrate_pages_stats astats;
> >> >> +
> >> >> +	memset(&astats, 0, sizeof(astats));
> >> >> +	/* Try to migrate in batch with MIGRATE_ASYNC mode firstly */
> >> >> +	rc = migrate_pages_batch(from, get_new_page, put_new_page, private, MIGRATE_ASYNC,
> >> >> +				 reason, &folios, split_folios, &astats,
> >> >> +				 NR_MAX_MIGRATE_PAGES_RETRY);
> >> >
> >> > I wonder if that and below would better be NR_MAX_MIGRATE_PAGES_RETRY / 2.
> >> >
> >> > Though I've never got down to adjusting that number (and it's not a job
> >> > to be done in this set of patches), those 10 retries sometimes terrify
> >> > me, from a latency point of view.  They can have such different weights:
> >> > in the unmapped case, 10 retries is okay; but when a pinned page is mapped
> >> > into 1000 processes, the thought of all that unmapping and TLB flushing
> >> > and remapping is terrifying.
> >> >
> >> > Since you're retrying below, halve both numbers of retries for now?
> >> 
> >> Yes.  These are reasonable concerns.
> >> 
> >> And in the original implementation, we only wait to lock page and wait
> >> the writeback to complete if pass > 2.  This is kind of trying to
> >> migrate asynchronously for 3 times before the real synchronous
> >> migration.  So, should we delete the "force" logic (in
> >> migrate_folio_unmap()), and try to migrate asynchronously for 3 times in
> >> batch before migrating synchronously for 7 times one by one?
> >
> > Oh, that's a good idea (but please don't imagine I've thought it through):
> > I hadn't realized the way in which your migrate_pages_sync() addition is
> > kind of duplicating the way that the "force" argument conditions behaviour,
> > It would be very appealing to delete the "force" argument now if you can.
> 
> Sure.  Will do that in the next version.
> 
> > But aside from that, you've also made me wonder (again, please remember I
> > don't have a good picture of the new migrate_pages() sequence in my head)
> > whether you have already made a *great* strike against my 10 retries
> > terror.  Am I reading it right, that the unmapping is now done on the
> > first try, and the remove_migration_ptes after the last try (all the
> > pages involved having remained locked throughout)?
> 
> Yes.  You are right.  Now, unmapping and moving are two separate steps,
> and they are retried separately.  After a folio has been unmapped
> successfully, we will not remap/unmap it 10 times if the folio is pinned
> so that failed to move (migrate_folio_move()).  So the latency caused by
> retrying is much better now.  But I still tend to keep the total retry
> number as before.  Do you agree?

Yes, I agree, keep the total retry number 10 as before: maybe someone in
future will show that more than 5 is a waste of time, but there's little
need to get into that now: if you've put an end to that 10 times unmapping
and remapping, that's a great step forward, quite apart from the TLB flush
batching itself.

(I did change "no need" to "little need" above: I do have some some
anxiety about the increased latencies from keeping folios locked and
migration entries in place for significantly longer than before your
batching: I won't be surprised if the maximum batch size has to be
lowered, if reports of latency spikes come in; and that might extend
to the retry count too.)

Hugh
