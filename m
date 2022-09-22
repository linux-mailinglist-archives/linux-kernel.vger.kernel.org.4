Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E545E5A96
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiIVFTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIVFS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:18:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3929DB02AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:18:55 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 63so11191075ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Rw64NwZx/B8h2jFhpGLG8OI96ufQiWMUmu8+tiGiOLc=;
        b=C603rccb6hId4BzesiorvaGb5PNIyamx2XoxD8sd4G6BPwbslwM22eIC9Z5V2GveT5
         8TWyvQMuxPIavUHFp+MS9JsfijeyCUZtCKzBIUHE04wEyqWYdEITh0TkY+KQRy8ciCgN
         Oe679nA/lXPLOMlX4MHbqzV6HQ4830ksgLkTJRhXqpCkZGUCZV26RcO7VmltTCn10CNp
         GySk3IGm8ecl7PAndEcFpEejsGblL9JLSwV0qHNbCGS1hv0XFoZnHz2xRz5f0h6VKsBb
         xUZE2eUmLVBjugFf/Ln3uRPS2ebjECy9VPJhMjQ2cmMDnFLd8iJP8/h+PVR/vWZ+xOBP
         HKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Rw64NwZx/B8h2jFhpGLG8OI96ufQiWMUmu8+tiGiOLc=;
        b=mcctHxLhFBMR8oRVasnlrPeIoCuO67E3Bu53mOv+ReIwEiEc5ar9MMFL/OzthEhIMq
         9nO4rrKHWqZM+L6T+Wx1uymkAb0NEI/b6JhadexS7rtoM5mGttlWzrMEo/rww3MWv0bv
         74GNMefI5xWIu92VDTeyBw0hLpHuE0jdbw0ia9jHN6KkpgitZwZM/sZiA0pexAW3G4d6
         5Ql8mpGhoVD43WO+3ETvPJV3oru92DLlLD6gV+hcRerymlOltXNqWy23KbSYF2QDPE3j
         TD/BR5fphfo8FaJhk+Z5+q6jR2PzVRg4VnMbXBMTt7wuU4H7FFCpk6yivHpyqxvlUEDb
         xUiw==
X-Gm-Message-State: ACrzQf2XkrfPCMxVe9WXZkNhczeRoI3O0GnhnbewJmzlAXsu/UoYujMc
        KZ+/aVDw+cJkQhLsOoT8DOSI75nJHn1Ff7A2O6STCQ==
X-Google-Smtp-Source: AMsMyM4W0O7FKQabSwFaZxcGeNQBHEU6hV0wOKadzkCSBB7fZKVDoK5ObmijiK7LZEIw4gqkjULTjtn5ZziZ6CUsxxc=
X-Received: by 2002:a25:4045:0:b0:6ae:b15a:cd81 with SMTP id
 n66-20020a254045000000b006aeb15acd81mr1852113yba.340.1663823934172; Wed, 21
 Sep 2022 22:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220919072356.GA29069@haolee.io>
In-Reply-To: <20220919072356.GA29069@haolee.io>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 21 Sep 2022 22:18:42 -0700
Message-ID: <CAJuCfpF592xFTKP8x-qgRVJ0y3kxJZZk3u8MGM3cBPoPVXYxWg@mail.gmail.com>
Subject: Re: [PATCH v2] psi: fix possible missing or delayed pending event
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Sep 19, 2022 at 12:23 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
>
> When a pending event exists and growth is less than the threshold, the
> current logic is to skip this trigger without generating event. However,
> from e6df4ead85d9 ("psi: fix possible trigger missing in the window"),
> our purpose is to generate event as long as pending event exists and the
> rate meets the limit, no matter what growth is.
> This patch handles this case properly.
>
> Fixes: e6df4ead85d9 ("psi: fix possible trigger missing in the window")
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

> ---
>  kernel/sched/psi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 9711827e3..7d305d0e0 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -539,10 +539,12 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>
>                         /* Calculate growth since last update */
>                         growth = window_update(&t->win, now, total[t->state]);
> -                       if (growth < t->threshold)
> -                               continue;
> +                       if (!t->pending_event) {
> +                               if (growth < t->threshold)
> +                                       continue;
>
> -                       t->pending_event = true;
> +                               t->pending_event = true;
> +                       }
>                 }
>                 /* Limit event signaling to once per window */
>                 if (now < t->last_event_time + t->win.size)
> --
> 2.21.0
>
