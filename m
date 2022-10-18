Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9967603207
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJRSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJRSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:11:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9BD72EC2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:11:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id d26so34271072ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FJEHOoMkjVGRlOZfU33xcjvk8gVc0gJkKWOVMhT1hk=;
        b=YKVioc1cJrhW8j2q33izuLomY4JfzAqH6+8bDDXIqMvE4+VgTl1+DWt9X0JvJa96dS
         bjWwF2UlwQLI14UU085xpm9npwWQbW4iK3Sw30+tefJYDNaUP06vzKyETch6tOA7s2Yd
         F/KUA26JImniA6eEzt0bjQJpH9fNxjeIpw0qyvleGFF+p+lWtXc6UbwyirQn8qCbwUMe
         kirJf4P99BF4BV0Sr1O9g+L44sDFNkW71NnO7pDKFvrceM7QzalCKzDHyiuiz6U9WYML
         HoagkIuOoJwwxsMTZouT8vD0rRQNwMlVMjzNwyx2Wv3v6p+RV9btb5h605iO1R6WG655
         p70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FJEHOoMkjVGRlOZfU33xcjvk8gVc0gJkKWOVMhT1hk=;
        b=uC7zHmAVYPvmBeny5eVdOUheOJMkkKW5VZxS4d2iMwcJUJei5y7t3rTDPzzt9xoybC
         U4D9AYTzWSKHybroiAwu7QiqUjzgvU4VMcVHoky8upr1p1DY+oR7hyHxHEl9NqyOAxmZ
         UwT0JIQeQjeLfDcM10VotsFE6LsnHAjmWKGHzeTGRe4lDnw0d2xMnos6bVT2oVt07Rlr
         N4zWKdAs82ZJOveoaq01G3wB3dhI5vVwxFDakbcidNm0W9Hr3LC7Zsk5dbaDYlJEowvA
         UUdyfA2zz+vdb6+vJw8r97sOwLAG0GYikBKYwCxwH3pl2COUS4romGeHL46cfFdn1fr6
         524Q==
X-Gm-Message-State: ACrzQf23PpkaeUsvDNZh0hYWwMJlyzlGBNmXf48U6cI7lnJfwB3CSKHU
        /9R9qJHx/w3eaItHFh2eI60=
X-Google-Smtp-Source: AMsMyM507Q8XFIA9G1zyTC/2DkCVGHsJGqQ6bAsF53Q9yeXxoWcJRJz+Sb3DI7QS6UGEGgXc4qL7vw==
X-Received: by 2002:a17:907:97c2:b0:78d:accc:c0a9 with SMTP id js2-20020a17090797c200b0078dacccc0a9mr3400841ejc.312.1666116658572;
        Tue, 18 Oct 2022 11:10:58 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b007877ad05b32sm7739302ejf.208.2022.10.18.11.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:10:58 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 2/7] mm: vmalloc: Add purge_vmap_area_lazy trace event
Date:   Tue, 18 Oct 2022 20:10:48 +0200
Message-Id: <20221018181053.434508-3-urezki@gmail.com>
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

It is for debug purpose to track number of freed vmap
areas including a range it occurs on.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/vmalloc.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/trace/events/vmalloc.h b/include/trace/events/vmalloc.h
index 39fbd77c91e7..afeb8003a0f2 100644
--- a/include/trace/events/vmalloc.h
+++ b/include/trace/events/vmalloc.h
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
 #endif /*  _TRACE_VMALLOC_H */
 
 /* This part must be outside protection */
-- 
2.30.2

