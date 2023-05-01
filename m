Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4596C6F2E78
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 06:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjEAEiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 00:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjEAEiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 00:38:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D0510C4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 21:38:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24b725d6898so1266537a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 21:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682915889; x=1685507889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko4tiDMCNwPwiBKs4VgPoNPtRXixXezyuAJ9a6xO9RM=;
        b=FtSp4b+ASDxukXFtW2S7EkatC+DYXYpzImjp1YBuwCY5wswC5emZTsjs9WDEFMARfB
         9nKF8Afp94nX3y3OAO+ACNRNI8nXe5j01y8jD3J/8xUsVs1glZ80zpk2amST3EHiLgbq
         evVBRoBiWSsRUNeDVZUlZmx5Pnb8zJLcQ9QJG+rmPRz2KXBqHkRUTVcYdeV3EZQkuch9
         qq0a0HZUvawATjPDroD7u3UYV8vkBj5WDOq6pq8FjrOowGnsXt9tNFsyzh1/PbcZ1IyK
         8eJoOuxFow9/OvH9KGnLIoRrjWqYz3ivaIg2p450nK7TW1cwXSBrXMUB3BmBDhDTqykp
         wjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682915889; x=1685507889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko4tiDMCNwPwiBKs4VgPoNPtRXixXezyuAJ9a6xO9RM=;
        b=mEHaGMCdZqBJ1MZBGfjSLI/piRedcFZsVvDSvrkqd2QCapatt+EKL4PDmmAbfT+x82
         xkxRcn1Vp3VOs2ehed6W2GGGIoNx0KS5GtpVkauL0GeQDUOmUr52y8OT7WUcOaBLYujL
         vIhZ2NIRI/jpquIGbTk8adAENVq9Wb5Kp2GTJp8rr1Bi3ecQPDQ72U7T0dAMkbxs6oQO
         ZxdT3g9fu/7qDkDJvIWK6nUSzVfPodrJ9qFlNSpCqxpbJH7QjbdfTzt5Vgq1+YkvX5qS
         93gx4AKPfIcolLlxNtqizaYyjFs4SbJRDeyV+5NIA4YqRebjeYpeifPSiQZmLKURcmLn
         jkqw==
X-Gm-Message-State: AC+VfDz0m1J2zoK1rW9QR/TzG58Jbtlk2HVTGgzPMnaH2sk5//Vbnjdv
        +UXTkuMVFKni46IJZM3McNykLK7NYmPsnc7zbLw=
X-Google-Smtp-Source: ACHHUZ7fTiFqIyBTzWCrrVJ/RnD57kvQQv4XZdKSVAoLuXTPYPtuLrAebWMESCqk01UIkRU2Q2Yaf8SakiebyLLicko=
X-Received: by 2002:a17:902:fa46:b0:1a6:a327:67e1 with SMTP id
 lb6-20020a170902fa4600b001a6a32767e1mr12725886plb.57.1682915889531; Sun, 30
 Apr 2023 21:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230429044506.24843-1-rdunlap@infradead.org>
In-Reply-To: <20230429044506.24843-1-rdunlap@infradead.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 1 May 2023 12:37:57 +0800
Message-ID: <CAJhGHyBjTykZ3d-D-M_1eD5J8QgNcPZcCsCMnqbBcvRoEceSuQ@mail.gmail.com>
Subject: Re: [RFC PATCH] workqueue: fix cast warnings on i386
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 12:45=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Add casts to avoid int-to-pointer-cast warings on i386 or UML for i386:
>
> ../kernel/workqueue.c: In function =E2=80=98get_work_pwq=E2=80=99:
> ../kernel/workqueue.c:713:24: warning: cast to pointer from integer of di=
fferent size [-Wint-to-pointer-cast]
>   713 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
>       |                        ^
> ../kernel/workqueue.c: In function =E2=80=98get_work_pool=E2=80=99:
> ../kernel/workqueue.c:741:25: warning: cast to pointer from integer of di=
fferent size [-Wint-to-pointer-cast]
>   741 |                 return ((struct pool_workqueue *)
>       |                         ^
> ../kernel/workqueue.c: In function =E2=80=98get_work_pool_id=E2=80=99:
> ../kernel/workqueue.c:763:25: warning: cast to pointer from integer of di=
fferent size [-Wint-to-pointer-cast]
>   763 |                 return ((struct pool_workqueue *)
>       |                         ^
>

Hello, Randy

Both the type of the "data" and WORK_STRUCT_WQ_DATA_MASK are
"unsigned long", so I don't think "(data & WORK_STRUCT_WQ_DATA_MASK)"
needs to be converted to "unsigned long".

        WORK_STRUCT_FLAG_MASK   =3D (1UL << WORK_STRUCT_FLAG_BITS) - 1,
        WORK_STRUCT_WQ_DATA_MASK =3D ~WORK_STRUCT_FLAG_MASK,

This simple fix might hide the real problem.

Thanks
Lai.

> Fixes: e120153ddf86 ("workqueue: fix how cpu number is stored in work->da=
ta")
> Fixes: 112202d9098a ("workqueue: rename cpu_workqueue to pool_workqueue")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> ---
>  kernel/workqueue.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff -- a/kernel/workqueue.c b/kernel/workqueue.c
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -710,7 +710,7 @@ static struct pool_workqueue *get_work_p
>         unsigned long data =3D atomic_long_read(&work->data);
>
>         if (data & WORK_STRUCT_PWQ)
> -               return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
> +               return (void *)(unsigned long)(data & WORK_STRUCT_WQ_DATA=
_MASK);
>         else
>                 return NULL;
>  }
> @@ -739,7 +739,7 @@ static struct worker_pool *get_work_pool
>
>         if (data & WORK_STRUCT_PWQ)
>                 return ((struct pool_workqueue *)
> -                       (data & WORK_STRUCT_WQ_DATA_MASK))->pool;
> +                       (unsigned long)(data & WORK_STRUCT_WQ_DATA_MASK))=
->pool;
>
>         pool_id =3D data >> WORK_OFFQ_POOL_SHIFT;
>         if (pool_id =3D=3D WORK_OFFQ_POOL_NONE)
> @@ -761,7 +761,7 @@ static int get_work_pool_id(struct work_
>
>         if (data & WORK_STRUCT_PWQ)
>                 return ((struct pool_workqueue *)
> -                       (data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
> +                       (unsigned long)(data & WORK_STRUCT_WQ_DATA_MASK))=
->pool->id;
>
>         return data >> WORK_OFFQ_POOL_SHIFT;
>  }
