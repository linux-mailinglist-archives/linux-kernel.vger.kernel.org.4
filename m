Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E186F2956
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 17:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjD3PHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3PHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 11:07:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396497;
        Sun, 30 Apr 2023 08:07:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f1950f569eso8779745e9.2;
        Sun, 30 Apr 2023 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682867230; x=1685459230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNA2K0rH9MrgxL3yIvI8k+E30Kvr7zSXTQ5c9EZm7oQ=;
        b=WOO4BOE5x9yHSm0Xq67hB0jdZqg5yPqQjCzbYps62+Ktq7YkvEkEBl9otVSyaqIy2X
         1nAQH9lVg6rCWXG0BvAy8cZDNNY+S/UaRJccPPL/Dnz6uAUrstmThjGlDylSB4aHEt4f
         M6ABPYHf9W3HKExAOZR+FDZeItqZeoWmHzvRYLvWIE4CVdkLJgJG80aY7/c/NPn24w5V
         8mNSQ87Stvpeduu8FdCSkBQslVw2jF6XCny4fkEmNAaCtWFzBzt2tXa4f6k0yQ7S5m/P
         wL18L8kiyXN2Ia1iy5XQURbnREp+XiyDU29f7Lb16IWrFNy0Ec0794RDyt38ET8hqzhD
         5jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682867230; x=1685459230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNA2K0rH9MrgxL3yIvI8k+E30Kvr7zSXTQ5c9EZm7oQ=;
        b=CIh4w9KDt//AaevCPqFX72c5KybHXeVIuZ0OgCB7NeRiRaFjL/i9r8fO1facT9H21Q
         ig2Mkv9WbKF9LBIAWV1PPKLXiwL6FKgRIFXoF0HxR+gxaYljpB3q0awaEIyzW1BcXvqD
         cRjwV9prfhUbjU8tI0XuhomaCEI//xCUeXS2Srf8yjasCV3imvplOAFbrEO0TVHc1LIJ
         GLemqTI4TCTUtLJysKddEs9n2q7Hsglv/OzKdSrpC/ZViJnmO+Ot8P9iVkFGtl9Oghtb
         iwAN9asdhY+X6B2xTK4qA5DuHAaS15ETXQTpb4J+DlLSCGNVA1Ij+O6dVXfZB0m5JuiP
         Ce8Q==
X-Gm-Message-State: AC+VfDxj24iaiWlT0jeRyovjZqN3ot6ynGaZw20BfIe7kPDO++YgAWw6
        oEm3sJUl859YC1ESkSHpJ7w=
X-Google-Smtp-Source: ACHHUZ5/IozSCusmdfxGH7uvDSUaBwy3WgSuCJRJJFZGuVqOysQEqEbLKdRuVFcC+hm0B2NPYB2DGQ==
X-Received: by 2002:a05:600c:22d0:b0:3f1:7a57:45cd with SMTP id 16-20020a05600c22d000b003f17a5745cdmr8210516wmg.28.1682867230079;
        Sun, 30 Apr 2023 08:07:10 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id l18-20020a05600c4f1200b003f07ef4e3e0sm43019311wmq.0.2023.04.30.08.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 08:07:09 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        oliver.sang@intel.com, Mel Gorman <mgorman@suse.de>,
        stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2] mm/mempolicy: Correctly update prev when policy is equal on mbind
Date:   Sun, 30 Apr 2023 16:07:07 +0100
Message-Id: <83f1d612acb519d777bebf7f3359317c4e7f4265.1682866629.git.lstoakes@gmail.com>
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
Cc: <stable@vger.kernel.org>
---

v2: updated to correctly cc the stable list :)

v1:
https://lore.kernel.org/all/db42467a692d78c654ec5c1953329401bd8a9c34.1682859234.git.lstoakes@gmail.com


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
