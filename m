Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2144B5EF43A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiI2LXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiI2LXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:23:40 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081F014A79D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:23:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d24so995033pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JV29A8S7H9nk8Y3ndCLgLNPfcLB/Fva66Tots67JJ10=;
        b=WZaIjGyMqadKRxBxDIX3xg5seZAzi2+eG7ff8NVX4HSQpWLaw7qaTpLYv/YzsmJZ78
         0NnMOP48NS2eZC/w3a+/Kp++v4n9iZh0e+KrLtb4TdUstzr1aoK25e4/VGuLE8P7JdzK
         1suBosGhTDhXAu4NhobZ89FaAuUVv/HxBFU66GPu6JRmMUWn9U5w/bmIC6Pd0IdxLIUz
         WBDvOvS4A2HpiV0Fh5DMIyi01dV9qwRu46qIq0FpWgrvfDltU6lBc1xSpgDbXd5Ebooa
         QbTwdU6ICfpqp0gtUx3HBoUF5EFzn3XbeDnFZSckv5p6dpnSL2Qn0DDszzZ1qcEtHrD+
         m7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JV29A8S7H9nk8Y3ndCLgLNPfcLB/Fva66Tots67JJ10=;
        b=nRYq3J/ScvIQyL7KU6KvdQHE9ST4VHL5HV1eeM5oQ3F/2GaTABhUFUvmrZ5eFq4n2M
         qMMdDzo8GRdmN4FWyGKgnCqyKKuKvl+at2LPxz8LzAkwGWkETIi06IOJaPc8WAIroacY
         2ZhvrghNWiYWkQoV2vdAeEEQeP1sWWzS6qqFjtsr3AXWWDH3f2aTQiPSv3Byw/m4T4UF
         pdSwDv9j5tObXvtrdmJylaxgH2uOtaVjbyq+670SutKjSmWNd+Uia8CAqBqT3v8ICs3X
         37Dw2MHh2gI/oFRhAwkwCJIlB9TEedTesmh9AwOU6svCuiJFwTy/66WYGWO9p/SqYChD
         1+jQ==
X-Gm-Message-State: ACrzQf02jGJLsiU+zKx0Maw7hZeoolfrKlshumlBs5t3ASzaX3o9e9HI
        Y+QOkltulpB7LXbtbdhIqlGi6A==
X-Google-Smtp-Source: AMsMyM4p8HFIjEO65m+ZzDQ2AJS0niFAGYsHTpyebBpnN8u0Uaq8ynnczc/Wl9uJ3y/8nm7ojyMTdQ==
X-Received: by 2002:a17:902:efc2:b0:179:fe90:55d3 with SMTP id ja2-20020a170902efc200b00179fe9055d3mr3032982plb.116.1664450618598;
        Thu, 29 Sep 2022 04:23:38 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id i8-20020a655b88000000b00434651f9a96sm5225401pgr.15.2022.09.29.04.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 04:23:38 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, maobibo@loongson.cn,
        chenhuacai@loongson.cn, songmuchun@bytedance.com, david@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, chris@zankel.net, jcmvbkbc@gmail.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 2/2] LoongArch: update local TLB if PTE entry exists
Date:   Thu, 29 Sep 2022 19:23:18 +0800
Message-Id: <20220929112318.32393-3-zhengqi.arch@bytedance.com>
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

Currently, the implementation of update_mmu_tlb() is empty if
__HAVE_ARCH_UPDATE_MMU_TLB is not defined. Then if two threads
concurrently fault at the same page, the second thread that did
not win the race will give up and do nothing. In the LoongArch
architecture, this second thread will trigger another fault,
and only updates its local TLB.

Instead of triggering another fault, it's better to implement
update_mmu_tlb() to directly update the local TLB of the second
thread. Just do it.

Suggested-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/loongarch/include/asm/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 8ea57e2f0e04..946704bee599 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -412,6 +412,9 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 	__update_tlb(vma, address, ptep);
 }
 
+#define __HAVE_ARCH_UPDATE_MMU_TLB
+#define update_mmu_tlb	update_mmu_cache
+
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 			unsigned long address, pmd_t *pmdp)
 {
-- 
2.20.1

