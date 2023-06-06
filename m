Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1C572368C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjFFFDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjFFFDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FE111A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686027747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q6TiThBigVDB9aOyNqXFDkJ+jf7GDr7BiU78S3IKVbg=;
        b=DXOSmGQuJPWqI3JjrijL3JdgIbSjHJVOttzKXLdF++Hah6mDhu7ZLv+4NlWG2U40tetT9/
        /Lg8Qm4TtjKxwmy2D0vRPkTrUEaRJbHdbct6NuQFjUSUdwmN7gWHHz22X6YzhF35MZZKth
        7JBjm/xUL0Mj7ZfawNYgve/e0H/0BSo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-xb3VxhJGO8mBpvtHMTtG2w-1; Tue, 06 Jun 2023 01:02:26 -0400
X-MC-Unique: xb3VxhJGO8mBpvtHMTtG2w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f61f59c230so1876194e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 22:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686027744; x=1688619744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6TiThBigVDB9aOyNqXFDkJ+jf7GDr7BiU78S3IKVbg=;
        b=fMPL9gS7cQgLSBdInRKU2YEEzI3BXJli5dDmEkFaF3ZPSwJ/ywL2iXf5DcHDz0Dsm3
         M9YzzDr3oQMX+uH6oqAzI5VgheNClKc95lOR+Vc8cvUXWKQ8XV/hy8U1F3WrKIpZh95f
         5OxuhH+3DXkZ0QjUyFiKfB7PLhd2j1+eh5rPp0jgLYEqq3cBG9IwnVgWNsbxkY4oIa0f
         kcolVmnFIZFoKLELmWpWcNkSuGO4nnybw8+tMO5hmtPdEaUa+65qzkfBzjc1m1S9V1Mb
         b13Liw6LPd2ngv89aNAR12eoQEzShvCBTAtyITajUnLSruxS1w7OKGDH9ylG+2sSoa2m
         SrAA==
X-Gm-Message-State: AC+VfDzEiv0RBFe8RKWs7N328xMajHBUkV/opPxSRerA4cQ9d2IcM1iK
        xKZ9+Yw5lrXYciZ1fjgYFIAIvqBTa8YXTAE52bR3bgDNXRCOzT2q1lwf4JK010m60uGoKla0cj2
        wBry4a4hCsj3u0ktrNS9DgMSKbvwb4zk3ZvDev8S1ef5ogP81XLdJ4yp2viRiwHGMtbHHESYGQv
        a9CZyi0K9fNw==
X-Received: by 2002:ac2:5a51:0:b0:4f3:7a59:d19 with SMTP id r17-20020ac25a51000000b004f37a590d19mr509150lfn.59.1686027744592;
        Mon, 05 Jun 2023 22:02:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7HrphmL6HhmYZDJSf6TcjUvcKI32fHvyE6ck53soSUhNDdEynhBUz3F7HNTCEMljoLCCxaMg==
X-Received: by 2002:ac2:5a51:0:b0:4f3:7a59:d19 with SMTP id r17-20020ac25a51000000b004f37a590d19mr509133lfn.59.1686027744205;
        Mon, 05 Jun 2023 22:02:24 -0700 (PDT)
Received: from mjp-Z390-AORUS-MASTER.redhat.com (62-78-130-207.bb.dnainternet.fi. [62.78.130.207])
        by smtp.gmail.com with ESMTPSA id v11-20020a056512096b00b004f5bc4e80easm1323915lft.171.2023.06.05.22.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:02:23 -0700 (PDT)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: [PATCH v3] mm/migrate_device: Try to handle swapcache pages
Date:   Tue,  6 Jun 2023 08:01:49 +0300
Message-Id: <20230606050149.25699-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Penttilä <mpenttil@redhat.com>

Migrating file pages and swapcache pages into device memory is not supported.
The decision is done based on page_mapping(). For now, swapcache pages are not migrated.

Things can however be improved, for swapcache pages. Try to get rid of the swap cache,
and if successful, go ahead as with other anonymous pages.

Cc: Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---

v3:
  - Adjust comments
  - Add Reviewed-bys

v2:
  - use folio_test_anon() (Huang, Ying)

 mm/migrate_device.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d30c9de60b0d..f76ebccfe067 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -747,13 +747,23 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 
 		if (is_device_private_page(newpage) ||
 		    is_device_coherent_page(newpage)) {
-			/*
-			 * For now only support anonymous memory migrating to
-			 * device private or coherent memory.
-			 */
+
 			if (mapping) {
-				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
-				continue;
+				struct folio *folio;
+
+				folio = page_folio(page);
+
+				/*
+				 * For now only support anonymous memory migrating to
+				 * device private or coherent memory.
+				 *
+				 * Try to get rid of swap cache if possible.
+				 *
+				 */
+				if (!folio_test_anon(folio) || !folio_free_swap(folio)) {
+					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+					continue;
+				}
 			}
 		} else if (is_zone_device_page(newpage)) {
 			/*
-- 
2.17.1

