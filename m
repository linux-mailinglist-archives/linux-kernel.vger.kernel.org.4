Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3FB647542
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLHSDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiLHSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:03:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D0D5BD60
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:03:16 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o12so2306871pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 10:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E96Wm/nE/BO1oqx7KrRbQksoP0SM8QfWpUYCtfF7ZOY=;
        b=elKCQdyBJ0zfJyNZL9MWCMZLH4HbJp0sc16DHkwY2E5BuxBXc6+kjPqmOH0MEON8c+
         x1q8YZAV5N61RQT/m3OutBjmiEN7IieOIDAJHd/hq9flNutIgFBfrmAvkwCHiWZpU968
         l3IuT9uaAPkuHG77zs7QLsSUC6ld+XhS8pJMfNyXq93eNDv1gMb8XaRWqLbPCQg4FLds
         Zw5LVsx1I3Bf87bQVz8e4Azxrug7PBuZkoHYH/SIAcF3bH6ttLQh+TrjPhbCygJXcrfP
         dhI88Wq2hZmQ5pkdV4izpmRYDsPTRa9HKcydpMuA1M6ve9u4TicYtF5kp0e90xqzNGBJ
         sKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E96Wm/nE/BO1oqx7KrRbQksoP0SM8QfWpUYCtfF7ZOY=;
        b=4w8ywLpr/2ueM0D5+aEjz0b4IF03Y2zZ3ofn/dDlUpb5x1JiUyQHliVmlynL7GRONq
         GFuRvYC2zlp+8IRnksjUOzgl0FhzSYNEW8jbQT/zfAc4GpNdLDocHXFLZYH2x2RQJ6gG
         YKe07sATnwSo2xLYug9D1QHtI8gPRf6V3pr7NCdrii3pd8dunhM3KTEwItVtobHWPwOj
         aNsTeEhkXxwXv7WV3arupWlm0bj+ir/pwDkfOlONDyjKk+sBiepw8lXv/6ZPvW/w8YNB
         fxvgsh7Ccwnv7RNalfDSWwMNu+XfFvGYPQQdlRpJ3E03BNqi7eLNs/+SkiOvrqLZ5keV
         izzw==
X-Gm-Message-State: ANoB5pmOKyGH2sf0GlR8NjCjW3NuTYAe83iqkT5vPJV0Bt7qAjC+g7zn
        0WSCQG8vxNSM0U/ZPyzR7lw=
X-Google-Smtp-Source: AA0mqf4pM+kGOAZ0I0/E4epPe+dakTrALDjT5h+cTK/rmfAO6gWi5Nw7yw9MBJ7OdK2iYJAqFCaERA==
X-Received: by 2002:a17:902:d58a:b0:189:a11e:9995 with SMTP id k10-20020a170902d58a00b00189a11e9995mr3153672plh.13.1670522595747;
        Thu, 08 Dec 2022 10:03:15 -0800 (PST)
Received: from localhost.localdomain ([198.13.51.166])
        by smtp.gmail.com with ESMTPSA id x23-20020a63db57000000b004785e505bcdsm13377909pgi.51.2022.12.08.10.03.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Dec 2022 10:03:15 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 1/5] swapfile: get rid of volatile and avoid redundant read
Date:   Fri,  9 Dec 2022 02:02:05 +0800
Message-Id: <20221208180209.50845-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221208180209.50845-1-ryncsn@gmail.com>
References: <20221208180209.50845-1-ryncsn@gmail.com>
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

Convert a volatile variable to more readable READ_ONCE. And this
actually avoids the code from reading the variable twice redundantly
when it races.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 72e481aacd5d..ff4f3cb85232 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1836,13 +1836,13 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	pte_t *pte;
 	struct swap_info_struct *si;
 	int ret = 0;
-	volatile unsigned char *swap_map;
 
 	si = swap_info[type];
 	pte = pte_offset_map(pmd, addr);
 	do {
 		struct folio *folio;
 		unsigned long offset;
+		unsigned char swp_count;
 
 		if (!is_swap_pte(*pte))
 			continue;
@@ -1853,7 +1853,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		offset = swp_offset(entry);
 		pte_unmap(pte);
-		swap_map = &si->swap_map[offset];
 		folio = swap_cache_get_folio(entry, vma, addr);
 		if (!folio) {
 			struct page *page;
@@ -1870,8 +1869,10 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				folio = page_folio(page);
 		}
 		if (!folio) {
-			if (*swap_map == 0 || *swap_map == SWAP_MAP_BAD)
+			swp_count = READ_ONCE(si->swap_map[offset]);
+			if (swp_count == 0 || swp_count == SWAP_MAP_BAD)
 				goto try_next;
+
 			return -ENOMEM;
 		}
 
-- 
2.35.2

