Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84246D66D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbjDDPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjDDPJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:09:30 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECB94C05
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:09:27 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id x8so23613376qvr.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680620966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Khpw7ou3XcOkEyyu20b7pCpZUxpOS3o1zWL8rB8cIWg=;
        b=E9HaZa+M8ODN9+y6nc9TMvZoWv3nEIIFh+FqI+q5iZAhq8VS7JMkQ0hLhz6wt77oVA
         Sq+WdbDqyjPlbJwfD2OUSgZQeboG04fvauXZxZIH/WIQxY8E6gdKJcdnE3H+wkrExBLE
         YAWFWGAMu6z7G9Cf0/oSmc7Wo6o4XBRAYbQoweEE732zv/bS89aVmY6sEhlvqDjYVGob
         1PMZBzk74rgVHntldzIxK3wUMyTxmvcK7DFlocLDK+a3NT02oEm8gm75iJ1X5LGEZYLD
         MeElj/ZJiMpZXbDV3PEKeTbdQtwCbRz/lkjROzo72Z4/k1Ds6aMF8oawb+YS+DecRvWZ
         rFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Khpw7ou3XcOkEyyu20b7pCpZUxpOS3o1zWL8rB8cIWg=;
        b=l/FgBjuTNmk096TqxaaaNbJl/DMcL7RkJEIs4c8CP60/8HgDUolxRxCZBriKnNU2su
         CdpMByzoxBWGkW9wzM0cV52ve5tjBZkJFuBPWheK+WQ/iyvr67Yk0oDImv9MggauEUJJ
         SmEWkA3qA8Lc+nBEXYeYboFu+N+EGr+qLwugkUquDUUdw7RLKPdv4rY67tktmggXByKN
         nrjVAc5Sg/IlJKwJ0Tyf/wBze9A6F8nyFZqr+Sg17VqyiJhIL7NvMZ6dAtPilJXAY0mN
         MJBDGEQYlIcCmu9i2vDGBEZWNPf0rrlJ0sgXReU3feFhplIsRlxyCFUnULg0d6p/Aaxj
         gs7w==
X-Gm-Message-State: AAQBX9eONMoq5pdNfm6uMi/uY9UQdxCquE7rcFIYUib3CKR1loyOUB8T
        NAhZbHuq7cRhkxq65+N/wbQYgg==
X-Google-Smtp-Source: AKy350bH4Eybbwzcg01VGLtl1xIuRMbkxkHCTQ/n7ebtI4XcFF2S8+1WMOtcB9uDE6vICJ+nQD+dVg==
X-Received: by 2002:a05:6214:29c2:b0:5c0:78bd:c262 with SMTP id gh2-20020a05621429c200b005c078bdc262mr4789792qvb.20.1680620966569;
        Tue, 04 Apr 2023 08:09:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ebcd])
        by smtp.gmail.com with ESMTPSA id oh4-20020a056214438400b005dd8b9345e6sm3443585qvb.126.2023.04.04.08.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:09:26 -0700 (PDT)
Date:   Tue, 4 Apr 2023 11:09:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 5/8] memcg: sleep during flushing stats in safe
 contexts
Message-ID: <20230404150924.GA11156@cmpxchg.org>
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-6-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330191801.1967435-6-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:17:58PM +0000, Yosry Ahmed wrote:
> Currently, all contexts that flush memcg stats do so with sleeping not
> allowed. Some of these contexts are perfectly safe to sleep in, such as
> reading cgroup files from userspace or the background periodic flusher.
> Flushing is an expensive operation that scales with the number of cpus
> and the number of cgroups in the system, so avoid doing it atomically
> where possible.
> 
> Refactor the code to make mem_cgroup_flush_stats() non-atomic (aka
> sleepable), and provide a separate atomic version. The atomic version is
> used in reclaim, refault, writeback, and in mem_cgroup_usage(). All
> other code paths are left to use the non-atomic version. This includes
> callbacks for userspace reads and the periodic flusher.
> 
> Since refault is the only caller of mem_cgroup_flush_stats_ratelimited(),
> change it to mem_cgroup_flush_stats_atomic_ratelimited(). Reclaim and
> refault code paths are modified to do non-atomic flushing in separate
> later patches -- so it will eventually be changed back to
> mem_cgroup_flush_stats_ratelimited().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
