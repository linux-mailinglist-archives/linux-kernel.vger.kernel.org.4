Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C0F67DA39
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjA0AJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjA0AJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:09:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C8728EE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:08:46 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso6988093pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYasTB2m4TEatMoCQBPHuxDKatey6WCBsn2n2geZIeM=;
        b=ICXGjelCoQX3DlTPd5YxJGGN4wvxmLuWXue7Y3WPN6UaMWwFG1kvLdxeUH9fV14mNc
         8Q73FUtUItzw+C1lppAOrpp8jfD93nvCvjsiNyiwD9aoks7SE9d1mqdRWHFHD6d/54iN
         +MlhcEwfpxqakO6mAZfOcfbxtEG6JOjlkDrfWfzsq+tj/5raaA5Les+oNZ5nQWl+zq+b
         QjzNAM7jqj0j1/lx3G22WFp91X+2TZg7ll35CbyCAXXsiqGubadvjLjmhrZnlhjphlq8
         Bh1fRdhNK+9nr1NJrUat/p6j5FQd3hbRIFPg8/5RmgWUiM0m223jobtKgUEd8h0RdIq4
         fltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYasTB2m4TEatMoCQBPHuxDKatey6WCBsn2n2geZIeM=;
        b=Zs4d8iY50x2E5bNgQUhTDNbvFXkQMOlMX9RKWaGpwVsgfln8TNLmwkVqNAqmWVD/IP
         uqBdVWf+VXIt3XWGF+YditigSXQCUQDlxvRnNprsSIHh5gn/0idpMNgw7jjVbO6aHqk2
         zHRpQlwMBQFfzuwuGV+qrXpz4v8lFIS295VjpHSOJKD28/KWLr6GsP412xe5hxwm1XCE
         /V+prjpd8IdohlI3E+vMd0KA4rM8SpnnAKVzKh9+tL2R7h/MGLNthHMNdJDH65ocAiU9
         ZoTUzoyzhClFn2h+Nr44piQfGHezowi30jat0Jy9sAs1s9jObpEB6+B7c4lMnr3AFYUH
         +blw==
X-Gm-Message-State: AFqh2koVHng1F0kIQgQReU+z7lJr6T1d0u1jOpatOBrhESh6TrLEgXx4
        pPLb4uaxDhoxeUyXTBovbrDzH+v6IOg=
X-Google-Smtp-Source: AMrXdXs5favszU6a2xnNWHR8t+LYt+QAJSjm58Nw1cMIzt0kh0ZMT3sYHmmhpfsek7efohuNx3o7YA==
X-Received: by 2002:a17:902:bf0c:b0:192:c36c:f115 with SMTP id bi12-20020a170902bf0c00b00192c36cf115mr35366957plb.66.1674778125579;
        Thu, 26 Jan 2023 16:08:45 -0800 (PST)
Received: from google.com ([2620:15c:211:201:9ca6:45a6:69fe:a468])
        by smtp.gmail.com with ESMTPSA id w30-20020aa79a1e000000b0058215708d57sm1431239pfj.141.2023.01.26.16.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:08:45 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 26 Jan 2023 16:08:43 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9MWC8xh8gOKDrUU@google.com>
References: <20230125005457.4139289-1-minchan@kernel.org>
 <Y9DigKf0w712t0OO@dhcp22.suse.cz>
 <Y9FacrcUIaLZq4DL@google.com>
 <Y9FhtBbnlNxAZAS4@dhcp22.suse.cz>
 <Y9Fv9YnNn7bHvLkN@google.com>
 <Y9GhNxqfjTEAFr5V@dhcp22.suse.cz>
 <Y9Grb2rggptkCu+n@google.com>
 <Y9I+3ZkWRdXdPBxg@dhcp22.suse.cz>
 <Y9K0Fn9MFPAgJjlM@google.com>
 <Y9LbgUDVnSBazIYW@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9LbgUDVnSBazIYW@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:58:57PM +0100, Michal Hocko wrote:
> On Thu 26-01-23 09:10:46, Minchan Kim wrote:
> > On Thu, Jan 26, 2023 at 09:50:37AM +0100, Michal Hocko wrote:
> [...]
> > > I suspect you try to mimic pgscan/pgsteal effectivness metric on the
> > > address space but that is a fundamentally different thing.
> > 
> > I don't see anything different, fundamentally.
> 
> OK, this really explains our disconnect here. Your metric reports
> nr_page_tables (nr_scanned) and number of aged and potentially reclaimed
> pages. You do not know whether that reclaim was successful. So you
> effectively learn how many pages have already been unmapped before your
> call. Can this be sometimes useful? Probably yes. Does it say anything
> about the reclaim efficiency? I do not think so. You could have hit
> pinned pages or countless other conditions why those pages couldn't have
> been reclaimed and they have stayed mapped after madvise call.
> 
> pgsteal tells you how many pages from those scanned have been reclaimed.
> See the difference?

That's why my previous version kept counting exact number of reclaimed/
deactivated pages but I changed mind since I observed majority of failure
happened from already-paged-out ranges and shared pages rather than minor
countless other conditions in real practice. Without finding present pages,
the mavise hints couldn't do anything from the beginning and that's the
major cost we are facing.

Saing again, I don't think the global stat could cover all the minor
you are insisting and I agree tracepoint could do better jobs to pinpoint
root causes but the global stat still have a role to provides basic ground
to sense abnormal and guides us moving next steps with easier interface/
efficient way.

> 
> Also I do not find information about how many non-present ptes have
> been scann super interesting. Sure that is a burnt time as well but to
> me it would be much more valuable information to see how many of those
> resident could have been actually reclaimed. Because that tells whether
> your reclaim target was a good choice and IMHO that is a valuable
> information for user space memory reclaim agent.

That's exactly what I had in previous version. If you believe it's right
direction, I am okay.

> 
> Again consider a large sparsely mapped memory but mostly inactive memory
> and a condensed active one with the same rss. The reclaim could have
> been successful for the former while not on the latter. Your matric
> would give a rather misleading numbers, don't you think?
> -- 
> Michal Hocko
> SUSE Labs
