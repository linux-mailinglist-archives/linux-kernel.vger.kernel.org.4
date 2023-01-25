Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77FE67C107
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbjAYXlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjAYXlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:41:47 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665F65FE1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b10so32100pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGNwUbDjmHky71GpbBmE9Nh0iBILc0cb1v5YBQZD5HQ=;
        b=mIXSbS3zx/wNtBmDxZy9pZVvSQJv/mHw4CtjWD65+3W9Nc24sZUEDDrNS8oORXHJiB
         CGLmGyovSMwnhhTJMVQUd2L8GZWQRYAR8SllfoLNKEh7wrEFC3j3GTPcpO6eGTt7IB6K
         lBtFoVj4NrI54l4nxgO5tQt5fd01MB+QIlXVuAOr/ab4O+2GR41LajuWCD6FMFuOkAbT
         foNteELlF+BDx6tehXHJkvTXF29r//7Ulc+DmZlFdhCsp3uvvGWYSsETbBZM2P3pBhTp
         ISJu5TQzkh/8DkQKSyiad0S01AG/Ia9PJmFtvYNhAgSLLO6dL8TA1pu24hsqMP5gFGpv
         Dniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGNwUbDjmHky71GpbBmE9Nh0iBILc0cb1v5YBQZD5HQ=;
        b=ZDP425oRvoBXKhJMiWjN/F4E9mvo8YiCeCTCfQ1qwCqVpJBv31xGwAJ//iHO79WgqD
         UDBuB+ZohynQgLd9D4yqw4dxcvxtGmrs4INExQSqFpMHCUpyBvAzWp4wxtDrdR8eJKVB
         V23xAGW/zJaqj9oESc3/TiYjUjTBHVBbhNJ26Gore5NC1ZS7rUDCtudIOTf2ybnxwoqa
         +SBzFcNjIcSWEWo8BSzYJ2BjKOkorotO43Ob7e6WP/hVdjn/QwPRkcSzuSqX/rmd52Ts
         8vCxJlQkcdMwko5GLSBNg46srHywuiDRGu+Ak26NdxGNNZZSMw9AT21QE75uifyxJ06r
         MQRg==
X-Gm-Message-State: AFqh2kqEMd9+eQMpxFMW7o+qM6qzeHblPAvI5GKl/L2Fka8OUwvwqOtj
        lMp83cGLeTJ5Mbc4FPx2uYg=
X-Google-Smtp-Source: AMrXdXv1TwX5bErJjQ9rOnQpq3s7ctcdlqui9fwxZ8JXfbnCm/ilrQAv8fF/p6GLVjSDREEOIxnLsQ==
X-Received: by 2002:a17:90b:1e4b:b0:229:ff05:691a with SMTP id pi11-20020a17090b1e4b00b00229ff05691amr23275110pjb.16.1674690105896;
        Wed, 25 Jan 2023 15:41:45 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id e8-20020a17090a630800b00219752c8ea5sm2226806pjj.37.2023.01.25.15.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 15:41:45 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v3 1/6] mm: Add folio_estimated_mapcount()
Date:   Wed, 25 Jan 2023 15:41:29 -0800
Message-Id: <20230125234134.227244-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230125234134.227244-1-vishal.moola@gmail.com>
References: <20230125234134.227244-1-vishal.moola@gmail.com>
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

folio_estimated_mapcount() takes in a folio and returns the precise
number of times the first subpage of the folio is mapped.

This function aims to provide an estimate for the mapcount of a subpage
within a folio. This is necessary for folio conversions where we care
about the mapcount of a subpage, but not necessarily the whole folio.

This is in contrast to folio_mapcount() which calculates the total
number of the times a folio and all its subpages are mapped.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c9db257f09b3..fdd5b77ac209 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1817,6 +1817,23 @@ static inline size_t folio_size(struct folio *folio)
 	return PAGE_SIZE << folio_order(folio);
 }
 
+/**
+ * folio_estimated_mapcount - Estimate a folio's per-page mapcount.
+ * @folio: The folio.
+ *
+ * folio_estimated_mapcount() aims to serve as a function to efficiently
+ * estimate the number of times each page in a folio is mapped.
+ * This may not be accurate for large folios. If you want exact mapcounts,
+ * look at page_mapcount() or folio_total_mapcount().
+ *
+ * Return: The precise mapcount of the first subpage, meant to estimate
+ * the precise mapcount of any subpage.
+ */
+static inline int folio_estimated_mapcount(struct folio *folio)
+{
+	return page_mapcount(folio_page(folio, 0));
+}
+
 #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
 static inline int arch_make_page_accessible(struct page *page)
 {
-- 
2.38.1

