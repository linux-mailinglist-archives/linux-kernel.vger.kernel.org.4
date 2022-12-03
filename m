Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE866411AE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiLBXvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiLBXvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:51:19 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE7FA47E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 15:51:17 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3b48b139b46so63918467b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 15:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9WKOxmWkfW4LPRSnLoIzD57XAizk9zr1vImUcT3N2Q=;
        b=J+XH6uWAW3mtp9ryZERhIO5RTz7UpJXX0ISGrh6eiHEBZtQ5DccXuubGSINfjBtjYq
         D+CSK2iBIfahhsUq5Gg7iKILITGVWaYVN5DKlN4Zn2ztLLehdBMGpZ5nHCZsPebuBi59
         j+bw9yPdQu3fGW+O7V5X2UAes2SJFvvNnOyDFCI9m44m2i8C/Lnk9+MyJd1q/ZmYuzbY
         xUJnCPgjHbY+6s514YFgBky0HhyI7X0JFrJvI6fSzGCkNJvHJnKQqc+Tr9brDL2F3Spk
         nUrRfLWcMr/3iv6hWBdbH3MXUczM6er3HW/oTTwdCihni9ZRtzi/e8GAovQ85z9cg5rQ
         GF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9WKOxmWkfW4LPRSnLoIzD57XAizk9zr1vImUcT3N2Q=;
        b=2ZM/rZlHzf0VyPNBNMQGS/gF+U4sFGcYM/QTbAl81qQEzBYSEt9yX2SVYkTC7Lx8Mo
         syGHCHPIlkqWOOU8rzrEjz3TIvsXRcU0Zk5pghM9RJ1ZB7k+4aKZPJiQlMcbiSTqgpZQ
         d8Hmfho9MGBAUPlOkOmfi+8ZMmk1IWfZ34aVFTZ9cCGoEUd2IJUUowpahEdkmHrKGKOO
         Mxyy8Epxuo+JZ5QpE9YvrgQLqRQRAIYZ9j+Lnn2RcYAEo1nbbaULQ9Td9P803uhRuMPb
         doP60xXd+wRcD7FDMsr3jD0qzRwFWpLqbKQMRnp59rQtS9nUyhqbdG5Y2dytuLKq2Dbd
         mo8w==
X-Gm-Message-State: ANoB5pkOqZjemIFXYJhkLYdb0x57nwwgCEoNeanNkJkyUw3bSnpWTYEe
        9F3DwL7np4/J8ayTAQQ4R8kVVnx8JdHm93si+BQPaA==
X-Google-Smtp-Source: AA0mqf5JqO0RWjrk2CGn7HiRfFaulAHm7j02wuTI4sJc1JkY/dCQghaPTFTFYshY1va1Q1nAOmgUS5UwyeDruhxe7vw=
X-Received: by 2002:a0d:f645:0:b0:3ba:76ae:dade with SMTP id
 g66-20020a0df645000000b003ba76aedademr36378869ywf.93.1670025076845; Fri, 02
 Dec 2022 15:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20221202223533.1785418-1-almasrymina@google.com>
In-Reply-To: <20221202223533.1785418-1-almasrymina@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 2 Dec 2022 15:51:05 -0800
Message-ID: <CALvZod5teb-tLz49PWny7+cV9pUQUom7k9+G6rXOhDH1tji9Lg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
To:     Mina Almasry <almasrymina@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, Michal Hocko <mhocko@suse.com>,
        bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 2:37 PM Mina Almasry <almasrymina@google.com> wrote:
>
> The nodes= arg instructs the kernel to only scan the given nodes for
> proactive reclaim. For example use cases, consider a 2 tier memory system:
>
> nodes 0,1 -> top tier
> nodes 2,3 -> second tier
>
> $ echo "1m nodes=0" > memory.reclaim
>
> This instructs the kernel to attempt to reclaim 1m memory from node 0.
> Since node 0 is a top tier node, demotion will be attempted first. This
> is useful to direct proactive reclaim to specific nodes that are under
> pressure.
>
> $ echo "1m nodes=2,3" > memory.reclaim
>
> This instructs the kernel to attempt to reclaim 1m memory in the second tier,
> since this tier of memory has no demotion targets the memory will be
> reclaimed.
>
> $ echo "1m nodes=0,1" > memory.reclaim
>
> Instructs the kernel to reclaim memory from the top tier nodes, which can
> be desirable according to the userspace policy if there is pressure on
> the top tiers. Since these nodes have demotion targets, the kernel will
> attempt demotion first.
>
> Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> reclaim""), the proactive reclaim interface memory.reclaim does both
> reclaim and demotion. Reclaim and demotion incur different latency costs
> to the jobs in the cgroup. Demoted memory would still be addressable
> by the userspace at a higher latency, but reclaimed memory would need to
> incur a pagefault.
>
> The 'nodes' arg is useful to allow the userspace to control demotion
> and reclaim independently according to its policy: if the memory.reclaim
> is called on a node with demotion targets, it will attempt demotion first;
> if it is called on a node without demotion targets, it will only attempt
> reclaim.
>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>

Acked-by: Shakeel Butt <shakeelb@google.com>
