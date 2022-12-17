Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9064F603
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiLQAXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiLQAW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:22:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E847CFFC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:16:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso2870400wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hOSZ9XvCZ0lVh7H3bPZKfFn1zZw42pxRgq17+nafB0=;
        b=Wd10C8F53VhKbkG4Y7lnFbK5RrR4ZEDvp1wRJElm/qesZY565MvnlIQ/egFl21fmCo
         K2yy/r6aSfJy4AXMIy6MTE93LoxqGYLOKcKoPvyxtBzJMLFfxpaZc2drzNAA7IRYOmRn
         HvPnSy7KLIzzqi4kKTnkKZONJyV0OWJx39ulMmacF/UP2rwnRXeAiaEqookxIS0iaPdr
         qNN3g6aYuk2yU2M0zOPc9GL5fEO7hg3nuw7O3nJuIz7Igxug5U6x2USBogjW52Qu+09y
         HNPC/ZQCQ25vG1CCr5BeQ5eTwzd8ICslP/bHCIWxMejH77/wZ/EULa5MRrL84t1FumVf
         LEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hOSZ9XvCZ0lVh7H3bPZKfFn1zZw42pxRgq17+nafB0=;
        b=gCDSKPNogSo5E0w5oqrSCtl3vlWiEWnkddoW92Jihc0/0uv+MNu71HEFuDI3doR+5j
         qPF0TjcRqc3fYlUPn7CQ417MVpZ/o1oFv7SyHQCUdlX+jQvHl9ty10YD0DGcsNn23n7Z
         HMrn/WWNdwFF6lFGQrAnhp8tJ7JpthI0srBOb64uPGc8AGhvbY61jVCBhcugMhB6Y5Qi
         tOZGCv48vxZVx8i3a1d5ad58WzEuc9mfVqZOAcAf/GfxKu/qxWHwC4RYrVT9YBxXZH5Y
         hfBG06pafA//+6L3z8LpTlF3aVGu8OEZ9dzigsMKk8D4tUaz+yT7Gl0qevfAkOtfu0lG
         +ECw==
X-Gm-Message-State: ANoB5plzOhahBqHZIzGERC0XodDMQUTxVCNogj+KOZq/f43eg8sgyStZ
        ZWfaT+LmX/r+x8dDKCFHhMs=
X-Google-Smtp-Source: AA0mqf4kILSJrFTdGHsPiCzjToEYxg/rLjBvuo4fPqokYKY9NrLy0YSCAxLGRc6cZkLuKtpU8pgD4w==
X-Received: by 2002:a05:600c:a11:b0:3d2:2a74:3a90 with SMTP id z17-20020a05600c0a1100b003d22a743a90mr16109466wmp.22.1671236179867;
        Fri, 16 Dec 2022 16:16:19 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id o3-20020a05600c510300b003cfa3a12660sm20866497wms.1.2022.12.16.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 16:16:19 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm: remove unused alloc_pages_bulk_list()
Date:   Sat, 17 Dec 2022 00:15:54 +0000
Message-Id: <20221217001554.554913-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.38.1
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

This function is not referenced anywhere else in the kernel, remove it.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/gfp.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 65a78773dcca..67c5164f4758 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -188,13 +188,6 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 				unsigned long nr_pages,
 				struct page **page_array);
 
-/* Bulk allocate order-0 pages */
-static inline unsigned long
-alloc_pages_bulk_list(gfp_t gfp, unsigned long nr_pages, struct list_head *list)
-{
-	return __alloc_pages_bulk(gfp, numa_mem_id(), NULL, nr_pages, list, NULL);
-}
-
 static inline unsigned long
 alloc_pages_bulk_array(gfp_t gfp, unsigned long nr_pages, struct page **page_array)
 {
-- 
2.38.1

