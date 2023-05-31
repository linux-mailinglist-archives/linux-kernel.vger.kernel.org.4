Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1CF718472
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjEaOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbjEaOOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:14:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A37B19BC
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:11:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso61772565e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685542234; x=1688134234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5rCFTJGWdcgITCagf0CQsma1inb7ImDXUHOuHQ7JIc=;
        b=j94+zIoZ3KRYPPrHHHAUKLiwb5mV/UHm+29bpvart7YsvPd+UTbkA5n56ly+Szc0P9
         0WFsT8iA6iENd7N/VlCsmyujT4p/Ld9+/cPfJQGrxfo8WBtjbolaS3oHnZ0rwA7806yC
         KTlKdXOlxxqSFSeVWtPUUhsPxW62/ryB8TRpiXMsffZbYecQ5h3+eDNJaAR0q7kZwYBQ
         roviRPdsT4hvqjzpsuKn1MTKsGws+dETl6FvJ07Utom0FDb07N3LapqPDX87TqaYuQHg
         eO5UePzfZEO3z2aja5sXz8uRx5pXcM6sn9oK4ONk7dZkdK27h5N2A0C8GmgeORSUQpSu
         FBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542234; x=1688134234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5rCFTJGWdcgITCagf0CQsma1inb7ImDXUHOuHQ7JIc=;
        b=hY2JPPSb3KNkMROJ4dbtnk7bZwVIw3vOjrFLQW2+QwHTw0RrCpJbTaU1sOc0L34C7p
         Fkyi99YpyjJQjkPCAJTwVNtoI6/MUn70tlkDTcIU1nesyKMb+rY3jkPIGBBC90DxpPDQ
         WJJgKnWHG2KJHy+lp7TbMMYhju/X2f3BhG/ILy4vN2k8q8ATVNgBmPMFvwFMbA/tyjva
         OT6yzuILiBuutzJKc5GANCoKgAG+HimdNrrqlOWkqfkglWvQpivpBFtPhH9W4Zd/J1ao
         aRC6whNgEVUZ1L6Rwsq2JXU+6VnDEmd4mjMYtykXsmwQNt/qkQ/7z+T9T+Ot1qJYs6pJ
         9Lvg==
X-Gm-Message-State: AC+VfDzncQDCv6qsB54Wczyfxen3b4WNEgoIs/z8hpe7gYcAI43doyFs
        OyQJkVWGJq/r5mirV5sf8JCtXdO0kVOWToZFy8k1ocQt8jW/ZA==
X-Google-Smtp-Source: ACHHUZ7AOHP9g2Megr5QVPTq3LJeayM4t3rVmsZgJHwHD+Q/YbNiDgK6CvMQPQgHJCiZfTLZ8kV3EGXsMp9XQ44DsAQ=
X-Received: by 2002:a17:907:a426:b0:96f:c988:93b with SMTP id
 sg38-20020a170907a42600b0096fc988093bmr5344896ejc.35.1685541243317; Wed, 31
 May 2023 06:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230531125918.55609-1-frank.li@vivo.com>
In-Reply-To: <20230531125918.55609-1-frank.li@vivo.com>
From:   Juhyung Park <qkrwngud825@gmail.com>
Date:   Wed, 31 May 2023 22:53:52 +0900
Message-ID: <CAD14+f1YoiSVvq2M1v8u5bUdCNN_0nurY4ued6ZFu1gaBSHxDw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: flag as supporting buffered async reads
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Lu Hongfei <luhongfei@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

I remember hearing that f2fs can perform relatively poorly under io_uring,
nice find.

I suggest rewriting the commit message though. From the looks of it, it
might suggest that FMODE_BUF_RASYNC is a magic flag that automatically
improves performance that can be enabled willy nilly.

How about something like:

f2fs uses generic_file_buffered_read(), which supports buffered async
reads since commit 1a0a7853b901 ("mm: support async buffered reads in
generic_file_buffered_read()").

Match other file-systems and enable it. The read performance has been
greatly improved under io_uring:

    167M/s -> 234M/s, Increase ratio by 40%

Test w/:
    ./fio --name=3Donessd --filename=3D/data/test/local/io_uring_test
    --size=3D256M --rw=3Drandread --bs=3D4k --direct=3D0 --overwrite=3D0
    --numjobs=3D1 --iodepth=3D1 --time_based=3D0 --runtime=3D10
    --ioengine=3Dio_uring --registerfiles --fixedbufs
    --gtod_reduce=3D1 --group_reporting --sqthread_poll=3D1

On Wed, May 31, 2023 at 10:01=E2=80=AFPM Yangtao Li via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> After enabling this feature, the read performance has been greatly
> improved:
>
>     167M/s -> 234M/s, Increase ratio by 40%
>
> Test w/:
>     ./fio --name=3Donessd --filename=3D/data/test/local/io_uring_test
>     --size=3D256M --rw=3Drandread --bs=3D4k --direct=3D0 --overwrite=3D0
>     --numjobs=3D1 --iodepth=3D1 --time_based=3D0 --runtime=3D10
>     --ioengine=3Dio_uring --registerfiles --fixedbufs
>     --gtod_reduce=3D1 --group_reporting --sqthread_poll=3D1
>
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 015ed274dc31..23c68ee946e5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -546,7 +546,7 @@ static int f2fs_file_open(struct inode *inode, struct=
 file *filp)
>         if (err)
>                 return err;
>
> -       filp->f_mode |=3D FMODE_NOWAIT;
> +       filp->f_mode |=3D FMODE_NOWAIT | FMODE_BUF_RASYNC;
>
>         return dquot_file_open(inode, filp);
>  }
> --
> 2.39.0
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
