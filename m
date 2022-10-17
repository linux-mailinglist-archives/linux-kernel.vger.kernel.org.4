Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356D160131C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJQQCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJQQCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:02:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B626D841
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u21so16713359edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/1RiMr1eJ0x+wK6LRLfk+CIs20GXMv9Cr5BUn6E+1A=;
        b=DLer6Af9yKSB5ehlJqsvjiavXklY9gP8YgB5+o0/x2C9g/bsjaDsVai9moAt1vqXpR
         gmwM1KoesEPNSUP55KIbw3TmwNkAO8zKzomWb6tfPyWGKUobzY7e3nTOjwhoCx46FPci
         T8q4RRP3HnXnk4gAgnJdu7gpX/NPRbk544624yw1zuJVNv61ZMumR2OFiWQsLqhAtljB
         juk/mi7Jiy9pn87anP15eEoDF2FWJOZZyLayMzxOciaDv2tiFNl6b4uBkbFj5KJnqOmr
         vVpAriTMlwiQyT1AqQe5Lfx2bggjR+L+0OlXbujEaP3SXIT21QBYWmL9+YGPAyOqU+90
         zzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/1RiMr1eJ0x+wK6LRLfk+CIs20GXMv9Cr5BUn6E+1A=;
        b=XfOb/4hdU+SAF2aWhwb9uMW2x+/FiwmuYlHADc/lwSfw/IocYmkyRZyiDA+d68w19+
         eEdxVetj7NIJ7Nd34yTIHvfCh01sBY7aw51sFlo9zrQ3ctNiMIWNKy2TUwNCtsnmqEI6
         +RPsMxvxeQFCrpLR+XallV1kIaLWGwW1GIKOj575g+T/m1MFdTKv0JyYyH7XiYJcoLux
         uo9Q7F4X8HRl4vEkZ0mqjRQC5CknDLjBC5gE+Q9Kttbym+ERxuzlCdt08TQhgNIPuOTr
         ZEHrcj1u3XLmhjrPhSH0qz8sI9QOd90wCTVikWsktMv792tA7RkB7PV+l5hTRYx8xwGT
         5vnQ==
X-Gm-Message-State: ACrzQf0jqxcPjdq2qfUEeiztiI+kHfH8L2vTnJZdmwBg8JVkghDq583E
        Eu+iu6f/v3mPcKxRHeV4EoM=
X-Google-Smtp-Source: AMsMyM7j6l6EW5hrjHaMWS0m06ylnM0/tLTszR1u9HVA9Id5jZFLJTLjoArgj3EMPX3y0vr6F9NWzg==
X-Received: by 2002:aa7:dd45:0:b0:458:7474:1fbe with SMTP id o5-20020aa7dd45000000b0045874741fbemr10980661edw.334.1666022558782;
        Mon, 17 Oct 2022 09:02:38 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b0073d5948855asm6389629ejo.1.2022.10.17.09.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:02:38 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/7] mm: vmap: Add a purge_vmap_area_lazy trace event
Date:   Mon, 17 Oct 2022 18:02:26 +0200
Message-Id: <20221017160233.16582-3-urezki@gmail.com>
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

