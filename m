Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6616601322
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiJQQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiJQQCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:02:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17456DF98
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a67so16678499edf.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk+KWgdlkiB+MWNzeR3WbAzUisj6JegHIR27QQQBgyQ=;
        b=omsUcwkM80T1HQfQByTwzQSSPIQo9VSPQ1minBRX8rzy6SbPGixUEBE2JXOujAa6uU
         /e/HMGViiP2taAM5sQo+EcgsE05mL14PgOfQja08E1ZZdNtuNlSWGCVBR2sHIy3q2nI1
         mphMO3QpS5U7jQxSpW7nPoESPS14DMXTB7PM5ynBKRIohJMyKbYkXh8Zu53N8j1wdBLT
         cW/XTANXBAJ9V24Ds87XvC6xvHTgEu7+kwW0Ay3h1Iu/Vu0GstEKCWlkOr4X7rnBLNa2
         WpLSDMa2+m+p3z846rzU4qw9mG4GOwP+XF5TrnV6HEeehFb/EWq17jyKIJHZm4aBU7wT
         8S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bk+KWgdlkiB+MWNzeR3WbAzUisj6JegHIR27QQQBgyQ=;
        b=vj/duOie5V1q7wtF1Vrcr/kAQVrHvcjSEzcpNm9KAYQb2T1Hnsn8O1MiFR5OXQDDL7
         iXSGTMWmLv+kPtR0pbxoh3ns+c+cBF2w/GwOQWBUvjp0M9ClibFPuVoe1tz/ZDhpZnQv
         Utzq/kQt72FcX03WxjEiUiM5Q8mAiNULRbegQ5mNTy+oXPGVAYZVItSX9XtlwOX++Hwg
         4nIEmQ9Wfhkgeh7dsVGpMZ9stVKKmX6YC688ANC5s34kXJxb/PJowbxX1wawqVdXPa7Y
         YymFAoFv9kKP3We+pdJCKtLHP+7BZy8uvuQNz5libLxYTGadSZGdJItU7m1vw+DZBAUp
         0/bw==
X-Gm-Message-State: ACrzQf0ReoPRBBcAisBWY3KehlZSBirP5L+FWzGQuxRC7F0634dVjT+8
        8b0DQdiSP/D8O11RWhjhZwo=
X-Google-Smtp-Source: AMsMyM5N8ZQLeNkoN0ubApdyoZVPYzXh3UKtjk6V1dRHUvCK+wRZxfEtOygHvSJU00j5uoC42C8N3g==
X-Received: by 2002:aa7:d454:0:b0:459:9ae7:725b with SMTP id q20-20020aa7d454000000b004599ae7725bmr10881077edr.165.1666022564305;
        Mon, 17 Oct 2022 09:02:44 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b0073d5948855asm6389629ejo.1.2022.10.17.09.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:02:43 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 5/7] mm/vmalloc: Use a trace_purge_vmap_area_lazy event
Date:   Mon, 17 Oct 2022 18:02:31 +0200
Message-Id: <20221017160233.16582-8-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017160233.16582-1-urezki@gmail.com>
References: <20221017160233.16582-1-urezki@gmail.com>
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

This is for debug purpose and is called when all outstanding
areas are removed back to the vmap space. It gives some extra
information about:
- a start:end range where set of vmap ares were freed;
- a number of purged areas which were backed off.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f4397817ccd7..912abcd6e8b4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1731,6 +1731,7 @@ static void purge_fragmented_blocks_allcpus(void);
 static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 {
 	unsigned long resched_threshold;
+	unsigned int num_purged_areas = 0;
 	struct list_head local_purge_list;
 	struct vmap_area *va, *n_va;
 
@@ -1742,7 +1743,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	spin_unlock(&purge_vmap_area_lock);
 
 	if (unlikely(list_empty(&local_purge_list)))
-		return false;
+		goto out;
 
 	start = min(start,
 		list_first_entry(&local_purge_list,
@@ -1777,12 +1778,16 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 					      va->va_start, va->va_end);
 
 		atomic_long_sub(nr, &vmap_lazy_nr);
+		num_purged_areas++;
 
 		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
 			cond_resched_lock(&free_vmap_area_lock);
 	}
 	spin_unlock(&free_vmap_area_lock);
-	return true;
+
+out:
+	trace_purge_vmap_area_lazy(start, end, num_purged_areas);
+	return num_purged_areas > 0 ? true:false;
 }
 
 /*
-- 
2.30.2

