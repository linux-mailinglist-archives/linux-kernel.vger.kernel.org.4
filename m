Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1888F65EA5B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjAEMEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjAEMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:04:37 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048D358D3E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:04:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso1120194wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HsXFSE5iuKwcFVE4uqAdahcBtbjYOXocUo7GZr/5XYM=;
        b=Y4WKlkMXpKB95jYUM7a2KbvSpv40y7L8ji+ExPAp3xgNswgaDKQZHOhnN32CzsZ40C
         q2lmkk5XAMq2HuzftvxiWFM4JPi/tCuFYS0ofvaGsiSvXX7hw8tO9bkrdd+gW7/9u5P0
         Y8hwTMxw/f/oH9fJokaMl5sauhKhksNXnqUxF6g6VsBgwUW81kO9SDExsESrqafqd6kB
         9vsj9vCl+JSjZ5PN7ycwgFCb9cCjV5TlTsN7zV8lTGz6JJW6o/H3VURkSwNAtluazo0m
         /CvPsCGT2u+WP7IUtCZ3Gs+i8L+88SQnurPui3Hm3BWoT+1WBLtuCn0BsyQFM5mpuy9g
         LtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsXFSE5iuKwcFVE4uqAdahcBtbjYOXocUo7GZr/5XYM=;
        b=lsuPz/FN2RM/alJ+myGT2PCGZN4sEJ81I1GU3fktxTiBgd5cDzLmIVTTnBvOpydZcA
         7re2oXylwdPV10n5NXRv2K+e+roGQF05q3johM9HhYNZqUeoiCJjqIhGbYInzwaN3H0r
         e2vWvzA4qdh44hw5iI4rflCGNRtifehFxKKVy1/Z3TH0o+3bewfdX/vPhQHvTvjBIkRJ
         eGuVkKoGKa4uBu9J6Tgx/le8cSx5m/nI7CDVoDPzpBd+ZP9oqQJf+f3YM+igrxMNZwb8
         DTFSR5/Zg+IpsRym2HUku6Ar+xsnstjanKNTYhdXbNkGcRnu+0uYlblLf1ij0hfmi4q/
         PXMQ==
X-Gm-Message-State: AFqh2ko6xQGEZ63j0/zPjOy0xEVf9g3G4CkTj29KKNpBmNoBI7vAx8JR
        xS39mzCYtDyjWkhAQdZrh0k=
X-Google-Smtp-Source: AMrXdXs3OPBu+GaIEgHEOC5Hl6HchU5paceNupPm5BaJdfMkFe/phu4WcT1P82cdlyzSFfKXPGPcGg==
X-Received: by 2002:a05:600c:13ca:b0:3d3:4427:dfbf with SMTP id e10-20020a05600c13ca00b003d34427dfbfmr35457387wmg.5.1672920272413;
        Thu, 05 Jan 2023 04:04:32 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id z25-20020a1c4c19000000b003d1e1f421bfsm2196388wmf.10.2023.01.05.04.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:04:31 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] mm: Remove an ambiguous sentence from kmap_local_folio() kdocs
Date:   Thu,  5 Jan 2023 13:04:24 +0100
Message-Id: <20230105120424.30055-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
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

In the kdocs of kmap_local_folio() there is a an ambiguous sentence
which suggests to use this API "only when really necessary".

On the contrary, since kmap() and kmap_atomic() are deprecated, both
kmap_local_folio(), as well as kmap_local_page(), must be preferred
to the previous ones.

Therefore, remove the above-mentioned sentence exactly how it has
previously been done for the kmap_local_page() kdocs in
commit 72f1c55adf70 ("highmem: delete a sentence from kmap_local_page() kdocs").

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 44242268f53b..7b0085a61e67 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -120,8 +120,7 @@ static inline void *kmap_local_page(struct page *page);
  * temporarily mapped.
  *
  * While it is significantly faster than kmap() for the higmem case it
- * comes with restrictions about the pointer validity. Only use when really
- * necessary.
+ * comes with restrictions about the pointer validity.
  *
  * On HIGHMEM enabled systems mapping a highmem page has the side effect of
  * disabling migration in order to keep the virtual address stable across
-- 
2.39.0

