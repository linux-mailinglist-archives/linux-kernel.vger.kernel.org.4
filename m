Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9AF651254
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiLSTAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiLSTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:00:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466DB25FA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:59:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v23so4802423pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e8B2I+4NRvgsSq6ExVIS5zUbrcMf1l4UJ5x1/qJc8cA=;
        b=eDZyM7UOpN208tVAX+hBqxHyra/S+kQPzV2RhHjUpgkC9oo2h5Ktaz/fro6c2oe/PI
         AiE0zgUos7a8I423N7mG0KgJrZbDbZjAuWEzhLGcsc4EetSbBy1aMp8FeQIqHi1Hqxqn
         /mMWiYwsa4h1ySc2e1WYwy1U8XSH06HeDaI3chHznqgvFcCkUMVwJdUKuQPt2Pb1uiRc
         ZcO5tNFbF1z+vFDCInDRnW/UpVs4kNmOWUagDrXtr1sYk7b4I6IGW+5X49eK1ICfP6Yc
         2Nt0p3JG5RSnqmvBmQNcIgP82uZ3RVr5b1D+Vl9i1cIFY/GPycw8aNT5PXlUOLbbE1in
         hFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8B2I+4NRvgsSq6ExVIS5zUbrcMf1l4UJ5x1/qJc8cA=;
        b=Wk9xIU57GBjKJySnb8BqoiWIVD9vksdYkSwP4E3Y55ErakUugSTo1BTARpXCD3WWRt
         ZYLVwYnHIIEU9KxfUTEssKw79I0HVMsjaU82yoawPUaz5+En87oS0E6pL87aA0nDMW5Y
         LvD1FgMQDbQ9Sd3rrU0+XFgHN/keAisJhlvOAjBQPkLLVuUpm7ojpkZ6FAx7aXgYVeMJ
         fbBjb5y4Soi+P/sugrBNVvz/qO/4vnTAJGKf+G4z6TMUjdj9o8/vG7VXRugCQ4NfAwUz
         umoZliCZdUVntL7S7qg1qee15vDsrMP0vx6rBSCQZkmGiWqrcRtQuH59oJwREfG1u7li
         /ZQg==
X-Gm-Message-State: ANoB5plG1PQdsWTgfoEhiNFy6D+8y7okP5jFBD19WsvEMc6roFNNxfQp
        s+dS0IiIsAAvednt++pSu7E=
X-Google-Smtp-Source: AA0mqf5haLYTtDDLTVNr5GE8KrQCnl2ZPXRQYj++5TqGjcUqyeaN1eo2aDvP3ExoJcIc66C/EvYGTg==
X-Received: by 2002:a17:903:2448:b0:189:f277:3830 with SMTP id l8-20020a170903244800b00189f2773830mr65253828pls.68.1671476368808;
        Mon, 19 Dec 2022 10:59:28 -0800 (PST)
Received: from localhost.localdomain ([198.13.51.166])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00189847cd4acsm7480790pla.237.2022.12.19.10.59.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Dec 2022 10:59:28 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 3/4] swap: fold swap_ra_clamp_pfn into swap_ra_info
Date:   Tue, 20 Dec 2022 02:58:39 +0800
Message-Id: <20221219185840.25441-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221219185840.25441-1-ryncsn@gmail.com>
References: <20221219185840.25441-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

This make the code cleaner. This helper is made of only two line of
self explanational code and not reused anywhere else.

And this actually make the compiled object smaller by a bit.

bloat-o-meter results on x86_64 of mm/swap_state.o:

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-35 (-35)
Function                                     old     new   delta
swap_ra_info.constprop                       512     477     -35
Total: Before=8388, After=8353, chg -0.42%

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/swap_state.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index af8bc123b7c4..d8d171195a3a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -693,28 +693,15 @@ void exit_swap_address_space(unsigned int type)
 	swapper_spaces[type] = NULL;
 }
 
-static inline void swap_ra_clamp_pfn(struct vm_area_struct *vma,
-				     unsigned long faddr,
-				     unsigned long lpfn,
-				     unsigned long rpfn,
-				     unsigned long *start,
-				     unsigned long *end)
-{
-	*start = max3(lpfn, PFN_DOWN(vma->vm_start),
-		      PFN_DOWN(faddr & PMD_MASK));
-	*end = min3(rpfn, PFN_DOWN(vma->vm_end),
-		    PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
-}
-
 static void swap_ra_info(struct vm_fault *vmf,
-			struct vma_swap_readahead *ra_info)
+			 struct vma_swap_readahead *ra_info)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long ra_val;
-	unsigned long faddr, pfn, fpfn;
+	unsigned long faddr, pfn, fpfn, lpfn, rpfn;
 	unsigned long start, end;
 	pte_t *pte, *orig_pte;
-	unsigned int max_win, hits, prev_win, win, left;
+	unsigned int max_win, hits, prev_win, win;
 #ifndef CONFIG_64BIT
 	pte_t *tpte;
 #endif
@@ -742,16 +729,23 @@ static void swap_ra_info(struct vm_fault *vmf,
 
 	/* Copy the PTEs because the page table may be unmapped */
 	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
-	if (fpfn == pfn + 1)
-		swap_ra_clamp_pfn(vma, faddr, fpfn, fpfn + win, &start, &end);
-	else if (pfn == fpfn + 1)
-		swap_ra_clamp_pfn(vma, faddr, fpfn - win + 1, fpfn + 1,
-				  &start, &end);
-	else {
-		left = (win - 1) / 2;
-		swap_ra_clamp_pfn(vma, faddr, fpfn - left, fpfn + win - left,
-				  &start, &end);
+	if (fpfn == pfn + 1) {
+		lpfn = fpfn;
+		rpfn = fpfn + win;
+	} else if (pfn == fpfn + 1) {
+		lpfn = fpfn - win + 1;
+		rpfn = fpfn + 1;
+	} else {
+		unsigned int left = (win - 1) / 2;
+
+		lpfn = fpfn - left;
+		rpfn = fpfn + win - left;
 	}
+	start = max3(lpfn, PFN_DOWN(vma->vm_start),
+		     PFN_DOWN(faddr & PMD_MASK));
+	end = min3(rpfn, PFN_DOWN(vma->vm_end),
+		   PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
+
 	ra_info->nr_pte = end - start;
 	ra_info->offset = fpfn - start;
 	pte -= ra_info->offset;
-- 
2.35.2

