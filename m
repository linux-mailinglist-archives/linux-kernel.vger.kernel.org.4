Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3275B549E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiILGkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiILGkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:40:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5C5101EE;
        Sun, 11 Sep 2022 23:40:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 29so11210512edv.2;
        Sun, 11 Sep 2022 23:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=TLRcC5IeLSQPuJjdu28jfpJ3HTwzjIn6aZaZhEyqqb8=;
        b=RndJJ2rDg5R1zqzv716+YXL8VScLD/w+CjQXUcOaIWgngLo3cgIIg+nzNWVHsTGqPA
         K2bgU8De2y5cpU/kiV9+5S2HtZlYDffixm8WJGLagHZvZ40GiyD1VFI2YnXBAVrdj3XH
         vUApN1xtg37pA7G+gpnZJdDBK/j0AyES1k8Grx3HPNitxHqUOBMt0lbn2weuAhtNhE3I
         YcDdRTBKVXjaS+Vzr4QLMRxMGbcgWufjOxzp38VTltykThp/MtEP24Fwumn6bAL544Mi
         Awd3CgiGCl9DMeR0b9kBQaO5jHMv/KETO0rCGqcqMNBZVCQLAwbF+cSAeMKRVj+0wdG2
         uMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TLRcC5IeLSQPuJjdu28jfpJ3HTwzjIn6aZaZhEyqqb8=;
        b=0XL4MntvjLtscJ1TvsP2rFvZVqmG0HlsvbW7rSzxaA1HzT4+GSDyqXztR5rgKgr6eO
         jMK79IBm2AdDpQC7ZE92TtCkgmu49Q1+RaRpsPNWC43bsDNSdMc9um68jptqJ0wH+YV5
         iH1zeErrbz02WPx2qarVho71fJVV4DnfejOJSxetKWMa+4XbFys3OYvkNspVQlIkHV3+
         ykTbZVRfINxsSF+N9p88l00X0qKGSFm8K9+uivle8kcZirVq1irlh++n0LUP1nAZtqPB
         tbSo9GPdwl30vqhKJri9yQgY9Vp/WCfdqc0y5S3sQqrq9MHwWXimFpkkVEK+WFUtspF+
         45CQ==
X-Gm-Message-State: ACgBeo3HXpIzl9haTE4FtLr5mqJ09i7p7j6+B51sHqRXn2KtFa73ECIb
        naCpXmdxuiBUwk7g6jKqOqY42gKzDbpiNfIXQPg=
X-Google-Smtp-Source: AA6agR46znubc9yp+36nQs2wR6T52X6DSisQgkemoU+rz2iwtTL+xVC8jLbZylVgvB7hkbZSl+Ha8yRc8OoqRF5ToGI=
X-Received: by 2002:a05:6402:1d55:b0:451:756e:439d with SMTP id
 dz21-20020a0564021d5500b00451756e439dmr5670556edb.226.1662964799232; Sun, 11
 Sep 2022 23:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220909030756.3916297-1-zhangshida@kylinos.cn> <20220911231251.GA3600936@dread.disaster.area>
In-Reply-To: <20220911231251.GA3600936@dread.disaster.area>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Mon, 12 Sep 2022 14:39:23 +0800
Message-ID: <CANubcdWe9thzi0WXHBg+vccP7UaGv1c8FiGQkORV6PGw_4cOwQ@mail.gmail.com>
Subject: Re: [PATCH] xfs: remove the redundant check in xfs_bmap_first_unused
To:     Dave Chinner <david@fromorbit.com>
Cc:     djwong@kernel.org, dchinner@redhat.com, chandan.babu@oracle.com,
        zhangshida@kylinos.cn, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
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

Dave Chinner <david@fromorbit.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=B8=80 07:12=E5=86=99=E9=81=93=EF=BC=9A
> Given that all the types and comparisons involved are 64 bit
> unsigned:
>
> typedef uint64_t        xfs_fileoff_t;  /* block number in a file */
>
> #define XFS_FILEOFF_MAX(a,b) max_t(xfs_fileoff_t, (a), (b))
>
>         xfs_fileoff_t br_startoff;
>
>         xfs_fileoff_t           lastaddr =3D 0;
>         xfs_fileoff_t           lowest, max;
>
> We end up with the following calculations (in FSBs, not bytes):
>
>         lowest + len    =3D 0x800000ULL + 1
>                         =3D 0x800001ULL
>
>         got.br_startoff - max   =3D 0ULL - 0x800000
>                                 =3D 0xffffffffff800000ULL
>
> and so the existing check is:
>
>         if (0 >=3D 0x800001ULL && 0xffffffffff800000 >=3D 1)
>
> which evaluates as false because the extent that was found is not
> beyond the initial offset (first_unused) that we need to start
> searching at.
>
> With your modification, this would now evaluate as:
>
>         if (0xffffffffff800000 >=3D 1)
>
> Because of the underflow, this would then evaluate as true  and we'd
> return 0 as the first unused offset. This is incorrect as we do not
> have a hole at offset 0, nor is it within the correct directory
> offset segment, nor is it within the search bounds we have
> specified.
>
> If these were all signed types, then your proposed code might be
> correct. But they are unsigned and hence we have to ensure that we
> handle overflow/underflow appropriately.
>
> Which leads me to ask: did you test this change before you send
> it to the list?
>

I am so sorry about the mistake, and thanks for your elaboration about
this problem. it indeed teaches me a lesson about the necessity of test
even for the simplest change.

By the way, theoretically, in order to solve this, I wonder if we could
change the code in the following way:
=3D=3D=3D=3D
xfs_bmap_first_unused(
                /*
                 * See if the hole before this extent will work.
                 */
-               if (got.br_startoff >=3D lowest + len &&
-                   got.br_startoff - max >=3D len)
+               if (got.br_startoff >=3D max + len)
                        break;
=3D=3D=3D=3D

Thanks,

Stephen.
