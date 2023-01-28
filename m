Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D764167F429
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 04:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjA1DAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 22:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA1DAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 22:00:20 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ACB7AE73
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:00:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e10so4365508pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kf1srqWLiAwQJb6khMqwccVVI6dGAIwYciecs0JihFw=;
        b=PnDYYJrl5/HaL/66Vaho3VwAxBYUuYrHz7sMKUcrXTWf35wQGaRCqc9qG2DD8WcMcY
         f48AWxAJEJInkZiDBr1usAv2I0md7+HuXdmSDSRMRIXh4Yi/YPOWr6xh/RwoneOqSPe4
         c3pr5+3zNSTEJ2BrwiK7Z8iOUmpCAKem9MiwY60Evz76Aff+hGFYG/JsR3NUgMqt3S9L
         /kHpXdeyjxfYROf6fNyBV73W/z8sm3j87wQQ/Qxu17PW1BKOKacAvM263xRakDaK6S7z
         lbdbX6mkIa1xb/yYRlcjrfGftm10NOyXP/1tDiHi7soJLvCVgqRDATo1cAbMeO/zFreZ
         7u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kf1srqWLiAwQJb6khMqwccVVI6dGAIwYciecs0JihFw=;
        b=OxsEd4sAwFPcSq2/YHXTenW57PKCgKjNoju+ApWFSHmxYz3G5NDEEeEg1hTXFPrJkf
         A4WiGe3//IDC74xLhu8L8rQY//8dpGEwEOuWkvpHkEKuwUkiajSU9EuPC9oFbfJ0hDrA
         MVE6ofFaBGfjUJ9nRrO3P8ZNxnRUqnJsd6BIGovrjihspZvJTY5GoxcpjmMapfT7S0Vg
         ajFwtXRcHOpmV3wn15Gozz+TfsxwFxX6TB5taGAtm3m+TvGwj5ZsR0z0uNsbVngQ6Ug5
         5bQuxfRRB4UtdqVs8Tpm65LPqwn4apurA076L6imp1yGnt6rN2Uf5Eyu9r2JZjyHAqBZ
         huaw==
X-Gm-Message-State: AO0yUKUC2uyNsTacZEHB1QDVAKtN3p++SYfoV3BdZ008oWogg04jQNZ/
        imtYZM706eidoKBY6e+0BxI=
X-Google-Smtp-Source: AK7set+yb44oBZDoiywyb2FVP/S1XOb7gj9HbHztCRuKfPl2QPgPINlnRyksIUK/2/CaaVVkWjCb2A==
X-Received: by 2002:aa7:8484:0:b0:593:89ab:2ec4 with SMTP id u4-20020aa78484000000b0059389ab2ec4mr1907103pfn.10.1674874818748;
        Fri, 27 Jan 2023 19:00:18 -0800 (PST)
Received: from google.com ([2620:15c:211:201:967e:a55c:7b58:6c3e])
        by smtp.gmail.com with ESMTPSA id e22-20020a62aa16000000b0058db5d4b391sm3426668pff.19.2023.01.27.19.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 19:00:17 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 27 Jan 2023 19:00:15 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9SPv/QWqJ3t7w8J@google.com>
References: <Y9FacrcUIaLZq4DL@google.com>
 <Y9FhtBbnlNxAZAS4@dhcp22.suse.cz>
 <Y9Fv9YnNn7bHvLkN@google.com>
 <Y9GhNxqfjTEAFr5V@dhcp22.suse.cz>
 <Y9Grb2rggptkCu+n@google.com>
 <Y9I+3ZkWRdXdPBxg@dhcp22.suse.cz>
 <Y9K0Fn9MFPAgJjlM@google.com>
 <Y9LbgUDVnSBazIYW@dhcp22.suse.cz>
 <Y9MWC8xh8gOKDrUU@google.com>
 <Y9Od6ccvXujj+YJ/@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Od6ccvXujj+YJ/@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:48:25AM +0100, Michal Hocko wrote:
> On Thu 26-01-23 16:08:43, Minchan Kim wrote:
> > On Thu, Jan 26, 2023 at 08:58:57PM +0100, Michal Hocko wrote:
> > > On Thu 26-01-23 09:10:46, Minchan Kim wrote:
> > > > On Thu, Jan 26, 2023 at 09:50:37AM +0100, Michal Hocko wrote:
> > > [...]
> > > > > I suspect you try to mimic pgscan/pgsteal effectivness metric on the
> > > > > address space but that is a fundamentally different thing.
> > > > 
> > > > I don't see anything different, fundamentally.
> > > 
> > > OK, this really explains our disconnect here. Your metric reports
> > > nr_page_tables (nr_scanned) and number of aged and potentially reclaimed
> > > pages. You do not know whether that reclaim was successful. So you
> > > effectively learn how many pages have already been unmapped before your
> > > call. Can this be sometimes useful? Probably yes. Does it say anything
> > > about the reclaim efficiency? I do not think so. You could have hit
> > > pinned pages or countless other conditions why those pages couldn't have
> > > been reclaimed and they have stayed mapped after madvise call.
> > > 
> > > pgsteal tells you how many pages from those scanned have been reclaimed.
> > > See the difference?
> > 
> > That's why my previous version kept counting exact number of reclaimed/
> > deactivated pages but I changed mind since I observed majority of failure
> > happened from already-paged-out ranges and shared pages rather than minor
> > countless other conditions in real practice. Without finding present pages,
> > the mavise hints couldn't do anything from the beginning and that's the
> > major cost we are facing.
> 
> I cannot really comment on your user space reclaim policy but I would
> have expected that you at least check for rss before trying to use
> madvise on the range. Learning that from the operation sounds like a
> suboptimal policy to me.

Current rss couldn't say where is the present pages among huge address spaces.
And that's not what I want to from the operation but keep monitoring trending
under fleet. 


> 
> > Saing again, I don't think the global stat could cover all the minor
> > you are insisting and I agree tracepoint could do better jobs to pinpoint
> > root causes but the global stat still have a role to provides basic ground
> > to sense abnormal and guides us moving next steps with easier interface/
> > efficient way.
> 
> I hate to repeat myself but the more we discuss this the more I am
> convinced that vmstat is a bad fit. Sooner or later you end up realizing
> that nr_reclaimed/nr_scanned is insufficient metric because you would
> need to learn more anout those reclaim failures. Really what you want is
> to have a tracepoint with a full reclaim metric and grow monitoring tooling
> around that. This will deal with the major design flaw of global stat
> mentioned ealier (that you cannot attribute specific stats to the
> corresponding madvise caller).

Then, let me ask back to you.

What statistcis in the current vmstat fields or pending fields
(to be merged) among accumulated counter stats sound reasonable
to be part of vmstat fields not tracepoint from your perspective?

Almost every stat would have corner cases by various reasons and
people would want to know the reason from process, context, function
or block scope depending on how they want to use the stat.
Even, tracepoint you're loving couldn't tell all the detail what they want
without adding more and more as on growing code chages.
However, unlike your worry, people has used such an high level vague
vmstat fields very well to understand/monitor system health even though
it has various miscounting cases since they know the corner cases
are really minor.

I am really curious what metric we could add in the vmstat instead of
tracepoint in future if we follow your logic. 
