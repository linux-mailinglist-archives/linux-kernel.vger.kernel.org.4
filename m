Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F17643CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiLFFhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiLFFhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:37:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8797D23143
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 21:37:06 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so13707887pjd.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 21:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQZFshjqB4wtFOz2UdJmUUSt4cp78Rg6R2ZZnizTKMg=;
        b=l3HsB9xfeGFcIIP515/iK95rBFJKDGwlVkcARHwqen0mD40gKB/Yn7NQZyMWoudwjy
         8MRXlW5s5bDKsqGU9Cak0jPqZQ1Flu0kG88Ie3Dr+ZI4glRiK1WUm47/ROQ3fBT3/bHC
         ZkOVdc+qklLxFuW924h1qsdp+RifGP3HnFdyVA8jJuqcy4YKYM10nFRXI1bg23grsl0t
         YiShF0ICEgoV3CoKI0uxzWjbHUo/H5RdG7V2Pb6WYtAlfiwcP7rFaRQ0wbPU80WkrqW3
         5OQYyLRj36leTdvt//Wj+JsMmrCk8zUsjEioanMIoDiSDsFKZz6ksGO5kTInOYW0YD6+
         oWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQZFshjqB4wtFOz2UdJmUUSt4cp78Rg6R2ZZnizTKMg=;
        b=um2qDIfCfx+rsprT5Ka+U0D4mKfl87WsDUHezXCsJdhwJL7NnnuUweKgD5XMxNcrWf
         ZQCs6Pq3SuqK9z23x4ncOIwiWW6m+81Upvka3JiI/Vew2fIQfnuYwotUJqMzhr+f/nai
         npwQLnEI4ytDM7DyoT3QFT90ioWKYbJH/2EXrJx4l1qaacxHa0W2Uwe8Xun07kfNV8uB
         HD8rpYtoxw1PlnBVhjUsiHN3niP7uutgz0oKWkZnTALNusjz3C4QgVb0ef7fXepACrZM
         CcHhW+f0CmCqpRmgBTMzU9aJivX9jBJ49Ve79z7LW3uB9+ctzZVjXifDO/Lzw5O2iaKr
         JdhQ==
X-Gm-Message-State: ANoB5pn3P1tLG4COJA6ysasbFu++yPguXEo2jwIpaPQ2gEo3qudk85o/
        jsb84riE5OwNApOa3No4b7nEL190GHY=
X-Google-Smtp-Source: AA0mqf6xgrbNZcgk5sPZ4G06UTfOQd8rQ6ESvJb75FR6JtpK6sjL9G648ZUupvwyCnMBanTZOI1+pQ==
X-Received: by 2002:a17:902:e311:b0:189:c7f1:c2a1 with SMTP id q17-20020a170902e31100b00189c7f1c2a1mr13885211plc.141.1670305026035;
        Mon, 05 Dec 2022 21:37:06 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id nk13-20020a17090b194d00b00219feae9486sm357964pjb.7.2022.12.05.21.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 21:37:05 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
Subject: [PATCH] erofs: fix missing continue for !shouldalloc in z_erofs_bind_cache()
Date:   Tue,  6 Dec 2022 13:36:33 +0800
Message-Id: <20221206053633.4251-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

Do cmpxchg_relaxed() is only for successful allocation if I/O is needed.

Fixes: 69b511baa0be ("erofs: clean up cached I/O strategies")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2584a62c9d28..b66c16473273 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -333,19 +333,19 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 		} else {
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
-			if (shouldalloc) {
-				/*
-				 * try to use cached I/O if page allocation
-				 * succeeds or fallback to in-place I/O instead
-				 * to avoid any direct reclaim.
-				 */
-				newpage = erofs_allocpage(pagepool, gfp);
-				if (!newpage)
-					continue;
-				set_page_private(newpage,
-						 Z_EROFS_PREALLOCATED_PAGE);
-				t = tag_compressed_page_justfound(newpage);
-			}
+			if (!shouldalloc)
+				continue;
+
+			/*
+			 * try to use cached I/O if page allocation
+			 * succeeds or fallback to in-place I/O instead
+			 * to avoid any direct reclaim.
+			 */
+			newpage = erofs_allocpage(pagepool, gfp);
+			if (!newpage)
+				continue;
+			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
+			t = tag_compressed_page_justfound(newpage);
 		}
 
 		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL,
-- 
2.17.1

