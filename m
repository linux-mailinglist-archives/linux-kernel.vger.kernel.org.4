Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3545F4B99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiJDWFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiJDWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:05:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E42019F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:05:06 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b6so16805410ljr.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i4aLMA4TA4CUFLBRQaS0urvmpnTEansyOz9PB91rDxQ=;
        b=fvOz7nE9Sf/CQGQN+iCHQaNaUiAVy2Jwui0QCRrMq7g3Ms3toSbqY+oLHQJ/7s+BzB
         czGGifrvjdzwm3YGI3g+x58+awgwBtR9YMx8zzFiQcGB0paUSISCH03JltfgD7ri93Bl
         TI9qgHM4HLipzOCxMazfjR09DmzFu66q/7Mo9/9ZHrey8+dntRR/H2WRHTF7od2po8ql
         HQDOGCUDuIWJ5Z/WGpUtMRs45Lxe/b3eMn5hW1tSI1/kvRdFqcAt/ojhb7BAw21n+7TB
         mNK9zbbVGK+JqMi7nFikmmHJvY3T44efBBW6Oa6hsfY1UzVq4zxpx0uuB+jmMPbgfe4b
         fQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4aLMA4TA4CUFLBRQaS0urvmpnTEansyOz9PB91rDxQ=;
        b=2AGhEzuNMEtaX+5QfCtK1825BEZmVbskpY+Gjgvr2QoKSLrGOgSviRkHyy+cb1tyF5
         N8b+U6I7PA9YDjYEQxxmKeslPOg0TTz/IUd/R2ikILLxtyvv/j+CUxXlDDLotxzlt7qG
         mz9LsCri/r94sg/lHyjFjpeUTVa4sqZcoF+Dqdw1sRkrfB+MvqzODICyBMlETavJjQ71
         MOkCYqOJQj6ArH8+OAcqUNH4j3ejfAB37tJqUhVOEVJEC+dx8VRV+MM/p9qppnn0kc0D
         W3FdhRbVrPAhEa0ItN7JKoMX7CYWialaMW/3gNxVXeZGfZYv355cowrXfgTgIm0KhkoS
         rP9w==
X-Gm-Message-State: ACrzQf0yVNMNIaqRXht301n9n/Rx9wBmvoMmb795AD5zS08n7yyF8rFL
        xlOGq079lU+TE7oa8rjxie9S8odntmcwe7GntMIGVg==
X-Google-Smtp-Source: AMsMyM7d7jCfiWrDjkaNdcqhsSyr1Id9/3igeyAAckgYGEWVBIqHNHJtrjzHjy/zi7gkx/0qPizYnb7ArhemyDEsrUo=
X-Received: by 2002:a2e:8190:0:b0:26b:d94b:75e9 with SMTP id
 e16-20020a2e8190000000b0026bd94b75e9mr9429804ljg.379.1664921104881; Tue, 04
 Oct 2022 15:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221004214125.120993-1-peterx@redhat.com> <20221004214305.121405-1-peterx@redhat.com>
In-Reply-To: <20221004214305.121405-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 4 Oct 2022 15:04:28 -0700
Message-ID: <CAJHvVcijJOzo=jTNO+Oxo8AwfW8G4n+Poytw+atU4=2wVfnbqw@mail.gmail.com>
Subject: Re: [PATCH 4/4] selftests/vm: Drop mnt point for hugetlb in run_vmtests.sh
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Tue, Oct 4, 2022 at 2:43 PM Peter Xu <peterx@redhat.com> wrote:
>
> After converting all the three relevant testcases (uffd, madvise, mremap)
> to use memfd, no test will need the hugetlb mount point anymore.  Drop the
> code.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/vm/run_vmtests.sh | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index e780e76c26b8..0dc9f545a32d 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -5,7 +5,6 @@
>  # Kselftest framework requirement - SKIP code is 4.
>  ksft_skip=4
>
> -mnt=./huge
>  exitcode=0
>
>  #get huge pagesize and freepages from /proc/meminfo
> @@ -84,9 +83,6 @@ run_test() {
>         fi
>  }
>
> -mkdir "$mnt"
> -mount -t hugetlbfs none "$mnt"
> -
>  run_test ./hugepage-mmap
>
>  shmmax=$(cat /proc/sys/kernel/shmmax)
> @@ -98,14 +94,9 @@ echo "$shmmax" > /proc/sys/kernel/shmmax
>  echo "$shmall" > /proc/sys/kernel/shmall
>
>  run_test ./map_hugetlb
> -
> -run_test ./hugepage-mremap "$mnt"/huge_mremap
> -rm -f "$mnt"/huge_mremap
> -
> +run_test ./hugepage-mremap
>  run_test ./hugepage-vmemmap
> -
> -run_test ./hugetlb-madvise "$mnt"/madvise-test
> -rm -f "$mnt"/madvise-test
> +run_test ./hugetlb-madvise
>
>  echo "NOTE: The above hugetlb tests provide minimal coverage.  Use"
>  echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
> @@ -126,14 +117,11 @@ for mod in "${uffd_mods[@]}"; do
>         # Hugetlb tests require source and destination huge pages. Pass in half
>         # the size ($half_ufd_size_MB), which is used for *each*.
>         run_test ./userfaultfd hugetlb${mod} "$half_ufd_size_MB" 32
> -       run_test ./userfaultfd hugetlb_shared${mod} "$half_ufd_size_MB" 32 "$mnt"/uffd-test
> -       rm -f "$mnt"/uffd-test
> +       run_test ./userfaultfd hugetlb_shared${mod} "$half_ufd_size_MB" 32
>         run_test ./userfaultfd shmem${mod} 20 16
>  done
>
>  #cleanup
> -umount "$mnt"
> -rm -rf "$mnt"
>  echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
>
>  run_test ./compaction_test
> --
> 2.37.3
>

Feel free to take:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
