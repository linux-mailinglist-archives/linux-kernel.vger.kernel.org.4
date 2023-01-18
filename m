Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38626716A5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjARIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjARIwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:52:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32B553F8D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:05:36 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id dw9so33556454pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfvGmMtFJjRRSAyhf9LFXYJKD8Rnq768IEyE92RvJw0=;
        b=E9VQ8FoxNSUrQG0Ly8zk8LSOYx2YwXs5F9WrtNhP7H1MeG+L3NyPfbaDSVccJ0lWGz
         RcAd/w4VRWGyQFpV/QPZVU0TlLju/hnt90mC8UFcS01K0hDeOEN6LXWGge/8nm3yzp7B
         JCFWXpYqI95zBsSMn4rh80lqcZDIe0dFIBig+Qj3Q703Q3jGVFosiZY+c1fSL06SvJCN
         YNccXl6lbEewgH/XIEHJ6gsuqK9lzoziCY3koDuKZNMM0qMSV1CJvhQjD0ahh2NWFsPK
         JmZA3RkP9Wf8eRke+GhlXKnht2oU/FiEcA9Tfy3//kX43lRB8WrI1FDjB+9mj0oUz9nF
         73+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfvGmMtFJjRRSAyhf9LFXYJKD8Rnq768IEyE92RvJw0=;
        b=T619zVJMt3U37tvZspG9umayeCkxSRJCxo+YFnFf1dTbKYSb25HjDksM3FyjvqHBDE
         tRfMzd/YOGEF5wq8IlWCpRZKM7kEMswVWew2qgZbSJrr2cs+IAVvOglCwePs1RNbBr/A
         h6OHDvYcUDSrpzZE+6H+FlYmdj6vhyXyclgsv3NlI6hrF8bW/nH/FQmjt/Yn3c28jNHR
         9DxYby5Gp3trckJbxt5t7ludirv7Jw3EmmdqNz6MjHG+OSaySw1CryJVeTVjKUeGRt/u
         5gJZQVLafTvL/mqXRFcg3XOWE/nqfs7NQzZ/7+y7r+qVCMknn/qnF900VXXHtUDrkNut
         v79w==
X-Gm-Message-State: AFqh2kpw7yuJp9r5AIDDT3Qk2Sop2iQaAgO0JVl3zlvk/4VZp/kwb8sL
        8Yzo2xTUXmKAFLLuUduvigw=
X-Google-Smtp-Source: AMrXdXtoQsC++CK/5+jP5d61aNMmdnw4zpHruqa60koml8i9+ow1z+GRbWamZBRzEITMCT6HSb6NWg==
X-Received: by 2002:a17:902:ccc9:b0:194:749a:1e78 with SMTP id z9-20020a170902ccc900b00194749a1e78mr7136533ple.40.1674029136134;
        Wed, 18 Jan 2023 00:05:36 -0800 (PST)
Received: from localhost.localdomain ([2001:e60:8009:708:f1fc:e9cc:7685:9c2c])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902654b00b001895d87225csm22359430pln.182.2023.01.18.00.05.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Jan 2023 00:05:35 -0800 (PST)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] mm/cma: Fix potential memory loss on cma_declare_contiguous_nid
Date:   Wed, 18 Jan 2023 17:05:23 +0900
Message-Id: <20230118080523.44522-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose, memblock_alloc_ranged_nid with highmem_start is success
when cma_declare_contiguous_nid is called with !fixed
in the system 32-bit system with PHYS_ADDR_T_64BIT enabled
with memblock.bottom_up == false.

But, Next trial to memblock_alloc_range_nid to allocate in
[SIZE_4G, limits) nullifies former success allocated addr and
it retries to memblock_alloc_ragne_nid again.

In this situation, first success address area is lost.

By changing order of allocation (SIZE_4G, high_memory and base) and
checking whether allocated prevents potential memory lost.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 mm/cma.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 4a978e09547a..49d9b08d9a47 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -321,18 +321,6 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	} else {
 		phys_addr_t addr = 0;

-		/*
-		 * All pages in the reserved area must come from the same zone.
-		 * If the requested region crosses the low/high memory boundary,
-		 * try allocating from high memory first and fall back to low
-		 * memory in case of failure.
-		 */
-		if (base < highmem_start && limit > highmem_start) {
-			addr = memblock_alloc_range_nid(size, alignment,
-					highmem_start, limit, nid, true);
-			limit = highmem_start;
-		}
-
 		/*
 		 * If there is enough memory, try a bottom-up allocation first.
 		 * It will place the new cma area close to the start of the node
@@ -350,6 +338,18 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 		}
 #endif

+		/*
+		 * All pages in the reserved area must come from the same zone.
+		 * If the requested region crosses the low/high memory boundary,
+		 * try allocating from high memory first and fall back to low
+		 * memory in case of failure.
+		 */
+		if (!addr && base < highmem_start && limit > highmem_start) {
+			addr = memblock_alloc_range_nid(size, alignment,
+					highmem_start, limit, nid, true);
+			limit = highmem_start;
+		}
+
 		if (!addr) {
 			addr = memblock_alloc_range_nid(size, alignment, base,
 					limit, nid, true);
--
2.35.1
