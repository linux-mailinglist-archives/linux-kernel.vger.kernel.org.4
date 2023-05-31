Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7947175CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjEaEmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjEaEmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A349B97
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685508083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UYEFrarq5y6NtgfnLcdtrjWHlHd0aEmEkiPetBxugj8=;
        b=HKHj31+IKjdyF5ZIidia4M/JWH4LHXlz8WNSnicLju3IA5ijZOtqkuRg9raG1JW312s8na
        ZNTwYDTFSxgQcr9kldbz0kuUk2viXhLro7nJuBwk7cEzKRxh731oDMq4ZxUrmYas8PsNRy
        Bv6puo2NbVYVzmItpXaFvR+AmOc0294=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Rk5dDANWNxq7gaccvLvaWA-1; Wed, 31 May 2023 00:41:20 -0400
X-MC-Unique: Rk5dDANWNxq7gaccvLvaWA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f4c30edfadso292869e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685508078; x=1688100078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYEFrarq5y6NtgfnLcdtrjWHlHd0aEmEkiPetBxugj8=;
        b=OzeEqyo01bphfKjfh7ODo4E7pDRR/7QBv/azD+NoCoVM8QCSSnG5288DIqOb//jDwS
         3HcF5+WZurVE+takYwFcxxrrCS04FGdnpZysaoXfyPLbNek9dHMUwqy6xRTEs04SXOQk
         D+KZG+boNa81E3bh68/yuaC9+A+981cHn7TrvvRkRcJItUqH2mrcQyh0iBIVCaWTOC+1
         C/lXmNEU0T7pLP8ieB0Hefa58ZYPQN7Pu4fpueXnrXdahDCFbAvOtCGppCSK4MbDBA2C
         WwnaLHwypx1L/sWFwjpjf4Fw7tq58M/MrmrvH0BZJeQAePLNAf3oLd1iPmI9dDBtuMhw
         tggQ==
X-Gm-Message-State: AC+VfDwNfn0yLM3FdV5fxw+AL6spA0MnD3AYqD2YmTxUKWyVlLUjt9Zq
        AELtp8cCtcbk6FOV5ArRrp39OELlv7rA3FokMEqvS33QJJ4xzZnvtjOHogaFBlOmuO5RFva8ver
        BIcuo328zNY347N3HPwlCXW0DG+IOcZt3DLsUVTmZAZhm3hMY/cvtNopqeN9VszbU9+zqo/ER0G
        4sKcZ3v0o=
X-Received: by 2002:a05:6512:31d6:b0:4f4:f38a:4423 with SMTP id j22-20020a05651231d600b004f4f38a4423mr4415701lfe.27.1685508078711;
        Tue, 30 May 2023 21:41:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6V0NcpagTYTWBJxBDh7faQPnfd0NUxubPvmUPnnIZthRTkB0B6uC0Tku8OOzlnqMU/pj6SGA==
X-Received: by 2002:a05:6512:31d6:b0:4f4:f38a:4423 with SMTP id j22-20020a05651231d600b004f4f38a4423mr4415690lfe.27.1685508078341;
        Tue, 30 May 2023 21:41:18 -0700 (PDT)
Received: from mjp-Z390-AORUS-MASTER.redhat.com (85-23-48-202.bb.dnainternet.fi. [85.23.48.202])
        by smtp.gmail.com with ESMTPSA id p24-20020ac246d8000000b004ec84d24818sm555088lfo.282.2023.05.30.21.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 21:41:17 -0700 (PDT)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Huang Ying <ying.huang@intel.com>
Subject: [PATCH v2] mm/migrate_device: Try to handle swapcache pages
Date:   Wed, 31 May 2023 07:40:18 +0300
Message-Id: <20230531044018.17893-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Cc: Huang Ying <ying.huang@intel.com>
Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---

v2:
  - use folio_test_anon() (Huang, Ying)

 
 mm/migrate_device.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d30c9de60b0d..829bbc526758 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -747,13 +747,25 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 
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
+				 * page is here file or swapcache page, could be shmem also
+				 * folio_test_anon() filters out file and shmem
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

