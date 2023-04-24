Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5A06D6B43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjDDSJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbjDDSJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:09:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D4F10CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:09:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so134057759edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680631779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B52t2fmF0ydFLoktH3nuFhcnoqrXavrVtQZskikW6K4=;
        b=ZUkn+vMmRDV0gsBTGXHogd0b1TEWeQRRSmXdQcA8YCbW4EuVBBVzWtXP1bseb8UKG4
         HJDAAsbeXjYwlGTq1GOQHa4KVIiS7AVj1arrMSDEu8cZLrnSvtzL29WGP876gNKX0FLM
         R8P9SFqsaEyYhbbck6gl7U+wfPr72XBPHHa+ziXeunDyh9RAQFmIOPxn/sLtUCoxKW8a
         J1BdHwp4szCI6HacbQjAk3Y454DHt3ONjUeVbcPTrpQt9VyfkRUyBrcc8jVO1AZ2tR4e
         1vv98LykBrkR7LWxMPMMrceWD1fqi3G5sA/UdA1GtjX6t0I617WwA0FZIzFiWLDPe/6/
         +B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680631779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B52t2fmF0ydFLoktH3nuFhcnoqrXavrVtQZskikW6K4=;
        b=IBfvdhlvmolacvxF3IGkrlW4boZmpCY/rehKBjnFjtucqrQMMP4qXiTj7Ho3rwlvkQ
         3GnDQKw+Vh77NwyBPpPD3wGXcAyrDaXrezon5lYuvwLrJmefbL90TEmzgMmaYWya9ujw
         +EQq7nDtPZ3iE64SGbH0UiIbRhrQRV2RWLD80bmkOKoxIoUTut//swA+atltL7JO21yD
         L5rtdwmzHI1CrceRGn7X71vdCv8/FRrKGEZtx7rTT+P3StRJsZpDwKVRhdjO7o4E+QFH
         mNL9AvLACZ2kisr84PoWcGPiJJ/CYA0qjgg7wSHh58P4/dE4wnPOl0nXO1+Z1Gm/lK3f
         SuQw==
X-Gm-Message-State: AAQBX9eijW1pzRtqbP/l/ocddc4QhlybQkAGEDafay5eolE/R5fXd1cX
        1hsXKNU7mY4uNUXoPovz8SH6h3mlZQ/sNkF7MnNJoQ==
X-Google-Smtp-Source: AKy350ZxaFc/uKVStdfwkk4WcI7qsM265x5mfy3cnNJzn3+MXngPFkg4fAUhp6xtZTUpsRfDLKUL6KUidnazS9zjh4s=
X-Received: by 2002:a17:906:af6b:b0:931:6e39:3d0b with SMTP id
 os11-20020a170906af6b00b009316e393d0bmr192993ejb.15.1680631778633; Tue, 04
 Apr 2023 11:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-7-yosryahmed@google.com> <20230404165305.ffs7uscqpndnfytn@blackpad>
In-Reply-To: <20230404165305.ffs7uscqpndnfytn@blackpad>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 4 Apr 2023 11:09:02 -0700
Message-ID: <CAJD7tkb-0rXL9V2TX-Ax-3OkwJPYx_GaOT4D=VCA60riit+dOw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] workingset: memcg: sleep when flushing stats in workingset_refault()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 9:53=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Thu, Mar 30, 2023 at 07:17:59PM +0000, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > In workingset_refault(), we call
> > mem_cgroup_flush_stats_atomic_ratelimited() to read accurate stats
> > within an RCU read section and with sleeping disallowed. Move the
> > call above the RCU read section to make it non-atomic.
> >
> > Flushing is an expensive operation that scales with the number of cpus
> > and the number of cgroups in the system, so avoid doing it atomically
> > where possible.
>
> I understand why one does not process the whole flushing load in one go
> in general.
> However, I remember there were reports of workingset_refault() being
> sensitive to latencies (hence the ratelimited call was created).
>
> Is there any consideration on impact of this here?
> (Or are there other cond_resched() precendents on this path? Should it
> be mentioned like in the vmscan (7/8) commit?)

IIUC there are multiple places where we can sleep in this path, we can
sleep waiting for a page to be read from disk, we can sleep during
allocating the page to read into, and IIUC the allocations on the
fault path can even run into reclaim, going into the vmscan code. So
there are precedents, but I am not sure if that's enough argument.

I did some light performance testing and I did not notice any
regressions (i.e concurrent processes faulting memory with a lot of
cgroups/cpus), but this change is done intentionally in a separate
patch so that it's easy to revert if regressions are reported.

>
> Thanks,
> Michal
