Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFC3642EAA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiLER01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiLER0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:26:06 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768F41D661
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:25:55 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 189so15333969ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 09:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Edkl3+qJAeg+/U50a0cxOdfQg98c2hJcXAmKpe7H710=;
        b=FpTRKX8UJUk9Op/KK/uXUUhZ6S5JK8MyesWCc4GCpXfqngc25OS1MFr3Ri2m4P+3KF
         JEkGVmny3vAWqXRowqwU8mqo9EFHYv332iGeFtVv8YMTZF1fbfHQZbo2lLf1eKmbVFuP
         aMECVitbiW1LmseQvTaaPEKfuJpCG84qxwsarkmyocsZwr1HWjdyjf48+GRUZfsfS/+z
         gT69a/gMeHf30XPTkUrvXl/1xM+AqdpU61+dFzWOilydAtPICWAtWE1zLWiAnNAO+SMp
         tAjbNPWXWQtOD4eQCbnZM1ik3f+9RIx79QYBUorEQIjttnmjPsE9BsUbEqslchMa0utO
         pWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Edkl3+qJAeg+/U50a0cxOdfQg98c2hJcXAmKpe7H710=;
        b=xTSnyQ8A+UmQ0FyY6pMKUS/RPxJG08Axspmj4YM/+jogU2I2CiFFmoTKBL/AjIpnwx
         RRfmfS0ygYISrPVOdX5f4avTbcY9kRqjJZvCVr/7LUuW9NMJtDklYCb6vkvHB4yNuubN
         wXXszskBch4epvmg9MTg1JqsMN+kxX/YK6MB27OskkKZWml1+OTW2czCaIUBSsjjHOOT
         7k0acI76dkeTUaRNOR8BCg1gi6mXX6kESgFSyZNjKJBTQ/q2W2CTFauIUiIlF//pLxnx
         DjMoYpmP7RimpSXLFL5sqGJTeUNenpeo94Eki8aox7Ix1JWFKHXRLoGlZju2pZFoQYxj
         Mejg==
X-Gm-Message-State: ANoB5pmAZj9uY2yqb7usnOYv4xd1HhDyNg1gPrIUI62kmmKoBIlxIaJz
        pm7zaaPa4JcQtrTCNAZXiwOg0X6xj7NXkgOPnWLUOw==
X-Google-Smtp-Source: AA0mqf6DwTZNLDhsdfcEkb2wWE5R6b32ryRzEyZrdKlofhuY67qZdSlztP8r0l3+UZteuF8ZRujA9JwtimR9iLWGiIo=
X-Received: by 2002:a25:ae92:0:b0:6f9:d605:9f6a with SMTP id
 b18-20020a25ae92000000b006f9d6059f6amr27618176ybj.294.1670261154521; Mon, 05
 Dec 2022 09:25:54 -0800 (PST)
MIME-Version: 1.0
References: <PH0PR11MB562641BC03630B4B7A227FD7E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
 <CALvZod6FGQyuubJ0tAjvBHrhc7r-wFsaz7so74Yk_Fd8x3yLOQ@mail.gmail.com> <f360e681-0fa9-be4b-ea78-d7783b39048b@redhat.com>
In-Reply-To: <f360e681-0fa9-be4b-ea78-d7783b39048b@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 5 Dec 2022 09:25:43 -0800
Message-ID: <CALvZod7crPM55W8TBqU1RsB5OoPYupDyu5jcaivqTqMTC_-KrA@mail.gmail.com>
Subject: Re: [Regression] mqueue performance degradation after "The new cgroup
 slab memory controller" patchset.
To:     Waiman Long <longman@redhat.com>
Cc:     "Luther, Sven" <Sven.Luther@windriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Bonn, Jonas" <Jonas.Bonn@windriver.com>
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

On Mon, Dec 5, 2022 at 8:31 AM Waiman Long <longman@redhat.com> wrote:
>
> On 12/5/22 11:06, Shakeel Butt wrote:
> > Hi Sven,
> >
> > On Mon, Dec 5, 2022 at 6:56 AM Luther, Sven <Sven.Luther@windriver.com> wrote:
> >> #regzbot ^introduced 10befea91b61c4e2c2d1df06a2e978d182fcf792
> >>
> >> We are making heavy use of mqueues, and noticed a degradation of performance between 4.18 & 5.10 linux kernels.
> >>
> >> After a gross per-version tracing, we did kernel bisection between 5.8 and 5.9
> >> and traced the issue to a 10 patches (of which 9 where skipped as they didn't boot) between:
> >>
> >>
> >> commit 10befea91b61c4e2c2d1df06a2e978d182fcf792 (HEAD, refs/bisect/bad)
> >> Author: Roman Gushchin <guro@fb.com>
> >> Date:   Thu Aug 6 23:21:27 2020 -0700
> >>
> >>      mm: memcg/slab: use a single set of kmem_caches for all allocations
> >>
> >> and:
> >>
> >> commit 286e04b8ed7a04279ae277f0f024430246ea5eec (refs/bisect/good-286e04b8ed7a04279ae277f0f024430246ea5eec)
> >> Author: Roman Gushchin <guro@fb.com>
> >> Date:   Thu Aug 6 23:20:52 2020 -0700
> >>
> >>      mm: memcg/slab: allocate obj_cgroups for non-root slab pages
> >>
> >> All of them are part of the "The new cgroup slab memory controller" patchset:
> >>
> >>    https://lore.kernel.org/all/20200623174037.3951353-18-guro@fb.com/T/
> >>
> >> from Roman Gushchin, which moves the accounting for page level to the object level.
> >>
> >> Measurements where done using the a test programmtest, which measures mix/average/max time mqueue_send/mqueue_rcv,
> >> and average for getppid, both measured over 100 000 runs. Results are shown in the following table
> >>
> >> +----------+--------------------------+-------------------------+----------------+
> >> | kernel   |    mqueue_rcv (ns)       | mqueue_send (ns)        |    getppid     |
> >> | version  | min avg  max   variation | min avg max   variation | (ns) variation |
> >> +----------+--------------------------+-------------------------+----------------+
> >> | 4.18.45  | 351 382 17533     base   | 383 410 13178     base  | 149      base  |
> >> | 5.8-good | 380 392  7156   -2,55%   | 376 384  6225    6,77%  | 169   -11,83%  |
> >> | 5.8-bad  | 524 530  5310  -27,92%   | 512 519  8775  -21,00%  | 169   -11,83%  |
> >> | 5.10     | 520 533  4078  -28,33%   | 518 534  8108  -23,22%  | 167   -10,78%  |
> >> | 5.15     | 431 444  8440  -13,96%   | 425 437  6170   -6,18%  | 171   -12,87%  |
> >> | 6.03     | 474 614  3881  -37,79%   | 482 693   931  -40,84%  | 171   -12,87%  |
> >> +----------+--------------------------+-------------------------+-----------------
> >>
> > Is the last kernel 6.0.3? Also we know there is performance impact of
> > per-object kmem accounting. Can you try the latest i.e. 6.1-rc8? There
> > are a couple of memcg charging optimization patches merged in this
> > window.
>
> It is known that per-object kmem accounting regresses performance. I had
> submitted a number of optimization patches that got merged into v5.14.
> So the regression is reduced in the 5.15 line above. It looks like there
> are some additional regressions in the latest kernel. We will need to
> figure out what causes it.
>

In 5.18 PREEMPT_RT patches went in and 559271146efc ("mm/memcg:
optimize user context object stock access") got reverted.
