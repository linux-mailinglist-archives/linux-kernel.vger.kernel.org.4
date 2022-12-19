Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9F4651253
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiLSTA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiLSTAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:00:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A76585
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:59:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u5so10022956pjy.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XocXQJ8/KIfX9/nTT1Ghmvl4XAcC2jwtLySqVPgnO78=;
        b=gTdt6BQeQx60iQ2xEpVkG9N2cVTn02TqELcNPrH2DPQHOHfHgBH7nbVVm4lJ0If6bi
         u8KJrL4+epaHOp5Ca5289ihVcOtRR8nvfWgIYq4R4IUNs45HAdcXI2X0EmzFMGuLVQRm
         rYddyOZNUm6HMseaqPywQxKdvhG2PrAOir8HWF8OlQ3muwxqLRO1dpkL6Eof7Lc5DHsW
         nExx/9uTYg/ylbOa4u5j4XAy35yUDRjgsu1L3drtgnxRxc5xbLN9wgJjbTR5fPIq5k7h
         kjMeYKpySfSdX4ZrmK7ECOULbiV6BH1SAgg3unw12ilu4j/ouOJRVoSSO7S4krtdRzZV
         sWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XocXQJ8/KIfX9/nTT1Ghmvl4XAcC2jwtLySqVPgnO78=;
        b=D3GxN6IM1VWdCuz4lGvkOldxbz8aa8quQfkJQzlS3wuTfIRPn5WxPm/4abSSBXDTDy
         n1MG6HfTy2hn99bXzPxR7q2gsInjtgW/A2aPqZZ+aoOUL0BhV8/8NKNwcFlQ4SvNzOgv
         7Rz5DrDdQ667mMhLzb5U1gw6fVwL/r8naRKMlYi+Ari2CJsoBh09yZF2smcZT4nsflYX
         gyVEiylEk4/SlvLuC1sqL8zj+l2GA9STl75WwUB9zLEjqiHx/0m8yjvjGk1YlDg1Ir4J
         fHpCQIyb2E8MDsQb4Fj0tyY+Gesnr8lVmsHLsXi1oaUBq0On1p4ZJn1+ntVU060w+pFd
         9WPQ==
X-Gm-Message-State: ANoB5pmGsecc5B9HMYLbQp/rzY5pbzSxl+CjQCPyV8DAA4b+HNTkQB2G
        QgVejTy+Z3q/DPygWpo2hVI=
X-Google-Smtp-Source: AA0mqf5+mjYb7s7cWrqX58p+GXu392SobpICcwlH+tQQtjEkCkRadzwoFuctBrNg/jxllqNTLEPk4Q==
X-Received: by 2002:a17:902:8209:b0:189:851d:644c with SMTP id x9-20020a170902820900b00189851d644cmr40913337pln.40.1671476356452;
        Mon, 19 Dec 2022 10:59:16 -0800 (PST)
Received: from localhost.localdomain ([198.13.51.166])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00189847cd4acsm7480790pla.237.2022.12.19.10.59.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Dec 2022 10:59:15 -0800 (PST)
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
Subject: [PATCH v2 1/4] swapfile: get rid of volatile and avoid redundant read
Date:   Tue, 20 Dec 2022 02:58:37 +0800
Message-Id: <20221219185840.25441-2-ryncsn@gmail.com>
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

Convert a volatile variable to more readable READ_ONCE. And this
actually avoids the code from reading the variable twice redundantly
when it races.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/swapfile.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 908a529bca12..6d3f60bd383b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1835,13 +1835,13 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
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
@@ -1852,7 +1852,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		offset = swp_offset(entry);
 		pte_unmap(pte);
-		swap_map = &si->swap_map[offset];
 		folio = swap_cache_get_folio(entry, vma, addr);
 		if (!folio) {
 			struct page *page;
@@ -1869,8 +1868,10 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
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

