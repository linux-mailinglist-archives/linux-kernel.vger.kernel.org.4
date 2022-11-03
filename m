Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5069E6182AF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKCP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiKCP0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:26:19 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D88DD5A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:26:18 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a27so1411477qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYPYwj1adcbSApDOudmjpirtRwA5o5JIyavOO64tkyQ=;
        b=MZfsDA9heawqnjgKXy5Xp96r7SpvPm7O1VWJaR/hAopTCTwihkbA3eLuuNJen2tIGT
         4TQNEZl6vv97cK6CDWDDlcBsKAc2edO8iXE43vn7KHlZphBc8jj5W0cv8aaSe9yR8ymq
         rKCuzwpBFwA4EA7Ox6rsDB6G2cOQouxxBWZThVgHcD9ZuJbYb7/kGeXv5uJ3lKSkcZB3
         gIGoxawDfdXUCrjq1HVE/zqY3VPxgjMLlwEGXbShisx8DppSy9PG+eDaoyGXX2TSZ2RV
         ypjdmNnwZQjlHBJithoBc3WQ1gidHSt4AXo8HjGyzE9RugNnhSxKpR5SfW1269jLHPIP
         9j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYPYwj1adcbSApDOudmjpirtRwA5o5JIyavOO64tkyQ=;
        b=QG6JPbdehqid8axoL1OtBhlwxK8XmR/5Kv367HQUaFKd9qGpqsWHg/PM5PH5/YiCeK
         B7r5IXkIc0G6dtq6bYrWi/ALa/PbUPpd+boDsczl4wB2DzXA5CS2v4qcNoFBKil2qNDC
         +Hf118u88fz8KtgtfCocCisg2PCxlwbk3CvpDTuqaf+lcEiD1p3cKywvEbJ7lczcVHTi
         3xWv+IeVYmayTaKDNOm9l+MjGNrjw0yiHoLHRZ7V/KPX8BY4j6pXjns5O8ijfO4yELYv
         bpUXvHz6aubzeBcPxsPQUJ1AyDA4dC0e1TroInoqv15ONS/Kwl2ZSZzrNUvCLpTYAdXl
         Cw/w==
X-Gm-Message-State: ACrzQf0QXaDAVhCse1IAxkHiElJaMhkanx+VbVtgF8++yPfRKLdxZWKA
        OlKFQ8i9rwoptYxTTXBrz9PgbA==
X-Google-Smtp-Source: AMsMyM5jEkrTs3ANo0m063odCcGS1HXlVESHhqDOsEjJ4IESWqAg93jD4+LUVPNSgTUxOl3ZK4kOEA==
X-Received: by 2002:a05:622a:424c:b0:3a5:5987:43c7 with SMTP id cq12-20020a05622a424c00b003a5598743c7mr1852326qtb.131.1667489177562;
        Thu, 03 Nov 2022 08:26:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id t29-20020a37ea1d000000b006af0ce13499sm908306qkj.115.2022.11.03.08.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:26:17 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:26:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v2 5/5] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y2Pdm2klQAw10apf@cmpxchg.org>
References: <202210272158.7swYwd23-lkp@intel.com>
 <20221027182736.513530-1-nphamcs@gmail.com>
 <Y2HnDi4K7lxKkptY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2HnDi4K7lxKkptY@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:42:06PM +0900, Sergey Senozhatsky wrote:
> On (22/10/27 11:27), Nhat Pham wrote:
> [..]
> > +static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
> > +{
> > +	int i, obj_idx, ret = 0;
> > +	unsigned long handle;
> > +	struct zspage *zspage;
> > +	struct page *page;
> > +	enum fullness_group fullness;
> > +
> > +	/* Lock LRU and fullness list */
> > +	spin_lock(&pool->lock);
> > +	if (!pool->ops || !pool->ops->evict || list_empty(&pool->lru) ||
> > +			retries == 0) {
> > +		spin_unlock(&pool->lock);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = 0; i < retries; i++) {
> > +		struct size_class *class;
> > +
> > +		zspage = list_last_entry(&pool->lru, struct zspage, lru);
> > +		list_del(&zspage->lru);
> > +
> > +		/* zs_free may free objects, but not the zspage and handles */
> > +		zspage->under_reclaim = true;
> > +
> > +		/* Lock backing pages into place */
> > +		lock_zspage(zspage);
> 
> Does this call into the scheduler under pool->lock spinlock?

Good catch!

We went back and checked our logs, and this didn't actually hit in our
production. We also couldn't trigger it with explicit compaction.

It's an easy fix, the page locks can be acquired after dropping the
pool lock.
