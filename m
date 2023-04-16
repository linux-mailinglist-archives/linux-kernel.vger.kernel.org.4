Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9727E6E3C32
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 23:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjDPVnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPVnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 17:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFCD1BF9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681681346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+CDZW46985IwQy8Xkhqagr11sC+NnziqlmReyszRjAA=;
        b=dTM8iqL6w030x3F7vE9YSN/O+mzxYGLUBYN7J88EXPHVO3Mq3RxVchOW/Ore+hT8m/1oks
        uH2POhXIwImL3PudLNCo+yxwqttsDYoPOEwtCmVtyl9iv0iIZEbOf2KaCNEuv/cuqX5EIb
        p9b7bUn5vunUWYxN4paTAQg1Xu8mpYs=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-Vbvy3oZDMZ2vOQz0CTGZDA-1; Sun, 16 Apr 2023 17:42:25 -0400
X-MC-Unique: Vbvy3oZDMZ2vOQz0CTGZDA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-54fbf53aa09so3566147b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681681344; x=1684273344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CDZW46985IwQy8Xkhqagr11sC+NnziqlmReyszRjAA=;
        b=api4G0kMGkC9zaeq3YgOH/uQyxSjBgY8XCKUOAi94uXZRGLTBdjdFQuGFwVa0yJZ0I
         ubmFjWER8/KMUEoGgnU5B4OHvQK1YSMrrkH96k3vFfLPrnJw0g3KYUo6vBbNlN76NDi8
         +1i3X9XwA0oaOJbhZAJA7wLDKL9vqZUQ7XLVFAjmSmrgTJwdjg03Lmj75gtBj+kvgPmc
         F7kZOadOWhfb4prVQ6xqnw77PLoiTUJrdLfsEr80Iri46hBSlWCx0JnLbl8oEyRvsN/B
         ldJjMuaXbI93TFVQE2KRUXvtlFIRXV1lGuxLB2AtWbkCdsncwccNoy45tzOMk5+eLf3P
         eHig==
X-Gm-Message-State: AAQBX9c2nVN+ZEDa1bo2pY856Flz3ehKcWbKK9Zd18V5O2AtyTYGCW9E
        7h7DqT0FP14aBfmoA80INETZv4uez2IeJd49/JMuZ0x8LsPhHSikAAh/YPnwAiRxAi62j0XW+B1
        nk572j7kUFTgX787DecDJ9nOo
X-Received: by 2002:a81:2544:0:b0:54f:de06:3e29 with SMTP id l65-20020a812544000000b0054fde063e29mr7311575ywl.5.1681681344525;
        Sun, 16 Apr 2023 14:42:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zv0MqMgdh3s3Q7eirAUuGVLmzeRAtOJJcYuGf4jT0XLwCs4orMvw027uf+5C3nia8JxxF1Hg==
X-Received: by 2002:a81:2544:0:b0:54f:de06:3e29 with SMTP id l65-20020a812544000000b0054fde063e29mr7311560ywl.5.1681681344160;
        Sun, 16 Apr 2023 14:42:24 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id z188-20020a814cc5000000b0054fb975df99sm2711532ywa.18.2023.04.16.14.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 14:42:22 -0700 (PDT)
Date:   Sun, 16 Apr 2023 17:42:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
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
Message-ID: <ZDxrvZh/cw357D8P@x1n>
References: <20230412163922.327282-1-peterx@redhat.com>
 <20230412164218.328104-1-peterx@redhat.com>
 <7a053781-b56a-4366-bff9-d19971594043@lucifer.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="l7Bb7i29tc9/CEUQ"
Content-Disposition: inline
In-Reply-To: <7a053781-b56a-4366-bff9-d19971594043@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l7Bb7i29tc9/CEUQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Apr 15, 2023 at 04:44:47PM +0100, Lorenzo Stoakes wrote:
> >  TEST_GEN_PROGS = madv_populate
> 
> This now results in TEST_GEN_PROGS being set to "cow compaction_test
> gup_test..." then here that is discarded and we start again from
> madv_populate meaning none of the prior tests get built.
> 
> I notice this today when trying to build the gup_test :)
> 
> I think this should be a += not an = (which made sense before as there were
> two different variables being assigned then).

Right, thanks for reporting.

This patch will need a fixup.  After we start to build all tests for real I
found that the other patch "selftests/mm: uffd_[un]register()" actually
broke build for testcase hugepage-mremap.c on missing headers.

I've attached two fixups and attached, one for this patch, one for the
other one.  I hope we can just queue these two fixups in Andrew's tree, or
I'll see what I should do.

Thanks,

-- 
Peter Xu

--l7Bb7i29tc9/CEUQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-selftests-mm-use-TEST_GEN_PROGS-where-proper.patch"

From 3ae6d1a0af0aff93734c9b07ff75dc89d3feafaf Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Sun, 16 Apr 2023 17:35:02 -0400
Subject: [PATCH 1/2] fixup! selftests/mm: use TEST_GEN_PROGS where proper

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 5a3434419403..63c03a6414fc 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -42,7 +42,7 @@ TEST_GEN_PROGS += hugepage-mremap
 TEST_GEN_PROGS += hugepage-shm
 TEST_GEN_PROGS += hugepage-vmemmap
 TEST_GEN_PROGS += khugepaged
-TEST_GEN_PROGS = madv_populate
+TEST_GEN_PROGS += madv_populate
 TEST_GEN_PROGS += map_fixed_noreplace
 TEST_GEN_PROGS += map_hugetlb
 TEST_GEN_PROGS += map_populate
-- 
2.39.1


--l7Bb7i29tc9/CEUQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0002-fixup-selftests-mm-uffd_-un-register.patch"

From b301e2301120d70477f3ae539704cfc0fe031119 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Sun, 16 Apr 2023 17:36:37 -0400
Subject: [PATCH 2/2] fixup! selftests/mm: uffd_[un]register()

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/hugepage-mremap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index 2084692fe1c4..cabd0084f57b 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -23,6 +23,8 @@
 #include <linux/userfaultfd.h>
 #include <sys/ioctl.h>
 #include <string.h>
+#include <stdbool.h>
+#include "vm_util.h"
 
 #define DEFAULT_LENGTH_MB 10UL
 #define MB_TO_BYTES(x) (x * 1024 * 1024)
-- 
2.39.1


--l7Bb7i29tc9/CEUQ--

