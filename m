Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1126DFD70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDLSZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDLSZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:25:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAFC4200
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:25:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a23so16405186lfk.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681323940; x=1683915940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b339/5ZxfKcTpER9IRdlqYifRrMLLvI9VSJje+nkiLk=;
        b=WLgto1hbTIhihM0a0uCkefbeibc9ipz9nx2VWok2xv/UeaHS2LX3CTfpbbsE3ZgxbF
         YAF0vY8FsRbMyo7+iVgYV9dGpuuiNLn1rQJtegzBrURkI+X6Zs+mAfPNl+5kXT4HZUb7
         7CyMrYbMs722iFXJ78KRXjVIXRh65h0jaqGulCVRjLOxX3r763JC6ckQ71pigRdvRZDm
         6DN964gS2oa8YP5+qhDb+P6PpuE+JQIEoGKqcSIBq7i44KtmOGZBk97W/gMPlxwpzloj
         huM4BWymBqqgMJ9X3JKdqp332KEFGk01oGe2cUonv0bTaD1JhknroDU4Ai8uT5s5WRIO
         cdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681323940; x=1683915940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b339/5ZxfKcTpER9IRdlqYifRrMLLvI9VSJje+nkiLk=;
        b=TkHQoCloks8/t7pHZHFErW+wbqPcdyPcMC2Zb3+bsL5NzkvYHijkA770zzSIYTPER4
         yCY2XB6WnKYpNmh5LuwSuRd+3/q7HDbc2CNfWeogu+0ba8h9v3/R+yZzA7IhPxDxlN4H
         CraJA19eP37h4L1mXtF10AfXvoTdmz22iLy0PMx5zBRsjhsAvRg7LEz7jFUHPy0YCYhh
         Gqwvtk8xCgwvgY/jFwxnVWmsHC/f3KDbogYc6wVoOeoI+WuE11KkJwpFzrltFKvnYE+Q
         GW4HWYJJCbDVBWCiHwh51dIJ1MaMZAc8mPbxoee7PEd3fam91etT2KcL48gLVjqXIlqq
         sqig==
X-Gm-Message-State: AAQBX9dkpioIc4M2WviI5vad01b8T3qXJWgxWA5LqK1WJ4nqGfnfkzaH
        m75yFddM/HXv2+0+FBSKNXU0IkjQhEu+YOrZns9TeQ==
X-Google-Smtp-Source: AKy350YPKgDj3o6RlYzRteVpCyjpy6r6P/yCXCigjfjxtrlbK9ZFxeUbYAW/a2Ymo82zPWiDUMXHohSAFqwF998L3ng=
X-Received: by 2002:ac2:530f:0:b0:4ec:8c1e:c817 with SMTP id
 c15-20020ac2530f000000b004ec8c1ec817mr3029848lfh.10.1681323940044; Wed, 12
 Apr 2023 11:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230412163922.327282-1-peterx@redhat.com> <20230412164254.328335-1-peterx@redhat.com>
In-Reply-To: <20230412164254.328335-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 12 Apr 2023 11:25:03 -0700
Message-ID: <CAJHvVcjeejumGV+0yuEvJbFb7+etbekcdCocS_4i5=eeoF=BxQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/31] selftests/mm: uffd_open_{dev|sys}()
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@kernel.org>
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

On Wed, Apr 12, 2023 at 9:43=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Provide two helpers to open an uffd handle.  Drop the error checks around
> SKIPs because it's inside an errexit() anyway, which IMHO doesn't really
> help much if the test will not continue.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

> ---
>  tools/testing/selftests/mm/uffd-common.c | 28 +++++-------------------
>  tools/testing/selftests/mm/vm_util.c     | 24 ++++++++++++++++++++
>  tools/testing/selftests/mm/vm_util.h     |  2 ++
>  3 files changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/sel=
ftests/mm/uffd-common.c
> index daa5b5781e7a..09ea24c5f02c 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -192,34 +192,16 @@ void uffd_stats_report(struct uffd_stats *stats, in=
t n_cpus)
>         printf("\n");
>  }
>
> -static int __userfaultfd_open_dev(void)
> -{
> -       int fd, _uffd;
> -
> -       fd =3D open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> -       if (fd < 0)
> -               errexit(KSFT_SKIP, "opening /dev/userfaultfd failed");
> -
> -       _uffd =3D ioctl(fd, USERFAULTFD_IOC_NEW, UFFD_FLAGS);
> -       if (_uffd < 0)
> -               errexit(errno =3D=3D ENOTTY ? KSFT_SKIP : 1,
> -                       "creating userfaultfd failed");
> -       close(fd);
> -       return _uffd;
> -}
> -
>  void userfaultfd_open(uint64_t *features)
>  {
>         struct uffdio_api uffdio_api;
>
>         if (test_dev_userfaultfd)
> -               uffd =3D __userfaultfd_open_dev();
> -       else {
> -               uffd =3D syscall(__NR_userfaultfd, UFFD_FLAGS);
> -               if (uffd < 0)
> -                       errexit(errno =3D=3D ENOSYS ? KSFT_SKIP : 1,
> -                               "creating userfaultfd failed");
> -       }
> +               uffd =3D uffd_open_dev(UFFD_FLAGS);
> +       else
> +               uffd =3D uffd_open_sys(UFFD_FLAGS);
> +       if (uffd < 0)
> +               err("uffd open failed (dev=3D%d)", test_dev_userfaultfd);
>         uffd_flags =3D fcntl(uffd, F_GETFD, NULL);
>
>         uffdio_api.api =3D UFFD_API;
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftes=
ts/mm/vm_util.c
> index bb633d050d71..5ee6c4688a7c 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -3,6 +3,8 @@
>  #include <fcntl.h>
>  #include <sys/ioctl.h>
>  #include <linux/userfaultfd.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
>  #include "../kselftest.h"
>  #include "vm_util.h"
>
> @@ -230,3 +232,25 @@ int uffd_unregister(int uffd, void *addr, uint64_t l=
en)
>
>         return ret;
>  }
> +
> +int uffd_open_dev(unsigned int flags)
> +{
> +       int fd, uffd;
> +
> +       fd =3D open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> +       if (fd < 0)
> +               return fd;
> +       uffd =3D ioctl(fd, USERFAULTFD_IOC_NEW, flags);
> +       close(fd);
> +
> +       return uffd;
> +}
> +
> +int uffd_open_sys(unsigned int flags)
> +{
> +#ifdef __NR_userfaultfd
> +       return syscall(__NR_userfaultfd, flags);
> +#else
> +       return -1;
> +#endif
> +}
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftes=
ts/mm/vm_util.h
> index 3a9762022efd..481354141533 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -48,6 +48,8 @@ unsigned long default_huge_page_size(void);
>  int uffd_register(int uffd, void *addr, uint64_t len,
>                   bool miss, bool wp, bool minor);
>  int uffd_unregister(int uffd, void *addr, uint64_t len);
> +int uffd_open_dev(unsigned int flags);
> +int uffd_open_sys(unsigned int flags);
>
>  /*
>   * On ppc64 this will only work with radix 2M hugepage size
> --
> 2.39.1
>
