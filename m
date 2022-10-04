Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E035F4B98
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiJDWFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJDWFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:05:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178FF1D0E1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:05:02 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id t16so16820097ljh.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JZOjir3bErEGZtdKwYJi22299Sgdh4HK9usPWaztJic=;
        b=S23DRjlyhxbAzHBeZYgt//cHEKrfwVbpyj/AV8ySrwBEcWKviUVGv3G4JJVRRxU5hS
         yHeCwjHMfSPqsk984lecY+fJ1mZaN9e+3Jb/X+RzeyVkc+Sk0Eaxgu06DKR5OcH21j2P
         CT4uoq/YoVqlCe5bwcvh1uAT+RAwe7JjfA643XBUfBKr7hmWAA85mapYRsDpG7fsuU7E
         2/HiEonP/aKp7MZtAhZmYaA0wMHpfuurevVGx1J4zgWRHhTAszuVifl9GFt7tR9A/Jij
         ADJqpl0f3vD2Vm2D+V3GzZF84FW4MaweRpo6+D7nJ1EbTN63XXCoracj/jdcJFWQ9ooU
         m/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZOjir3bErEGZtdKwYJi22299Sgdh4HK9usPWaztJic=;
        b=0QsnUpc++ucwNrYlf273ss/y8tOFNnICp4kHXiCyZt1tweQIfRFgG4MCEssry/ofes
         QPD5fr+mnT/ALi3Vw2noVtShWpHL0MWHxbSWlanY0PcANMdmBGsSU7qLqrjDgd3Sa4dg
         G3JHJvH8LM18Yk8vKP7pQtWwq4YCfLQ495I+ImrunryUVJhbdIDCg8RLjeeKK5N9avfD
         8OE0ODFpFh+8NW0hcJk/tAKr+sQKaIVk6p1p3eqsWqnD2m/DTWqoITgBUIjBOQXefrod
         96DBUbZSrlDd6Hno/bAYHSUe0xHo0MjH62mrDUecgfWZdG8i98EwlaKzm7RREC/F5oyU
         jUfQ==
X-Gm-Message-State: ACrzQf2LI+Jr0zka26bccFgHu8qpv3j6tDtynvUd70apuDU9+Md5p8a7
        Ak1KohqukC4nlmYUkYzN/M8Tkx9L9uVHhHfj/qI33g==
X-Google-Smtp-Source: AMsMyM5q0JRPqQc/cQ8WzhhOr5ZwKE43aj8qiMA6PDjlSsrwUoEm+1Uwd0nC4AF7e8ffT/5Ah6NwAK5VHFJVF7Hoa9o=
X-Received: by 2002:a05:651c:882:b0:261:81b3:16b3 with SMTP id
 d2-20020a05651c088200b0026181b316b3mr8389002ljq.142.1664921100235; Tue, 04
 Oct 2022 15:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221004214125.120993-1-peterx@redhat.com> <20221004214125.120993-2-peterx@redhat.com>
In-Reply-To: <20221004214125.120993-2-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 4 Oct 2022 15:04:23 -0700
Message-ID: <CAJHvVchRHhQDug1Zf6ygdnz96Dn4tBkPpB5fO3g2EDpxFcwP+A@mail.gmail.com>
Subject: Re: [PATCH 1/4] selftests/vm: Use memfd for hugetlb tests
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
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

On Tue, Oct 4, 2022 at 2:41 PM Peter Xu <peterx@redhat.com> wrote:
>
> We already used memfd for shmem test, move it forward with hugetlb too so
> that we don't need user to specify the hugetlb file path explicitly when
> running hugetlb shared tests.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 60 ++++++++----------------
>  1 file changed, 20 insertions(+), 40 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 74babdbc02e5..c0c6853cdce5 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -93,10 +93,8 @@ static volatile bool test_uffdio_zeropage_eexist = true;
>  static bool test_uffdio_wp = true;
>  /* Whether to test uffd minor faults */
>  static bool test_uffdio_minor = false;
> -
>  static bool map_shared;
> -static int shm_fd;
> -static int huge_fd;
> +static int mem_fd;
>  static unsigned long long *count_verify;
>  static int uffd = -1;
>  static int uffd_flags, finished, *pipefd;
> @@ -260,35 +258,21 @@ static void hugetlb_release_pages(char *rel_area)
>
>  static void hugetlb_allocate_area(void **alloc_area, bool is_src)
>  {
> +       off_t size = nr_pages * page_size;
> +       off_t offset = is_src ? 0 : size;
>         void *area_alias = NULL;
>         char **alloc_area_alias;
>
> -       if (!map_shared)
> -               *alloc_area = mmap(NULL,
> -                       nr_pages * page_size,
> -                       PROT_READ | PROT_WRITE,
> -                       MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB |
> -                               (is_src ? 0 : MAP_NORESERVE),
> -                       -1,
> -                       0);
> -       else
> -               *alloc_area = mmap(NULL,
> -                       nr_pages * page_size,
> -                       PROT_READ | PROT_WRITE,
> -                       MAP_SHARED |
> -                               (is_src ? 0 : MAP_NORESERVE),
> -                       huge_fd,
> -                       is_src ? 0 : nr_pages * page_size);
> +       *alloc_area = mmap(NULL, size, PROT_READ | PROT_WRITE,
> +                          (map_shared ? MAP_SHARED : MAP_PRIVATE) |
> +                          (is_src ? 0 : MAP_NORESERVE),
> +                          mem_fd, offset);
>         if (*alloc_area == MAP_FAILED)
>                 err("mmap of hugetlbfs file failed");
>
>         if (map_shared) {
> -               area_alias = mmap(NULL,
> -                       nr_pages * page_size,
> -                       PROT_READ | PROT_WRITE,
> -                       MAP_SHARED,
> -                       huge_fd,
> -                       is_src ? 0 : nr_pages * page_size);
> +               area_alias = mmap(NULL, size, PROT_READ | PROT_WRITE,
> +                                 MAP_SHARED, mem_fd, offset);
>                 if (area_alias == MAP_FAILED)
>                         err("mmap of hugetlb file alias failed");
>         }
> @@ -334,14 +318,14 @@ static void shmem_allocate_area(void **alloc_area, bool is_src)
>         }
>
>         *alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
> -                          shm_fd, offset);
> +                          mem_fd, offset);
>         if (*alloc_area == MAP_FAILED)
>                 err("mmap of memfd failed");
>         if (test_collapse && *alloc_area != p)
>                 err("mmap of memfd failed at %p", p);
>
>         area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
> -                         shm_fd, offset);
> +                         mem_fd, offset);
>         if (area_alias == MAP_FAILED)
>                 err("mmap of memfd alias failed");
>         if (test_collapse && area_alias != p_alias)
> @@ -1821,21 +1805,17 @@ int main(int argc, char **argv)
>         }
>         nr_pages = nr_pages_per_cpu * nr_cpus;
>
> -       if (test_type == TEST_HUGETLB && map_shared) {
> -               if (argc < 5)
> -                       usage();
> -               huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
> -               if (huge_fd < 0)
> -                       err("Open of %s failed", argv[4]);
> -               if (ftruncate(huge_fd, 0))
> -                       err("ftruncate %s to size 0 failed", argv[4]);

We should also update the examples / help text near the top of the
file, since we're changing what arguments this accepts.

It might also be better to squash the changes to test arguments in
run_vmtests.sh into each patch, so if we're bisecting we'll have a
matching / working test + run_vmtests.sh combo at each commit.

> -       } else if (test_type == TEST_SHMEM) {
> -               shm_fd = memfd_create(argv[0], 0);
> -               if (shm_fd < 0)
> +       if (test_type == TEST_SHMEM || test_type == TEST_HUGETLB) {
> +               unsigned int memfd_flags = 0;
> +
> +               if (test_type == TEST_HUGETLB)
> +                       memfd_flags = MFD_HUGETLB;
> +               mem_fd = memfd_create(argv[0], memfd_flags);
> +               if (mem_fd < 0)
>                         err("memfd_create");
> -               if (ftruncate(shm_fd, nr_pages * page_size * 2))
> +               if (ftruncate(mem_fd, nr_pages * page_size * 2))
>                         err("ftruncate");
> -               if (fallocate(shm_fd,
> +               if (fallocate(mem_fd,
>                               FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
>                               nr_pages * page_size * 2))
>                         err("fallocate");
> --
> 2.37.3
>

This is a nice simplification! Thanks for doing it. Besides the
comments above, the rest of the code here looks correct to me. Feel
free to take:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
