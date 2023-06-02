Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB2720C2D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbjFBXGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbjFBXGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB83BE40
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 16:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685747163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxigdMYXU7S1zIuZO/BNG/wM9sX6VFUiTJ8CdWEAXIc=;
        b=Pkjwsb0TYjCl2JucYwoEr1xtnZgkwH1BZYGvRIEzLwtlHWyJXQzDP4Eh+QUVNDNiNHeAca
        Q3vKWV1rKuiYkmV3DG5qggNrBXNNRu/RbTP+93co/H02ujyyPXz2HBxgXS0D7djI+TZ/Vt
        PvifEge0n9+meo31sMdy5JpI9sh8wdE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-04oU9R1PPZ6WwMYtI_0zuQ-1; Fri, 02 Jun 2023 19:06:02 -0400
X-MC-Unique: 04oU9R1PPZ6WwMYtI_0zuQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-626380298d3so5604826d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 16:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685747161; x=1688339161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxigdMYXU7S1zIuZO/BNG/wM9sX6VFUiTJ8CdWEAXIc=;
        b=i5TdcrqQmsbZRdMUeDdGIcER7iL2HTHxs1H2Q50roqbUrJEZmVaF0Q9yg2oOEPl6/9
         6CmjkXu3BKbEftJDMeTVkaKNgsOZ7t2d8LX7K9tTTEAJYVxEKOdrTImSLzcPrnHi3YlZ
         veDWnGG3UxCacyTwXYJXkrqpVVnrtmVc7bask8ihMRKW1xZ62Cnw86iZAP0WLLjlILo/
         Xj1hwsCb9deeso/7dQuttWUbXsyStkd+mHVFAF4zoPe3Is8Wu7vjJ0pmN6QQj1ThNWzS
         DI1T+buVSCZR4KT4bWCAdjJg+vm8AfIxy1SXTCqdMX1OJvPCHFXp1THXy1V+EQXIzi16
         pJ8A==
X-Gm-Message-State: AC+VfDxm9JOBecp+G/L0NCSYDlvf3B51k8fxWRohRLulYKExW1F+8HPN
        FEYOS9u8fPR3Oq67+cfJl1DvDLVFJGc/Sp+L6OacUZWKBHAiKzRgOGvBJxkVOFS1WeVMRANW1oy
        P2A4KX48qEOM/Sa5T7c44SmbIY2IbmcldzM+yfoOIs9CG5rk/LnfcGFElwDFDZhHDdrT5iTTSW6
        VnukgEOA==
X-Received: by 2002:a05:6214:509b:b0:61b:2111:c2e2 with SMTP id kk27-20020a056214509b00b0061b2111c2e2mr11674452qvb.2.1685747161381;
        Fri, 02 Jun 2023 16:06:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7jREXzIBfJ2jGu2Th1XhPhOEnrLhoc+Gdd624qpUgrWRSHyWtIXLUeI1ddBAENoN0t4K9xNg==
X-Received: by 2002:a05:6214:509b:b0:61b:2111:c2e2 with SMTP id kk27-20020a056214509b00b0061b2111c2e2mr11674414qvb.2.1685747161031;
        Fri, 02 Jun 2023 16:06:01 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id px13-20020a056214050d00b0062607ea6d01sm1400792qvb.50.2023.06.02.16.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 16:06:00 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, peterx@redhat.com,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 2/4] mm/migrate: Unify and retry an unstable pmd when hit
Date:   Fri,  2 Jun 2023 19:05:50 -0400
Message-Id: <20230602230552.350731-3-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602230552.350731-1-peterx@redhat.com>
References: <20230602230552.350731-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's one pmd_bad() check, but should be better to use pmd_clear_bad()
which is part of pmd_trans_unstable().

And I assume that's not enough, because there can be race of thp insertion
when reaching pmd_bad(), so it can be !bad but a thp, then the walk is
illegal.

There's one case though where the function used pmd_trans_unstable() but
only for pmd split.  Merge them into one, and if it happens retry the whole
pmd.

Cc: Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/migrate_device.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d30c9de60b0d..6fc54c053c05 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -83,9 +83,6 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		if (is_huge_zero_page(page)) {
 			spin_unlock(ptl);
 			split_huge_pmd(vma, pmdp, addr);
-			if (pmd_trans_unstable(pmdp))
-				return migrate_vma_collect_skip(start, end,
-								walk);
 		} else {
 			int ret;
 
@@ -106,8 +103,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		}
 	}
 
-	if (unlikely(pmd_bad(*pmdp)))
-		return migrate_vma_collect_skip(start, end, walk);
+	if (unlikely(pmd_trans_unstable(pmdp))) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 	arch_enter_lazy_mmu_mode();
-- 
2.40.1

