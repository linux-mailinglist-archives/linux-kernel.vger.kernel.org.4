Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE03664C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjAJTJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbjAJTId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:08:33 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8079913DCF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:08:16 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-4c15c4fc8ccso166796837b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eB6zDLr3jptFznjCY+cJ6LV+lGxSv6mlgWXUb4GRVLE=;
        b=kNneCXnUbGtaezFZly8EELiFvrMI8uCxra4hUNp5F8h55KzRcraX6HTcL/eoX2slxU
         5eIut2BW8V2KxE4ECFGrtM+afRxG/KTeduZVHs5S8WSaTnrTAKUpQ9LGjuGWxJrrW+Rb
         HL3W/mk5/ZWXlu153IFY6bWd5ku/c5DQ1P/WEPBZYa8NWqLe/FC6eZ+nVcj+NfNmapAJ
         hhVfZ0STKoz+rrAswTAQZmVDSFu+39MDK4KoXl6hbj290qVSa10/hwUiXT3+ysS6+4M+
         Fn8gtLHQRlRNe7nlS5w5XbzHPW/6rq2M3KUaxPGuT+9WamrHs6La624Sedcyvl8v1GSa
         pxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eB6zDLr3jptFznjCY+cJ6LV+lGxSv6mlgWXUb4GRVLE=;
        b=0gQR4QHVmV7F1601I5wvj9/6ioEQ8Lgj9drDWfAabT2WXfzKBTOjRYsSUVZMEUWmuH
         bwUT18xZoqFRNInmNAWXGgJdSyJo9X+71bVDZXxhfxwsjSg2rotrs/LWG4R5UPy6O+AV
         xTdNZFXlsQwXuc+AEDLvMVPoxrEZmM5NtLETtSB2CgOsBe9q6CM/AXQmIaKhrkF5HkRS
         99OGrndLge0OnZ5bXWBGk5w8jzWKcjSu7cXQAZd3HGVDKuo5fjOBdQdyz9YBWPnzAbNP
         VC6FVj1KJ6m1h92d3MWOCUOMZKrLVl6hdz31cWCHlxclN+GZf7dfjrdrgWWd/mq7+VtV
         6T5w==
X-Gm-Message-State: AFqh2kqSufOzuC7CXIy4zAyecsEM5xETstySLKImI287nISkbeZ93xC5
        PqBZXZgt6a3zVjcw3PHSTyb2wYxjqQJjEHVbNabSgQ==
X-Google-Smtp-Source: AMrXdXuWt8GL2cvwM/11siCYrRBKZLbeyNUoNJAwEvUjJQicN0t0jFrxPGHJ56q+FKvR1iOeW+XS0IBv7xTbyCMXxzs=
X-Received: by 2002:a05:690c:b88:b0:3e3:866c:a51b with SMTP id
 ck8-20020a05690c0b8800b003e3866ca51bmr218703ywb.439.1673377695560; Tue, 10
 Jan 2023 11:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com> <20230109213809.418135-2-tjmercier@google.com>
 <Y70oqxejnUqkJVPx@dhcp22.suse.cz>
In-Reply-To: <Y70oqxejnUqkJVPx@dhcp22.suse.cz>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 10 Jan 2023 11:08:04 -0800
Message-ID: <CABdmKX3hBX1O8fJ2Zz0ajL=f+tROqWe-Kzr7oPjs46qBYBXV1g@mail.gmail.com>
Subject: Re: [PATCH 1/4] memcg: Track exported dma-buffers
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
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

On Tue, Jan 10, 2023 at 12:58 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 09-01-23 21:38:04, T.J. Mercier wrote:
> > When a buffer is exported to userspace, use memcg to attribute the
> > buffer to the allocating cgroup until all buffer references are
> > released.
> >
> > Unlike the dmabuf sysfs stats implementation, this memcg accounting
> > avoids contention over the kernfs_rwsem incurred when creating or
> > removing nodes.
>
> I am not familiar with dmabuf infrastructure so please bear with me.
> AFAIU this patch adds a dmabuf specific counter to find out the amount
> of dmabuf memory used. But I do not see any actual charging implemented
> for that memory.
>
> I have looked at two random users of dma_buf_export cma_heap_allocate
> and it allocates pages to back the dmabuf (AFAIU) by cma_alloc
> which doesn't account to memcg, system_heap_allocate uses
> alloc_largest_available which relies on order_flags which doesn't seem
> to ever use __GFP_ACCOUNT.
>
> This would mean that the counter doesn't represent any actual memory
> reflected in the overall memory consumption of a memcg. I believe this
> is rather unexpected and confusing behavior. While some counters
> overlap and their sum would exceed the charged memory we do not have any
> that doesn't correspond to any memory (at least not for non-root memcgs).
>
> --
> Michal Hocko
> SUSE Labs

Thank you, that behavior is not intentional. I'm not looking at the
overall memcg charge yet otherwise I would have noticed this. I think
I understand what's needed for the charging part, but Shakeel
mentioned some additional work for "reclaim, OOM and charge context
and failure cases" on the cover letter which I need to look into.
