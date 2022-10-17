Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0130D60131F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiJQQC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJQQCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:02:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD3C6DAD0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id d26so25978875ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8PGF12HowaED9GsfrGSUOr+T+BR5MJRz00gwWuwNBY=;
        b=FwjCcmT197rmgh5QI5e3OYcSXGX0J/38zjdy+NQLWYvd36DTytm0a9xBb/IVvrvF0m
         NeTlftucGk9bI3HSKTXMixH7YlHMB7m/qnAKI+1GzsSdwrrMfD5uVgsEABz9UJ3YKBXF
         diMaxcKQucmoyB8BbBfaSPCvum3Hk6iPW34T2KUZpguWuKRUVCqpjUhaEuIoPME22BTK
         uStcrtd21fD5JEXPENWctXC9cYfaidqN8WOdR5ymvUnmYEBfa98t6dq7oL3aGIpJjgxx
         kSTrDAAJ29nzE08s3MhU+S2C9r/NHfqyHauqVyH3qssZwy8VkCEZj/nIInk/D9vANe+m
         TgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8PGF12HowaED9GsfrGSUOr+T+BR5MJRz00gwWuwNBY=;
        b=eA/D3+GpPFNJItmpOV2zfoiTv1RrNlw5rnk5mCqANrHSgrX68Qq9F9tNGiKetf1mwj
         Fy+RTpJHydCfQ97gFVeiuwwlEOwHHbgy9hz11dYTCJFVbat/qYwS8iL50buSi5P67m/l
         4H279fBUkMgf6UNnS296KKjn/bzE55AUHvJYWB+/pz0zgTIe6Q1R3LRog2q/Wxb4DVP0
         Yk/W27jgArnsw5CobgBjf4VYP9G2wQnfBAP3cNF9dVypf5xB5yfPKGINNpgX98Y/OzUm
         GxuUdv1xfbFHQIrAGDTg8OiFUILXoqHxq8FY4AnNy1Sh3l54iKHx/y2KGtr83zLqeDJ4
         dCyw==
X-Gm-Message-State: ACrzQf2xl6CnjAzSM31eM3VrwYafqH9nN1mJNWqsTjNF5azOsl7r4Y7C
        Eb4l847CZlxWQ6uStYQOWKs=
X-Google-Smtp-Source: AMsMyM7mQD7IJcK53cEQL1/Z+YHex7sxuqWGp8otU30wY2tEfaxu2LL184YVDQk0dPc0p6SpQLXgjg==
X-Received: by 2002:a17:906:d54d:b0:78e:2fbf:ca2a with SMTP id cr13-20020a170906d54d00b0078e2fbfca2amr9476322ejc.488.1666022561205;
        Mon, 17 Oct 2022 09:02:41 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b0073d5948855asm6389629ejo.1.2022.10.17.09.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:02:40 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 3/7] mm: vmap: Add a free_vmap_area_noflush trace event
Date:   Mon, 17 Oct 2022 18:02:28 +0200
Message-Id: <20221017160233.16582-5-urezki@gmail.com>
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

