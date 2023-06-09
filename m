Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E6728E4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjFIDJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFIDJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:09:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC3830C3;
        Thu,  8 Jun 2023 20:09:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso9857635e9.1;
        Thu, 08 Jun 2023 20:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686280154; x=1688872154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTDok3dfDPQdHPJLG2arA+PJ+fGlkSKKnE69ts+c3B4=;
        b=Z4XO8XODAhi/moJJ7JXdsyqypDtXgYXGN4bVhWGOXZcsXVw7iC9J53l+5mwEWfdG0Z
         EoxjTIVOWgtk1fBPX/XAnKi29TExTgECz6fdNXvBsiWDSsW1LkfKQyrGyPyBunaX25VT
         Ve2/m+ZEP+EXI8BV2G4IogCnvzYxtwmePcgxEL2bMKm1oUhQq9SnHZtYd3P+bb/Q87PP
         X4G4gaYJ2risEjyx2b0MGcFro7NOAC3hWiT9OtwcTkn3z50dW1ki4r18Oc01+VsgMXjU
         tYbwBaGrinMEEbt9fQQEtlHizEJTa1TJjvwJ1/XBGlhalKlH7M35IrmVWIAvoJJDU5Sz
         V7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686280154; x=1688872154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTDok3dfDPQdHPJLG2arA+PJ+fGlkSKKnE69ts+c3B4=;
        b=YWaRUyCsSmwQxDZApSCynHzzSyKPe775bC3Fa0HDoNcWnIHYk7eMYIAHJxzHKoXh/D
         T8HQwTjKvBgrfW1MmEFxw2FjmVUEeoMNxN2hOUChog1LGdR8VDswVBg5+vTMOurGPx4m
         8VYjnDcP5G1WX53HD2Pp7xzHH7SOam12FPq/mSyMxXqXXyAvdAYPbSuWw6L7F2yC+u8Q
         JKokdnK7ParO8fTBWgR45V5SlDfChtCaBJtQQwJxic8iRqivwVFXXGGWhPRXay/R9WS/
         RdWXDNl42G2FpLRHTDRaV2TmPCdifbSs/08F1dK8F63cSYTWSRRVGZoLtOAEL4e/SO+F
         VERw==
X-Gm-Message-State: AC+VfDx5M1T4Ik9J/k3Tryjk4DmdDU/2T6bPJEM7y1EnkvKo46Wr/vQH
        aEATr539ePMl4X+hqJAnlp8=
X-Google-Smtp-Source: ACHHUZ7h/Q+N48tlnHqDVl6ud3LFDuX2Jb1fznsSJEHsIMXAQ0pXxEcNyiKinsNZaP1OqRd2sV1RzA==
X-Received: by 2002:a05:600c:3793:b0:3f7:2b61:4c98 with SMTP id o19-20020a05600c379300b003f72b614c98mr294480wmr.13.1686280154005;
        Thu, 08 Jun 2023 20:09:14 -0700 (PDT)
Received: from localhost.localdomain (host-79-23-99-244.retail.telecomitalia.it. [79.23.99.244])
        by smtp.gmail.com with ESMTPSA id s5-20020a7bc385000000b003f6132f95e6sm1192738wmj.35.2023.06.08.20.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 20:09:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Deming Wang <wangdeming@inspur.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH] Documentation/mm: Add kmap_local_folio() to Temporary Virt. Mappings
Date:   Fri,  9 Jun 2023 05:09:08 +0200
Message-Id: <20230609030908.31373-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.40.1
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
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
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
2.40.1

