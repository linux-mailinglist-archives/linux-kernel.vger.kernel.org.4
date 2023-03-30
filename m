Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1668B6D13CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjC3X6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjC3X6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55863B771
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680220685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1xy3Si82hsoX5OufaGVk7KtbhEZkZn8SmKdNVmGxaE4=;
        b=PCYPeCgf6EXy+Kv8I1OBLZ2NN+S4/n0RSH/kMsNbaiye3MpS1UZXBIvqz/Dmx0Fw+bLczB
        SSJLdoWUHnXXiNBUbdEVcJ1TKY5WfXkgRs9w7wFHk7YFeKS78avp7cZ0g3VveRfZ0/d6Hj
        x8lLW0xm47VwtdjEuxVdMlXO7HKFBDI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-rGNzXE46NyWmkg1zfP6G3g-1; Thu, 30 Mar 2023 19:58:04 -0400
X-MC-Unique: rGNzXE46NyWmkg1zfP6G3g-1
Received: by mail-qk1-f199.google.com with SMTP id 195-20020a3705cc000000b00746a3ab9426so9661698qkf.20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680220683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xy3Si82hsoX5OufaGVk7KtbhEZkZn8SmKdNVmGxaE4=;
        b=Vs5tjTOFV6T8/EoL4YnJmY96xhD+bkOKnYNJ/HqPb1xsOBv3D08PIgYjQbd8wXShG9
         lj3j+sGrUAiH2FXg0JTWd0EXKImHnqs82lpjk0mjwmhQ8EX6K0zQIxKrk2DlHwlZ0uBQ
         w9GsJoWgZFugDF4jcPz7yfXPGCPIToWqLRYHdKfjkPVVB//0U05O4mkJ8CQk2ZCCdvo4
         r/P1oyXaPiqY+h3C//7LrWDYgbzIsT6qEaqGZsXYekZTINuHJ1vTGEItpJLni15CZAr6
         nUacdY+RAYwiKnavkPZqo1ZkBWU7bzbuJyQVw5WH48YNGsNfYun8iFBtGlqXbGIClTfX
         T8iA==
X-Gm-Message-State: AO0yUKUWd7xo0mSYL9TOaYPXESuZCOXmGVct9P/yErf6AHxhK5oDsmuW
        qmIqrlYsloOh7LOMCXl4Q3KXJvg4AMTXBzHaySstO0QdleJT2gHnz3mMpt0B4e5uLQNRNTXo/Rl
        xSsSfKXQzZIwqpAGjXxQE8HcT/168x0W8
X-Received: by 2002:ac8:5a81:0:b0:3e3:9532:fa06 with SMTP id c1-20020ac85a81000000b003e39532fa06mr41800166qtc.45.1680220683457;
        Thu, 30 Mar 2023 16:58:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set+jNIid0RKyvmGE9Vcm0M+oEDEwii4d1YpbtTLE1M5k3iMBeqHTdXCI512CI6VH0VLZqDCgMg==
X-Received: by 2002:ac8:5a81:0:b0:3e3:9532:fa06 with SMTP id c1-20020ac85a81000000b003e39532fa06mr41800149qtc.45.1680220683222;
        Thu, 30 Mar 2023 16:58:03 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i2-20020ac84882000000b003d5aae2182dsm229182qtq.29.2023.03.30.16.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:58:02 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] IB/qib: remove unused cnt variable
Date:   Thu, 30 Mar 2023 19:58:00 -0400
Message-Id: <20230330235800.1845815-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/infiniband/hw/qib/qib_file_ops.c:487:20: error: variable
  'cnt' set but not used [-Werror,-Wunused-but-set-variable]
        u32 tid, ctxttid, cnt, limit, tidcnt;
                          ^
drivers/infiniband/hw/qib/qib_file_ops.c:1771:9: error: variable
  'cnt' set but not used [-Werror,-Wunused-but-set-variable]
        int i, cnt = 0, maxtid = ctxt_tidbase + dd->rcvtidcnt;
               ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/infiniband/hw/qib/qib_file_ops.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 108520e53928..bf0c90eb3129 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -484,7 +484,7 @@ static int qib_tid_free(struct qib_ctxtdata *rcd, unsigned subctxt,
 			const struct qib_tid_info *ti)
 {
 	int ret = 0;
-	u32 tid, ctxttid, cnt, limit, tidcnt;
+	u32 tid, ctxttid, limit, tidcnt;
 	struct qib_devdata *dd = rcd->dd;
 	u64 __iomem *tidbase;
 	unsigned long tidmap[8];
@@ -520,7 +520,7 @@ static int qib_tid_free(struct qib_ctxtdata *rcd, unsigned subctxt,
 		/* just in case size changes in future */
 		limit = tidcnt;
 	tid = find_first_bit(tidmap, limit);
-	for (cnt = 0; tid < limit; tid++) {
+	for (; tid < limit; tid++) {
 		/*
 		 * small optimization; if we detect a run of 3 or so without
 		 * any set, use find_first_bit again.  That's mainly to
@@ -530,7 +530,7 @@ static int qib_tid_free(struct qib_ctxtdata *rcd, unsigned subctxt,
 		 */
 		if (!test_bit(tid, tidmap))
 			continue;
-		cnt++;
+
 		if (dd->pageshadow[ctxttid + tid]) {
 			struct page *p;
 			dma_addr_t phys;
@@ -1768,7 +1768,7 @@ static void unlock_expected_tids(struct qib_ctxtdata *rcd)
 {
 	struct qib_devdata *dd = rcd->dd;
 	int ctxt_tidbase = rcd->ctxt * dd->rcvtidcnt;
-	int i, cnt = 0, maxtid = ctxt_tidbase + dd->rcvtidcnt;
+	int i, maxtid = ctxt_tidbase + dd->rcvtidcnt;
 
 	for (i = ctxt_tidbase; i < maxtid; i++) {
 		struct page *p = dd->pageshadow[i];
@@ -1783,7 +1783,6 @@ static void unlock_expected_tids(struct qib_ctxtdata *rcd)
 		dma_unmap_page(&dd->pcidev->dev, phys, PAGE_SIZE,
 			       DMA_FROM_DEVICE);
 		qib_release_user_pages(&p, 1);
-		cnt++;
 	}
 }
 
-- 
2.27.0

