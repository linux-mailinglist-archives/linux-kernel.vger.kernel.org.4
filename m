Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303506CC0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjC1NZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjC1NZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:25:34 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602FFBBAB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:25:25 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-545e907790fso113475367b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680009924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKr9MaZxGZc9u8ZhIE9so1jdgqHxAOgc8JTrWbL9sqY=;
        b=i9jvfdCeB9SsJnyBiAbhdPLhoxjsfRopr7eARS5rGyPO0aOs26naUPy0TOlNDXReWF
         R5Ea79kbAr+glBAXFOfEsjm49+Nm5fB3G3LIqw9DO4pIhWqBfQICEKbBtdAas72TZMRa
         2naeIrUIfdDmFPzU0ieyV8VHQOarplR5OZFhsLhdFTJ17Qsili22215RkxE3w61P7NqR
         QN1VePuwazlq07Mx1/r+u1FhPyrqxDDF2mBmsHwUrqWufwHsPj0sdlguYWltwhWjNVjP
         5VKvQ0LXJosLvebPB+Yu1xwBQd5x8bAJlaPp08d3BXWvpGTaWuuE3u78gHSrMcThnKrJ
         Ve5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKr9MaZxGZc9u8ZhIE9so1jdgqHxAOgc8JTrWbL9sqY=;
        b=m9iNkfrj+FrWEnuq3QBeoHg+FfcS1bAhbfMnbOlCRZKde2A5Jc3rrzJIWMROzyjuDw
         ul6/ARhiDcgBHGUDKrQMPiJyDEQjQJFrvsqXpVfG27tVovBt/AfoNmaQUc2bRPDldgao
         EVAEu007oy2HdZi5oT5Jwb0jKLHrV7Yv1G8jGIkf2QXWdNoQXKp7rVCQ8J2vGQjA08ac
         9KB5orVm/TzqqnEPaHIQlTr5axVWFDTmK8FHsBIitng3h8WQVhc8e7cLRM74V3W46yXB
         q5UAmZHFV+0wy256cfBcQIRCRWCS/wYtaKpKsUAsBMYmOG3zt8Im0RzxLPBmmMWWPyeE
         IsFg==
X-Gm-Message-State: AAQBX9cerCAMpOZlIvuYJZk3QPs/UvVeZVimcCL2E85rq0u1HGJIoAWT
        aOrWcsJ0LGScQ2gKhUbtnKJvqvPBf54He2dIju3kpw==
X-Google-Smtp-Source: AKy350ZqnYLSmT7eJTq65fiNra/60hMVxVRo2NTN5O7ip/pdM6ESKQ/7QeIH3HPcBu0i1k4EPDQhyQj9uL9p9e2MRY0=
X-Received: by 2002:a81:e546:0:b0:546:1ef:54f9 with SMTP id
 c6-20020a81e546000000b0054601ef54f9mr2180958ywm.0.1680009924474; Tue, 28 Mar
 2023 06:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-3-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-3-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 06:25:13 -0700
Message-ID: <CALvZod50Kh602rFii_=8q+_xdZTqHfDJyc_XNNTixGTqgcSDHA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] memcg: rename mem_cgroup_flush_stats_"delayed" to "ratelimited"
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
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

On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> mem_cgroup_flush_stats_delayed() suggests his is using a delayed_work,
> but this is actually sometimes flushing directly from the callsite.
>
> What it's doing is ratelimited calls. A better name would be
> mem_cgroup_flush_stats_ratelimited().
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
