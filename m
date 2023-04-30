Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370266F28F6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjD3NAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 09:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjD3NAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 09:00:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7773E70;
        Sun, 30 Apr 2023 06:00:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1cfed93e2so15039185e9.3;
        Sun, 30 Apr 2023 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682859619; x=1685451619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gJoztnqwIQgpjaOP6X2OK+4rUxlcDJhg6AbeMdHGJLI=;
        b=ZgR/5hKiBoSBb3pYvmERFlJ9eIuK8McJDTki/qkZLZLcXXKBI0IPNGfJdIMAEBF2Vf
         GruJzrHVSZ8oyoBwLtGtnYWHhbZdWoaUNFfOS9Nl2zQzyF/7RAoIAtqI2XgHIapgziWL
         ZLsyAVdOnw30X0LCQCBf4IDRyaeInILd4N6DMC3GTMq8rhPGTgzWZrlw5T3DYyE6UfyO
         vCBcJn8nLFqB4O4j4jn2+/tZCBZmCsPwhT9rDO2duiLt9AjPTb33BnX9C5th0xkhqCTI
         15PMHu4v8DyXCLY4JdT8x0WYTobF4U4lRo2FAEnDmN5pLFexb2+1sjvnBkv2B7X1mD/e
         odeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682859619; x=1685451619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJoztnqwIQgpjaOP6X2OK+4rUxlcDJhg6AbeMdHGJLI=;
        b=Y032vx8fbuuMxidc6ZtabXW4lrKcChtlSy2wWjI7vq4Urg3xDEs/p0rGgUk+TX0egW
         7v9VuMPCpAgU8R/+2MRIDxAs24jMMy/7yZ5x8zNxliWPISlNcgi21SC86CnYPmEhQ9Zx
         NYDgoK3Pa8Dk3GPijuOxclXhGKcVyhwGdk87z+xDc6BrnCH/0Mldcnus2GhCgzOGHc6D
         JjySJcCdDmukcje+5tvfdF9a4c/eJMrv972OJWRtHcINRoAZOrdgLhwA6Qyfihp8m6oh
         Gl0UAkqNce49OLm0cncXFenGDP3QkP0fOnPFtWVkC5wXZnj6OMiG5PQZFA6UM84RiRe/
         LYWQ==
X-Gm-Message-State: AC+VfDz1jDOe/tLqF/I24zttwanK5ZJAS9JItj+Ewcw9dr3sc6jnoCZ4
        4UcdkM6LTCzkkYzdzNX8YGHq+unakfLWKw==
X-Google-Smtp-Source: ACHHUZ6ClPaB2tSn/cDdBaR8COWvv3/lZgNrssz1O0d5viNUQLB3qekLnwv4YW++IfTJ+QzTP1CFgw==
X-Received: by 2002:a05:600c:d7:b0:3f2:51e7:f110 with SMTP id u23-20020a05600c00d700b003f251e7f110mr7729914wmm.32.1682859619121;
        Sun, 30 Apr 2023 06:00:19 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id u5-20020a7bc045000000b003f32c9ea20fsm5228255wmc.11.2023.04.30.06.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 06:00:18 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        oliver.sang@intel.com, Mel Gorman <mgorman@suse.de>,
        stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm/mempolicy: Correctly update prev when policy is equal on mbind
Date:   Sun, 30 Apr 2023 14:00:15 +0100
Message-Id: <db42467a692d78c654ec5c1953329401bd8a9c34.1682859234.git.lstoakes@gmail.com>
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

The refactoring in commit f4e9e0e69468 ("mm/mempolicy: fix use-after-free
of VMA iterator") introduces a subtle bug which arises when attempting to
apply a new NUMA policy across a range of VMAs in mbind_range().

The refactoring passes a **prev pointer to keep track of the previous VMA
in order to reduce duplication, and in all but one case it keeps this
correctly updated.

The bug arises when a VMA within the specified range has an equivalent
policy as determined by mpol_equal() - which unlike other cases, does not
update prev.

This can result in a situation where, later in the iteration, a VMA is
found whose policy does need to change. At this point, vma_merge() is
invoked with prev pointing to a VMA which is before the previous VMA.

Since vma_merge() discovers the curr VMA by looking for the one immediately
after prev, it will now be in a situation where this VMA is incorrect and
the merge will not proceed correctly.

This is checked in the VM_WARN_ON() invariant case with end > curr->vm_end,
which, if a merge is possible, results in a warning (if CONFIG_DEBUG_VM is
specified).

I note that vma_merge() performs these invariant checks only after
merge_prev/merge_next are checked, which is debatable as it hides this
issue if no merge is possible even though a buggy situation has arisen.

The solution is simply to update the prev pointer even when policies are
equal.

This caused a bug to arise in the 6.2.y stable tree, and this patch
resolves this bug.

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202304292203.44ddeff6-oliver.sang@intel.com
Fixes: f4e9e0e69468 ("mm/mempolicy: fix use-after-free of VMA iterator")
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mempolicy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2068b594dc88..1756389a0609 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -808,8 +808,10 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vmstart = vma->vm_start;
 	}
 
-	if (mpol_equal(vma_policy(vma), new_pol))
+	if (mpol_equal(vma_policy(vma), new_pol)) {
+		*prev = vma;
 		return 0;
+	}
 
 	pgoff = vma->vm_pgoff + ((vmstart - vma->vm_start) >> PAGE_SHIFT);
 	merged = vma_merge(vmi, vma->vm_mm, *prev, vmstart, vmend, vma->vm_flags,
-- 
2.40.1

