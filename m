Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3C05EA768
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiIZNgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiIZNg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:36:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFA31E1CE2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:56:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so12133716pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=g8La9o/nNfleZYR5eX/LnvX4ayFeiZcwHVO0isJ+H6U=;
        b=653Z3bdEfFZWr6su4Ly2EQIg7sAvHMvxMW+IG/F+c2HogzXzCBn4Xe/Ac8eQeFhkjU
         Emw+pN+IbxpuUdYvoCsotI84upTXinNu3/QQ3h3JT/J4TOFATjMIftG9dxJEhYWYm4jw
         w6vMY/Alz7QsjbScSbPKy3JRodqTL3GcBky7/n6K9hSm7BmDKzmk1j3f+PTcPYw1pize
         sPXoAYa5B9/n95NwXUgyooPcpxaVLZt+VTEgH5XSNe3u0xoLLLRSZQDivonRUpkcCV1P
         gxDVWPklnjYq23SAH3RiiyDv1x3BkUA4vqp3D1rvKUnqEVmZhnISAsfxgQrct49vSiiw
         DDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=g8La9o/nNfleZYR5eX/LnvX4ayFeiZcwHVO0isJ+H6U=;
        b=3cOysh1JD6nR9ZND3NUtZYV/RcA/h2Ql7d8fSAkMDpx5lsB6w18G8MMXAgRLKEIPcQ
         8sPfQf5omF07TcGBJX0LFucHVpd6A+Y4B/LtdMYH+8TIrphDF4XkNafjpdBJA6CouWZV
         RQbPxoW6lKQFvFAzuyahHn5w/iUEByMyfmXgPBHLEJg/Ao+AksRqwRe3Y/gkxaw4IOMx
         UrfrenX7ApHK9CrgiqegOyfq8k//PQcXg2QGNrLpwvr9w161anJtu2i4ISp5+CFSMuKL
         FJK8g7ZULyty0ee63cx2yDIQx4SpeVEDsqca03d7W0l5AN8uw9UPvvm7Ev0SQ3HYrcZv
         WjAg==
X-Gm-Message-State: ACrzQf3dY/xej2Zd8v7NdKQoJ0TSEqzG2PnKroCgDutgfZuHwm01OC6l
        ujlW71tC3C/moY5neIEZryBX334bDJntjw==
X-Google-Smtp-Source: AMsMyM4ejO3jvfuH7QursZdDdLIy877QhdZW4S/PDlLZkDWt08ZGYbD0N8Mry4T6PJ7Hw7YVH4g0vA==
X-Received: by 2002:a17:90b:3510:b0:202:f18c:fdb6 with SMTP id ls16-20020a17090b351000b00202f18cfdb6mr24321795pjb.122.1664193391562;
        Mon, 26 Sep 2022 04:56:31 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id 128-20020a620586000000b0053ea3d2ecd6sm12157057pff.94.2022.09.26.04.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 04:56:30 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com
Cc:     chris@zankel.net, jcmvbkbc@gmail.com, maobibo@loongson.cn,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: use update_mmu_tlb() on the second thread
Date:   Mon, 26 Sep 2022 19:56:21 +0800
Message-Id: <20220926115621.13849-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As message in commit 7df676974359 ("mm/memory.c: Update local TLB
if PTE entry exists") said, we should update local TLB only on the
second thread. So in the do_anonymous_page() here, we should use
update_mmu_tlb() instead of update_mmu_cache() on the second thread.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
v1: https://lore.kernel.org/lkml/20220924053239.91661-1-zhengqi.arch@bytedance.com/

Changelog in v1 -> v2:
 - change the subject and commit message (David)

 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 118e5f023597..9e11c783ba0e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4122,7 +4122,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
 	if (!pte_none(*vmf->pte)) {
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		goto release;
 	}
 
-- 
2.20.1

