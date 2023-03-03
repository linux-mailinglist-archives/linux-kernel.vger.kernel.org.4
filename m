Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7DA6AA06E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjCCUCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjCCUBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:01:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6477D61890
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677873635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hjd5gtUB1FFqfcJWUv9qrW5kcd1bszAAtI+X6kwFBXk=;
        b=X+m+D57bpiaqCWxNYc9f0RV+z7ZzRDFMqm/PR+j24jhR/NBnjjioJk+vzlTxWs2cl1NmNd
        jor7WW+rLa9BeuI4NcujmTiDVMexYxgf8kf+dTJGEzZ1IPgAP03JvF03RS1SAyV0YpSmK3
        /aV//LklbOuLZKFFAE1NN1JS6E1vOeg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-cMDpLZCKMwyZ6cNzNBnl9Q-1; Fri, 03 Mar 2023 15:00:33 -0500
X-MC-Unique: cMDpLZCKMwyZ6cNzNBnl9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BD4F280AA49;
        Fri,  3 Mar 2023 20:00:32 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 093FF40BC781;
        Fri,  3 Mar 2023 20:00:32 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 986474291962E; Fri,  3 Mar 2023 17:00:12 -0300 (-03)
Message-ID: <20230303195908.877083312@redhat.com>
User-Agent: quilt/0.67
Date:   Fri, 03 Mar 2023 16:58:46 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 05/11] this_cpu_cmpxchg: x86: switch this_cpu_cmpxchg to locked, add _local function
References: <20230303195841.310844446@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
change x86's this_cpu_cmpxchg_ helpers to be atomic.
and add this_cpu_cmpxchg_local_ helpers which are not atomic.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/arch/x86/include/asm/percpu.h
===================================================================
--- linux-vmstat-remote.orig/arch/x86/include/asm/percpu.h
+++ linux-vmstat-remote/arch/x86/include/asm/percpu.h
@@ -197,11 +197,11 @@ do {									\
  * cmpxchg has no such implied lock semantics as a result it is much
  * more efficient for cpu local operations.
  */
-#define percpu_cmpxchg_op(size, qual, _var, _oval, _nval)		\
+#define percpu_cmpxchg_op(size, qual, _var, _oval, _nval, lockp)	\
 ({									\
 	__pcpu_type_##size pco_old__ = __pcpu_cast_##size(_oval);	\
 	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
-	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
+	asm qual (__pcpu_op2_##size(lockp "cmpxchg", "%[nval]",		\
 				    __percpu_arg([var]))		\
 		  : [oval] "+a" (pco_old__),				\
 		    [var] "+m" (_var)					\
@@ -279,16 +279,20 @@ do {									\
 #define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, , pcp, val)
 #define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, , pcp, val)
 #define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, , pcp, val)
-#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, , pcp, oval, nval)
-#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, , pcp, oval, nval)
-#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, , pcp, oval, nval)
+#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, , pcp, oval, nval, "")
+#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, , pcp, oval, nval, "")
+#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, , pcp, oval, nval, "")
 
 #define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, volatile, pcp, val)
 #define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, volatile, pcp, val)
 #define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, volatile, pcp, val)
-#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval)
-#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval)
-#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_local_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval, "")
+#define this_cpu_cmpxchg_local_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval, "")
+#define this_cpu_cmpxchg_local_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval, "")
+
+#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval, LOCK_PREFIX)
+#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval, LOCK_PREFIX)
+#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval, LOCK_PREFIX)
 
 #ifdef CONFIG_X86_CMPXCHG64
 #define percpu_cmpxchg8b_double(pcp1, pcp2, o1, o2, n1, n2)		\
@@ -319,16 +323,17 @@ do {									\
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
-#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
+#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval, "")
 
-#define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
-#define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
-#define this_cpu_add_8(pcp, val)		percpu_add_op(8, volatile, (pcp), val)
-#define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
-#define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
-#define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
-#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
-#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
+#define this_cpu_read_8(pcp)				percpu_from_op(8, volatile, "mov", pcp)
+#define this_cpu_write_8(pcp, val)			percpu_to_op(8, volatile, "mov", (pcp), val)
+#define this_cpu_add_8(pcp, val)			percpu_add_op(8, volatile, (pcp), val)
+#define this_cpu_and_8(pcp, val)			percpu_to_op(8, volatile, "and", (pcp), val)
+#define this_cpu_or_8(pcp, val)				percpu_to_op(8, volatile, "or", (pcp), val)
+#define this_cpu_add_return_8(pcp, val)			percpu_add_return_op(8, volatile, pcp, val)
+#define this_cpu_xchg_8(pcp, nval)			percpu_xchg_op(8, volatile, pcp, nval)
+#define this_cpu_cmpxchg_local_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval, "")
+#define this_cpu_cmpxchg_8(pcp, oval, nval)		percpu_cmpxchg_op(8, volatile, pcp, oval, nval, LOCK_PREFIX)
 
 /*
  * Pretty complex macro to generate cmpxchg16 instruction.  The instruction


