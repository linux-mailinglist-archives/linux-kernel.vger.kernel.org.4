Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95F560320A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJRSLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJRSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:11:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23FD733DA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:11:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m16so21757116edc.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8kMXp9BQAd3vgxARQi9NOKOPWDC+b4eB+IRpUUVrl4=;
        b=WfSPJEGUoF2C9KAvUYS570nptYgLA/TuWUM/Ysm9180aXj8gEJL6TR3123vRXv72s7
         XFX+/7g1IMk6mf/h5jeA+hPg0nl725MnZQc7Q38P9jvAXr75fkC63/p0h5UmM5KUegTY
         D2z9K80d7tlDUECwTADSfkpPpF9Dk4ZY74npnitOV4oqWqarha84ZLQLT3Xz04BFACCB
         8PwzK8coREdFHo8Pb8ZxRj4TRiqxAxYTK5AbtLBq81L/WTL8EF+6MFdsPxvosGw0b3DG
         dZSKqSkKwHzfCv+UALd5/k+1QbABrGTotVu4KWiVPzobmZURCQdTLLx2WkGmS1A3adcB
         T3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8kMXp9BQAd3vgxARQi9NOKOPWDC+b4eB+IRpUUVrl4=;
        b=LXHjCm/Oseoks6qiYtHzMhBXcK7u2NpAGT1O0oRBan+EsC7hG2R8ayM1owcBKOqM76
         +dQNDwz8t2/2mHo3qMgoaZQ641QRbdx29Pdy4S0p1FITz4X+pOlULNZPc9UPMZKwWRnc
         dpaiRtIswTIHf4sE1MAjBLfikKsLbZ1fyoIXnsTTojRkoSSj40eeg9GJBJjv61fsHr0i
         Z2aKxbMMvaKGIRyL/iSOmKGSXIy5v25i7Uv+h0RRnTFRxfT0vIq4vPHoODQG2l3t4RvT
         HtHF3oxBFisM00Ny1VC06qkgasSjLnsMX5mMyrUMMmAzV5/w9EyiWlUb5itrUNH6fou5
         Slcg==
X-Gm-Message-State: ACrzQf1fUk1QgbNr8ILYvRbQWcivHrA0+qGE4lukq4CisDdaM/DEG1Fc
        RPDHb9Kbu3NHQRv4hAw9Ogk=
X-Google-Smtp-Source: AMsMyM7ijjHus1bRUjHQvJYBGDCBkNK0BwtjzEw9/bAky47EzLnOn5lKf4DXyLK+rkXid4XZJwz9xA==
X-Received: by 2002:a05:6402:f96:b0:459:4180:6cf4 with SMTP id eh22-20020a0564020f9600b0045941806cf4mr3805343edb.64.1666116661749;
        Tue, 18 Oct 2022 11:11:01 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b007877ad05b32sm7739302ejf.208.2022.10.18.11.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:11:01 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 5/7] mm: vmalloc: Use trace_purge_vmap_area_lazy event
Date:   Tue, 18 Oct 2022 20:10:51 +0200
Message-Id: <20221018181053.434508-6-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018181053.434508-1-urezki@gmail.com>
References: <20221018181053.434508-1-urezki@gmail.com>
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

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index aa86f21bfad0..4292f44ae670 100644
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

