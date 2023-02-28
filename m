Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AC26A612E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjB1VXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB1VXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:23:04 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ADC10402
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:23:02 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id l18so11114577qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677619382;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eA3BqXcGEc46f5liQkJ2TjEWDJOzbNiIQCKLaYI0SXA=;
        b=e+W8arsY9EsnC6Gr2ZfXQPNvZ0+R3kmADmzK7YBsjdz1FxcdKr/H7+vWeVmUak/mfh
         5/ZnXv3aG0BgMWs8qfZ3y4VF+eznPagy2BfYh24PB7frAWW0B9RwuR1xFCUtYYCkIxYx
         +E7BhZg3QVf3boKXXvPsul4T+wCac46VPoxyvziAbUbqlEujSvFKAVKX3V1w9n+cYXdq
         nN4zstbiF2ydNWtd5d4twfGchaYPkOaDqjFmXfQ3IzyTaOZhBBT12GdtG8IIglEQNZ1D
         loYjqSdYjqP3RW0rC256fsf34tIhdMR60Cy18khf9jswBpm/lAT8VGlXJnoBHm5MSG1y
         TqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677619382;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eA3BqXcGEc46f5liQkJ2TjEWDJOzbNiIQCKLaYI0SXA=;
        b=vNbYhdlLBEKxq8moTEU/wwZHkwJqkuSP8AVLMItEetAdV/2BFLlh/x8On9eAq6lqE5
         jIPZgurgE6QPzqdJlxH2mMZHjPK7KEh314ATaK3IG6PjuzHPEi9oYifFzvL6xN70JxW5
         6i6mT7MJ3hfQ11ncIu5yk5JNlI9hMsQ+Yt6QASYFmvVofblnCca/DMGXnduxd/eIaAiB
         sAu43tAA2xYKYouu5bm+O5+vskrMGuobQ8YEZFfjexukpJKtu9qcr8WDLyWHE0C7yx5s
         FWf4t9oxBf6oQ4W/7XFrRaSLudJMPi/p/TDZtK6HhKNVS+UnVAByPbGg+PNjd4pxdooK
         W6EQ==
X-Gm-Message-State: AO0yUKXhxX96V8MVFPptrdqQt59yID7Mi1TgdXbOIHDnT+nPdPTJzlFZ
        8ql/0I7C+2jhKKa7PW/D+cVTXw==
X-Google-Smtp-Source: AK7set9QLRaN0qvbqFj+yjo3Bh1WlVVO26R8J7dMRJHdm0Bt+ZxyLy3MLUk+OBPK/7bGqF1wQBzB2A==
X-Received: by 2002:a05:622a:19a0:b0:3bf:de3a:e717 with SMTP id u32-20020a05622a19a000b003bfde3ae717mr8136570qtc.39.1677619381941;
        Tue, 28 Feb 2023 13:23:01 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 15-20020ac856ef000000b003bfeb30c24dsm1329481qtu.39.2023.02.28.13.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 13:23:01 -0800 (PST)
Date:   Tue, 28 Feb 2023 13:22:59 -0800 (PST)
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
In-Reply-To: <87cz5ub5dr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <070f71-9af-c29a-30b9-758b5cdf6766@google.com>
References: <20230224141145.96814-1-ying.huang@intel.com> <20230224141145.96814-4-ying.huang@intel.com> <bdc873-3367-9aa7-79c6-91c68fecac41@google.com> <87cz5ub5dr.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

On Tue, 28 Feb 2023, Huang, Ying wrote:
> Hugh Dickins <hughd@google.com> writes:
> > On Fri, 24 Feb 2023, Huang Ying wrote:
> >> 
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 91198b487e49..c17ce5ee8d92 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -1843,6 +1843,51 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
> >>  	return rc;
> >>  }
> >>  
> >> +static int migrate_pages_sync(struct list_head *from, new_page_t get_new_page,
> >> +		free_page_t put_new_page, unsigned long private,
> >> +		enum migrate_mode mode, int reason, struct list_head *ret_folios,
> >> +		struct list_head *split_folios, struct migrate_pages_stats *stats)
> >> +{
> >> +	int rc, nr_failed = 0;
> >> +	LIST_HEAD(folios);
> >> +	struct migrate_pages_stats astats;
> >> +
> >> +	memset(&astats, 0, sizeof(astats));
> >> +	/* Try to migrate in batch with MIGRATE_ASYNC mode firstly */
> >> +	rc = migrate_pages_batch(from, get_new_page, put_new_page, private, MIGRATE_ASYNC,
> >> +				 reason, &folios, split_folios, &astats,
> >> +				 NR_MAX_MIGRATE_PAGES_RETRY);
> >
> > I wonder if that and below would better be NR_MAX_MIGRATE_PAGES_RETRY / 2.
> >
> > Though I've never got down to adjusting that number (and it's not a job
> > to be done in this set of patches), those 10 retries sometimes terrify
> > me, from a latency point of view.  They can have such different weights:
> > in the unmapped case, 10 retries is okay; but when a pinned page is mapped
> > into 1000 processes, the thought of all that unmapping and TLB flushing
> > and remapping is terrifying.
> >
> > Since you're retrying below, halve both numbers of retries for now?
> 
> Yes.  These are reasonable concerns.
> 
> And in the original implementation, we only wait to lock page and wait
> the writeback to complete if pass > 2.  This is kind of trying to
> migrate asynchronously for 3 times before the real synchronous
> migration.  So, should we delete the "force" logic (in
> migrate_folio_unmap()), and try to migrate asynchronously for 3 times in
> batch before migrating synchronously for 7 times one by one?

Oh, that's a good idea (but please don't imagine I've thought it through):
I hadn't realized the way in which your migrate_pages_sync() addition is
kind of duplicating the way that the "force" argument conditions behaviour,
It would be very appealing to delete the "force" argument now if you can.

But aside from that, you've also made me wonder (again, please remember I
don't have a good picture of the new migrate_pages() sequence in my head)
whether you have already made a *great* strike against my 10 retries
terror.  Am I reading it right, that the unmapping is now done on the
first try, and the remove_migration_ptes after the last try (all the
pages involved having remained locked throughout)?

Hugh
