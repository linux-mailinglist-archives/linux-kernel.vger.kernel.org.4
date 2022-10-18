Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E282603206
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJRSLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJRSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:11:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076212A402
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:10:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r14so21722458edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=se3AV6vebDZ5YP2shntPND551GMkzS6L+QPXNqXiQ7o=;
        b=EiH1XPctTsH40jJoCVZZQ2IWCv/qUknaMjZUF6TgNR1NyiiSgP1FKDRwgS3YgvgusO
         KAuH+P3qhGPDvn9cHgJYQ3UTGZGWiJlnO/BPHA/hsY8Ri9HPyj/YX5Tr7/BV7dnuoHlQ
         AtOfDu0kXX/3QfwsV1hlmwVz9X+MeAL0TpbJIQ2awoBkxBa+iQkwbt4U+XoHEetoQ3J5
         SnhRrjXJuyZiyawCxpUsB/X1SVmr2DP4dlXgGt39dKrXXpQnovJNwgHhtrEYxPAF9Yp5
         zigl8L0Dn6HAeQDpPGtOBDWQmEvL6nC2ySfy50CgtLQmONHTErp3JDAE9H2hq5yQ3prC
         3mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=se3AV6vebDZ5YP2shntPND551GMkzS6L+QPXNqXiQ7o=;
        b=OX1IU61dl/YpJSFrq5FQOwPupjrFA3CjPb9hSpmlpcAYhzOZ3QU73Byg8F65BVkwa6
         w73GdIOmVjra30r/EVr95wWpbs2WkTMl4J8PhSylGe5ritKahZTzXKn74bx7s4aMVOTy
         iACTXSNXE8Q3/Z4TZcDNR1vvLQWy4WFgmbWQEF1Tf+ehm+K5h66BFRY8DKWuzKKqfsOc
         XCLJtX0mVXq8ZNkKGVeLNYswBdbimtNrDHqqbIwbxiQTVwzKVrzwYwnILwivXXRv8roc
         E3tNE8h8LvzmmmIVDPK/NxuZ/LcCG5nJpscIjeDsZaqnl8LwMakz6k/dNSlbDFmHFlzo
         Fkmw==
X-Gm-Message-State: ACrzQf2IE7Be8Htm1vqm1/LwLdME0iGzzL8/pOLhkhmZbT7fJV8Exz3m
        zke7y5mTlglSpzEzVFaIUTE=
X-Google-Smtp-Source: AMsMyM555IpSQr3xQVjxZqzGIi4S+lkctx+n6jalt6F4k/WIUgkQUw6UHLeQ3jOaPacFX26PYZk0HA==
X-Received: by 2002:a05:6402:5193:b0:45c:e2c6:6f0e with SMTP id q19-20020a056402519300b0045ce2c66f0emr3820266edd.29.1666116657449;
        Tue, 18 Oct 2022 11:10:57 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b007877ad05b32sm7739302ejf.208.2022.10.18.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:10:56 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 1/7] mm: vmalloc: Add alloc_vmap_area trace event
Date:   Tue, 18 Oct 2022 20:10:47 +0200
Message-Id: <20221018181053.434508-2-urezki@gmail.com>
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

It is for a debug purpose and for validation of passed parameters.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/vmalloc.h | 56 ++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 include/trace/events/vmalloc.h

diff --git a/include/trace/events/vmalloc.h b/include/trace/events/vmalloc.h
new file mode 100644
index 000000000000..39fbd77c91e7
--- /dev/null
+++ b/include/trace/events/vmalloc.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM vmalloc
+
+#if !defined(_TRACE_VMALLOC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_VMALLOC_H
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
+#endif /*  _TRACE_VMALLOC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.30.2

