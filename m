Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32A726D79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjFGUmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjFGUmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:42:08 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011CB1BC2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:42:04 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39a3f2668d5so5039147b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686170524; x=1688762524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey2UbSSD6HTyAcLv0AY9dZrdKeIxvviru1wMGbVrakw=;
        b=EKIEXuK2HrV9b4GAc1FYFt4tWgHbIo7g00IploG7pvcsvEOkFUq4x2eyu2xxVDZGdp
         tEN8uS9uKtAdTnG62EARyZXGYoT1sw8c1Vn9rX0fpPBpJMokbvEjdT7IPHWLqxNvPfzB
         FYNUGFj6kVYM4KFbzc/7j5R79Fo7Xr+PL86x7R5F72hUQ/B7Q+AM9b6UdQrsJi9zwJ2h
         khIahuABzHZ1fcJzs5G90o5gx2Js6/wwKNXNlZaC9KWoJXrpejE3zLFZ5Vp4EyDTqui+
         njy60L3rayqzL3wlrYwdfBDXI1EEgou0vd5Ha0USb6Z9hzucwKz3eJTEe3aewCTbDFpK
         4ciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170524; x=1688762524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey2UbSSD6HTyAcLv0AY9dZrdKeIxvviru1wMGbVrakw=;
        b=LTxHcbgc0FRpfmtEH3YIyRcyGizBF8xaF43KjCZ81yQloEdpAoHK1b5Sooe2hH3SPx
         9P0WCI+YUe5Ck2GW4g2SXHJPKR1Z+yDbJtpMQlklvZWkwzIk81yHTQU154tHShekPp7E
         +cc6iQGNk5lumWFvwuTzxEwrMIwOMW3e1xUX79Xy/1hiSqbIixiAoJnOL72CF+2HbDBf
         pM0EAXomA28KBgZTHOkJ4t4jXegiKmf7E744puvaTEtGk+YF2qFl2Ii1sOS+1aGbmh47
         UrC3QFly1pyPyi2a8i+Gqq/Qx/w0wIMOsMPDb+0PiV9TQE84eJ5REltr+2rthID70x9K
         s4nQ==
X-Gm-Message-State: AC+VfDx12RMS4h+vySgxWpswZNXAX3yWHuWLt642TEAKnvCnhD0tCdWW
        UOil+Zpa4KqTuxJKqDPlTExEjw==
X-Google-Smtp-Source: ACHHUZ7tyBX1YABuNMr3eSV/hjYc4tx0HBZ69XRt/8jg+wqfrzncg8SUpl96we2j2nzyZBvLyC4DGw==
X-Received: by 2002:a05:6808:105:b0:399:b0ee:de1 with SMTP id b5-20020a056808010500b00399b0ee0de1mr3769072oie.49.1686170523986;
        Wed, 07 Jun 2023 13:42:03 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id d8-20020a0cdb08000000b0062621e3b511sm173635qvk.74.2023.06.07.13.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:42:02 -0700 (PDT)
Date:   Wed, 7 Jun 2023 16:42:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
        cerasuolodomenico@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
Message-ID: <20230607204202.GA340728@cmpxchg.org>
References: <20230530162153.836565-1-nphamcs@gmail.com>
 <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
 <CAKEwX=OK5qK9DTYLKZUefE0eq8KooygT-nbkgUZaYjK72SKzFQ@mail.gmail.com>
 <CAJD7tkZUc=h+h4f1a+nas8KruFBaGMuaq67jZLk+LkdbwZVqKQ@mail.gmail.com>
 <20230607120939.c1256fac4bb4e081811c02da@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607120939.c1256fac4bb4e081811c02da@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:09:39PM -0700, Andrew Morton wrote:
> It's unclear (to me) whether we should proceed with this.  Thoughts, please?
> 
> Here's what I presently have in mm-hotfixes-unstable:
> 
> 
> From: Nhat Pham <nphamcs@gmail.com>
> Subject: zswap: do not shrink if cgroup may not zswap
> Date: Tue, 30 May 2023 15:24:40 -0700
> 
> Before storing a page, zswap first checks if the number of stored pages
> exceeds the limit specified by memory.zswap.max, for each cgroup in the
> hierarchy.  If this limit is reached or exceeded, then zswap shrinking is
> triggered and short-circuits the store attempt.
> 
> However, since the zswap's LRU is not memcg-aware, this can create the
> following pathological behavior: the cgroup whose zswap limit is 0 will
> evict pages from other cgroups continually, without lowering its own zswap
> usage.  This means the shrinking will continue until the need for swap
> ceases or the pool becomes empty.
> 
> As a result of this, we observe a disproportionate amount of zswap
> writeback and a perpetually small zswap pool in our experiments, even
> though the pool limit is never hit.
> 
> More generally, a cgroup might unnecessarily evict pages from other
> cgroups before we drive the memcg back below its limit.
> 
> This patch fixes the issue by rejecting zswap store attempt without
> shrinking the pool when obj_cgroup_may_zswap() returns false.
> 
> [akpm@linux-foundation.org: fix return of unintialized value]
> [akpm@linux-foundation.org: s/ENOSPC/ENOMEM/]
> Link: https://lkml.kernel.org/r/20230530222440.2777700-1-nphamcs@gmail.com
> Link: https://lkml.kernel.org/r/20230530232435.3097106-1-nphamcs@gmail.com
> Fixes: f4840ccfca25 ("zswap: memcg accounting")
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Cc: Dan Streetman <ddstreet@ieee.org>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Seth Jennings <sjenning@redhat.com>
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
