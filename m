Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE3603208
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiJRSLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJRSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:11:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430752A402
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:11:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a67so21677911edf.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGvV10NBcCrSezhTjPfao8bP5T+d+bVsisSq+cCouQY=;
        b=cp/WUR6aCWDI+OCpdo1Mqr37ZrkfYXFwt2cAJh73Rf++Ascr6Pz5amkT4eshLOmmx5
         I0sXthOSWHzTxx7KwTkIx5m4VZyF/ULV3atv3AnIicjKIPTEetEh2ZZLctb+ClyI0De/
         HxvvI0ijAX38uAiMRAP6Xop6Ar7rmg9DsM+kdALIDC2oqA0emaacv5H62+RRe09rHxOJ
         0aBVQG16MsalBddkiNBvDbV5KYggQzgZwcDkzQ+CuOZ8VQiCGuzWTvV8hjafJ5trvg7A
         YmMWXKMxxqXNtEF6deex7PGOzGkiFnz/NsX00cO4/cIY6JCqUTNPCJiLqUM4jU9XVnoi
         +5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGvV10NBcCrSezhTjPfao8bP5T+d+bVsisSq+cCouQY=;
        b=On5lEBzWigNsDTcA/4RLi7CHzx2dwRops24GYcO1VGLgsAblL1TGr95BLEPuhCOJ8b
         mkLkhtDpGdGBqgXgpi3KeuG5mzSP4SZZgNWvD1s6ooZ6McZ5si2feZGkjjVLmTImm4O1
         Y11hTrHX4Gnpn7f/U0blCVeUAYS2MoAuBlYrG6eNrQs9/zpMMvjnVQ8Mn8TNQCcuL/Cw
         McRD+9xb8BF15mYApnWaynfq6VpvZ1GSbyBPtN/khRN97B0d8jqzZVa+AZDTqkDIa88B
         mpvd5nsTWcqMAJL3wqn34VCDPIABvpTUcyIRWVPtfcCN/nBsBlzW90b05QWzwAGvbdzs
         pM9g==
X-Gm-Message-State: ACrzQf1I1135y3b+sZ8EIFEzOM9Fo/A7RMCFlw2Wp0REYhkN6AQMbfl+
        y0habHUTRxjG3ylB5ho//v/df5HZQew=
X-Google-Smtp-Source: AMsMyM4gAfyaTp00ZrQx53AEKrsE2jZKlpRzrjlGcl07GaznwjzM2RvcbfXk66RxgAWkyqnshjwPuw==
X-Received: by 2002:a05:6402:320e:b0:45c:ae50:dbca with SMTP id g14-20020a056402320e00b0045cae50dbcamr3810327eda.104.1666116659623;
        Tue, 18 Oct 2022 11:10:59 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b007877ad05b32sm7739302ejf.208.2022.10.18.11.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:10:59 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 3/7] mm: vmalloc: Add free_vmap_area_noflush trace event
Date:   Tue, 18 Oct 2022 20:10:49 +0200
Message-Id: <20221018181053.434508-4-urezki@gmail.com>
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

This event is used in order to validate/debug a start address
of freed VA, number of currently outstanding and maximum allowed
areas.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/vmalloc.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/trace/events/vmalloc.h b/include/trace/events/vmalloc.h
index afeb8003a0f2..ad4e02191f35 100644
--- a/include/trace/events/vmalloc.h
+++ b/include/trace/events/vmalloc.h
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
 #endif /*  _TRACE_VMALLOC_H */
 
 /* This part must be outside protection */
-- 
2.30.2

