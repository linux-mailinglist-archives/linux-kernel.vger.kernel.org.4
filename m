Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B484F62E1BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbiKQQ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240456AbiKQQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0622014023
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668702216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WFPI0NFugsCul//0RfsqwViFOLqhD0XmwgH8bMY+Xk=;
        b=B5O6pngTS15MpjfnDSd7vyvx0B3ws6w67nyxwTVvhxBANsN/saSGzmGpRFtGLSZYHswVKu
        P7LJRTNK3NWZ9Sp6lmBuSIYY5tn+CZu5U97N5xSLbR9mcB/pvRAsqivwFZ3ANFG5jbXgho
        v4wlP5F6SNeiJr6KQVQqiCHgJE9nNYI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-lX4sOq1TM_KTv2Fj2jL6bA-1; Thu, 17 Nov 2022 11:23:31 -0500
X-MC-Unique: lX4sOq1TM_KTv2Fj2jL6bA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 545EE3C11EAE;
        Thu, 17 Nov 2022 16:23:31 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C09A35429;
        Thu, 17 Nov 2022 16:23:31 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>, pauld@redhat.com
Subject: [PATCH v5 2/2] cpuhp: Set cpuhp target for boot cpu
Date:   Thu, 17 Nov 2022 11:23:29 -0500
Message-Id: <20221117162329.3164999-3-pauld@redhat.com>
In-Reply-To: <20221117162329.3164999-1-pauld@redhat.com>
References: <20221117162329.3164999-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the boot cpu does not go through the hotplug process it ends
up with state == CPUHP_ONLINE but target == CPUHP_OFFLINE.
So set the target to match in boot_cpu_hotplug_init().

Signed-off-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 979de993f853..3f704a8896b0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2690,6 +2690,7 @@ void __init boot_cpu_hotplug_init(void)
 	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
+	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
 }
 
 /*
-- 
2.31.1

