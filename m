Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE595BB57F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 04:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIQCNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 22:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQCNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 22:13:20 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A006CBC831
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 19:13:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e68so22913208pfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 19:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=O/wHfSygLsTDmbVML9jL5HVnMqDKxLwyjweHfisFexo=;
        b=hkpFE9dY8zc+Tj/9KFsk0wgqf7HV2Vezb5hXqx4WGnDt6gWbT8Oo2Mm/WniNar0pjZ
         axB4dbEGB4QUVsmTeFErEpIpUoOK+9fHkROm67WOLblpmqgjMoGBpUNsaB/0cWDEcvZP
         6Jw8EIKe/7w3+jCTuy2gt1cMlwCaMbzVBkDiMMSXFmlXRauiQpcRy/XIwSiT6QtelneC
         8LEfZwtbUlvV6Jpb7W9DxRKSzG3oTthsYAZmAsV9bEyQpF0sXHtt5ham7Da91bzhppLx
         AY6DtdzzaUHtLmU5YIVJsCGL/x3G2wGU+3xq3Ckv7QU8hzbrDXe0LNWaClm54Q35Rp3B
         Wp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=O/wHfSygLsTDmbVML9jL5HVnMqDKxLwyjweHfisFexo=;
        b=ELTBXathHA0bWGO0LSCjvjwI3kDEJMHAkzlpmRqmQj2LRRJxNzrEnJALJ9xgDXIAUI
         LSNZ4V6qsqEWYFMWOSCtQV+Xp/MmZ7ShD3ZNA8hXtbZemq2V4pTRwn9rEZC8/AmNenX+
         sSN/d7nvcPkX6ZCuYE0RVwIYF8LQpu2FehSobHNZAm3OTt6oNgvqvb6VdHUe1CU1rB2I
         pLobY2v1UEVlVFf/Xt9dTMGgIlYL5/wAz6CVToMPy4lyTC1zk3eopJ9KjssC849UWXe2
         wOea/snWt22YYH8DTvABwHfuvzO8Z43nnjrNcIzSumVk5bPd7up0+o3HrYMBh1kHdQyp
         E0hA==
X-Gm-Message-State: ACrzQf0Kota0EiLyHXC+4UFGu+TluFZGSiZJ+t5jEXAxc48fEEnd8HST
        Ma2MXOqZvVbolfdef3qNuFzSs8DWk190cg==
X-Google-Smtp-Source: AMsMyM4wSunl1Ehj83giXSNRzm8v0AxUUnGmsIK5jCr7OOe0AbFT0IYYcCJ0U4URWNWErqSPiRxzNQ==
X-Received: by 2002:a63:1349:0:b0:438:fa5a:b6f1 with SMTP id 9-20020a631349000000b00438fa5ab6f1mr7201270pgt.250.1663380796804;
        Fri, 16 Sep 2022 19:13:16 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id oj5-20020a17090b4d8500b0020263b7177csm9753575pjb.3.2022.09.16.19.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 19:13:15 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] mm/vmscan: check the return value of migrate_pages()
Date:   Fri, 16 Sep 2022 19:12:57 -0700
Message-Id: <20220917021257.3840548-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Check the return value of migrate_pages() to check error exeuction.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 mm/vmscan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2b1431352dc..50aaaa9377e2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1547,6 +1547,7 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 {
 	int target_nid = next_demotion_node(pgdat->node_id);
 	unsigned int nr_succeeded;
+	int ret;
 
 	if (list_empty(demote_pages))
 		return 0;
@@ -1555,10 +1556,13 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 		return 0;
 
 	/* Demotion ignores all cpuset and mempolicy settings */
-	migrate_pages(demote_pages, alloc_demote_page, NULL,
+	ret = migrate_pages(demote_pages, alloc_demote_page, NULL,
 			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
 			    &nr_succeeded);
 
+	if (ret)
+		putback_movable_pages(&pagelist);
+
 	if (current_is_kswapd())
 		__count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
 	else
-- 
2.25.1

