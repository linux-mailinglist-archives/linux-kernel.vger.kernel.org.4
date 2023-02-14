Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B6D6957A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjBNDzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjBNDz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:55:29 -0500
Received: from out-115.mta1.migadu.com (out-115.mta1.migadu.com [95.215.58.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFED16337
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:55:15 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676346913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJDJP0j4+xdi6GbS1edJShWLKFMsTSqxJTsdV08hDs4=;
        b=mu3+eYoDhYdn8rZZ4CmJCO1XTUQR92FiUzEDezyQFbJcxt8VsV5CYJYbOHyOGTC2hXMURR
        G5HPzwWtYnn7V1aRlWxFsj4HtiHct2hOLXjuoYmuGW2I6XrSQOpg83cG+qo6cGReFZdqrR
        yTXJZe/6cHJ0+XyNYn10ahZvdaT7Q3I=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: memcontrol: rename memcg_kmem_enabled()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230213192922.1146370-1-roman.gushchin@linux.dev>
Date:   Tue, 14 Feb 2023 11:54:35 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Transfer-Encoding: 7bit
Message-Id: <BE9C605A-2719-4738-A084-067E780A7108@linux.dev>
References: <20230213192922.1146370-1-roman.gushchin@linux.dev>
To:     Roman Gushchin <roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 14, 2023, at 03:29, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
> Currently there are two kmem-related helper functions with a confusing
> semantics: memcg_kmem_enabled() and mem_cgroup_kmem_disabled().
> 
> The problem is that an obvious expectation
> memcg_kmem_enabled() == !mem_cgroup_kmem_disabled(),
> can be false.
> 
> mem_cgroup_kmem_disabled() is similar to mem_cgroup_disabled(): it
> returns true only if CONFIG_MEMCG_KMEM is not set or the kmem
> accounting is disabled using a boot time kernel option
> "cgroup.memory=nokmem". It never changes the value dynamically.
> 
> memcg_kmem_enabled() is different: it always returns false until
> the first non-root memory cgroup will get online (assuming the kernel
> memory accounting is enabled). It's goal is to improve the performance
> on systems without the cgroupfs mounted/memory controller enabled or
> on the systems with only the root memory cgroup.
> 
> To make things more obvious and avoid potential bugs, let's rename
> memcg_kmem_enabled() to memcg_kmem_online().
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

It's more clear.

Acked-by: Muchun Song <songmuchun@bytedance.com>

BTW, I also dislike the name of mem_cgroup_kmem_disabled, it is not
harmonious with memcg_kmem_enabled since the prefix of one is "mem_cgroup",
another is "memcg". Maybe we could make them more consistent. Anyway, it
is not related to this patch.

Thanks.
