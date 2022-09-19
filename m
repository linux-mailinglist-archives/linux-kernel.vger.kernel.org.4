Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE26D5BD682
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiISVhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiISVhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:37:08 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61584D834
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 14:36:25 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g15-20020aa7874f000000b0053e8b9630c7so411697pfo.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 14:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=gBPDRnXdyvF4xAXr245jZgfFcKRBxlvo8nsBRpPChFM=;
        b=pBQdFlYTW5SMJZLEMS2PIeY/jXnxQHmBdVPB0G13hsQ/jjd473V1RsISyxaNwQYjyP
         yH1LP0v5pq5LDRQLhpdkRO31sgmsuTaBoWRWpfl3oJObc2DyxrjOIJQRM78202UbhSDs
         I3YXeiX+4M9mVmC/jNaFEUhrogAJuDu88LJDMqkZifaAjpi+hYvR1xpnjM+HACqJ94bB
         LajxRGIq9aCsw8DTPeTOjXxhSvXNlH3t+YvGLSTEWAQ4/W3reGAiQWXWsg7YBT9/1i1f
         x7kIHKYQ/xdvouPjm2aKVRXkjRJtsiVBtIUblxJ9idoqr+i9hG1fedynPAQfkv10QNB9
         TPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=gBPDRnXdyvF4xAXr245jZgfFcKRBxlvo8nsBRpPChFM=;
        b=DgAWPAR4eKMtuZu0SF1Zr7O35puYf12VqIfttIY9IlG8EO0vx5559O/QzvWAFW+8zI
         auIXwxDVT0ZzDV7MgwvzEes4gmfy9ZC0ndMMFtqETyr68C9i5m0D2rpu7Pkt7nt+r9tf
         a64J+GJn0ve+VdT7Aw47agl7MAU/xNft3x0+A0lPAc542H7Oo9tjWZDa4Isp2/qk0KiH
         QOqhaAcZJyNL5SlnQL0NnlWUl/75dB9jK076Akm5paTF6SRGM1+orFoiPY1kyCSusCPk
         LR6+IWr+OILk2unxscIBQ36d4GT8SLP4WVPM/z7j4m2Aq7tMKxydYeRj+ZXMx0/wR5wP
         7nVw==
X-Gm-Message-State: ACrzQf3lmudzHlWM8WJrttKdx1oHkuStmn6RDqUpq3C9ZHK6HQxvGYCG
        IjfceIvxwa7LS6j0GHyOGQsyam4QXQ6xjQ==
X-Google-Smtp-Source: AMsMyM5N8FWtYCLqNF0zfkdeNsEsbGZbL/ZlbqHTPultDwLR5KPcpZgvQuO9hx4F8/FG9yKpgr9DjPIcxlzz6A==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:254a:b0:200:53f:891d with SMTP id
 nw10-20020a17090b254a00b00200053f891dmr246179pjb.168.1663623385293; Mon, 19
 Sep 2022 14:36:25 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:36:22 +0000
In-Reply-To: <20220919180634.45958-2-ryncsn@gmail.com>
Mime-Version: 1.0
References: <20220919180634.45958-1-ryncsn@gmail.com> <20220919180634.45958-2-ryncsn@gmail.com>
Message-ID: <20220919213622.s3w2v2q7ktvbrpha@google.com>
Subject: Re: [PATCH v2 1/2] mm: memcontrol: use memcg_kmem_enabled in count_objcg_event
From:   Shakeel Butt <shakeelb@google.com>
To:     Kairui Song <kasong@tencent.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 02:06:33AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> There are currently two helpers for checking if cgroup kmem
> accounting is enabled:
> 
> - mem_cgroup_kmem_disabled
> - memcg_kmem_enabled
> 
> mem_cgroup_kmem_disabled is a simple helper that returns true
> if cgroup.memory=nokmem is specified, otherwise returns false.
> 
> memcg_kmem_enabled is a bit different, it returns true if
> cgroup.memory=nokmem is not specified and there was at least one
> non-root memory control enabled cgroup ever created. This help improve
> performance when kmem accounting was not actually activated. And it's
> optimized with static branch.
> 
> The usage of mem_cgroup_kmem_disabled is for sub-systems that need to
> preallocate data for kmem accounting since they could be initialized
> before kmem accounting is activated. But count_objcg_event doesn't
> need that, so using memcg_kmem_enabled is better here.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
