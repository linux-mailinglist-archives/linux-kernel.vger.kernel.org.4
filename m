Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634535F7586
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJGIvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJGIvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:51:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3B6A4877;
        Fri,  7 Oct 2022 01:51:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m3so6054355eda.12;
        Fri, 07 Oct 2022 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLFQR3kf1OGc7RQtWTzli/pg6vzYR5MtvqkuvoSq10U=;
        b=D11I+OvztMi9pekoUUOm09LpYiyz+HrZJYT/FygLFpJ9/PXxr88+u4y/Heyji+CS9S
         KGSPYRzX6tmi/TNrWJhGYuruka01TsLnnZOyfk7eoGF7xLWHsYM/rUliQqg1W90uTP9H
         NtdCAH061CrucF7V8dkPlF0e62nePZxXxqWhMD6Xjz3BJv4A1Pgz5HvYOyRPdcAkwVRN
         V00OaOxgZaVHlxAgSJnxVP27diOZZ+luJ0qrkccCoUmrRgVPyVDPEJ6GhANNyQrGBG6v
         ROswcdZDsZK2ft5QzvPplwZcLJzb/xckycHCOyS6GCx6Nx9AslT6qK/hIL/+9e8QWxb6
         Y4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLFQR3kf1OGc7RQtWTzli/pg6vzYR5MtvqkuvoSq10U=;
        b=nHahbqRZRYNWBFXNd3c1x8jC5sS4GLqetRxlcYPgCCwUyl8EnYa9s6EOlpu5/JjWIK
         njw0+M3S+7PmABzfK/qv4D01GIoMXu1hblE4jn/j2iY8tARhKLDQrcLhDa0wx2wTTkjo
         Jad+k9nC56FSp7HEqyofytGV3K7JpR8XnXgnObvM44F0MAWrX1iErgnzMhd8ufc1GWuV
         zVh5b0WKM1W+aZTzb0ofxUUHa69fBJndX0dnJOC5AtnRCDoknuS+dfyrQxVSXGC9fgAr
         b462oUIIgkm213HIKpRSiabaYeJfKVoVzkRHWkk3pTh2SKMFC0ahxpqHFxBf9XGm1tQ0
         UWgg==
X-Gm-Message-State: ACrzQf0e4lfJc25xwhQiX+2nnXmkKZBjnERiP9FWKHoYOOq0XI73kusY
        fO2JLILD99MvD8aNxdx30a8EbtR7QK8=
X-Google-Smtp-Source: AMsMyM4TdfDLjqMXqmX4Onf8iCVlyu0YZh3B46wR6fYKNu0PV5e+5E58d2my43J26fSS+FeMbP8ZIA==
X-Received: by 2002:a05:6402:357:b0:458:5cb6:f587 with SMTP id r23-20020a056402035700b004585cb6f587mr3586230edw.183.1665132673923;
        Fri, 07 Oct 2022 01:51:13 -0700 (PDT)
Received: from felia.fritz.box (200116b826e52a0050a02ad37da10fc5.dip.versatel-1u1.de. [2001:16b8:26e5:2a00:50a0:2ad3:7da1:fc5])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906a01500b0072f112a6ad2sm882806ejy.97.2022.10.07.01.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 01:51:13 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mm/shmem: remove unneeded assignments in shmem_get_folio_gfp()
Date:   Fri,  7 Oct 2022 10:50:27 +0200
Message-Id: <20221007085027.6309-1-lukas.bulwahn@gmail.com>
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

After the rework of shmem_get_folio_gfp() to use a folio, the local
variable hindex is only needed to be set once before passing it to
shmem_add_to_page_cache().

Remove the unneeded initialization and assignments of the variable hindex
before the actual effective assignment and first use.

No functional change. No change in object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 mm/shmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8280a5cb48df..5577c3e72e0f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1833,7 +1833,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	struct shmem_sb_info *sbinfo;
 	struct mm_struct *charge_mm;
 	struct folio *folio;
-	pgoff_t hindex = index;
+	pgoff_t hindex;
 	gfp_t huge_gfp;
 	int error;
 	int once = 0;
@@ -1871,7 +1871,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	if (folio) {
-		hindex = folio->index;
 		if (sgp == SGP_WRITE)
 			folio_mark_accessed(folio);
 		if (folio_test_uptodate(folio))
-- 
2.17.1

