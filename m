Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D309B5E8DC8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiIXPWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIXPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C9770E56
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664032957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJy6J71aJA3IuazPVpZvOJ+o0HTfRS9wHinNTI5//yw=;
        b=OetVel6WfVEaemmg6Mg6RkZGHTVlcQDaUYxuXTIw9D5xaHztNY6DSP5T0kl0sqdynIbqdU
        OxoLZv9K/AL2VLRd4iXzd0PoexCM9KcAHqHuQGLmGx92bWYNVJ6O61zZW8JZHnjVudrj/e
        xg6cp0E8ibBw0UtHewvEY3G8JXpomt0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-438-7Rh1qVlwM1GhsNQnD08-UA-1; Sat, 24 Sep 2022 11:22:36 -0400
X-MC-Unique: 7Rh1qVlwM1GhsNQnD08-UA-1
Received: by mail-wm1-f69.google.com with SMTP id i132-20020a1c3b8a000000b003b339a8556eso1631956wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TJy6J71aJA3IuazPVpZvOJ+o0HTfRS9wHinNTI5//yw=;
        b=yRl7BbKTu4Uk22VAt8GPei6WIn8o17pLDb90pTiMDq6y1dx+IIjAr91ndpMrCHLP/e
         qXeMUeoVxgljQ2wJzBPOzLs+u2KNd7ZRnbIuPTnmyQny5HaXqsDE4p7TdpcqzVh4pchV
         dXFVA4jz5ZNUu/1UC71VKHr+i1qM52a57S6qti65bBY8AMQolDyNQqHICO+ISCB7iW7O
         zcljSgM3HqCDJtpcGZPb6KdCg7Kp9WMmtw9NJHf49WjKqlxQF9o204t6hotngsuIUibq
         Ol645Rb4MulTvO3qpH68vuSuGG7lY/q0egYFQjat9VeQ+hoeKDwQkd0OkKUg4KHXfFmF
         ARBg==
X-Gm-Message-State: ACrzQf31Nd6QPaWli1iwRa8IaUlKGT/QzOtsHmuchIMncyinJ3skCkmP
        BK+kKOQ9Zpj1egy+ad2J7/gvuwT1Hs4adIeHw0dSoVMDkOIQIwyWEJLHqxjKuiqzG4gsF/rVnBg
        ybccgnAywBW9nZ65XWI7Y9GU=
X-Received: by 2002:adf:fd47:0:b0:228:dbab:8f5d with SMTP id h7-20020adffd47000000b00228dbab8f5dmr8180139wrs.524.1664032954966;
        Sat, 24 Sep 2022 08:22:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6sU8DZqkudooT7dcV2k2CxDwD6Eg+x8I5ijbDfegC963F4VJd1EaU/hhsShwvAdgEZ3nK3Sg==
X-Received: by 2002:adf:fd47:0:b0:228:dbab:8f5d with SMTP id h7-20020adffd47000000b00228dbab8f5dmr8180125wrs.524.1664032954760;
        Sat, 24 Sep 2022 08:22:34 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p21-20020a1c5455000000b003b27f644488sm5396182wmi.29.2022.09.24.08.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:22:29 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v8 1/5] mm/vmstat: Add CPU-specific variable to track a vmstat discrepancy
Date:   Sat, 24 Sep 2022 16:22:23 +0100
Message-Id: <20220924152227.819815-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220924152227.819815-1-atomlin@redhat.com>
References: <20220924152227.819815-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a CPU-specific variable namely vmstat_dirty to indicate
if a vmstat imbalance is present for a given CPU. Therefore, at
the appropriate time, we can fold all the remaining differentials.
This patch also provides trivial helpers for modification and testing.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 mm/vmstat.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 90af9a8572f5..24c67b2e58fd 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -195,6 +195,22 @@ void fold_vm_numa_events(void)
 #endif
 
 #ifdef CONFIG_SMP
+static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+
+static inline void vmstat_mark_dirty(void)
+{
+	this_cpu_write(vmstat_dirty, true);
+}
+
+static inline void vmstat_clear_dirty(void)
+{
+	this_cpu_write(vmstat_dirty, false);
+}
+
+static inline bool is_vmstat_dirty(void)
+{
+	return this_cpu_read(vmstat_dirty);
+}
 
 int calculate_pressure_threshold(struct zone *zone)
 {
-- 
2.37.1

