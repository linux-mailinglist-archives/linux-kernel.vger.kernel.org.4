Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC576B9F44
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCNTCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjCNTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B9B12CD8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678820474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=X5A6sr5GdS/CRp9e0AjLg+A82o3GBDzuPA8yAWqGcJk=;
        b=AvayQ7bVl14fhh1tlqMBj0hXWPb3UWjdATHzH5UJRoGxbyUaZixYSxYZiiv8nsU39IanFV
        7DPDTvK1McUkPXk43itLf4RlVCZ+8srr5tV0KxKCwYyfqXKIL9slIUw5l9b57n4b0zroPY
        wXchHqJ4zjiNDWthiVbTV8Gm3M4NUq0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-e5iFwDmNPK6iXBSIkZqWfA-1; Tue, 14 Mar 2023 15:01:08 -0400
X-MC-Unique: e5iFwDmNPK6iXBSIkZqWfA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E190A1024D07;
        Tue, 14 Mar 2023 19:01:04 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B63FF140EBF4;
        Tue, 14 Mar 2023 19:01:04 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 643694039C28F; Tue, 14 Mar 2023 16:00:44 -0300 (-03)
Message-ID: <20230314185951.654080886@redhat.com>
User-Agent: quilt/0.67
Date:   Tue, 14 Mar 2023 15:59:19 -0300
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
Subject: [PATCH v6 05/12] add this_cpu_cmpxchg_local and asm-generic definitions
References: <20230314185914.836510860@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

Add this_cpu_cmpxchg_local_ helpers to asm-generic/percpu.h.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/include/asm-generic/percpu.h
===================================================================
--- linux-vmstat-remote.orig/include/asm-generic/percpu.h
+++ linux-vmstat-remote/include/asm-generic/percpu.h
@@ -424,6 +424,23 @@ do {									\
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
+#ifndef this_cpu_cmpxchg_local_1
+#define this_cpu_cmpxchg_local_1(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+#ifndef this_cpu_cmpxchg_local_2
+#define this_cpu_cmpxchg_local_2(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+#ifndef this_cpu_cmpxchg_local_4
+#define this_cpu_cmpxchg_local_4(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+#ifndef this_cpu_cmpxchg_local_8
+#define this_cpu_cmpxchg_local_8(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+
 #ifndef this_cpu_cmpxchg_double_1
 #define this_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	this_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
Index: linux-vmstat-remote/include/linux/percpu-defs.h
===================================================================
--- linux-vmstat-remote.orig/include/linux/percpu-defs.h
+++ linux-vmstat-remote/include/linux/percpu-defs.h
@@ -513,6 +513,8 @@ do {									\
 #define this_cpu_xchg(pcp, nval)	__pcpu_size_call_return2(this_cpu_xchg_, pcp, nval)
 #define this_cpu_cmpxchg(pcp, oval, nval) \
 	__pcpu_size_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
+#define this_cpu_cmpxchg_local(pcp, oval, nval) \
+	__pcpu_size_call_return2(this_cpu_cmpxchg_local_, pcp, oval, nval)
 #define this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	__pcpu_double_call_return_bool(this_cpu_cmpxchg_double_, pcp1, pcp2, oval1, oval2, nval1, nval2)
 


