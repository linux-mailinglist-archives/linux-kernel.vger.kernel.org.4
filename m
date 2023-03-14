Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08696B9F39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCNTB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCNTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B61449C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678820467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1qMXUw9dsgBVhjNMR0OfieQvkRg7GOetq5N/8/ayAmg=;
        b=YAGbhl6LDyKhPBGY7BgVw5FFBtMt59yIadd986T5x5SIuxEPIwp1jFdB9zUzSzbl9tStNP
        0ZotOOSmH/O0auGV+9mwBgKsuiUCrfd517D5iCcSHV7in1BA2YJ3ZH+9UpMcF/ign7ieuo
        2NVt2O46zZC5VKwlkmjt/uN3RW7KdKc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-Qza4perdPzSYms_2eeHgDQ-1; Tue, 14 Mar 2023 15:01:04 -0400
X-MC-Unique: Qza4perdPzSYms_2eeHgDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 665D83C1178D;
        Tue, 14 Mar 2023 19:01:03 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F17A2166B26;
        Tue, 14 Mar 2023 19:01:03 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 57D0F4039C28C; Tue, 14 Mar 2023 16:00:44 -0300 (-03)
Message-ID: <20230314185951.577895774@redhat.com>
User-Agent: quilt/0.67
Date:   Tue, 14 Mar 2023 15:59:16 -0300
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
Subject: [PATCH v6 02/12] this_cpu_cmpxchg: loongarch: switch this_cpu_cmpxchg to locked, add _local function
References: <20230314185914.836510860@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 


