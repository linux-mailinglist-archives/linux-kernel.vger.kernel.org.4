Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8043C5B9F04
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIOPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIOPiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE6382FA1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663256277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MeijtbKvrYGzYu1cjjokAKVDKvkSgGK6+5a9Mt5coG4=;
        b=N+2ypnB/vVV2u7p3mhJr9x53dj38wPqrrgknTF7jioIG3D3NacWcB87RwnGYcwcZr/0gSI
        48u4avVsKuoWLP3YqgwLRinDVMr3Ulu3rxl+0wYrJP9veJ+DgFDptEqNX7u+0npcYnQbyD
        /7p6RVlMfDobKgy3fElC6CAcYqzOdwQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-wpxUSTTZPyCSvepizFF92A-1; Thu, 15 Sep 2022 11:37:53 -0400
X-MC-Unique: wpxUSTTZPyCSvepizFF92A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60680382ECD0;
        Thu, 15 Sep 2022 15:37:53 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D9792166B26;
        Thu, 15 Sep 2022 15:37:53 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [RESEND PATCH v4 2/2] cpuhp: Set cpuhp target for boot cpu
Date:   Thu, 15 Sep 2022 11:37:51 -0400
Message-Id: <20220915153751.2123654-3-pauld@redhat.com>
In-Reply-To: <20220915153751.2123654-1-pauld@redhat.com>
References: <20220915153751.2123654-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

