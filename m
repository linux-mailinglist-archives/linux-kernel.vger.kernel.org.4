Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5888712466
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242732AbjEZKSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbjEZKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:18:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F9EE7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:18:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae3a5dfa42so4088475ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1685096312; x=1687688312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlqAXejfirMJTTl5iB2+w+HwiJoIEIC89FrsVWdTKhE=;
        b=McV4SpinmODlndelrGvXMBwr77mQpGgQFCx/TjpCAOYysCLo1uBms1yuLxjx/a2atW
         5s3QigePCD3UMiryzMkJPVGoGZT/icdDftgsqOTxRMCI0Pm9MjZXl1Mt+WPODPnjuTAH
         PGX0MM28eYoVY7w+DAEn9gP8Q9zXCwpGHAEh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685096312; x=1687688312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlqAXejfirMJTTl5iB2+w+HwiJoIEIC89FrsVWdTKhE=;
        b=E9lwGBhjqk2/zYplvr1ERRGT6AjjDef0FF7GuuDwATnJ0soQKKRjKBZ+zPRu7EEkgN
         eFtMUnk80vU9Hoo7ZhJH6I67eQibLZZa4JlI38rds0qqCdkT5v+SG7ICNPQlgU5oy30O
         5qhQHao6/upq3fnZhX6bYyhOlOwzLxX/FXgo6tyW/eqP/IMSHdux9IXbvxB4TfyQCQet
         X+5QuS6k6YN393XRpZBzAsEBRXiCTIwiEYNx3JhdG0urAlxkhzxTiyR6VC92zTyHffdV
         a7oSM3V0YA3IzGISVmfGl7ersJxyE3zrlZQ9rhWJB1HE1AjP4mv66ABLditj+oDLg/Da
         6GTw==
X-Gm-Message-State: AC+VfDzZQ688d3FHyYIfHugbcGO7tD67J+vEx+XMMb9pd+WOIS1IOc3U
        LHUfvM+ZE3HqzNWJ4foGBUi3Eg2pe444VzSuTpJ2XQ==
X-Google-Smtp-Source: ACHHUZ6hqAqRVb3mcOCYrOmRkmTU3PSJToOeDiWChZ+adogXMRZswpaYWn8rr61PmwxJ5R/+n16pDDyMzdVn1fTb12c=
X-Received: by 2002:a17:903:1209:b0:1b0:6c3:e851 with SMTP id
 l9-20020a170903120900b001b006c3e851mr2368882plh.18.1685096312458; Fri, 26 May
 2023 03:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
In-Reply-To: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Fri, 26 May 2023 12:18:21 +0200
Message-ID: <CAM4kBBLA_DfAENfRD3QwfTOfvcDuyrkCwKHiuiZFVkt0c4ZR2Q@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: shrink until can accept
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, yosryahmed@google.com,
        hannes@cmpxchg.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Domenico,

On Wed, May 24, 2023 at 8:50=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> This update addresses an issue with the zswap reclaim mechanism, which
> hinders the efficient offloading of cold pages to disk, thereby
> compromising the preservation of the LRU order and consequently
> diminishing, if not inverting, its performance benefits.
>
> The functioning of the zswap shrink worker was found to be inadequate,
> as shown by basic benchmark test. For the test, a kernel build was
> utilized as a reference, with its memory confined to 1G via a cgroup and
> a 5G swap file provided. The results are presented below, these are
> averages of three runs without the use of zswap:
>
> real 46m26s
> user 35m4s
> sys 7m37s
>
> With zswap (zbud) enabled and max_pool_percent set to 1 (in a 32G
> system), the results changed to:
>
> real 56m4s
> user 35m13s
> sys 8m43s
>
> written_back_pages: 18
> reject_reclaim_fail: 0
> pool_limit_hit:1478
>
> Besides the evident regression, one thing to notice from this data is
> the extremely low number of written_back_pages and pool_limit_hit.
>
> The pool_limit_hit counter, which is increased in zswap_frontswap_store
> when zswap is completely full, doesn't account for a particular
> scenario: once zswap hits his limit, zswap_pool_reached_full is set to
> true; with this flag on, zswap_frontswap_store rejects pages if zswap is
> still above the acceptance threshold. Once we include the rejections due
> to zswap_pool_reached_full && !zswap_can_accept(), the number goes from
> 1478 to a significant 21578266.
>
> Zswap is stuck in an undesirable state where it rejects pages because
> it's above the acceptance threshold, yet fails to attempt memory
> reclaimation. This happens because the shrink work is only queued when
> zswap_frontswap_store detects that it's full and the work itself only
> reclaims one page per run.
>
> This state results in hot pages getting written directly to disk,
> while cold ones remain memory, waiting only to be invalidated. The LRU
> order is completely broken and zswap ends up being just an overhead
> without providing any benefits.
>
> This commit applies 2 changes: a) the shrink worker is set to reclaim
> pages until the acceptance threshold is met and b) the task is also
> enqueued when zswap is not full but still above the threshold.
>
> Testing this suggested update showed much better numbers:
>
> real 36m37s
> user 35m8s
> sys 9m32s
>
> written_back_pages: 10459423
> reject_reclaim_fail: 12896
> pool_limit_hit: 75653
>
> Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit=
 is hit")
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zswap.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 59da2a415fbb..2ee0775d8213 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -587,9 +587,13 @@ static void shrink_worker(struct work_struct *w)
>  {
>         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
>                                                 shrink_work);
> +       int ret;
>
> -       if (zpool_shrink(pool->zpool, 1, NULL))
> -               zswap_reject_reclaim_fail++;
> +       do {
> +               ret =3D zpool_shrink(pool->zpool, 1, NULL);
> +               if (ret)
> +                       zswap_reject_reclaim_fail++;
> +       } while (!zswap_can_accept() && ret !=3D -EINVAL);
>         zswap_pool_put(pool);
>  }

while I do agree with your points, I have a concern about this
shrinker logic change. The reason for not doing this as you do was
possible real time/responsiveness characteristics degrade. Have you
checked that it's not really the case?

Thanks,
Vitaly

> @@ -1188,7 +1192,7 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>         if (zswap_pool_reached_full) {
>                if (!zswap_can_accept()) {
>                         ret =3D -ENOMEM;
> -                       goto reject;
> +                       goto shrink;
>                 } else
>                         zswap_pool_reached_full =3D false;
>         }
> --
> 2.34.1
>
