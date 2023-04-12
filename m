Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894646DFB90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDLQnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDLQnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502468A4F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGqh0HGkgoECYjM8JfbpdJ2gFcbvM7PfOwSnAOWQ14c=;
        b=XG7SZZDV7NPWxthngLwoA6PvfqSU5TZBEeUQeHXyo3Q0gxew8acy1Tovpt0pf0rLYZtiIl
        yVJtQZ9am5wQpUiIJrVf/ftSACdSpHy42yuisDv7xWol6OhHI8fYGOgx5474SeHufLQSC2
        AaODQrumAxFw/m0LMUynpqjomDxsUbY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-FeBVkfCMP0W4YjwS14y3sw-1; Wed, 12 Apr 2023 12:42:21 -0400
X-MC-Unique: FeBVkfCMP0W4YjwS14y3sw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3e69901d854so893931cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317740; x=1683909740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGqh0HGkgoECYjM8JfbpdJ2gFcbvM7PfOwSnAOWQ14c=;
        b=LFjsObXzNEcojeVMNC4lxvJgU+wiqwbaDTR8xcRsuKwCGTb3v2ePQChP2JPlLz07tJ
         haK73+wmXoy/vRJd69ibiilACfHHKDCyvjSo9CXQo/d9xwOvNngbRaLsU64bS007B59W
         6fCQTEKJZfg2VlvwwV0685dMOKxHt5HerHnjcXKlGRaCSNo+DRzCGzPirUnNdcgr25nJ
         ZJ3XMaViUzgnVISWQwZYFnZR5d9Vq5K2Q6ziVMGnp6chP2LB4JS/GtBB1vjjBmrcSenK
         YUcjEN58XwLth+URq1AX24/5PotphDl3MQJMsHt8xNLorPGuNapXj2RDgN88uJJVWpMN
         B3bw==
X-Gm-Message-State: AAQBX9e6kyKKbpMA38/atBV2NHW/GXXSnzIrBjbsVZjdlHC6yb8mwmLl
        qXpXqAsac1ZSaT5i8Nw7Pvwoi0d22gWkI4y7VTjiyULOSpLXnXMPHlugv0w5VEt6l6kyoccSipJ
        Nq8joxIkfppdeChNSCszBlLddCJ5LzIlMXRev18JT9FC7SLQn2tVZC3LKzRnNWSKyttTk8VRp+S
        15xKgwhA==
X-Received: by 2002:a05:622a:314:b0:3e8:e986:b20b with SMTP id q20-20020a05622a031400b003e8e986b20bmr2585191qtw.6.1681317740330;
        Wed, 12 Apr 2023 09:42:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350bkvTx9eAqSgNGgv+038c+tdv0QunwK9SW60Y4+A1DFmxnzTzQyPH/H2ogtGhLnE+aAF7AzBw==
X-Received: by 2002:a05:622a:314:b0:3e8:e986:b20b with SMTP id q20-20020a05622a031400b003e8e986b20bmr2585158qtw.6.1681317740031;
        Wed, 12 Apr 2023 09:42:20 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id i18-20020ac860d2000000b003e45a39ed74sm4352477qtm.81.2023.04.12.09.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:42:19 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com, Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 05/31] selftests/mm: Use TEST_GEN_PROGS where proper
Date:   Wed, 12 Apr 2023 12:42:18 -0400
Message-Id: <20230412164218.328104-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230412163922.327282-1-peterx@redhat.com>
References: <20230412163922.327282-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/Makefile | 63 +++++++++++++++--------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 9d9822b4bf24..74988f5adc5f 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -31,35 +31,36 @@ MAKEFLAGS += --no-builtin-rules
 
 CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
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
+TEST_GEN_PROGS += map_fixed_noreplace
+TEST_GEN_PROGS += map_hugetlb
+TEST_GEN_PROGS += map_populate
+TEST_GEN_PROGS += memfd_secret
+TEST_GEN_PROGS += migration
 TEST_GEN_PROGS += mkdirty
-TEST_GEN_FILES += mlock-random-test
-TEST_GEN_FILES += mlock2-tests
-TEST_GEN_FILES += mrelease_test
-TEST_GEN_FILES += mremap_dontunmap
-TEST_GEN_FILES += mremap_test
-TEST_GEN_FILES += on-fault-limit
-TEST_GEN_FILES += thuge-gen
-TEST_GEN_FILES += transhuge-stress
-TEST_GEN_FILES += userfaultfd
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
 
@@ -77,24 +78,24 @@ CFLAGS += -no-pie
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

