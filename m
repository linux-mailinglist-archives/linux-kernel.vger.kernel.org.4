Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20EB601323
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiJQQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiJQQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:02:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DA66D843
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sc25so25944601ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFb/7zwjqK5CQviz80hJ2NborTj9HM/1n8g5QJGdbSg=;
        b=YiYXWC+QyyMRmUFikBr8oB0Y1Dv5Ak0+JU9eRaISPncrUtmk74un588/6vLUW20FX2
         lcsMHUj1ia8PYSlFC9HVKa8LYI5/Yh0TjGpkQyJZZ4YS0bm/QH6Rv2CFRjtHZBT3b3pT
         0+BPG/BTVuhoW6zArG3Q9DVL9nBrJkcTvqqVQu/jOMiJKoe+vM3ZZ6pcDUDpv1pb0fcM
         4tAtotDnjQBySPAXfmWgfyTTefQF78FTuW3MoxUtYOQjsfkM6atHxIjLRfvQcYVxkVuy
         ova4Mkw2DwcL0fxYGdC/Heno/OPCahBGre0elnEAC15yZWG8R1irKhQOqHbNR3mi0PHl
         r5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFb/7zwjqK5CQviz80hJ2NborTj9HM/1n8g5QJGdbSg=;
        b=45IK+4mZnM0bcNbIA45u7fict2h6lGLw88Cc9l6mDUkNbDOAv0Rx9R6it5kTF7NGWB
         zxg8kSwL/48nSJ5t/cS22kqhaQjWuSc0ERqwEWovVyWaWvYXyghrX/D9xdxRD/YdMXSd
         3UbtmxLYFYvubbyVBzI3JZAQ+wu5vjgkFcQFZ8NLQOdJ5Q8FDjPOM6AWqNPNZlAjxvz+
         IQZQo/dAO66y3o+iVXDcHLeFoWTesODTjWvWJqNmst2QR8VGPxXHImFKC2dirEIHOAm5
         eZ3c+Ko7na7FqZ+kAsPBR375b6ZeujmD5dIliYN9q9tUzUFSoQEofxrzwxPwhHMH4hgT
         RFog==
X-Gm-Message-State: ACrzQf0CYHkCjlLX5cDGcwWO+YIgnBbz925qEnns10IfqN0EtJ9NVIZT
        9rjJqGk8OxLRBN4n8CnoTh8=
X-Google-Smtp-Source: AMsMyM53rJaLhk4GwF6LlPSoomVfcARTFPfJm/NqfYLKgstdDAxVM5szNB2fF2xkAFkG5XJVLI5fRQ==
X-Received: by 2002:a17:907:3f94:b0:78d:9d2f:3002 with SMTP id hr20-20020a1709073f9400b0078d9d2f3002mr9099892ejc.40.1666022565358;
        Mon, 17 Oct 2022 09:02:45 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b0073d5948855asm6389629ejo.1.2022.10.17.09.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:02:44 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 6/7] mm/vmalloc: Use a trace_free_vmap_area_noflush event
Date:   Mon, 17 Oct 2022 18:02:32 +0200
Message-Id: <20221017160233.16582-9-urezki@gmail.com>
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

It is for a debug purpose and is called when a vmap area
gets freed. This event gives some indication about:
- a start address of released area;
- a current number of outstanding pages;
- a maximum number of allowed outstanding pages.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 912abcd6e8b4..df4fd6674ced 100644
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

