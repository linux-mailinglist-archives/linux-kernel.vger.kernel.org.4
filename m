Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5004970D99F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjEWJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbjEWJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:54:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B1129
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:54:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae3f6e5d70so65295765ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684835661; x=1687427661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhCkMkjn9VMpJcOKlJHl3OXu9zjlWEVVFontZ/bb8KQ=;
        b=akE++w3zqrtnAR5tMBTtEAWvh9lJ97qKebndyx7Rm38WPYp+hcaSqH00ON0mxKZCMr
         2mW/7sErwYYuyBGQ4TOHPkGSRTIU11JThNY1XAaZmAJcRcWiK5HMR9i1hdeVBKNP4xT5
         +Mn/mBLNqDirTGAYlC82Vg2cbrUmIYH2oHOonfHMvjgFw4Vmp8TGFBC8UGZgRfNZko3z
         SdUpLklWmjmGl4zJbNmFjS5mjIq8Rb5Ua9l/ooNVb53gT1mgmEP9PFUO9mW+UAtbcdf6
         hvwDsMiSOb0JIcw/mQtNp1yk9urAYIRfb4AD17+2mHjYhObd1XrgLoohVeSg6n8FGW/G
         HH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835661; x=1687427661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhCkMkjn9VMpJcOKlJHl3OXu9zjlWEVVFontZ/bb8KQ=;
        b=D2TeRwquO1OJPP6phs4x6Y+k50bzKUpifT+ct0m4GJQsLi1kXCXZol17OQXLPLTHUU
         2/E/P/PIdwjUE9vGR+pB1TzkYxOHGx2ZHwR8sxu6h2rzZfWhp1pMX1iyAp9E7TsPr7Nl
         nPT+9Kr9+JE+t6mi91DSzSy2v1/C7NYr/UrZ2FqPN9IY6QPUeknWYwA1gF4OWywY3+0w
         T2BlXuMx/sNZoLnjO8f40HuFQjX/vS7k07AX+APT9pfL/305qjrT0oYdrfRWQMv95yNq
         haU5P4xEKJ4z+Ejijh5UBtzH9GKygf5BWfCJQBu242GFbrPbTgHiv3YeXWj2fvIS6Ip6
         /hRg==
X-Gm-Message-State: AC+VfDxtH3chZFPzjDD5tSDGPL4XMl7LBUrXAliaAgeajiPsSR+WtzP3
        gdzRy50GFTL1JPDoy9lNFvgx3X485FTcIdxNCVU=
X-Google-Smtp-Source: ACHHUZ4KH+M35u437cIeDgpMXry4UOnML2mFX7Y9nelHoR1zbyX0pkPscNLV6p1NTYEOa9XVz1V8aFt1pLujnsNDU3M=
X-Received: by 2002:a17:902:e9d4:b0:1ac:b0c5:77e5 with SMTP id
 20-20020a170902e9d400b001acb0c577e5mr12979545plk.68.1684835661414; Tue, 23
 May 2023 02:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org> <20230519001709.2563-4-tj@kernel.org>
In-Reply-To: <20230519001709.2563-4-tj@kernel.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 23 May 2023 17:54:10 +0800
Message-ID: <CAJhGHyCdgfNY83ddpQRpsCVvPQF9HtuNXXFFbpJuxYLL+mYcZQ@mail.gmail.com>
Subject: Re: [PATCH 03/24] workqueue: Not all work insertion needs to wake up
 a worker
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com
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

On Fri, May 19, 2023 at 8:17=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> +       pool =3D pwq->pool;
> +
>         /*
>          * If @work was previously on a different pool, it might still be
>          * running there, in which case the work needs to be queued on th=
at
>          * pool to guarantee non-reentrancy.
>          */
>         last_pool =3D get_work_pool(work);
> -       if (last_pool && last_pool !=3D pwq->pool) {
> +       if (last_pool && last_pool !=3D pool) {
>                 struct worker *worker;
>
>                 raw_spin_lock(&last_pool->lock);
> @@ -1638,13 +1636,14 @@ static void __queue_work(int cpu, struct workqueu=
e_struct *wq,
>
>                 if (worker && worker->current_pwq->wq =3D=3D wq) {
>                         pwq =3D worker->current_pwq;
> +                       pool =3D pwq->pool;

The code above does a "raw_spin_lock(&last_pool->lock);", and
the code next does a "raw_spin_unlock(&pool->lock);".

                            WARN_ON_ONCE(pool !=3D last_pool);

can be added here and served as a comment.

>                 } else {
>                         /* meh... not running there, queue here */
>                         raw_spin_unlock(&last_pool->lock);
> -                       raw_spin_lock(&pwq->pool->lock);
> +                       raw_spin_lock(&pool->lock);
>                 }
>         } else {
> -               raw_spin_lock(&pwq->pool->lock);
> +               raw_spin_lock(&pool->lock);
>         }
>
