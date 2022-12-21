Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA496535E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiLUSKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLUSKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:10:00 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD7252B1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:09:59 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v23so11292865pju.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PmJb6CIEqNY6rS2poozpptUa/GTiPJRR/qxOS9Vnc0=;
        b=nkDePdtCIPB0JT+k15LKJQpvT/NCX++WS8dNEXwSceLOrvzJbV5KnFSi/Q69IbR9m3
         pz0bbEASdkL5ZdY4gNIep4yTOxDqQn+6P2mNirIanQro8qY4+EtQs7/dTqDX5lFIhZ/n
         TAj3GOz59idRv9VjUz6+R5EikvGTM60+tFyZa7Efn6m94pwClx9r/IkHOqsvbxOBTehN
         2j8mpE/fJEO71UEk6LCm68MCU5C3Szk13jN/lj+xzg73aRLX4FQNK8M1K67QCFEsH8Ww
         rfmAhg4rTRNPdQSkZ0GXgSLs9nXLKoZKuvw6ULiCzpmc618r3bMtR9tPRASbUks1tuQx
         uUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PmJb6CIEqNY6rS2poozpptUa/GTiPJRR/qxOS9Vnc0=;
        b=Zgzd3TMrTGAC1csYLjRziBZ7Ti0Y4Hv2AR3gioiRasaxyo8B+ZSDa1WApqd/WupfTz
         UD+6aAi/8SQCBuGJSDzPrxgSxwAQoY9uGMfCygYj4s1DGQ2cD+tiEU6tHWNwUQLbDOwa
         HlpRnkOCuaDbgxbAGTb3b4h2EuG2CZszQzP6LKLEC4VQUu6Ii/0c0Bdcs5+48K60Sj9A
         0ZmboYM4NUCs9ns/e4VIxaf+VJ5RA7b9RG1/aD2uwk7Eirp26PLeIvHYDWpoSRHGaJRP
         U5ZNHPwoydZQe2zmuwNk20kXFZAQSDNb6uMNFFOeR4IDOj93cuTM/bAgJpk+RvsK46Oa
         kq5w==
X-Gm-Message-State: AFqh2kpT9TMTRkK+XGsqGdUrOvIxfz/nUzjXo5kgBUy4k8wFuSpsWKyP
        7EdcOgCYGswjvC6Zla6G+iU=
X-Google-Smtp-Source: AMrXdXtca0fMprEg2pyoicfMqzT5In5Towl3radcXSD/IZnbSgXS2K9Z4XEmJtw7RR7DJxDDggCraQ==
X-Received: by 2002:a17:90a:fd09:b0:219:c40:e3c with SMTP id cv9-20020a17090afd0900b002190c400e3cmr2632387pjb.33.1671646198887;
        Wed, 21 Dec 2022 10:09:58 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id e26-20020a63745a000000b00477bfac06b7sm10110732pgn.34.2022.12.21.10.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 10:09:58 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org, willy@infradead.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 1/4] mm/memory: Add vm_normal_folio()
Date:   Wed, 21 Dec 2022 10:08:45 -0800
Message-Id: <20221221180848.20774-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221180848.20774-1-vishal.moola@gmail.com>
References: <20221221180848.20774-1-vishal.moola@gmail.com>
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

Introduce a wrapper function called vm_normal_folio(). This function
calls vm_normal_page() and returns the folio of the page found, or null
if no page is found.

This function allows callers to get a folio from a pte, which will
eventually allow them to completely replace their struct page variables
with struct folio instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ff46dcab2004..d29bfae4b71f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1968,6 +1968,8 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct ucounts *);
 extern void user_shm_unlock(size_t, struct ucounts *);
 
+struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
+			     pte_t pte);
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 37d1763c4d47..4000e9f017e0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -625,6 +625,16 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 	return pfn_to_page(pfn);
 }
 
+struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
+			    pte_t pte)
+{
+	struct page *page = vm_normal_page(vma, addr, pte);
+
+	if (page)
+		return page_folio(page);
+	return NULL;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd)
-- 
2.38.1

