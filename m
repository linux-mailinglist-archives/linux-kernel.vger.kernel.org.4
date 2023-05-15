Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0AD703BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245067AbjEOSHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243789AbjEOSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931F51F308
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684173826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6QfpHdKEKCW5B9XIpfLylgQS/cYcg8nRN+BFpTs113M=;
        b=PwGwixU1u4jEM7y3smS1NzsqGZS8r4lSJE0oMG2AGqz/WvDT+gD2EW5fexitCgPlgTFOEx
        1mCvi6l1hKKHAUh8VlR+WVy+jBuVJoyZM42KGI2Tm352XVyD31wfno9LI3CHSHNgVTt5rT
        Lsq/28IMIpRs1BmaFkBuSngZPtkmxsQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-4rDDS1EbMJedd7bEsqx9QA-1; Mon, 15 May 2023 14:03:44 -0400
X-MC-Unique: 4rDDS1EbMJedd7bEsqx9QA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A8703C0ED50;
        Mon, 15 May 2023 18:03:43 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF5352026D16;
        Mon, 15 May 2023 18:03:42 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 48EDC4161E525; Mon, 15 May 2023 15:02:17 -0300 (-03)
Message-ID: <20230515180138.491271416@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 15 May 2023 15:00:18 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v8 03/13] this_cpu_cmpxchg: loongarch: switch this_cpu_cmpxchg to locked, add _local function
References: <20230515180015.016409657@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goal is to have vmstat_shepherd to transfer from
per-CPU counters to global counters remotely. For this,
an atomic this_cpu_cmpxchg is necessary.

Following the kernel convention for cmpxchg/cmpxchg_local,
add this_cpu_cmpxchg_local helpers to Loongarch.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

Index: linux-vmstat-remote/arch/loongarch/include/asm/percpu.h
===================================================================
--- linux-vmstat-remote.orig/arch/loongarch/include/asm/percpu.h
+++ linux-vmstat-remote/arch/loongarch/include/asm/percpu.h
@@ -150,6 +150,16 @@ static inline unsigned long __percpu_xch
 }
 
 /* this_cpu_cmpxchg */
+#define _protect_cmpxchg(pcp, o, n)				\
+({								\
+	typeof(*raw_cpu_ptr(&(pcp))) __ret;			\
+	preempt_disable_notrace();				\
+	__ret = cmpxchg(raw_cpu_ptr(&(pcp)), o, n);		\
+	preempt_enable_notrace();				\
+	__ret;							\
+})
+
+/* this_cpu_cmpxchg_local */
 #define _protect_cmpxchg_local(pcp, o, n)			\
 ({								\
 	typeof(*raw_cpu_ptr(&(pcp))) __ret;			\
@@ -222,10 +232,15 @@ do {									\
 #define this_cpu_xchg_4(pcp, val) _percpu_xchg(pcp, val)
 #define this_cpu_xchg_8(pcp, val) _percpu_xchg(pcp, val)
 
-#define this_cpu_cmpxchg_1(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
-#define this_cpu_cmpxchg_2(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
-#define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
-#define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_local_1(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_local_2(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_local_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_local_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+
+#define this_cpu_cmpxchg_1(ptr, o, n) _protect_cmpxchg(ptr, o, n)
+#define this_cpu_cmpxchg_2(ptr, o, n) _protect_cmpxchg(ptr, o, n)
+#define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg(ptr, o, n)
+#define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg(ptr, o, n)
 
 #include <asm-generic/percpu.h>
 


