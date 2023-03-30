Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106D6D0AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjC3QHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjC3QHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554BC93F9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQ4ftFOSRnTCxQ3k16FeIYD6t7fNL3xHl6bh3AvSWJg=;
        b=GZPEVMuC0ko8IbQElid6M0CBsIoweo9IITLCZ0y7lxjeBvrzsN75HG1wirLtxO98IWQEuh
        5xArJtRXPxIBArxnZ9XiDK7K9/0AfHhfIsUWbuDEACfecap6L0o6ev/kru4Zz+wXlB3meo
        yBkG+ThjuCisMKoKQ6uSeWbAJhoeX74=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-JzpKxE4ZN-qwPoxr1fKyow-1; Thu, 30 Mar 2023 12:07:02 -0400
X-MC-Unique: JzpKxE4ZN-qwPoxr1fKyow-1
Received: by mail-qv1-f70.google.com with SMTP id m3-20020a0cbf03000000b005de7233ca79so6265810qvi.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192420; x=1682784420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ4ftFOSRnTCxQ3k16FeIYD6t7fNL3xHl6bh3AvSWJg=;
        b=K98zgL3VKblFFiuXWAm76aM9sTLAexy6gXxjD68hk7vSd+cQl1UUjg04q7zHhjSKzC
         WrO02ZcLZ/W8Waf83DtHLzikEPBmyLuMyQJ2+yLfxWgQmd6Pu9VpODk/Sk4BNpW4wXKI
         JUUfRP7xQk1HvkMMF/kIK3XyOwMD7qT80NaItvTz+e6qor+webBgzw6T6jTzFUsG249j
         XUlcuTzrDGdlGV/gMqJDObwQXnhmN/Di68oNGM8y6vAcL6WZaTzFO+kFfLSeK9J6YY4I
         9+FE4gr4R//Wx4mrKlHGkmsIGj7l224Q+qHQhVlsh9JYyzP1/dVHTt4O8E+LInG0/LHW
         wgCg==
X-Gm-Message-State: AAQBX9e0d3pWyO0O7I6PEdxNWi0m3pAtR9zutTY1aCDv/TljjaVt4kiS
        H54rTeBdCnfR6kxI+1oSNh1BQi1P5LM0vLwUtcmSXxTJ7h9Mh8diFe1nTdZQEbkXDtxdvG8PL+W
        +BveGJjcYXbnFs1UFO9yYSqfy
X-Received: by 2002:a05:6214:509b:b0:5af:3a13:202d with SMTP id kk27-20020a056214509b00b005af3a13202dmr3919565qvb.4.1680192420084;
        Thu, 30 Mar 2023 09:07:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350bLzP4GpcegMpvHKLVfgNmScSdhSk7athulffSgV0YbWPWaz9dWtQYXSRFdrOj4JKqHaphj6Q==
X-Received: by 2002:a05:6214:509b:b0:5af:3a13:202d with SMTP id kk27-20020a056214509b00b005af3a13202dmr3919542qvb.4.1680192419807;
        Thu, 30 Mar 2023 09:06:59 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id f13-20020ad442cd000000b005dd8b9345b8sm5531537qvr.80.2023.03.30.09.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:06:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 05/29] selftests/mm: Use TEST_GEN_PROGS where proper
Date:   Thu, 30 Mar 2023 12:06:54 -0400
Message-Id: <20230330160654.3106929-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230330155707.3106228-1-peterx@redhat.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TEST_GEN_PROGS and TEST_GEN_FILES are used randomly in the mm/Makefile to
specify programs that need to build.  Logically all these binaries should
all fall into TEST_GEN_PROGS.

Replace those TEST_GEN_FILES with TEST_GEN_PROGS, so that we can reference
all the tests easily later.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/Makefile | 63 +++++++++++++++--------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 4188435967ed..47516a78d447 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -31,34 +31,35 @@ MAKEFLAGS += --no-builtin-rules
 
 CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 LDLIBS = -lrt -lpthread
-TEST_GEN_FILES = cow
-TEST_GEN_FILES += compaction_test
-TEST_GEN_FILES += gup_test
-TEST_GEN_FILES += hmm-tests
-TEST_GEN_FILES += hugetlb-madvise
-TEST_GEN_FILES += hugepage-mmap
-TEST_GEN_FILES += hugepage-mremap
-TEST_GEN_FILES += hugepage-shm
-TEST_GEN_FILES += hugepage-vmemmap
-TEST_GEN_FILES += khugepaged
+
+TEST_GEN_PROGS = cow
+TEST_GEN_PROGS += compaction_test
+TEST_GEN_PROGS += gup_test
+TEST_GEN_PROGS += hmm-tests
+TEST_GEN_PROGS += hugetlb-madvise
+TEST_GEN_PROGS += hugepage-mmap
+TEST_GEN_PROGS += hugepage-mremap
+TEST_GEN_PROGS += hugepage-shm
+TEST_GEN_PROGS += hugepage-vmemmap
+TEST_GEN_PROGS += khugepaged
 TEST_GEN_PROGS = madv_populate
-TEST_GEN_FILES += map_fixed_noreplace
-TEST_GEN_FILES += map_hugetlb
-TEST_GEN_FILES += map_populate
-TEST_GEN_FILES += memfd_secret
-TEST_GEN_FILES += migration
-TEST_GEN_FILES += mlock-random-test
-TEST_GEN_FILES += mlock2-tests
-TEST_GEN_FILES += mrelease_test
-TEST_GEN_FILES += mremap_dontunmap
-TEST_GEN_FILES += mremap_test
-TEST_GEN_FILES += on-fault-limit
-TEST_GEN_FILES += thuge-gen
-TEST_GEN_FILES += transhuge-stress
-TEST_GEN_FILES += userfaultfd
+TEST_GEN_PROGS += map_fixed_noreplace
+TEST_GEN_PROGS += map_hugetlb
+TEST_GEN_PROGS += map_populate
+TEST_GEN_PROGS += memfd_secret
+TEST_GEN_PROGS += migration
+TEST_GEN_PROGS += mlock-random-test
+TEST_GEN_PROGS += mlock2-tests
+TEST_GEN_PROGS += mrelease_test
+TEST_GEN_PROGS += mremap_dontunmap
+TEST_GEN_PROGS += mremap_test
+TEST_GEN_PROGS += on-fault-limit
+TEST_GEN_PROGS += thuge-gen
+TEST_GEN_PROGS += transhuge-stress
+TEST_GEN_PROGS += userfaultfd
 TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
-TEST_GEN_FILES += ksm_tests
+TEST_GEN_PROGS += ksm_tests
 TEST_GEN_PROGS += ksm_functional_tests
 TEST_GEN_PROGS += mdwe_test
 
@@ -76,24 +77,24 @@ CFLAGS += -no-pie
 endif
 
 ifeq ($(CAN_BUILD_I386),1)
-TEST_GEN_FILES += $(BINARIES_32)
+TEST_GEN_PROGS += $(BINARIES_32)
 endif
 
 ifeq ($(CAN_BUILD_X86_64),1)
-TEST_GEN_FILES += $(BINARIES_64)
+TEST_GEN_PROGS += $(BINARIES_64)
 endif
 else
 
 ifneq (,$(findstring $(MACHINE),ppc64))
-TEST_GEN_FILES += protection_keys
+TEST_GEN_PROGS += protection_keys
 endif
 
 endif
 
 ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
-TEST_GEN_FILES += va_128TBswitch
-TEST_GEN_FILES += virtual_address_range
-TEST_GEN_FILES += write_to_hugetlbfs
+TEST_GEN_PROGS += va_128TBswitch
+TEST_GEN_PROGS += virtual_address_range
+TEST_GEN_PROGS += write_to_hugetlbfs
 endif
 
 TEST_PROGS := run_vmtests.sh
-- 
2.39.1

