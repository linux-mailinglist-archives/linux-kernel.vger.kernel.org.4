Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF036D1082
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjC3VJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjC3VJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:09:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C06DBE6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:09:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g19so13127587lfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680210567; x=1682802567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpUMpg3yepCG5iMbuz1fYVzL8K/nnTgwA5kWuMu4nDU=;
        b=mEiFTACMN4ys+SV3RwMNP9CyDfbK3m0zNWnSjwBcoN/v4ZTuJsEtLVtuw3oBTWadrc
         QjRKtvguD0d3r9P1YOHv0ZuMr6kpwXrIX3FIRVgCNLPlzzbapzkw/dPuo45RcREI5ZrF
         g9WMdkHUXoYvjYK7zB3nlKOqH85/zlKHsPIXTLKLv7u03CuQp8+OK3oGL29kccqYfP0W
         nyHwy96WWPgQuXQokPirMUA8K7RPXM3K0jJJsShWdYiFzkkC2MOUHha1r0kY+vfmbZu7
         JW4Gq7jU6vFaaoNTPYt7lKxblvEhwbxRGUYuE7qEXExx8CGV7L4GN/tUA15QQ2pddExL
         jmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680210567; x=1682802567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpUMpg3yepCG5iMbuz1fYVzL8K/nnTgwA5kWuMu4nDU=;
        b=Zm0eyHSdwA7M1VqGgdGQcQY57rPg3UK/IDqomRfgpwHcHOXLZHYXQe+5OqVUgkkNcb
         Dl/4HesbyZA5J2EjsGSLWYT7ydMdF46ZzN/Wd9WKuijZEZzT9Cjs/rOgT+j4pDvYBUpQ
         43gJyd4XysaUj+YkBOi5vnVHQks1VYLK8D8dR2YKY1llTV+9inBAw4s7tJpOTwm7p5f4
         PrCXfT/mhPpPEhQ/waTos5xW1IrdpQgEp6Pq3q2Lrw/W9C6BY9z6+vD8LzzzRsmeefkB
         sOALC5cWgH+5IKdSqRkuJX/s/hYbKwapLBLsMGAH/yNo4iSusNZn79xLdMaiNKM+iEiV
         XJlg==
X-Gm-Message-State: AAQBX9d6EFDfe1vNHDOccmnkUvW+p5BYjZWrgAIzwgD0w1ejftgytijF
        MyZf8My+MEUuHhMaNR5BWUTNWKXCsFrOi+vy6Otx3Q==
X-Google-Smtp-Source: AKy350ZACKX7j1h2YRZJ6+UqLdfbVy5E3og835SUkvWtBS7noJ7tpLqEKkeX/8+l2gQ5UDjBcxy0WNbvrzDpZCtbu+c=
X-Received: by 2002:a05:6512:23a3:b0:4d8:86c2:75ea with SMTP id
 c35-20020a05651223a300b004d886c275eamr3409589lfv.3.1680210566612; Thu, 30 Mar
 2023 14:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230330155707.3106228-1-peterx@redhat.com> <20230330160711.3106988-1-peterx@redhat.com>
In-Reply-To: <20230330160711.3106988-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 30 Mar 2023 14:08:50 -0700
Message-ID: <CAJHvVch1uY4JUtxLcKFe=LL3FgryrdqYrrcy20WXvbt7tdLhKw@mail.gmail.com>
Subject: Re: [PATCH 09/29] selftests/mm: Reuse pagemap_get_entry() in vm_util.h
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
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

On Thu, Mar 30, 2023 at 9:07=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Meanwhile drop pagemap_read_vaddr().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

> ---
>  tools/testing/selftests/mm/userfaultfd.c | 31 +++++++-----------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/sel=
ftests/mm/userfaultfd.c
> index 7e841f7e2884..795fbc4d84f8 100644
> --- a/tools/testing/selftests/mm/userfaultfd.c
> +++ b/tools/testing/selftests/mm/userfaultfd.c
> @@ -1399,19 +1399,6 @@ static int pagemap_open(void)
>         return fd;
>  }
>
> -static uint64_t pagemap_read_vaddr(int fd, void *vaddr)
> -{
> -       uint64_t value;
> -       int ret;
> -
> -       ret =3D pread(fd, &value, sizeof(uint64_t),
> -                   ((uint64_t)vaddr >> 12) * sizeof(uint64_t));
> -       if (ret !=3D sizeof(uint64_t))
> -               err("pread() on pagemap failed");
> -
> -       return value;
> -}
> -
>  /* This macro let __LINE__ works in err() */
>  #define  pagemap_check_wp(value, wp) do {                              \
>                 if (!!(value & PM_UFFD_WP) !=3D wp)                      =
 \
> @@ -1427,7 +1414,7 @@ static int pagemap_test_fork(bool present)
>         if (!child) {
>                 /* Open the pagemap fd of the child itself */
>                 fd =3D pagemap_open();
> -               value =3D pagemap_read_vaddr(fd, area_dst);
> +               value =3D pagemap_get_entry(fd, area_dst);
>                 /*
>                  * After fork() uffd-wp bit should be gone as long as we'=
re
>                  * without UFFD_FEATURE_EVENT_FORK
> @@ -1446,24 +1433,24 @@ static void userfaultfd_wp_unpopulated_test(int p=
agemap_fd)
>
>         /* Test applying pte marker to anon unpopulated */
>         wp_range(uffd, (uint64_t)area_dst, page_size, true);
> -       value =3D pagemap_read_vaddr(pagemap_fd, area_dst);
> +       value =3D pagemap_get_entry(pagemap_fd, area_dst);
>         pagemap_check_wp(value, true);
>
>         /* Test unprotect on anon pte marker */
>         wp_range(uffd, (uint64_t)area_dst, page_size, false);
> -       value =3D pagemap_read_vaddr(pagemap_fd, area_dst);
> +       value =3D pagemap_get_entry(pagemap_fd, area_dst);
>         pagemap_check_wp(value, false);
>
>         /* Test zap on anon marker */
>         wp_range(uffd, (uint64_t)area_dst, page_size, true);
>         if (madvise(area_dst, page_size, MADV_DONTNEED))
>                 err("madvise(MADV_DONTNEED) failed");
> -       value =3D pagemap_read_vaddr(pagemap_fd, area_dst);
> +       value =3D pagemap_get_entry(pagemap_fd, area_dst);
>         pagemap_check_wp(value, false);
>
>         /* Test fault in after marker removed */
>         *area_dst =3D 1;
> -       value =3D pagemap_read_vaddr(pagemap_fd, area_dst);
> +       value =3D pagemap_get_entry(pagemap_fd, area_dst);
>         pagemap_check_wp(value, false);
>         /* Drop it to make pte none again */
>         if (madvise(area_dst, page_size, MADV_DONTNEED))
> @@ -1522,7 +1509,7 @@ static void userfaultfd_pagemap_test(unsigned int t=
est_pgsize)
>         /* Touch the page */
>         *area_dst =3D 1;
>         wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
> -       value =3D pagemap_read_vaddr(pagemap_fd, area_dst);
> +       value =3D pagemap_get_entry(pagemap_fd, area_dst);
>         pagemap_check_wp(value, true);
>         /* Make sure uffd-wp bit dropped when fork */
>         if (pagemap_test_fork(true))
> @@ -1536,7 +1523,7 @@ static void userfaultfd_pagemap_test(unsigned int t=
est_pgsize)
>                 err("madvise(MADV_PAGEOUT) failed");
>
>         /* Uffd-wp should persist even swapped out */
> -       value =3D pagemap_read_vaddr(pagemap_fd, area_dst);
> +       value =3D pagemap_get_entry(pagemap_fd, area_dst);
>         pagemap_check_wp(value, true);
>         /* Make sure uffd-wp bit dropped when fork */
>         if (pagemap_test_fork(false))
> @@ -1544,12 +1531,12 @@ static void userfaultfd_pagemap_test(unsigned int=
 test_pgsize)
>
>         /* Unprotect; this tests swap pte modifications */
>         wp_range(uffd, (uint64_t)area_dst, page_size, false);
> -       value =3D pagemap_read_vaddr(pagemap_fd, area_dst);
> +       value =3D pagemap_get_entry(pagemap_fd, area_dst);
>         pagemap_check_wp(value, false);
>
>         /* Fault in the page from disk */
>         *area_dst =3D 2;
> -       value =3D pagemap_read_vaddr(pagemap_fd, area_dst);
> +       value =3D pagemap_get_entry(pagemap_fd, area_dst);
>         pagemap_check_wp(value, false);
>
>         close(pagemap_fd);
> --
> 2.39.1
>
