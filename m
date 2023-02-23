Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3056A0140
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjBWCnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBWCnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:43:41 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0BE23667
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:43:40 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id e9so6207513plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RRSa5splVjb43STyERCx9WqlUztd7VM3FAvVjySaRc=;
        b=3UbItT/HFNE9ifMa9oVMNSFp0ZFUbjR2gN6C6MjOwe2Zuj4WGXBCqBrhnvviVy+Yiv
         qVKiE48Jr/53Wn/HP32d7T7JNfau2kM8/wKCROpM13MhS5j/KD4+a4NB+JXQi13RvsTu
         GIBNBm1bCQ6Mn4IPACpLkZi+GXviVqxx/Rm3YQdtcKVieIwCXsooWt9gXaAqR56Gx3V6
         qrBQbNzRmlJVG7r6mzRFWkBbOcLWt1LE3K0OKIH/QwDCKjgjotuCzPtRRMsG540Zw+nk
         UqUp2irn4MQlPQ/hs2NFGPOC6aCtcd0akCsIQaQNtfPo0R9uYP5FtM3SV2s+aGr+35Lu
         29mg==
X-Gm-Message-State: AO0yUKX89jynSqaudzibtRJiGYfUqm1LC/j1dGek3HCY6N3HT7R+SLzQ
        xrMxdNHSp+ytGqezhFxN8iY=
X-Google-Smtp-Source: AK7set8I3NBhaf91prdHzskrOHBW/DbdHgpSePrMBVWKWgirrHeCstQuH88WWE1bmmzjy00B8g5vSw==
X-Received: by 2002:a17:903:28c6:b0:19a:a43c:41b7 with SMTP id kv6-20020a17090328c600b0019aa43c41b7mr9454095plb.21.1677120220145;
        Wed, 22 Feb 2023 18:43:40 -0800 (PST)
Received: from localhost.localdomain (144.34.241.68.16clouds.com. [144.34.241.68])
        by smtp.gmail.com with ESMTPSA id je15-20020a170903264f00b00199025284b3sm12512760plb.151.2023.02.22.18.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 18:43:39 -0800 (PST)
From:   Ke Sun <sunke@kylinos.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ke Sun <sunke@kylinos.cn>
Subject: [RESEND PATCH RFC] mm: pagemap: add vma(VM_PFNMAP) support in pagemap_pte_hole()
Date:   Thu, 23 Feb 2023 10:43:32 +0800
Message-Id: <20230223024332.1337578-1-sunke@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pagemap currently does not support vma(FIXMAP), add support
in pagemap_pte_hole().

Signed-off-by: Ke Sun <sunke@kylinos.cn>
---
 fs/proc/task_mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index af1c49ae11b1..297c7b9dc630 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1400,6 +1400,11 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
 		if (vma->vm_flags & VM_SOFTDIRTY)
 			pme = make_pme(0, PM_SOFT_DIRTY);
 		for (; addr < min(end, vma->vm_end); addr += PAGE_SIZE) {
+			if ((vma->vm_flags & VM_PFNMAP) && vma->vm_pgoff) {
+				unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+
+				pme = make_pme(vma->vm_pgoff + pgoff, PM_PRESENT);
+			}
 			err = add_to_pagemap(addr, &pme, pm);
 			if (err)
 				goto out;
-- 
2.25.1

