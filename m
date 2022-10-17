Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828F060131D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJQQCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJQQCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:02:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562AE6B64B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y14so25952432ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW9p6gqCP8BTkpd3KnUrua005vAUzWUKXVDnMgK4wSE=;
        b=p7ue2b5p1cSoOlv54tUktRDTVPP4c92MupghFTAiB7PAfixY8Od9qA4Anal/wav/k+
         ayqBy3iPRORMqag2K69iY07DYl0HC/MFiVl0niW9mb/mMkozpYDdKxgWRPmQY4WyFLwu
         c9bbrRIb9lnALtd/DkpaBTHEaWDXXlk4iEjozNede5qOCwtpxo2YI3MMQ/8tIBJx6Ac3
         lHqr0+XpxWjPTZJqA0q0MKZX7RC6ErCfQ9xix0Bk3U1F9eHLUbojgx84U9OQ5T/ntJBR
         Yj6VwsrXhANBCHApVotBbiHAriRfQY313+JPqkUTJLeBHvSR6ADuaGgrlCO2RbWCDOW8
         kmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UW9p6gqCP8BTkpd3KnUrua005vAUzWUKXVDnMgK4wSE=;
        b=AJr+ahjz/DNTHw/hC7dV/VK3pfUk6bq+o0oRGd4Yb/2Es6tCStrJ+fdzUKEjB1HY3S
         8jzvReX7ERMH+zaNUlxo0iDSAvKAFxjWAIV6Ou3d1vYl9JzVkh+cuOFhtx4fgefjjkIk
         hkNl5f6z5t/Om/bpLqpYzXpFhjwLxMXr3tBNCKtUcL09CABP9Z9EN+IAoZWT1HYA5+QO
         zVOvliiLOFwwQIMNFKMDAVJiN1W/A4U8Mb0TjD3VdMPzNhtFtWlNbkOz4jAOwxek6U64
         l5WLZcFy9FjSU4fPj6/DfRORaDZFOL412s5cCY0LkzhXA9rGv07dV/TeEiKcMH5l3Ikc
         Uajw==
X-Gm-Message-State: ACrzQf0IinmqyfcxF3JZAtiILFtib9wXKH6tw2sPG7+mUfeGNo22TDSO
        REtbAQVejlWM5WD/4VdOY08=
X-Google-Smtp-Source: AMsMyM5SxZrbOhitrGkJnUUrBOtivtJ91xTMK9BjD/W3QMvvFR3FFy8S4KBWCllqWlOu7s/nUtGDyA==
X-Received: by 2002:a17:906:6a25:b0:78d:4906:b960 with SMTP id qw37-20020a1709066a2500b0078d4906b960mr9490255ejc.647.1666022557707;
        Mon, 17 Oct 2022 09:02:37 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b0073d5948855asm6389629ejo.1.2022.10.17.09.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:02:37 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/7] mm: vmap: Add alloc_vmap_area trace event
Date:   Mon, 17 Oct 2022 18:02:25 +0200
Message-Id: <20221017160233.16582-2-urezki@gmail.com>
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

It is for a debug purpose and for validation of passed parameters.

To: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/vmap.h | 56 +++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 include/trace/events/vmap.h

diff --git a/include/trace/events/vmap.h b/include/trace/events/vmap.h
new file mode 100644
index 000000000000..504870d95a4e
--- /dev/null
+++ b/include/trace/events/vmap.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM vmap
+
+#if !defined(_TRACE_VMAP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_VMAP_H
+
+#include <linux/tracepoint.h>
+
+/**
+ * alloc_vmap_area - called when a new vmap allocation occurs
+ * @addr:	an allocated address
+ * @size:	a requested size
+ * @align:	a requested alignment
+ * @vstart:	a requested start range
+ * @vend:	a requested end range
+ * @failed:	an allocation failed or not
+ *
+ * This event is used for a debug purpose, it can give an extra
+ * information for a developer about how often it occurs and which
+ * parameters are passed for further validation.
+ */
+TRACE_EVENT(alloc_vmap_area,
+
+	TP_PROTO(unsigned long addr, unsigned long size, unsigned long align,
+		unsigned long vstart, unsigned long vend, int failed),
+
+	TP_ARGS(addr, size, align, vstart, vend, failed),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, addr)
+		__field(unsigned long, size)
+		__field(unsigned long, align)
+		__field(unsigned long, vstart)
+		__field(unsigned long, vend)
+		__field(int, failed)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->size = size;
+		__entry->align = align;
+		__entry->vstart = vstart;
+		__entry->vend = vend;
+		__entry->failed = failed;
+	),
+
+	TP_printk("va_start: %lu size=%lu align=%lu vstart=0x%lx vend=0x%lx failed=%d",
+		__entry->addr, __entry->size, __entry->align,
+		__entry->vstart, __entry->vend, __entry->failed)
+);
+
+#endif /*  _TRACE_VMAP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.30.2

