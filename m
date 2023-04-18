Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649756E6CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjDRTPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjDRTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:08 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930489EDF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id m21so19410812qtg.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845229; x=1684437229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWzWNVwkSkX/nKeV3fr2KFPOgnXDvxLFllKcLvZxGIY=;
        b=A6AezfgFb558g3zl8KYkj4x8/L0DIOCUiDlAuiOpPB/uNdrligymciqY3pviiovSz7
         vKSf382DQ8ssov3wdJ9qL3nD7oIEAgvToPUv9CYpTlO4HbTHGzp2IZTc2DXrdM3mXahz
         0py57a20ojr2O+PepMwl9/QHioEm1FDw2MRiTZYyYWKB9AsL5d0proRbKpQwyYUfMNP1
         //zhEeIOanhXcaehUnWf/FVKyKlOdRk3NVSIwARpSIl5m2koxzkBtGtcG0JMTTTieE93
         AO69YNUjxBNNIS0LLC1PusXdBE3chI7eqcQajUcD2Uoo7NcibA/0DG0uhwzJHlI926dN
         p8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845229; x=1684437229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWzWNVwkSkX/nKeV3fr2KFPOgnXDvxLFllKcLvZxGIY=;
        b=J5aSft4JB8haMw9NvPttTF7gAKpazGo5g/A85CKm0eF5x4ZEt2E/QXtO7RJgHCR1Cg
         eex9Z8WHC8dqaC36xAbrB47WCiH3xZUJMyo2nh9N3pWoX4WPYXsdbxICtAOeJOCJ29hn
         f1Ns/JmMVv/NFxrJVo+QkPh1LWFJzi31gcZ5MX6xhogFIDl6RLrfcphshBj1HfyIe62L
         FKz0TSPTsDltf2kv1yIMQbsg2iFK8q8PVZccjn+E7scs9gg8Fzu0GoK+Zx9r2+FZycRm
         fzWuuz/vCSLp6SHmJnPsoUJ1lUbtTxvk2ludQgOLvVyw/4YOHnAK03Q8pHyRMgR2cOxP
         6p1g==
X-Gm-Message-State: AAQBX9fwp6oS+wRInX3e7EKDWckBpUmJIQfpLPATxGLs8QzCtQPx367B
        4LJnY2EIFqaQ+ssdwI1WCyhiTQ==
X-Google-Smtp-Source: AKy350ZdZcMKMoHMrh8Lve5YppGzlgXCzZWIFyu+Z0bcXvlyOp64kIBGTX1A+KzTiCSPMF180KBHNA==
X-Received: by 2002:a05:622a:4a:b0:3b8:6ca4:bb23 with SMTP id y10-20020a05622a004a00b003b86ca4bb23mr1454631qtw.15.1681845229705;
        Tue, 18 Apr 2023 12:13:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id d9-20020ac81189000000b003eb136bec50sm3482413qtj.66.2023.04.18.12.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:49 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 26/26] mm: page_alloc: add sanity checks for migratetypes
Date:   Tue, 18 Apr 2023 15:13:13 -0400
Message-Id: <20230418191313.268131-27-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that known block pollution from fallbacks, !movable compaction,
highatomic reserves and single THP pcplists is gone, add high-level
sanity checks that ensure that pages coming out of the allocator are
of the requested migratetype.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9db588a1de3b..b8767a6075e8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3675,6 +3675,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 			int migratetype)
 {
 	struct page *page;
+	int buddy = 0;
 
 	/*
 	 * We most definitely don't want callers attempting to
@@ -3698,9 +3699,14 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
 							migratetype);
+	buddy = 1;
 
 out:
 	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
+	VM_WARN_ONCE(page && get_pageblock_migratetype(page) != migratetype,
+		     "%d:%s order=%u gfp=%pGg mt=%s alloc_flags=%x buddy=%d\n",
+		     zone_to_nid(zone), zone->name, order, &gfp_flags,
+		     migratetype_names[migratetype], alloc_flags, buddy);
 	return page;
 }
 
-- 
2.39.2

