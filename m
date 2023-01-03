Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADA565C6E1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbjACTDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbjACTDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:03:06 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F95A13D2B;
        Tue,  3 Jan 2023 11:03:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso14057298wmq.1;
        Tue, 03 Jan 2023 11:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAiqidS71pJ1PpHC3qaeiwc7XXSwdkyY1rJdxC3sdNo=;
        b=OcUJGFAXnpz0EkpWWzeEIqPQuYA7Qc6fwxZdmwvCO4Fcle/tdimP2DJpb0xboB1RnZ
         PDCzLu1k27WuaXiLG2xsc0Q7SfrYippStl4wae/mLaKgZ7Cyri88QXLMF26l7D/SG3Om
         cWcVa8aoGxOpZHzzcGF2kCJ1LEvdrLeghuGAgpIN27A7LwDEi6NG4wweKFc8pM3YLO1l
         0CopLYMIGuzeHYC5/7UJ1hDuUVk4dCnN0IXOK1QQZJDif4mzY+xP1dKRAphKL4Y2unqP
         FUi30PH3K0HPNXVqIqitXkmYcnG08fNM3nrq07Xq+odLoe9iLqbCM3GMpPPPQ0Hv6i6r
         hVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAiqidS71pJ1PpHC3qaeiwc7XXSwdkyY1rJdxC3sdNo=;
        b=n7wZbof0H3gqfAYSkUjISPuT8rpoQOcPqL5maZBNPcb4MkeeWJ0v1IdfogsqaVHYDn
         1u47eG2GOQFGn3niammOvK4lP6hkx2lKNxR9rmy7N3yp44KunIp5eEd42msE/Z8t6nCB
         POcxzz98HsNvU3ynEdh/bursaUA7o5i9b3DNJigaUlNUZHCMK7MyLgc8WJs0/GXjhGtp
         4bPDP3kQ0bkmWUw9AA0EC5/3kKX2Jl4OmoDhHuzIzV50BGfFYnC2zeqR09yCZwbHC53q
         tk6T9t8BA2h949jXOs+VNyXX1t1S22I0ywv6AIIO5QuW0oxsbHekS17mty1uN+QDozKe
         j0sQ==
X-Gm-Message-State: AFqh2koUEAwXd0TFa/LjcXWXdSJh3kLq6j4YZaGj6s7cXsMWlUHee6IK
        LXiGYnrNiTOjK44au76LmrAX0ORhd3g=
X-Google-Smtp-Source: AMrXdXtexH9TelQNA3D+1EMb1lKqrd/TkGIoXpjVBz/n72HJNG+Ol1q3Esrab9okaLJkXeVsl//o8A==
X-Received: by 2002:a05:600c:21cc:b0:3d5:79bb:d7da with SMTP id x12-20020a05600c21cc00b003d579bbd7damr31957033wmj.18.1672772584014;
        Tue, 03 Jan 2023 11:03:04 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id iv7-20020a05600c548700b003d35c09d4b9sm54517168wmb.40.2023.01.03.11.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 11:03:03 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tyler Hicks <code@tyhicks.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Muchun Song <muchun.song@linux.dev>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] fs/ecryptfs: Replace kmap_atomic() with kmap_local_page()
Date:   Tue,  3 Jan 2023 20:02:59 +0100
Message-Id: <20230103190259.30944-1-fmdefrancesco@gmail.com>
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

kmap_atomic() is deprecated in favor of kmap_local_page(). Therefore,
replace kmap_atomic() with kmap_local_page() in ecryptfs_write().

kmap_atomic() is implemented like a kmap_local_page() which also disables
page-faults and preemption (the latter only for !PREEMPT_RT kernels).

The code within the mapping/un-mapping in ecryptfs_write() does not
depend on the above-mentioned side effects.

Therefore, a mere replacement of the old API with the new one is all that
is required (i.e., there is no need to explicitly add any calls to
pagefault_disable() and/or preempt_disable()).

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ecryptfs/read_write.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 5edf027c8359..3458f153a588 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -140,7 +140,7 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 			       ecryptfs_page_idx, rc);
 			goto out;
 		}
-		ecryptfs_page_virt = kmap_atomic(ecryptfs_page);
+		ecryptfs_page_virt = kmap_local_page(ecryptfs_page);
 
 		/*
 		 * pos: where we're now writing, offset: where the request was
@@ -163,7 +163,7 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 			       (data + data_offset), num_bytes);
 			data_offset += num_bytes;
 		}
-		kunmap_atomic(ecryptfs_page_virt);
+		kunmap_local(ecryptfs_page_virt);
 		flush_dcache_page(ecryptfs_page);
 		SetPageUptodate(ecryptfs_page);
 		unlock_page(ecryptfs_page);
-- 
2.39.0

