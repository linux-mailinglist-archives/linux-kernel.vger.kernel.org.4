Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BFB6A2E11
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBZEKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZEKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:10:00 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CF355AC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:10:00 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y2so2916854pjg.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oG85UY3exoCKYxhLzbBvh8IvJHkJe4lKut/jy7cNC+A=;
        b=iDqG1LSbkkz6go3LRUm4otXKpZiZ3jN9DR9C5Bt5Mo/PPbZK0paSq10/j8Ah3emPur
         xJ/tLB2qVgHbpfYWW1InphQ+P9zTtVJ/IJNYlnj6cJOCz//lVKpIqo3EAsIbeTF2ExT1
         WV4lxTF8KNS79dX16PH7IQKqrum0E2FZ/tJ2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oG85UY3exoCKYxhLzbBvh8IvJHkJe4lKut/jy7cNC+A=;
        b=yxYYbekU7D7KcSPm5gsxs8/OmpM/VYmMbCx7AXzXLMWwjCotk2YM+eaqC0SSxC3iWU
         sbGzCyHg1qQtvQAyMS2Z8wgqncaY0+8Wy6dJ9sgTtLO97c9ECG4mxH33teNkrs3TQOZY
         ozbTabz10xq8D0jOU2hsK+Gz5dMgmlFVSN3Lwhu0KJrzZ6J0k9din1LH/S6e85oEWT/u
         Wm5UlB6yGrkoAXOGGJXqrXSNLiPc2IelGCxtS5IVezJW94sN55Y75xkTPSayipLYlTdz
         rmVnOndru2Is5gwXwnjfi5BOGHcu+S/O+UkBuf/Cp05SZugxbpWKOou7QanFgatWKGQQ
         AvMQ==
X-Gm-Message-State: AO0yUKXXNTrRuSooYxy/0Tad6rp2MxTz6WMOlIZFRAmwX0m1hZl7KsKn
        VxTHXNIOuCZUjzL37TYblap9dw==
X-Google-Smtp-Source: AK7set9HK0gGLeLYDgcMVVNSfKMfoyjNCjjQhFkeXNMa/fJjha1Ui9KvxJcfBZPqs6ZED3JnLhcsZA==
X-Received: by 2002:a17:902:e884:b0:198:dd3f:2847 with SMTP id w4-20020a170902e88400b00198dd3f2847mr27274559plg.21.1677384599577;
        Sat, 25 Feb 2023 20:09:59 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709029a8b00b0019a7363e752sm1930345plp.276.2023.02.25.20.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:09:59 -0800 (PST)
Date:   Sun, 26 Feb 2023 13:09:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 4/6] zsmalloc: rework compaction algorithm
Message-ID: <Y/rbk03cJc44StNr@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-5-senozhatsky@chromium.org>
 <Y/f60c25V4oiIeMN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/f60c25V4oiIeMN@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/23 15:46), Minchan Kim wrote:
> >  	spin_lock(&pool->lock);
> > -	while ((src_zspage = isolate_src_zspage(class))) {
> > -		/* protect someone accessing the zspage(i.e., zs_map_object) */
> > -		migrate_write_lock(src_zspage);
> > -
> > -		if (!zs_can_compact(class))
> > -			break;
> > -
> > -		cc.obj_idx = 0;
> > -		cc.s_page = get_first_page(src_zspage);
> > -
> > -		while ((dst_zspage = isolate_dst_zspage(class))) {
> > -			migrate_write_lock_nested(dst_zspage);
> > -
> > +	while (1) {
> 
> Hmm, I preferred the old loop structure. Did you see any problem
> to keep old code structure?

Unfortunately we cannot keep the current structure as it will create
conflicting/reverse locking patterns.

What we currently have is that source page is isolated first and its
migration lock is the outter lock:

	migrate_write_lock src

Destination page is isolated second and its migration lock is nested:

	migrate_write_lock_nested dst

Since destination page lock is nested we always need to unlock it before
we unlock the outer lock (source page migrate lock). If we keep destination
locked (nested lock, which will be a bug) then on the next iteration we will
isolate a new source page and try to migrate_write_lock it except that now
source page migration lock is in fact nested which we take under another
nested lock (which is another bug).

Hence we need to flip the structure: we isolate destination page, its
lock is outter lock, we keep it locked as long as we need and source page
lock becomes nested. I think that's the simplest way.
