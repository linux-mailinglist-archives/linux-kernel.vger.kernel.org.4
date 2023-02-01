Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9067A354
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjAXTqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjAXTqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:46:36 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC25C28865
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:46:31 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id c5-20020aa78805000000b0058d983c708aso7258455pfo.22
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/GyNyIeeVhsFfDVzo3Uv5K6TJGpkGDF80R1/yVGfsGs=;
        b=s+S6NvStNDfxmLH+7HdkNoMxBGNFu15nS1JbU3o7kKshlx447vodpqXHX0di6WuhDZ
         a1MO4rwyUgw2LrSCtGq08zPjHV51A98+yZHCXgSTngUgV4XXVXDeDPcjG7CuFBAKTuAR
         kTHeE5yNP/OikYuovflyL/aEcJ+JOgjIm+SFfej2Z5ILJ8d5oy9l9Ll/yZqUaJp+iWXi
         DD5HNZQ0qbq4VEtW0G8okZMv8molLKQ44+tNH1Nu8KJ7B9jWjxkED24jWjgeRCFRcQ8I
         izZ99IapQOypOy9ZAzpJglu0Rf0PFoxX1xa78gNX6tsRtckWTeEuw1Q3Oze2b7gqQYar
         JRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GyNyIeeVhsFfDVzo3Uv5K6TJGpkGDF80R1/yVGfsGs=;
        b=AoBCVDZ/4qs9sed4sxAREktmvmyUMEX06m/up06RtN04HAA6DdfyhZ4ILkXjTZb6rH
         JsjNoMkIZiT+lQKZZ04qQt5IwEHFjh31xjidmKrS0jRwNhQCOaVEe0lQptGgPM/GwjfJ
         TRHw6BhIB36NnhLVLf/nz39ALvScGTtXLmHn7YBI5vlO8onbX/O6EmEXQEIfViPqIRLP
         TUDXGu6QBgBY+/51Qc7VWhhhyrHJXBbMSTTeChrSQdlC3GvlKdJBYdIU8z2UfsUxIyU9
         GU3HI00vRX4NxJNl2/bubAlKPLZ2eHQHHi2TeswjPzO5Mi9Ca2UK9LA7W/S869r3yZTt
         NFjQ==
X-Gm-Message-State: AFqh2krfJusXYOn/V01d1TOMmDruAVa9PyBjD53x24J2p7Hb/S1vKVrd
        66HaI7W/GRdxhqh+sUegel48JS/OJJfoyw==
X-Google-Smtp-Source: AMrXdXukkwsl/ioqg+fD35BqMTHaPjz5qGGy0gbqkxllMlQZ94JVGByIXE/sjuoEMUouo8MXOIoUEVSlfpldQQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a62:30c7:0:b0:58d:af10:5831 with SMTP id
 w190-20020a6230c7000000b0058daf105831mr2987930pfw.24.1674589591181; Tue, 24
 Jan 2023 11:46:31 -0800 (PST)
Date:   Tue, 24 Jan 2023 19:46:28 +0000
In-Reply-To: <Y8/ybgp2FW+e3bjc@dhcp22.suse.cz>
Mime-Version: 1.0
References: <20230123191728.2928839-1-tjmercier@google.com>
 <20230123191728.2928839-2-tjmercier@google.com> <Y8/ybgp2FW+e3bjc@dhcp22.suse.cz>
Message-ID: <20230124194628.d44rtcfsv23fndxw@google.com>
Subject: Re: [PATCH v2 1/4] memcg: Track exported dma-buffers
From:   Shakeel Butt <shakeelb@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        jeffv@google.com, cmllamas@google.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-mm@kvack.org
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

On Tue, Jan 24, 2023 at 03:59:58PM +0100, Michal Hocko wrote:
> On Mon 23-01-23 19:17:23, T.J. Mercier wrote:
> > When a buffer is exported to userspace, use memcg to attribute the
> > buffer to the allocating cgroup until all buffer references are
> > released.
> 
> Is there any reason why this memory cannot be charged during the
> allocation (__GFP_ACCOUNT used)?
> Also you do charge and account the memory but underlying pages do not
> know about their memcg (this is normally done with commit_charge for
> user mapped pages). This would become a problem if the memory is
> migrated for example.

I don't think this is movable memory.

> This also means that you have to maintain memcg
> reference outside of the memcg proper which is not really nice either.
> This mimicks tcp kmem limit implementation which I really have to say I
> am not a great fan of and this pattern shouldn't be coppied.
> 

I think we should keep the discussion on technical merits instead of
personal perference. To me using skmem like interface is totally fine
but the pros/cons need to be very explicit and the clear reasons to
select that option should be included.

To me there are two options:

1. Using skmem like interface as this patch series:

The main pros of this option is that it is very simple. Let me list down
the cons of this approach:

a. There is time window between the actual memory allocation/free and
the charge and uncharge and [un]charge happen when the whole memory is
allocated or freed. I think for the charge path that might not be a big
issue but on the uncharge, this can cause issues. The application and
the potential shrinkers have freed some of this dmabuf memory but until
the whole dmabuf is freed, the memcg uncharge will not happen. This can
consequences on reclaim and oom behavior of the application.

b. Due to the usage model i.e. a central daemon allocating the dmabuf
memory upfront, there is a requirement to have a memcg charge transfer
functionality to transfer the charge from the central daemon to the
client applications. This does introduce complexity and avenues of weird
reclaim and oom behavior.


2. Allocate and charge the memory on page fault by actual user

In this approach, the memory is not allocated upfront by the central
daemon but rather on the page fault by the client application and the
memcg charge happen at the same time.

The only cons I can think of is this approach is more involved and may
need some clever tricks to track the page on the free patch i.e. we to
decrement the dmabuf memcg stat on free path. Maybe a page flag.

The pros of this approach is there is no need have a charge transfer
functionality and the charge/uncharge being closely tied to the actual
memory allocation and free.

Personally I would prefer the second approach but I don't want to just
block this work if the dmabuf folks are ok with the cons mentioned of
the first approach.

thanks,
Shakeel
