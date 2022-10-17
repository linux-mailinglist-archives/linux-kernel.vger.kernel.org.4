Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D730E60131E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiJQQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJQQCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:02:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F189B6D843
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d26so25960138eje.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/1RiMr1eJ0x+wK6LRLfk+CIs20GXMv9Cr5BUn6E+1A=;
        b=qxhJaPRp0C1CnLCFp02667sEh3nTRwKHTgeeTplt+G+mCrIlcs4hRfjfzFmtSMKS5B
         Ru4N2JJro5y1V+RBQElu0oUEWVc/iuDrkjsfJALvC3mui2/wFwWSeLu7KvUBCfH/QVbg
         e+8R4DsIoDD8jTjBvGL5JrrxB3mBMXM44W9pyDU+0ZKXgZs+Nqf/IlXKv5FNtW10hkJU
         LfLfrVSmU/MYA7xHhsFVYKKxpYoZ1y/v3S42Cpf0ciYRKHx9ghv8mTY1vcrxcBtXwOAx
         FqKtwhN3Jb5kDDN/U2PNa8GEdiND3I3a3Z/2TiJGEaIYyTMIhX8Su0Jvy6wC2TQ8XPdd
         SFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/1RiMr1eJ0x+wK6LRLfk+CIs20GXMv9Cr5BUn6E+1A=;
        b=fpkfsEXOWxt8NnbqN21u8Wr9jBPB/4PdQk4izF8MDaH/RvzAetAjfOf9x73F5ReIX8
         Z+2qWwOtygAgENZnysDRMhdmZq+JR+ZZCIEFdvjIYZ7d+BysbxtsLmqUrO56MVv2c8DD
         ruY7hRm8Qx7gjyfJrhF0eFEP2WzpiMDsl+0kvHuaDcfScnmn2vfLwMhCzSLNWEp5rf7A
         5LLM3LpIKAKHfBUjQKdGGMN+YVIasWak87qIyAq5cFgkQpXuAyxNmJiaPyEn0Hk2UQTa
         BmV4K9kZXyWigWqSpuNaHipZjbfUivL51n3nqEvtzPriU8hEeApahNXMf+FIjy5kg+Yd
         /uCw==
X-Gm-Message-State: ACrzQf3JqHoOOgHWQw7lk98ZTwmpwLyiux/jb2sORyP0JiNlbcL/mrbh
        lkTkS7BL0HdqQ0ZeS3kVnwU=
X-Google-Smtp-Source: AMsMyM5oF/D+J68qyYf7OpinzoVRIca5njlKZiVt120+6mGZCZeIlXSoEubnaQQ/aKTMqvFacsOwCw==
X-Received: by 2002:a17:906:ef8f:b0:78e:28e7:6c64 with SMTP id ze15-20020a170906ef8f00b0078e28e76c64mr9497023ejb.165.1666022560203;
        Mon, 17 Oct 2022 09:02:40 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b0073d5948855asm6389629ejo.1.2022.10.17.09.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:02:39 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/7] mm: vmap: Add purge_vmap_area_lazy trace event
Date:   Mon, 17 Oct 2022 18:02:27 +0200
Message-Id: <20221017160233.16582-4-urezki@gmail.com>
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

It is for debug purpose to track number of freed vmaps
including a range it occurs on.

To: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/vmap.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/trace/events/vmap.h b/include/trace/events/vmap.h
index 504870d95a4e..2af2b84c6eb7 100644
--- a/include/trace/events/vmap.h
+++ b/include/trace/events/vmap.h
@@ -50,6 +50,39 @@ TRACE_EVENT(alloc_vmap_area,
 		__entry->vstart, __entry->vend, __entry->failed)
 );
 
+/**
+ * purge_vmap_area_lazy - called when vmap areas were lazily freed
+ * @start:		purging start address
+ * @end:		purging end address
+ * @npurged:	numbed of purged vmap areas
+ *
+ * This event is used for a debug purpose. It gives some
+ * indication about start:end range and how many objects
+ * are released.
+ */
+TRACE_EVENT(purge_vmap_area_lazy,
+
+	TP_PROTO(unsigned long start, unsigned long end,
+		unsigned int npurged),
+
+	TP_ARGS(start, end, npurged),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned int, npurged)
+	),
+
+	TP_fast_assign(
+		__entry->start = start;
+		__entry->end = end;
+		__entry->npurged = npurged;
+	),
+
+	TP_printk("start=0x%lx end=0x%lx num_purged=%u",
+		__entry->start, __entry->end, __entry->npurged)
+);
+
 #endif /*  _TRACE_VMAP_H */
 
 /* This part must be outside protection */
-- 
2.30.2

