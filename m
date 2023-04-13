Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83316E0C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDML11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjDML1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:27:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1E09742
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:27:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id si1so6395160ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681385242; x=1683977242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzqQs+ynPLskxl47UZfCKlnD8vWrn86NbxoteoLGhFU=;
        b=JNfNJP3pF77l40f1jjSgvbWjp2I2/WFvuBnxlqMR81t79Dtpme0p9vMqE0EfTQlY+5
         UQ5/1l+482xix6SvemcrraWKa8GP6Eq9DLY2ze//BXzN6zXQ+yYtsnOSweo+AFG1OQtc
         C7hG7cdh1vUGhwwE+G1jeoRmTSjeavJatbUnKd2hrAI9Akn0/QYTYoYXhVnfkoGtMaIY
         Ox9YUu+JbLCOCTEirveoq4t/mSoxeo0MvMzFgs+MRLUBCZOCaTLKaqSpNbmiPSp3ITGu
         +7bV2a8y9RqGqHKl4mmEmAGXcma6tXW7Uf8YVPJ2TqTph4k1//8eeXUKBSKqd68ShkvY
         42BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681385242; x=1683977242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzqQs+ynPLskxl47UZfCKlnD8vWrn86NbxoteoLGhFU=;
        b=A3iGHyuVqe9fKpvyG+5Jeaz/Pok6rONf29SbsYIojLKfYtV2b3bCMpW32z7A15zgJp
         3tAokn81FIko+7nMsrLnuM5XF73JCud2szpg/jHP6OlLhTTIqIX/BtqZbdghibPrNZB4
         PTdO9yt0jNrY8bYEUriQk7RITKIn/4TqOSAAQioQYYHirVYgNxaLj0dCDDJbXIw3idtq
         jhVrTdY7GpeKD0qrcf4o9hhS6r0c2lBZ8yQLGYxO+8TowaEDnLp7RAwvmrv+wEHLjHVp
         e0VzT6cp83lEGY3HnZtGJi3K50KGSsrIG/KsdbTAh+Ci3UdT2oprETFNnSio2G65E7In
         02kA==
X-Gm-Message-State: AAQBX9ePaih0OSyv1yCE4RWgly+rTZLJ5SAiIugBo29QkHDBVDBNXfqm
        HhOWVZJWkJJmWcLFlzOTXh11zzNOoY0YpW3RXokJLw==
X-Google-Smtp-Source: AKy350ZRfFmJqhIM+zLx5wasnjk9Kpxdo4Y1Z7QE9rOwvq/eCO+8LfihDacwwj/WEG28XM3uy6urY66KF6eKt2jUGgg=
X-Received: by 2002:a17:906:2c1a:b0:94e:8e6f:4f1c with SMTP id
 e26-20020a1709062c1a00b0094e8e6f4f1cmr1088308ejh.15.1681385242447; Thu, 13
 Apr 2023 04:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230413104034.1086717-1-yosryahmed@google.com>
 <20230413104034.1086717-3-yosryahmed@google.com> <bb42720b-dec9-a62b-50a2-422ddd6a1920@redhat.com>
In-Reply-To: <bb42720b-dec9-a62b-50a2-422ddd6a1920@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 13 Apr 2023 04:26:45 -0700
Message-ID: <CAJD7tkZFnjw4sfvr1aDts0B4uWrHAQ962mgKwA3h=es3P=QWFQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] mm: vmscan: move set_task_reclaim_state() near flush_reclaim_state()
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
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

On Thu, Apr 13, 2023 at 4:19=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.04.23 12:40, Yosry Ahmed wrote:
> > Move set_task_reclaim_state() near flush_reclaim_state() so that all
> > helpers manipulating reclaim_state are in close proximity.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
>
> Hm, it's rather a simple helper to set the reclaim_state for a task, not
> to modify it.
>
> No strong opinion, but I'd just leave it as it.

It's just personal taste to have helpers acting on the same data
structure next to one another. I don't feel strongly about it either,
I left it as a separate patch so that we can simply drop it. Peter
also thought the same, so maybe I should just drop it.

>
> --
> Thanks,
>
> David / dhildenb
>
