Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC4716563
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjE3O5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjE3O5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DBAB0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685458617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zB34+gA9q6N2mJEfFmSt2POPWMX6epdGtnjhsa8vBnc=;
        b=iBCAgAnmzLl7pJbLrXIGp0tLeTly6KSI2RePd+9IiCIYcxesDLCKtzWPOwWleHe7Y+hjRX
        +uv2ng/UFTsZZHw/OXcaPa7iNRPFDovreXw9GbSHAr7Gxmtb0iWFS7vd7Q2OfiAEnYnr7p
        9/TR1DCoYyKW+DhKlnRIDK4YlWCGcpw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-M5R71YDnOC6zHMxN_4ZF3Q-1; Tue, 30 May 2023 10:56:51 -0400
X-MC-Unique: M5R71YDnOC6zHMxN_4ZF3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25935101AA68;
        Tue, 30 May 2023 14:56:51 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F62C154D3;
        Tue, 30 May 2023 14:56:50 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 57A59401E150C; Tue, 30 May 2023 11:56:33 -0300 (-03)
Message-ID: <20230530145335.930262644@redhat.com>
User-Agent: quilt/0.67
Date:   Tue, 30 May 2023 11:52:37 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 3/4] workqueue: add schedule_on_each_cpumask helper
References: <20230530145234.968927611@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a schedule_on_each_cpumask function, equivalent to
schedule_on_each_cpu but accepting a cpumask to operate.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

Index: linux-vmstat-remote/kernel/workqueue.c
===================================================================
--- linux-vmstat-remote.orig/kernel/workqueue.c
+++ linux-vmstat-remote/kernel/workqueue.c
@@ -3455,6 +3455,56 @@ int schedule_on_each_cpu(work_func_t fun
 	return 0;
 }
 
+
+/**
+ * schedule_on_each_cpumask - execute a function synchronously on each
+ * CPU in "cpumask", for those which are online.
+ *
+ * @func: the function to call
+ * @mask: the CPUs which to call function on
+ *
+ * schedule_on_each_cpu() executes @func on each specified CPU that is online,
+ * using the system workqueue and blocks until all such CPUs have completed.
+ * schedule_on_each_cpu() is very slow.
+ *
+ * Return:
+ * 0 on success, -errno on failure.
+ */
+int schedule_on_each_cpumask(work_func_t func, cpumask_t *cpumask)
+{
+	int cpu;
+	struct work_struct __percpu *works;
+	cpumask_var_t effmask;
+
+	works = alloc_percpu(struct work_struct);
+	if (!works)
+		return -ENOMEM;
+
+	if (!alloc_cpumask_var(&effmask, GFP_KERNEL)) {
+		free_percpu(works);
+		return -ENOMEM;
+	}
+
+	cpumask_and(effmask, cpumask, cpu_online_mask);
+
+	cpus_read_lock();
+
+	for_each_cpu(cpu, effmask) {
+		struct work_struct *work = per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, func);
+		schedule_work_on(cpu, work);
+	}
+
+	for_each_cpu(cpu, effmask)
+		flush_work(per_cpu_ptr(works, cpu));
+
+	cpus_read_unlock();
+	free_percpu(works);
+	free_cpumask_var(effmask);
+	return 0;
+}
+
 /**
  * execute_in_process_context - reliably execute the routine with user context
  * @fn:		the function to execute
Index: linux-vmstat-remote/include/linux/workqueue.h
===================================================================
--- linux-vmstat-remote.orig/include/linux/workqueue.h
+++ linux-vmstat-remote/include/linux/workqueue.h
@@ -450,6 +450,7 @@ extern void __flush_workqueue(struct wor
 extern void drain_workqueue(struct workqueue_struct *wq);
 
 extern int schedule_on_each_cpu(work_func_t func);
+extern int schedule_on_each_cpumask(work_func_t func, cpumask_t *cpumask);
 
 int execute_in_process_context(work_func_t fn, struct execute_work *);
 


