Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D512A74BD6C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGHMRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 08:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGHMR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 08:17:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB10F120;
        Sat,  8 Jul 2023 05:17:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so23423485e9.1;
        Sat, 08 Jul 2023 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688818646; x=1691410646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrwJasY3cJuEA4+eZCnOTkC6/C/i+F1wG15vTJoUGTg=;
        b=Zb3fPI842NYI9Pnn1VdSQGtfjPgEH/6Se9Fn99r25H8BipyXFJ1sjvge760Hx8bDgH
         bMNogKxczovu24ZofN0c7P7tyZQwgopxFiuzwc0AQXTW7uGPHKgOhQL3y4UTw6b5UH6Q
         wnsPK2B4soVXZ8RWHRbtz1NPeM25rNFfZKHE5zX6rtz/w1EdgDC9hPcqujvBuz+xPDYJ
         OQQl3NLZdyBELb3N6rzjWceuuGSfPJpSDNPFB6sj9SIIvV8nz5UB2QLvdiKQ9gAN4Ttq
         dxI8pQGDcKtjhaWQS7K2v+s6W9cYDjE9eU1er2hPOx46nnsaegwCJaWbaks+FhYEdb+i
         T+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688818646; x=1691410646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrwJasY3cJuEA4+eZCnOTkC6/C/i+F1wG15vTJoUGTg=;
        b=mIEUQ0Kg1Y1BHXaCFpwujIgmAtVJRK63Oh6963n9tPmaTelY8nsnBvGXijuS2PX5Rs
         jTbTTTZ5/utGKc7ewtL3Xkp6ID9M0LnkraZCnTG4U9Fb0rLEheqLJaJ0npwpbkQlRi8t
         3vo8YCG7VtX0fjNliSvQ5fOb69RVtlKcDmvo9ni5I8ZLU0FinByHI4XzCOk6lJGySZJr
         XUvHVW5sObONhaGFUlzdb/pYjrdB8dcKi6w0trGoTcmvYQz2QsZbAJ4ei9VcWPjzo/s1
         5SP5ddJTg8TBYk0w+yHvi1HDRYMfIlGTHWGr8IEeFA+NZMnoJByOfKGrq8NPkFL5hmfV
         EVcQ==
X-Gm-Message-State: ABy/qLbVuIsWPR+/JPUBXooFWtPG1H50qJPxNkf2nXMbCf/qdS5Dazmw
        WyIjk5B8/vFr6owq0LFzKDI=
X-Google-Smtp-Source: APBJJlF5S37/61IOUN4boRGyQ+eZbxbUsGSs3iPJnY2sKXBk7rqPV2h3cJxGNUS1K7AOv/xHI7PW6Q==
X-Received: by 2002:a1c:770b:0:b0:3f7:c92:57a0 with SMTP id t11-20020a1c770b000000b003f70c9257a0mr7445101wmi.14.1688818645993;
        Sat, 08 Jul 2023 05:17:25 -0700 (PDT)
Received: from localhost.localdomain (host-95-247-100-31.retail.telecomitalia.it. [95.247.100.31])
        by smtp.gmail.com with ESMTPSA id f17-20020adfe911000000b0031416362e23sm6889003wrm.3.2023.07.08.05.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 05:17:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Deming Wang <wangdeming@inspur.com>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH v3] Documentation/highmem: Add information about kmap_local_folio()
Date:   Sat,  8 Jul 2023 14:16:18 +0200
Message-ID: <20230708121719.8270-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The differences between kmap_local_page() and kmap_local_folio() consist
only in the first taking a pointer to a page and the second taking two
arguments, a pointer to a folio and the byte offset within the folio which
identifies the page.

The two API's can be explained at the same time in the "Temporary Virtual
Mappings" section of the Highmem's documentation.

Add information about kmap_local_folio() in the same subsection that
explains kmap_local_page().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v2->v3:	Replaced "request" with "create". Noticed by Randy (thanks),
	fixed by Matthew (again thanks).
	https://lore.kernel.org/lkml/970a881a-cdaf-2568-657a-3b93b0273338@infradead.org/

v1-v2:	I had Cc'ed everybody but Andrew :-( Sorry, it's now fixed.
	In the meantime, I collected the review tags by Ira and Mike
	(thanks to both of you). All entries are listed using a simple
	ascending lexycographycal order based on first names.

 Documentation/mm/highmem.rst | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
index c964e0848702..fe68e02fc8ff 100644
--- a/Documentation/mm/highmem.rst
+++ b/Documentation/mm/highmem.rst
@@ -51,11 +51,14 @@ Temporary Virtual Mappings
 The kernel contains several ways of creating temporary mappings. The following
 list shows them in order of preference of use.
 
-* kmap_local_page().  This function is used to require short term mappings.
-  It can be invoked from any context (including interrupts) but the mappings
-  can only be used in the context which acquired them.
-
-  This function should always be used, whereas kmap_atomic() and kmap() have
+* kmap_local_page(), kmap_local_folio() - These functions are used to create
+  short term mappings. They can be invoked from any context (including
+  interrupts) but the mappings can only be used in the context which acquired
+  them. The only differences between them consist in the first taking a pointer
+  to a struct page and the second taking a pointer to struct folio and the byte
+  offset within the folio which identifies the page.
+
+  These functions should always be used, whereas kmap_atomic() and kmap() have
   been deprecated.
 
   These mappings are thread-local and CPU-local, meaning that the mapping
@@ -72,17 +75,17 @@ list shows them in order of preference of use.
   maps of the outgoing task are saved and those of the incoming one are
   restored.
 
-  kmap_local_page() always returns a valid virtual address and it is assumed
-  that kunmap_local() will never fail.
+  kmap_local_page(), as well as kmap_local_folio() always returns valid virtual
+  kernel addresses and it is assumed that kunmap_local() will never fail.
 
-  On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
+  On CONFIG_HIGHMEM=n kernels and for low memory pages they return the
   virtual address of the direct mapping. Only real highmem pages are
   temporarily mapped. Therefore, users may call a plain page_address()
   for pages which are known to not come from ZONE_HIGHMEM. However, it is
-  always safe to use kmap_local_page() / kunmap_local().
+  always safe to use kmap_local_{page,folio}() / kunmap_local().
 
-  While it is significantly faster than kmap(), for the highmem case it
-  comes with restrictions about the pointers validity. Contrary to kmap()
+  While they are significantly faster than kmap(), for the highmem case they
+  come with restrictions about the pointers validity. Contrary to kmap()
   mappings, the local mappings are only valid in the context of the caller
   and cannot be handed to other contexts. This implies that users must
   be absolutely sure to keep the use of the return address local to the
@@ -91,7 +94,7 @@ list shows them in order of preference of use.
   Most code can be designed to use thread local mappings. User should
   therefore try to design their code to avoid the use of kmap() by mapping
   pages in the same thread the address will be used and prefer
-  kmap_local_page().
+  kmap_local_page() or kmap_local_folio().
 
   Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
   extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
-- 
2.41.0

