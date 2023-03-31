Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D760B6D29A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjCaUv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjCaUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:51:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A6322236
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:51:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c18so22414020ple.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1680295880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRtzt5673pTBKCFQHX4UYCBd1m8JBF6Zbrrqfs4di9A=;
        b=sXAFDda3zkcwpKdTpeSLhqOkOCproJyUjAxYnkIZqqtYJQR0zPt3ML4D1hMXQBwS9g
         a0nmSOSxm4Bseka1sDryDTasxJXpwTjTq3427t6UMW+Eqr28vGQXGdBd8sddp3cvjpDt
         MUGDPWdU3UQ2dyd/yPEaofbIJI2VdqxJPnEKIxShKwvUqsEpGLWL2FoYOGyJ3/JVXC6t
         TMjPJjW9gs7HPq0qrBIqlXCZ9oamDENbToQItl4kQnuEQVrZin0EKEd03vQuXgbLd4bm
         xsCvzf1fGNGnnrkyiSG+DDovI5RqIqi4/QOj3voi0jP5UvS9ZDRl0JXrNnFYX09llJ6+
         wQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680295880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRtzt5673pTBKCFQHX4UYCBd1m8JBF6Zbrrqfs4di9A=;
        b=Q9dYEQqmMBF4VzSawfVWK+3CFo2LxD7zXWlen50oERagPaPcS2wz/3augN3rOJRqpw
         v+MZiwF8vvI1geQ180Z89fYQ/GvT21kxLnTRvpp4Jv4Jw80vJSdXS8VXdY/R3fLRmFNz
         2EGW3mi3ShPuncc27vD9kU/QqT3Xwbleln29N+cX+qsamm0fvvWQ1ZrEowUTnvZx3sKx
         MmAPoQxQqhgTu/1XoNgN7jOUAxq5zowxrnByaBnplMcsFUjAQh+ftzed8bHDdqSNO3nu
         pQrbtYyFfq31rFDw6BAvOBFD9X7bsi4qsHPnXewOayxp1WX3gSWP3ItVelI6Kx0ziHZg
         TRmw==
X-Gm-Message-State: AAQBX9fe4yfN1A4/YMYuYHP5WVEVNlP9K1+d1FjICNZkK4973qn/7zyb
        gwPresJvf3lNgrCI4kK/Rp9v/w==
X-Google-Smtp-Source: AKy350Zd1SJBPcPtRskYI01NIeYVd9XIyz1RMBNV6xb7+9mZreUhDv4A1BbFCs/GjenmQlsecveCdQ==
X-Received: by 2002:a17:902:db10:b0:1a1:f5dd:2dce with SMTP id m16-20020a170902db1000b001a1f5dd2dcemr31879426plx.6.1680295880383;
        Fri, 31 Mar 2023 13:51:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902b21000b0019a997bca5csm1967102plr.121.2023.03.31.13.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:51:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1piLiP-00FUn3-2r; Sat, 01 Apr 2023 07:51:17 +1100
Date:   Sat, 1 Apr 2023 07:51:17 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] mm: vmscan: refactor updating reclaimed pages in
 reclaim_state
Message-ID: <20230331205117.GI3223426@dread.disaster.area>
References: <20230331070818.2792558-1-yosryahmed@google.com>
 <20230331070818.2792558-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331070818.2792558-3-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 07:08:17AM +0000, Yosry Ahmed wrote:
> During reclaim, we keep track of pages reclaimed from other means than
> LRU-based reclaim through scan_control->reclaim_state->reclaimed_slab,
> which we stash a pointer to in current task_struct.
> 
> However, we keep track of more than just reclaimed slab pages through
> this. We also use it for clean file pages dropped through pruned inodes,
> and xfs buffer pages freed. Rename reclaimed_slab to reclaimed, and add
> a helper function that wraps updating it through current, so that future
> changes to this logic are contained within mm/vmscan.c.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
.....
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fef7d1c0f82b2..a3e38851b34ac 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -511,6 +511,34 @@ static void set_task_reclaim_state(struct task_struct *task,
>  	task->reclaim_state = rs;
>  }
>  
> +/*
> + * mm_account_reclaimed_pages(): account reclaimed pages outside of LRU-based
> + * reclaim
> + * @pages: number of pages reclaimed
> + *
> + * If the current process is undergoing a reclaim operation, increment the
> + * number of reclaimed pages by @pages.
> + */
> +void mm_account_reclaimed_pages(unsigned long pages)
> +{
> +	if (current->reclaim_state)
> +		current->reclaim_state->reclaimed += pages;
> +}
> +EXPORT_SYMBOL(mm_account_reclaimed_pages);

Shouldn't this be a static inline in a header file?

Then you don't need an EXPORT_SYMBOL() - which should really be
EXPORT_SYMBOL_GPL() - and callers don't add the overhead of a
function call for two lines of code....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
