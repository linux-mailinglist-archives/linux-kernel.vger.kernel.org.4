Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831945EF438
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiI2LXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiI2LXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:23:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A781401A1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:23:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r8-20020a17090a560800b00205eaaba073so1034898pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xxtjUzETZH9DEkady7grPZMHSOc1w1fLwuVdzuJOa7k=;
        b=F0vnTbakLMMLXNr4+EoGBwJ7euaiMM3zQ1iPMnIFzbzTDT+UedxfCF+nzZ8Pu1dxgo
         jFnRRQ87mG9ETqHrCRPJ8tYtFphSYYI02spSlat9EK0B813gSaIgau9lC8HO2TnfioyA
         U5z6aLF8grpUiBTUr+XtFfpPaJYP9p4wA8DQKcjo3sr2dGe0NeM6Fxc/VWkqDOtlnnzg
         pSkuwm2hb2k8o1a08Un+gZ94hmONuRKnxJltHdPaQsfHBaJZptn+qowTGYNvF6D/Q9Zt
         8uDtYYjW2vdcVCbGIPWPG9Hu3SNsD27KC0RvbFFKymk5xhXut/fT0TtX9i9M5v8aewJA
         XeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xxtjUzETZH9DEkady7grPZMHSOc1w1fLwuVdzuJOa7k=;
        b=n+inEAZAcdkhUOEoYhXpwpUm14J3sjPR95tFNYEZmwh9Pl91EOC0wfYYuttGF6xOJ6
         G7dYfZeCqLGSPSQwD6/B7+95UorxTDmoaEBMu2FelTOkN+UYdmdUhWzRZWx0C9owYZ2I
         bS8AVaSeFwjl4cMBWz0UvXvae53fnexhRXykFSIzqlq424068b63TgOWsljR0dZ9HmHN
         cDu5oLWuCnzgAkWgig3PpJQx1XREr0z/k0R3lerkrl/oXdOvgCqvZWfl4DECuKIlP3zH
         T61JAZm4cNVqX45EuRsL78fsT1XA5gHniV032XTz2/9FJb4ROefXIBlqfpz9Si9Y48bh
         ziqw==
X-Gm-Message-State: ACrzQf2vD4zBBxDUMLjK3I+FVuuLT6WvRVj5a0+2AR2KsJutACCVreMA
        qhRPf6WoBnkKUVjKx06rdK/ceQ==
X-Google-Smtp-Source: AMsMyM53p08RePYQc/tpM4G6W0IClpl/1lZvEDpnTKE1I+fFxmkZIodX6//T3hVBYwLf82XMjWa5Lw==
X-Received: by 2002:a17:90b:180e:b0:202:e725:19e2 with SMTP id lw14-20020a17090b180e00b00202e72519e2mr15923391pjb.163.1664450613800;
        Thu, 29 Sep 2022 04:23:33 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id i8-20020a655b88000000b00434651f9a96sm5225401pgr.15.2022.09.29.04.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 04:23:33 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, maobibo@loongson.cn,
        chenhuacai@loongson.cn, songmuchun@bytedance.com, david@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, chris@zankel.net, jcmvbkbc@gmail.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 1/2] mm: use update_mmu_tlb() on the second thread
Date:   Thu, 29 Sep 2022 19:23:17 +0800
Message-Id: <20220929112318.32393-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220929112318.32393-1-zhengqi.arch@bytedance.com>
References: <20220929112318.32393-1-zhengqi.arch@bytedance.com>
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

