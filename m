Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376B26EF937
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjDZRWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjDZRWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:22:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32CB768F;
        Wed, 26 Apr 2023 10:22:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f173af665fso49265575e9.3;
        Wed, 26 Apr 2023 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682529753; x=1685121753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGGuuT4kxnu8LAsLSN2/nZn2XL63I1olVWlYc+jmPC8=;
        b=lwHid8p1I8iTy9vPNQ9QsstpfBfNYMX0SCwBPeSCOrHNYDlEA8itjR4aaI24wsroqJ
         xz9U9x5RLhvUzDCAsGSCO/02PEaszNEXYIJNOH+7qiUEymIzKizSCLCoP1e0RZIRmpMC
         8navah0qGqSI0R1CdLmD8uiRXbg7y0MkmKNP1xZk/gyFmnKUPlkKbwoV3gJ9Bim0qQ1f
         Mm2uge3wRikEapyEZkPoysQYOD5X70QD+BOUt8y95ojFeX4AqQN4gHl3L1ioNEhPlhJR
         aR+VDXTECHd7suMSc9GnhML8JLLDyLnfIRFtHiPp76Dev8uwj/f8d0T7D6tWDPtWdmNU
         Bgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682529753; x=1685121753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGGuuT4kxnu8LAsLSN2/nZn2XL63I1olVWlYc+jmPC8=;
        b=BgF42VOfN1ZApGpL6O1SUOpg9PB/hyL0WilJhE19UWhL3BXr9rlSBY5f+HiZglZe0f
         DiT8B9QKz3EKsV8353ycjkpghonPsJ54rpsRo2OdDbzwtf1AqRdZ0mCOT5zsoizrr3Bt
         Y58fPZRHZOEXP+l55rmW0xOomKDja1y7wYn+ZU0C1pK8yQQu24tG/1NlILWVHexcttBu
         dBTOF09Mkpegf0VbkW3W4U6kaqKiG8rxZgdGR79PyLG6BR1BtyQfEZLcSES2touAnO3z
         YrDEc6fHt7JfykFXR+x1NsyqCikt1qImi25Ov1dTkFROR7n7JXuFuPvsv/AprdEfJyl8
         XJOQ==
X-Gm-Message-State: AAQBX9eACONz5c/rxV3kdNk/AcEgc2BI6cfwpQcKfgV5Hq5W0oZGGKL6
        yc/ZBtP1lWarCNfq1T1m/Is=
X-Google-Smtp-Source: AKy350Y1g9yuXHNVum2sTVb3YCthxPQVLi02craw3DCirefDJOXL+pfmmqf/rPuJaXidIs1B5LR3uQ==
X-Received: by 2002:a05:600c:259:b0:3f1:662a:93d0 with SMTP id 25-20020a05600c025900b003f1662a93d0mr14566645wmj.15.1682529753282;
        Wed, 26 Apr 2023 10:22:33 -0700 (PDT)
Received: from localhost.localdomain (host-87-21-14-179.retail.telecomitalia.it. [87.21.14.179])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b003f16f362ae7sm18675613wmj.21.2023.04.26.10.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 10:22:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tyler Hicks <code@tyhicks.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 2/3] fs/ecryptfs: Use kmap_local_page() in ecryptfs_write()
Date:   Wed, 26 Apr 2023 19:22:22 +0200
Message-Id: <20230426172223.8896-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426172223.8896-1-fmdefrancesco@gmail.com>
References: <20230426172223.8896-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap_atomic() is deprecated in favor of kmap_local_page().

Therefore, replace kmap_atomic() with kmap_local_page() in
ecryptfs_write().

kmap_atomic() is implemented like kmap_local_page() which also disables
page-faults and preemption (the latter only for !PREEMPT_RT kernels).

The code within the mapping/un-mapping in ecryptfs_write() does not
depend on the above-mentioned side effects so that a mere replacement of
the old API with the new one is all that is required (i.e., there is no
need to explicitly call pagefault_disable() and/or preempt_disable()).

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

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
2.40.0

