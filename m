Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD7460320B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJRSLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJRSLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:11:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7BE72FEC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:11:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m15so21683430edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi0tjzbLmXgGsglusGmrSt3nKwzpPKhOzNGgAFj4deM=;
        b=J35hy3hbYScd9cIdMAW/EhRXhuMHkMIbXqlAvSSnIY27KTlIg7uboTgd1AXcX9OjBP
         LgOnwf6MOgzur7qqpFElJ+91KdHC0ymafDroc/4r9m9fvtrFxMQNj/P4JPFSO7KMJ2yF
         7CRJPh6bVA4+3AI3/mB5yiwzHi04YCVk4opiXmufUS3us8kpBR0bh+xpivtbT8raOFG/
         8BJHX4mlM1kUnQnOCnPGnh6I3hGjOSCIqsE8kppaSzYHBhFVY2ATiB6PRNpt4zm1yImZ
         LLRwpgnP/nA/8JUwlPgFQ8y8u27DXDnSOTZfG5AGSwsGR9d51XvYbm41HFGhdvz3fwYp
         plzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi0tjzbLmXgGsglusGmrSt3nKwzpPKhOzNGgAFj4deM=;
        b=jCbf1lLRlwQ3ZVg69qvBkxndjlpp/duHv4iLarbXYZUQQtzr3Jep0Lw+oYIu09nMTZ
         jqawIsFUB3mn6zU9XHr1UOY8+EQvMRsmdWU+skBij+wJjsrcLeZLgn8lprloZkb9t3YS
         JPBcQNuTR3bp4lqMkxa6fKOKKq7JcUyg/bSbyTZlkwzyeua2ppE0z/yJ81AsQ+97meKt
         CyBs/F1dpocazPS25O/ETg5OjVQ8MdEJdzwdUDK9j1YoQiR4Lcig9D1gk0zouS/OEP23
         SviRWUxeACETkDIVu94fMsvgcXoDQSYyYBLRJhKIxVqVJ+IgRHazYdmMSCmU5PDD+zXS
         AHqQ==
X-Gm-Message-State: ACrzQf3+FpX/NXzkwDOoNPprPesHw3u37mTIyK9ErxBx2WV5QlPVJnPQ
        Y9+mxtgzPBzmMT5XlYet2og=
X-Google-Smtp-Source: AMsMyM5Zl8vwJg/6ezF7ChkqFZClQkn3o+MqhrKUy+U0XHnl5bkuEf36aH9F8/4DjW9zC42HhN7ebg==
X-Received: by 2002:a05:6402:1d53:b0:45e:ec87:686e with SMTP id dz19-20020a0564021d5300b0045eec87686emr2362032edb.380.1666116662826;
        Tue, 18 Oct 2022 11:11:02 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b007877ad05b32sm7739302ejf.208.2022.10.18.11.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:11:02 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 6/7] mm: vmalloc: Use trace_free_vmap_area_noflush event
Date:   Tue, 18 Oct 2022 20:10:52 +0200
Message-Id: <20221018181053.434508-7-urezki@gmail.com>
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

It is for a debug purpose and is called when a vmap area
gets freed. This event gives some indication about:
- a start address of released area;
- a current number of outstanding pages;
- a maximum number of allowed outstanding pages.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4292f44ae670..bd56f68bedf0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1822,6 +1822,8 @@ static void drain_vmap_area_work(struct work_struct *work)
  */
 static void free_vmap_area_noflush(struct vmap_area *va)
 {
+	unsigned long nr_lazy_max = lazy_max_pages();
+	unsigned long va_start = va->va_start;
 	unsigned long nr_lazy;
 
 	spin_lock(&vmap_area_lock);
@@ -1839,8 +1841,10 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 		&purge_vmap_area_root, &purge_vmap_area_list);
 	spin_unlock(&purge_vmap_area_lock);
 
+	trace_free_vmap_area_noflush(va_start, nr_lazy, nr_lazy_max);
+
 	/* After this point, we may free va at any time */
-	if (unlikely(nr_lazy > lazy_max_pages()))
+	if (unlikely(nr_lazy > nr_lazy_max))
 		schedule_work(&drain_vmap_work);
 }
 
-- 
2.30.2

