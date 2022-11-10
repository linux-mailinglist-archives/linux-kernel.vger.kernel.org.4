Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6A1624AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiKJTgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKJTgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:36:13 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE90F00A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:36:11 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p141so2063430iod.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzjw3odtvlQil/jHlpnewBAjOSpFW5cV80T6OAYFKjY=;
        b=iuaYqdwZM/0oCPWc93mIY0NicjiJhw7/rvxeaarjT1Tqf5ZHSLmKsKcf7baqlRZzGW
         48G7ydGLqDDqE6J6z5KkTZTsT6IPlVP9/NuCrbkuyC0ICfrf0mTe64olZVw4TUCHsHMz
         exlcuIbh+46O5BTFQ7fbnEIKz+5LZav8ff5cDQmxpnLZa4hPCawhSu8wtZ25bYO3uJCY
         yo/PRhoXv3c4U/NLMsEsT/3BfQJPlZcpCrHjsgK3t47W6BptStFIaAV97x3GKxq3sQF/
         ArH6DTw1RQswDn2xtHiVHAZhACBR/S7NMkmMMP+mUCvFTFHflwGVYX8uEDZ5rbAAicnY
         H9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzjw3odtvlQil/jHlpnewBAjOSpFW5cV80T6OAYFKjY=;
        b=3TnzPk4aEaeEq7fdoGyfUY8LwlUSWfmGRysCJzuOgLzMe1GBj7ZS0VqvNHMJqmAHzU
         kVr4Y8vHkVWM/Z+VzHCJpLRl0MKGJjUoGWKSMHzADndd/qRL3sFcDccR+2pUNZ+x8SjI
         Q1IGKxQLnpthOoW+uSRhMoffE/dtRumY9BJVUZT3Dnpvw9ny+2O7e0LqdyObketpSjjV
         5KfO5dKFmwF2/l71fLErAV6l5jNVSsjRRUX5tIhWPBvPucCkrTSQc4TbWAyc/8QUAZIU
         4h2nrvXwJ8Fw2eZ3j4g/WIpAz/KOoIYPn/IbTokMKujX5Bolmx4FzHugrJnxB5HfUdBU
         G3/w==
X-Gm-Message-State: ACrzQf3GKemSvLlJzV4VQcmBd+byjdmqXVjHPdjStgRmVeWZr4hM19w1
        NIoej0EnbH7bti0XAyLHTDryJ+77yB2CvXR9E8U61w==
X-Google-Smtp-Source: AMsMyM5GN5HdlamsR5UN+KbvUSB3LPRGSiwNUFNx5ocIJVw5vHYrJHTFCeeh4JJGj4nGoqQ/uCr7MisQ7VCz7xr7kYg=
X-Received: by 2002:a05:6638:1a8f:b0:375:1ad6:e860 with SMTP id
 ce15-20020a0566381a8f00b003751ad6e860mr3684660jab.191.1668108970639; Thu, 10
 Nov 2022 11:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20221110065316.67204-1-lujialin4@huawei.com> <20221110144243.GA10562@blackbody.suse.cz>
In-Reply-To: <20221110144243.GA10562@blackbody.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 10 Nov 2022 11:35:34 -0800
Message-ID: <CAJD7tkat6QAJkPJ-of0xYGbKJ1CyXeC0cMh+U9Nzmddm4pOZ9g@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol.c: drains percpu charge caches in memory.reclaim
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Lu Jialin <lujialin4@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Nov 10, 2022 at 6:42 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> Hello Jialin.
>
> On Thu, Nov 10, 2022 at 02:53:16PM +0800, Lu Jialin <lujialin4@huawei.com=
> wrote:
> > When user use memory.reclaim to reclaim memory, after drain percpu lru
> > caches, drain percpu charge caches for given memcg stock in the hope
> > of introducing more evictable pages.
>
> Do you have any data on materialization of this hope?
>
> IIUC, the stock is useful for batched accounting to page_counter but it
> doesn't represent real pages. I.e. your change may reduce the
> page_counter value but it would not release any pages. Or have I missed
> a way how it helps with the reclaim?

+1

It looks like we just overcharge the memcg if the number of allocated
pages are less than the charging batch size, so that upcoming
allocations can go through a fast accounting path and consume from the
precharged stock. I don't understand how draining this charge may help
reclaim.

OTOH, it will reduce the page counters, so if userspace is relying on
memory.current to gauge how much reclaim they want to do, it will make
it "appear" like the usage dropped. If userspace is using other
signals (refaults, PSI, etc), then we would be more-or-less tricking
it into thinking we reclaimed pages when we actually didn't. In that
case we didn't really reclaim anything, we just dropped memory.current
slightly, which wouldn't matter to the user in this case, as other
signals won't change.

The difference in perceived usage coming from draining the stock IIUC
has an upper bound of 63 * PAGE_SIZE (< 256 KB with 4KB pages), I
wonder if this is really significant anyway.

>
> Thanks,
> Michal
