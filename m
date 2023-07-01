Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484C474498E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 16:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGAOUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 10:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGAOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 10:20:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF31630D0;
        Sat,  1 Jul 2023 07:20:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-314172bb818so3263179f8f.1;
        Sat, 01 Jul 2023 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688221246; x=1690813246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xzwfPjRQFT6QKTWY2W7B8J20zCNe8ZcBZy6OXaEZiE=;
        b=VMDWbuxc1Y6vsnHVtQXRkXyvapLiLnw6gcnHcjZLt2lDpg8vDqciqBzOkHDZgGgCJJ
         +QwCuRAk8LsSSfXQOXg7wO1/dG+fYDAmMT/+mEf/uMJ/DDIr29gwEKvPARdlvxRnUplI
         u3brKHyBqYEOAby5GHwvguXFV5okajoyD/gpdVUy2qgMAT/EOBRO9OVzk4uOIShNc0DM
         65CMYHkesyGwMuesK+Aqzo6cnCKO7q1glqj6an3sIU+GtW1GKwkW3M4jLVYQCnVT3Nr5
         qn4j820pxQOdVxkMyUFSePMrzKu1DdtNubgwbhuUuMwF4HhiiZ7Oi9Vn1xgGKHJtsQJw
         k/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688221246; x=1690813246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xzwfPjRQFT6QKTWY2W7B8J20zCNe8ZcBZy6OXaEZiE=;
        b=bQnejJCtCN2ZvUvkV0Vol3464wDn1dFfxfI/hxcFIXqzGXBO2Gc55kZ5m8/mLRYEWy
         QS5T3kfoyTuUau7oD11A17WKo24l0kFgYdEFfdjTVQ5bIMBX+zjrx+nWi51TbMX6F8xj
         MDTflJhDl4EoXg6GzmqqXK5ucuR1rF17xgzkJplxYSGaBsMexnSttCwVQ3axo/bTXR4o
         Rpuh0cZF2pXnYinNj9yLp0AIjRBhSXBXOdVSHzHJQKB4TbObFowCiIxiG+RZquwsyKAO
         LnzuenxqVQGgHiUMA0522GcH4Tr0OiGmQ7Z7LM5+NakgpOXv7DnoXRVxrCDGElc84Skd
         IRFQ==
X-Gm-Message-State: ABy/qLbo9Za+1vpUKew8TM6o54FWo+FDOgYPHO8nmR643E6JfuqHayqw
        EC0uzPT5IdG1qb3aXmDW8SE=
X-Google-Smtp-Source: APBJJlH8c1U2WWQW1POCEW5HO6qA6qoyqkRKvCgSWNquBLbN/NooBhoLGygUtVIZX4azLQMGdUrtKQ==
X-Received: by 2002:a5d:49d1:0:b0:314:15b7:1fb5 with SMTP id t17-20020a5d49d1000000b0031415b71fb5mr4238962wrs.34.1688221246067;
        Sat, 01 Jul 2023 07:20:46 -0700 (PDT)
Received: from localhost.localdomain (host-82-49-237-33.retail.telecomitalia.it. [82.49.237.33])
        by smtp.gmail.com with ESMTPSA id t5-20020a05600001c500b00313f7b077fesm14307741wrx.59.2023.07.01.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 07:20:45 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Deming Wang <wangdeming@inspur.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH v2] Documentation/mm: Add information about kmap_local_folio()
Date:   Sat,  1 Jul 2023 16:19:31 +0200
Message-ID: <20230701142041.9992-1-fmdefrancesco@gmail.com>
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
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: I thought to Cc everybody but Andrew :-( Sorry, fixed.
	Andrew, can you please take this patch through your tree?

 Documentation/mm/highmem.rst | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
index c964e0848702..bb9584f167a6 100644
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
+* kmap_local_page(), kmap_local_folio() - These functions are used to require
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

