Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D636F9728
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 08:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjEGGSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 02:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGGSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 02:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC48CA279
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 23:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683440278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/hRxrUUzRLvf8AVUqcmw5+jNN6/ijgKdT9lm3aojzhc=;
        b=aMUS0goYnsJN/tQSfgmZNG9f+MNRKAl8U0A60Csf826HnCYEBFrdQGwLg6D5LIbHWSFTpU
        zVz+V26sD4o4OFKtOxEfGQU83+qUmLZRjJaRnYgGbOiIq0cL0uxK8k9CWOEkItPGgSv2hS
        d3reRKMi0vATIYtZfUoNEuJcenOUfNY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-N8KHgwunOKu-XWs6-U0D-Q-1; Sun, 07 May 2023 02:17:57 -0400
X-MC-Unique: N8KHgwunOKu-XWs6-U0D-Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4edc5d704a0so1927931e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 23:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683440275; x=1686032275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hRxrUUzRLvf8AVUqcmw5+jNN6/ijgKdT9lm3aojzhc=;
        b=RXB4mXg5BRgWB+zaxy+uIwMMdFtZk67z+Tz6Vl3zWGrY1sof3PJmTGt5l3eyvbp9X0
         qdfAbIg6bArBCjO/szo7TEQic9DWph9alm+chaRDaMz+kujaSwaDEMSMf7+csjQK7oaK
         sW2fx3DE6znXhWD0F9zer51tKpPc3fKpe4eu4Mk/bfnn50ezPojd/p1E4OdK87j860ll
         QOsTY+6JHjjZPWJytaQT6CC+dZzjTxdRmllSuK96YChkYA/2hG1o+DVtM5OK3hhm3lJE
         ZSVXWmSnaU5bEnR7YixTguiH01Z50aJp83x5GN1Qz4cL/IWYy8Pylyto+ZoG++xK4xCa
         Tubg==
X-Gm-Message-State: AC+VfDwsQDuXDLzIKF9/yevflOJl5RjfT3UKeArl0TkOTdNrB9aqfHEg
        MN5d8JkjppJyejIB1JTBIFTcW41wSLXs8xOrPbnBgZE/gJgBI4gOAkwzAQ3V9kD0tNOakiT+bqB
        gkjJMTlHhpctt0GxfmBMjlPQ1FMNGxZKk/FkO/Pa2+LjfHG1IETg/XzQO/TVG/IVi0T63CU8QcS
        pt8wHLFFo=
X-Received: by 2002:ac2:44b8:0:b0:4ec:8a0e:64c8 with SMTP id c24-20020ac244b8000000b004ec8a0e64c8mr1753306lfm.11.1683440275692;
        Sat, 06 May 2023 23:17:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4962BgfRvaN1caA4kasC+PeBOW6jCTiIzFz5nVVdlPlB2W3RzrkFV/Xpy0TnZ9b8WLLocOhA==
X-Received: by 2002:ac2:44b8:0:b0:4ec:8a0e:64c8 with SMTP id c24-20020ac244b8000000b004ec8a0e64c8mr1753298lfm.11.1683440275338;
        Sat, 06 May 2023 23:17:55 -0700 (PDT)
Received: from mjp-Z390-AORUS-MASTER.redhat.com (85-23-48-202.bb.dnainternet.fi. [85.23.48.202])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004eb07f5cde6sm870753lfc.297.2023.05.06.23.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 23:17:54 -0700 (PDT)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>
Subject: [PATCH] mm/migrate_device: Try to handle swapcache pages.
Date:   Sun,  7 May 2023 09:17:26 +0300
Message-Id: <20230507061726.13422-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

As a detail, do not mess with shmem pages, as they handle swap internally.

Cc: Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---
 mm/migrate_device.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d30c9de60b0d..e8169c58c341 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -12,6 +12,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/oom.h>
 #include <linux/pagewalk.h>
+#include <linux/shmem_fs.h>
 #include <linux/rmap.h>
 #include <linux/swapops.h>
 #include <asm/tlbflush.h>
@@ -750,10 +751,17 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 			/*
 			 * For now only support anonymous memory migrating to
 			 * device private or coherent memory.
+			 *
+			 * Try to get rid of swap cache if possible.
+			 * Leave shmem pages alone, they handle swap internally
+			 *
 			 */
 			if (mapping) {
-				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
-				continue;
+				if (shmem_mapping(mapping) ||
+				    !folio_free_swap(page_folio(page))) {
+					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+					continue;
+				}
 			}
 		} else if (is_zone_device_page(newpage)) {
 			/*
-- 
2.17.1

