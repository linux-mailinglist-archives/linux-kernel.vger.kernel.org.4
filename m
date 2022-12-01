Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6784863FA53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiLAWKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiLAWKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:10:51 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAE62B1B3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:10:50 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id t5so3005576vsh.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf84obAKN/8ruolDjM0pM28OtudVnfPduob08XaAHeM=;
        b=C5A/tE+OvI+/icvXdhe39VigA0TTbTY4PJd9mnXEXbnfkr0SrvZc1sS0BhKGJ9tFbH
         VrlF6IzPg1aqf/aWu55hvBF9KZc12XIGaiyBaaWM8tzg9pEnKuCYLKsOWIO9iIRoq6fN
         h+9U6WOdvTl4++/BjtWYxzFMTOs+g5fd6qJ/zeLOaxZ5HqfmU3EFndAxTDwLIhOvufRg
         lz9HYLOosZUavj+NWHAmwUBmjsPobyVqbSeR7xoIPkhsfX+u6FQFeFXf4lUXDXHETkX+
         aOg84lpe1797MkZHvW3Z/yK8LBKC0vRON342vgsQ0hEFEvXwFpzRCnmNE0JkU96V1fXe
         hHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rf84obAKN/8ruolDjM0pM28OtudVnfPduob08XaAHeM=;
        b=zRN0+BTUcLtiU6TQ3Ml+jC3YEDN9BOCUGT1nXglDPFF5znRvssg8HnBMTT52NS0mzs
         YGdAYFlwofcI2jCRoSCrSA0KfGHkf5vSa4KtHNSc9G8f5PbTK9yUF53nlEeKz+N+wYe1
         Owfjgl8UKhVN3mD6fBEYaPbrmyGDcXwy31Eg8MjZq24NEVMR+TicMOcd1OIiSl7cXoam
         irDt8PrfQm15vlW+P+yJln1Hw6GpjhIfCoGU7oA0y0aiJnrPGum8RCSzq1d7LWXgcJdL
         Tljxe2WXyqiIa8b24sIRUP2FT7KJMa4ppAdzsMzcylP98oANRbddFi7WnU1LMUyxnw8I
         2oGw==
X-Gm-Message-State: ANoB5pnsYs3r11BSTLprXJt/4rZBmO7qVX1URXpBpZgrZiIH+yChag8y
        XRlhXfIo76EIXoqQ8ZMBxoyBKKj7IEtJ+72IYINzMQ==
X-Google-Smtp-Source: AA0mqf7+zcrz2gPmzIkscfmr5SMSSgOcjkv+7kg2SOfHpFg5FBWFgEZt95ZGmuZG032Oshqx0NMxe3bwoGr4Onh742g=
X-Received: by 2002:a05:6102:cd1:b0:3aa:1bff:a8a5 with SMTP id
 g17-20020a0561020cd100b003aa1bffa8a5mr39103278vst.67.1669932649473; Thu, 01
 Dec 2022 14:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20221130020328.1009347-1-almasrymina@google.com> <20221201213202.ycdaymwojd5plyrk@google.com>
In-Reply-To: <20221201213202.ycdaymwojd5plyrk@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 1 Dec 2022 14:10:37 -0800
Message-ID: <CAHS8izOn3Kr8vqxHYxEoGVoCXKmysRKNsvXpJ2EumxDU6JfSDQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm: Add nodes= arg to memory.reclaim
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        gthelen@google.com, fvdl@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Dec 1, 2022 at 1:32 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Nov 29, 2022 at 06:03:27PM -0800, Mina Almasry wrote:
> [...]
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 7b8e8e43806b..23fc5b523764 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -6735,7 +6735,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
> >  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> >                                          unsigned long nr_pages,
> >                                          gfp_t gfp_mask,
> > -                                        unsigned int reclaim_options)
> > +                                        unsigned int reclaim_options,
> > +                                        nodemask_t nodemask)
>
> Can you please make this parameter a nodemask_t* and pass NULL instead
> of NODE_MASK_ALL?

Thank you very much for the review. I sure can in the next version. To
be honest I thought about that and made the parameter nodemask_t
because I thought the call sites would be more readable. I.e. this:

    try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
MEMCG_RECLAIM_MAY_SWAP,  NODE_MASK_ALL);

Would be more readable than this:

    try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
MEMCG_RECLAIM_MAY_SWAP,  NULL);

But the tradeoff is that the callers need include/linux/nodemask.h.
But yes I can fix in the next version.
