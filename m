Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAA9601320
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiJQQC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJQQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:02:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A46B64B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g27so16706181edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8PGF12HowaED9GsfrGSUOr+T+BR5MJRz00gwWuwNBY=;
        b=PuSyLUliSWcCdVU4u7qHBbywoFiv8OcPvJLS/1g7R6MQWRqgwi9ab6h3UNMAdzJ3r2
         LE2uVd4tU/Ubdl3myCXCO7PeGNs0vZnHReXivgvRK4Bze4KVRzOvfA4IOQeK3rrfgt5D
         BhZZPORrFgoF7oDSHAYM4kvWeAMUBuIE+njxY7T2eKBV5QjqdSWPU6xjQMAcWilw4HNE
         XUcV9qbf13+VHz9QpAEi8xk9Rd7hA1twg3bjLCnisbFN1Gk9+o5TNA3+jq20D4ikP/W0
         5loQEp4hEFdhDBNpIjn7WEtAFSZD2gDZlrfK4iHK+ND1y29bST762akZlqLlK6Zjd8v2
         gFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8PGF12HowaED9GsfrGSUOr+T+BR5MJRz00gwWuwNBY=;
        b=0ydvQxqmDP9pGzDFGNZKNZn1lvzMDesjorfG87BHQIyIge15Udz7YPSDWQwX7MFk7n
         devx7wIscoDD93gVFFb703ugbr4Vpacgdx9xDIYx+pjciykbsTxEgfw/QWsIXbtwhYSw
         p5p6s4xhBbzYoL3yF0AWhdbdX7FmyFzr7AvC9gB4IYZbPHDcIzfFsYAhdRS794LYy63j
         3gewocabqzmRLWBupUDeUNUHewvbZ6jNx1KF5yjVxoILr4FXruGIOGEd5vTXPdasGDtu
         iN5LpetieM5TuhdgTLns2vnuupCgY/BvTlZNwL7/N2DGvWeb7TsAZt0T8FQe2FuSLNj+
         FDow==
X-Gm-Message-State: ACrzQf1bAvbmpcOIwe93px4E9NmVJ9A/QBFAYm7XY6DOWfRINdbFmNo5
        WVupWbExZKQSSILxvPD38A4=
X-Google-Smtp-Source: AMsMyM5J6EvtgyhKOpb9oGBdRpl3SDQY9wi4qJB+ZFoj5u0QAiVRfFyH462ZJNpLtpsrBwVY0Rj1CQ==
X-Received: by 2002:a05:6402:35d6:b0:45d:a52f:2d30 with SMTP id z22-20020a05640235d600b0045da52f2d30mr3601725edc.4.1666022562308;
        Mon, 17 Oct 2022 09:02:42 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b0073d5948855asm6389629ejo.1.2022.10.17.09.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:02:41 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 3/7] mm: vmap: Add free_vmap_area_noflush trace event
Date:   Mon, 17 Oct 2022 18:02:29 +0200
Message-Id: <20221017160233.16582-6-urezki@gmail.com>
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

This event is used in order to validate/debug a start address
of freed VA, number of currently outstanding and maximum allowed
areas.

To: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/vmap.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/trace/events/vmap.h b/include/trace/events/vmap.h
index 2af2b84c6eb7..5ba9bf58772a 100644
--- a/include/trace/events/vmap.h
+++ b/include/trace/events/vmap.h
@@ -83,6 +83,40 @@ TRACE_EVENT(purge_vmap_area_lazy,
 		__entry->start, __entry->end, __entry->npurged)
 );
 
+/**
+ * free_vmap_area_noflush - called when a vmap area is freed
+ * @va_start:		a start address of VA
+ * @nr_lazy:		number of current lazy pages
+ * @nr_lazy_max:	number of maximum lazy pages
+ *
+ * This event is used for a debug purpose. It gives some
+ * indication about a VA that is released, number of current
+ * outstanding areas and a maximum allowed threshold before
+ * dropping all of them.
+ */
+TRACE_EVENT(free_vmap_area_noflush,
+
+	TP_PROTO(unsigned long va_start, unsigned long nr_lazy,
+		unsigned long nr_lazy_max),
+
+	TP_ARGS(va_start, nr_lazy, nr_lazy_max),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, va_start)
+		__field(unsigned long, nr_lazy)
+		__field(unsigned long, nr_lazy_max)
+	),
+
+	TP_fast_assign(
+		__entry->va_start = va_start;
+		__entry->nr_lazy = nr_lazy;
+		__entry->nr_lazy_max = nr_lazy_max;
+	),
+
+	TP_printk("va_start=0x%lx nr_lazy=%lu nr_lazy_max=%lu",
+		__entry->va_start, __entry->nr_lazy, __entry->nr_lazy_max)
+);
+
 #endif /*  _TRACE_VMAP_H */
 
 /* This part must be outside protection */
-- 
2.30.2

