Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62315E8DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiIXPW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiIXPWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6F80F49
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664032962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUeQREelS5Rh9IXzWSL5LmYfttFnlORFlEDP5NM1JJE=;
        b=Ix2RY/4Jde5sKwtdYlDXxi7A1o8ZA9kHKouIlpTjqYc/FKR8yeEHJmUxUwUQywPJhzC9Nn
        Imz7wuKlPeNLyrQmR3sOecNruhovSKL9QhFgeYdoFJFV8HeIz7G51CCxAkTWAGARUNJ1Ci
        n2CZ8rLKcqqRMI2rt9gav4wY3zjhPns=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-S95I4ovTO0q5jRXSl3qK8w-1; Sat, 24 Sep 2022 11:22:41 -0400
X-MC-Unique: S95I4ovTO0q5jRXSl3qK8w-1
Received: by mail-wm1-f72.google.com with SMTP id p24-20020a05600c1d9800b003b4b226903dso4337060wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TUeQREelS5Rh9IXzWSL5LmYfttFnlORFlEDP5NM1JJE=;
        b=xSYF0ZAvSNmH03WouVtC6q8joWqIjNcYl5GxVTANn3PKxc51plPZRn8VTzrdswmMQg
         LG5gmkvpjPmLl3MBTWmv5icPmkG7N84no83RRBudMRnTecYcrP7fujEb0L0NdP9MPY08
         TNwejajgxOhebOrJln3ForDLM21lp8ClRsx8iUqcwE4ywUpjmUeXg9pzSTqFwbRSJqHx
         NX+3CgGeUk+8QiYsE5YS6E4y227PCPCELZLGUlOvhpJsCRSYeLrcN5ty4M1rVCYTN5dg
         TqiXA8sylR381K6VdMsMpY9U+JHzbwYiHkX9WffHcbiWLpmJ+kxQT05uu3W7FR1BSNRf
         0J4w==
X-Gm-Message-State: ACrzQf23Kx1KEPh9B1zXEcU8fpjRXnzxU/8Xl24wnnF1DscQ9KtgLEKN
        W1QNXnYGNr5y84DTnC7TPl7Z1TKhhTcRGza5rkAXwXo9sGVXSsUEYD03rVhxxSwcFygBZ+WtIOo
        b/0NA144I+aJpisO0aUIVVuc=
X-Received: by 2002:a05:600c:3781:b0:3a6:804a:afc with SMTP id o1-20020a05600c378100b003a6804a0afcmr16215759wmr.27.1664032960277;
        Sat, 24 Sep 2022 08:22:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5m/4w+5hkvjp8DxE5I0zgzzGcCHocqRX8TyR/j15JVMnw/b2kAHfK1Vm5eShxot1oDE/8fJQ==
X-Received: by 2002:a05:600c:3781:b0:3a6:804a:afc with SMTP id o1-20020a05600c378100b003a6804a0afcmr16215737wmr.27.1664032960043;
        Sat, 24 Sep 2022 08:22:40 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id e19-20020a5d5953000000b00228c792aaaasm9941182wri.100.2022.09.24.08.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:22:39 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v8 3/5] mm/vmstat: Do not queue vmstat_update if tick is stopped
Date:   Sat, 24 Sep 2022 16:22:25 +0100
Message-Id: <20220924152227.819815-4-atomlin@redhat.com>
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

From: Marcelo Tosatti <mtosatti@redhat.com>

From the vmstat shepherd, for CPUs that have the tick stopped, do not
queue local work to flush the per-CPU vmstats, since in that case the
flush is performed on return to userspace or when entering idle. Also
cancel any delayed work on the local CPU, when entering idle on nohz
full CPUs. Per-CPU pages can be freed remotely from housekeeping CPUs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
---
 mm/vmstat.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 472175642bd9..3b9a497965b4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -29,6 +29,7 @@
 #include <linux/page_ext.h>
 #include <linux/page_owner.h>
 #include <linux/migrate.h>
+#include <linux/tick.h>
 
 #include "internal.h"
 
@@ -1990,19 +1991,23 @@ static void vmstat_update(struct work_struct *w)
  */
 void quiet_vmstat(void)
 {
+	struct delayed_work *dw;
+
 	if (system_state != SYSTEM_RUNNING)
 		return;
 
 	if (!is_vmstat_dirty())
 		return;
 
+	refresh_cpu_vm_stats(false);
+
 	/*
-	 * Just refresh counters and do not care about the pending delayed
-	 * vmstat_update. It doesn't fire that often to matter and canceling
-	 * it would be too expensive from this path.
-	 * vmstat_shepherd will take care about that for us.
+	 * If the tick is stopped, cancel any delayed work to avoid
+	 * interruptions to this CPU in the future.
 	 */
-	refresh_cpu_vm_stats(false);
+	dw = &per_cpu(vmstat_work, smp_processor_id());
+	if (delayed_work_pending(dw) && tick_nohz_tick_stopped())
+		cancel_delayed_work(dw);
 }
 
 /*
@@ -2024,6 +2029,9 @@ static void vmstat_shepherd(struct work_struct *w)
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
 
+		if (tick_nohz_tick_stopped_cpu(cpu))
+			continue;
+
 		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 
-- 
2.37.1

