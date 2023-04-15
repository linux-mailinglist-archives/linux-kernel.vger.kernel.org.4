Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4C6E3226
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDOPoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDOPow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 11:44:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F962D59
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 08:44:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f16ecaadd1so2150465e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681573489; x=1684165489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/T49OfIgGjP3qZEDPGcEigiLih5H2RVNsPO16/ysbGo=;
        b=MuajMTgHWznTOquxj3IAvkXyxmUsRwm8S1AfhJSixMdxGoBYZVjmqBe61bwP+nA0a1
         AqTix4zisMYCkih7qnYADZuRpf8BoZQkiUOw2FH4aFa6Ass0xQQ6LVstu+GqB+M4Gb54
         8sSAXL+5Ox8dXs1ZZOHY7UpTOQ0qGvJFoHHvR2tOjGxIK5OBkQUyb6Uyq4U9JU1pqePZ
         vkG/A7oFOtwwjsX0E+BqnoJRf+aEQROZsZwZayIgZwf0UEyClcyD/pgK7qRqONnjCOfe
         18jCmcKbh7tlUU5Hwl0PZ3td/LrkVM1vltlbQ5aEjlrTLR7PsAeSGTyDqs6WuLVPfLXA
         fz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681573489; x=1684165489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/T49OfIgGjP3qZEDPGcEigiLih5H2RVNsPO16/ysbGo=;
        b=PcDxw3pZeM2tLU9gYr6eRYLYVMC+9TJuK39tF2RYCmlfvI1sif3oC/nyxswqjb5JoE
         RLIgOvI0/1n22BeCHEdjbeblU0uEN7W6xShet+POz9blhdpRy+7YrBIJxiwwRpHgNV82
         yIZJ+rg/eNzusk5YLiljM69+YPtTSQmQz6NIB4C39KTQwk/kGvuYZwmkTGbb5+lnJkgv
         sFI8myoq65lmUb0V9yoq51T5JTK7QEwcShCO5m318pBZEcJrIj5o3iyljiM9DcoYSkBV
         9eUNvvpQcoUsqyjedoCV4QTBvlSzSG4M6+m9wt1ruD7PdA/SGxz6nPA2coZpsu6N0vqb
         w/+w==
X-Gm-Message-State: AAQBX9cs/kcudvDBWGZp+N/PBLqFcdHZkZPfNUCJOm2PuQQEUgu9PFsc
        WVomfooM/Hb7tpUrVP1wxMDcG/JUrgIUKw==
X-Google-Smtp-Source: AKy350aiUHsQtkzjVsv891Fd4t/BD9r+D/7VqB5cACKtsd2R1LOtOxYZI0007p2aCAOEnkoMiXqkMQ==
X-Received: by 2002:a5d:4604:0:b0:2f4:d01f:fd8c with SMTP id t4-20020a5d4604000000b002f4d01ffd8cmr1879251wrq.10.1681573488985;
        Sat, 15 Apr 2023 08:44:48 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d6a04000000b002f0442a2d3asm5995736wru.48.2023.04.15.08.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 08:44:48 -0700 (PDT)
Date:   Sat, 15 Apr 2023 16:44:47 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 05/31] selftests/mm: Use TEST_GEN_PROGS where proper
Message-ID: <7a053781-b56a-4366-bff9-d19971594043@lucifer.local>
References: <20230412163922.327282-1-peterx@redhat.com>
 <20230412164218.328104-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412164218.328104-1-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:42:18PM -0400, Peter Xu wrote:
> TEST_GEN_PROGS and TEST_GEN_FILES are used randomly in the mm/Makefile to
> specify programs that need to build.  Logically all these binaries should
> all fall into TEST_GEN_PROGS.
>
> Replace those TEST_GEN_FILES with TEST_GEN_PROGS, so that we can reference
> all the tests easily later.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/Makefile | 63 +++++++++++++++--------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 9d9822b4bf24..74988f5adc5f 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -31,35 +31,36 @@ MAKEFLAGS += --no-builtin-rules
>
>  CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>  LDLIBS = -lrt -lpthread
> -TEST_GEN_FILES = cow
> -TEST_GEN_FILES += compaction_test
> -TEST_GEN_FILES += gup_test
> -TEST_GEN_FILES += hmm-tests
> -TEST_GEN_FILES += hugetlb-madvise
> -TEST_GEN_FILES += hugepage-mmap
> -TEST_GEN_FILES += hugepage-mremap
> -TEST_GEN_FILES += hugepage-shm
> -TEST_GEN_FILES += hugepage-vmemmap
> -TEST_GEN_FILES += khugepaged
> +
> +TEST_GEN_PROGS = cow
> +TEST_GEN_PROGS += compaction_test
> +TEST_GEN_PROGS += gup_test
> +TEST_GEN_PROGS += hmm-tests
> +TEST_GEN_PROGS += hugetlb-madvise
> +TEST_GEN_PROGS += hugepage-mmap
> +TEST_GEN_PROGS += hugepage-mremap
> +TEST_GEN_PROGS += hugepage-shm
> +TEST_GEN_PROGS += hugepage-vmemmap
> +TEST_GEN_PROGS += khugepaged
>  TEST_GEN_PROGS = madv_populate

This now results in TEST_GEN_PROGS being set to "cow compaction_test
gup_test..." then here that is discarded and we start again from
madv_populate meaning none of the prior tests get built.

I notice this today when trying to build the gup_test :)

I think this should be a += not an = (which made sense before as there were
two different variables being assigned then).

> -TEST_GEN_FILES += map_fixed_noreplace
> -TEST_GEN_FILES += map_hugetlb
> -TEST_GEN_FILES += map_populate
> -TEST_GEN_FILES += memfd_secret
> -TEST_GEN_FILES += migration
> +TEST_GEN_PROGS += map_fixed_noreplace
> +TEST_GEN_PROGS += map_hugetlb
> +TEST_GEN_PROGS += map_populate
> +TEST_GEN_PROGS += memfd_secret
> +TEST_GEN_PROGS += migration
>  TEST_GEN_PROGS += mkdirty
> -TEST_GEN_FILES += mlock-random-test
> -TEST_GEN_FILES += mlock2-tests
> -TEST_GEN_FILES += mrelease_test
> -TEST_GEN_FILES += mremap_dontunmap
> -TEST_GEN_FILES += mremap_test
> -TEST_GEN_FILES += on-fault-limit
> -TEST_GEN_FILES += thuge-gen
> -TEST_GEN_FILES += transhuge-stress
> -TEST_GEN_FILES += userfaultfd
> +TEST_GEN_PROGS += mlock-random-test
> +TEST_GEN_PROGS += mlock2-tests
> +TEST_GEN_PROGS += mrelease_test
> +TEST_GEN_PROGS += mremap_dontunmap
> +TEST_GEN_PROGS += mremap_test
> +TEST_GEN_PROGS += on-fault-limit
> +TEST_GEN_PROGS += thuge-gen
> +TEST_GEN_PROGS += transhuge-stress
> +TEST_GEN_PROGS += userfaultfd
>  TEST_GEN_PROGS += soft-dirty
>  TEST_GEN_PROGS += split_huge_page_test
> -TEST_GEN_FILES += ksm_tests
> +TEST_GEN_PROGS += ksm_tests
>  TEST_GEN_PROGS += ksm_functional_tests
>  TEST_GEN_PROGS += mdwe_test
>
> @@ -77,24 +78,24 @@ CFLAGS += -no-pie
>  endif
>
>  ifeq ($(CAN_BUILD_I386),1)
> -TEST_GEN_FILES += $(BINARIES_32)
> +TEST_GEN_PROGS += $(BINARIES_32)
>  endif
>
>  ifeq ($(CAN_BUILD_X86_64),1)
> -TEST_GEN_FILES += $(BINARIES_64)
> +TEST_GEN_PROGS += $(BINARIES_64)
>  endif
>  else
>
>  ifneq (,$(findstring $(MACHINE),ppc64))
> -TEST_GEN_FILES += protection_keys
> +TEST_GEN_PROGS += protection_keys
>  endif
>
>  endif
>
>  ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
> -TEST_GEN_FILES += va_128TBswitch
> -TEST_GEN_FILES += virtual_address_range
> -TEST_GEN_FILES += write_to_hugetlbfs
> +TEST_GEN_PROGS += va_128TBswitch
> +TEST_GEN_PROGS += virtual_address_range
> +TEST_GEN_PROGS += write_to_hugetlbfs
>  endif
>
>  TEST_PROGS := run_vmtests.sh
> --
> 2.39.1
>
