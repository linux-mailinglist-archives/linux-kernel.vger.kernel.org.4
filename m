Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EA45E85EF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiIWWfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIWWfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14C1257B0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663972548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J+2c5YW+EA7plWyqyC2+l7gyp9odW6tPIthlfYxVMK0=;
        b=Fky66IgpBEzZ0l5b5ueeqma2/xy4U7NpFdk7AyQGuhvLp2bKyRA+1uqxfvoQ78VxDqoGDr
        PGOUqDw1+hLq1Gh6S6wlCGeEofH7oZNXK/qN07WEA9hjTbr7uWEMYBrdvBh2Mm9nefxo0k
        fDLamrXNnhVVhRu1nfg6BFJe8VMrHE0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-KVFdRSwLPg2wrXPU8qJPag-1; Fri, 23 Sep 2022 18:35:47 -0400
X-MC-Unique: KVFdRSwLPg2wrXPU8qJPag-1
Received: by mail-ed1-f69.google.com with SMTP id m3-20020a056402430300b004512f6268dbso895561edc.23
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=J+2c5YW+EA7plWyqyC2+l7gyp9odW6tPIthlfYxVMK0=;
        b=E9uKNL726DzgoJn1O2AoVHrNFI0fr8ZIbKrzn1ncmHxhPBgUCInZwoJVczZbk6y2Vy
         Hj0Ktmhp2DU6yjAXkYw++/ANknTP5hss+wI57ELkl/yxQ+5ta8UoMhIWNuMYMMeb3NkM
         SR8OElaBrfiQK8FpmgK2FaXny+RJC3Up4htnSmnIsqzmWAXl2OwWrpZgN76sRTJzPAxB
         Q5fH7ES8qgAQKQv/r/6TsO8yv8ad9Z2l4ogmZkSuMucgpMgPWIu9Mn0ZMBwfK/VcWgc4
         ZAA9PKz1RwnF2FLN7TSkA7YwRJxj6FxSOFB3uvA5JKdSPfHu2EycRnOgO+t8jK1nn3m8
         LYyA==
X-Gm-Message-State: ACrzQf3NkNupv7NIZWvhcXfFHt0iuMHiUm8rKaNpKyjfUv0yNi2DMOV0
        r9livzajANjCR7N19+ALw0DxavfXfMNZqi6NBGU4Dau2NmPFvpd8RtJIY0QKEB8i7BDPXwkz9ze
        wfZ0IBKGfBotcbajOHcePKpzBxLQQa9y3vBpmSuV9
X-Received: by 2002:a05:6402:43cf:b0:450:eae1:c9d3 with SMTP id p15-20020a05640243cf00b00450eae1c9d3mr10723240edc.231.1663972546216;
        Fri, 23 Sep 2022 15:35:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM61hUVlIihf1mB+9peSUfCPpl2lY1axiVlb+Hc695DbpTg/y1XovHLdPOCHpv2yeQfoafdsaHoX9kl8fnmcvjE=
X-Received: by 2002:a05:6402:43cf:b0:450:eae1:c9d3 with SMTP id
 p15-20020a05640243cf00b00450eae1c9d3mr10723224edc.231.1663972545995; Fri, 23
 Sep 2022 15:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220420084036.4101604-1-usama.anjum@collabora.com>
 <01f64e01-580e-abca-2b86-aa586d987bf4@redhat.com> <c3df7c71-79c1-7876-e39a-15cffc444da3@collabora.com>
In-Reply-To: <c3df7c71-79c1-7876-e39a-15cffc444da3@collabora.com>
From:   Nico Pache <npache@redhat.com>
Date:   Fri, 23 Sep 2022 16:35:19 -0600
Message-ID: <CAA1CXcAMeoaSTc3Oa-ZppX9GqpDRH=cJ+aLnTgWU1-=OEcwTsw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] selftests: vm: bring common functions to a new file
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        krisman@collabora.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Joel Savitz <jsavitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 5:06 AM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 9/9/22 8:06 AM, Nico Pache wrote:
> >
> >
> > On 4/20/22 04:40, Muhammad Usama Anjum wrote:
> >> Bring common functions to a new file while keeping code as much same as
> >> possible. These functions can be used in the new tests. This helps in
> >> avoiding code duplication.
> >
> > This commit breaks a pattern in the way tests are run in the current scheme.
> > Before this commit the only executable (or TEST_PROGS) that was executed was
> > run_vmselftests.sh. Now both madv_populate and split_huge_page_test are being
> > run as well.
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >> Changes in V6:
> >> - Correct header files inclusion
> >>
> >> Changes in V5:
> >> Keep moved code as same as possible
> >> - Updated macros names
> >> - Removed macro used to show bit number of dirty bit, added a comment
> >>   instead
> >> - Corrected indentation
> >> ---
> >>  tools/testing/selftests/vm/Makefile           |   7 +-
> >>  tools/testing/selftests/vm/madv_populate.c    |  34 +-----
> >>  .../selftests/vm/split_huge_page_test.c       |  79 +------------
> >>  tools/testing/selftests/vm/vm_util.c          | 108 ++++++++++++++++++
> >>  tools/testing/selftests/vm/vm_util.h          |   9 ++
> >>  5 files changed, 124 insertions(+), 113 deletions(-)
> >>  create mode 100644 tools/testing/selftests/vm/vm_util.c
> >>  create mode 100644 tools/testing/selftests/vm/vm_util.h
> >>
> >> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> >> index 5e43f072f5b76..4e68edb26d6b6 100644
> >> --- a/tools/testing/selftests/vm/Makefile
> >> +++ b/tools/testing/selftests/vm/Makefile
> >> @@ -34,7 +34,7 @@ TEST_GEN_FILES += hugepage-mremap
> >>  TEST_GEN_FILES += hugepage-shm
> >>  TEST_GEN_FILES += hugepage-vmemmap
> >>  TEST_GEN_FILES += khugepaged
> >> -TEST_GEN_FILES += madv_populate
> >> +TEST_GEN_PROGS = madv_populate
> > madv_populate is already being run in run_vmselftests.sh
> >>  TEST_GEN_FILES += map_fixed_noreplace
> >>  TEST_GEN_FILES += map_hugetlb
> >>  TEST_GEN_FILES += map_populate
> >> @@ -47,7 +47,7 @@ TEST_GEN_FILES += on-fault-limit
> >>  TEST_GEN_FILES += thuge-gen
> >>  TEST_GEN_FILES += transhuge-stress
> >>  TEST_GEN_FILES += userfaultfd
> >> -TEST_GEN_FILES += split_huge_page_test
> >> +TEST_GEN_PROGS += split_huge_page_test
> >>  TEST_GEN_FILES += ksm_tests
> >>
> >>  ifeq ($(MACHINE),x86_64)
> >> @@ -91,6 +91,9 @@ TEST_FILES := test_vmalloc.sh
> >>  KSFT_KHDR_INSTALL := 1
> >>  include ../lib.mk
> >>
> >> +$(OUTPUT)/madv_populate: vm_util.c
> >> +$(OUTPUT)/split_huge_page_test: vm_util.c
> > Not sure what this does but if we add a run entry for split_huge_page_test in
> > run_vmselftests.sh we wont really need this patch.
> >
> > I'm not sure the reduction in code size is worth the change in run behavior.
> >
> > Unless I'm missing something I suggest we revert this patch and add a run entry
> > for split_huge_page_test in run_vmselftests.sh. I can do this if no one objects.
> The run behavior isn't being changed here. Only the build behavior is
> being changed as we want to keep the common code in one file. You can
> add the run entry as required. I don't know why do you think the
> Makefile has changed the run behavior.

Before your commit running
    `make TARGETS=vm; make TARGETS=vm run_tests`
had the following run behavior:
    - The only thing executed via the run_tests wrapper is run_vmtests.sh
    - TAP output is 1/1:
        TAP version 13
        1..1
        # selftests: vm: run_vmtests.sh
        # arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64
sparc64 x86_64
        # -----------------------
        # running ./hugepage-mmap
        # -----------------------
        ....

After your commit:
    - Multiple executables (madv_populate, soft-dirty,
split_huge_page_test, run_vmtests.sh) are defined and ran:
         # selftests: vm: madv_populate
         not ok 1 selftests: vm: madv_populate # exit=1
         # selftests: vm: soft-dirty
         ok 2 selftests: vm: soft-dirty
         # selftests: vm: split_huge_page_test
         ok 3 selftests: vm: split_huge_page_test
         # selftests: vm: run_vmtests.sh
         ok 4 selftests: vm: run_vmtests.sh # SKIP

I'm not saying utilizing the TEST_GEN_PROG variable is incorrect, I'm
just pointing out that we have a sudden change in run behavior via the
run_test wrapper. I personally think the TEST_GEN_PROG output is
cleaner, but having two different ways of outputting results may be
harder/confusing to parser. Additionally there is still the issue that
madv_populate is being run twice for no reason.

Cheers,
-- Nico

>
> >
> > Cheers,
> > -- Nico
> >
>
> --
> Muhammad Usama Anjum
>

