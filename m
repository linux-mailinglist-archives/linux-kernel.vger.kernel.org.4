Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827696B7D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjCMQaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCMQ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BC47A91E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678724867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iUvNynje4NLXuVViJqGVXz34mfwfY1r+EmC29iXiBlQ=;
        b=R9glNPjQ9JH41ZUUhZm78C36m6D7U/izmO00owo2Xjm/m6eHJapvMEmTvr7RTjHBlhfW8t
        anaNQC4wC79oXfRssqtONlYHzYmI93UG72fyYBcaoflIG61SKF7qsuD5RrPVUE8pkaawRt
        cY1gHCzGHxrYsg2LMxtiI46QmzaDhI0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-_i-nT0qoM-Wt4M1D21UMfQ-1; Mon, 13 Mar 2023 12:27:40 -0400
X-MC-Unique: _i-nT0qoM-Wt4M1D21UMfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32BC618E0044;
        Mon, 13 Mar 2023 16:27:40 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E93CA1121318;
        Mon, 13 Mar 2023 16:27:39 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 11E84401344A4; Mon, 13 Mar 2023 13:26:44 -0300 (-03)
Message-ID: <20230313162634.283504192@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 13 Mar 2023 13:25:08 -0300
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
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v5 01/12] this_cpu_cmpxchg: ARM64: switch this_cpu_cmpxchg to locked, add _local function
References: <20230313162507.032200398@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
change ARM's this_cpu_cmpxchg_ helpers to be atomic,
and add this_cpu_cmpxchg_local_ helpers which are not atomic.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/arch/arm64/include/asm/percpu.h
===================================================================
--- linux-vmstat-remote.orig/arch/arm64/include/asm/percpu.h
+++ linux-vmstat-remote/arch/arm64/include/asm/percpu.h
@@ -232,13 +232,23 @@ PERCPU_RET_OP(add, add, ldadd)
 	_pcp_protect_return(xchg_relaxed, pcp, val)
 
 #define this_cpu_cmpxchg_1(pcp, o, n)	\
-	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+	_pcp_protect_return(cmpxchg, pcp, o, n)
 #define this_cpu_cmpxchg_2(pcp, o, n)	\
-	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+	_pcp_protect_return(cmpxchg, pcp, o, n)
 #define this_cpu_cmpxchg_4(pcp, o, n)	\
-	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+	_pcp_protect_return(cmpxchg, pcp, o, n)
 #define this_cpu_cmpxchg_8(pcp, o, n)	\
+	_pcp_protect_return(cmpxchg, pcp, o, n)
+
+#define this_cpu_cmpxchg_local_1(pcp, o, n)	\
 	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_local_2(pcp, o, n)	\
+	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_local_4(pcp, o, n)	\
+	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_local_8(pcp, o, n)	\
+	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+
 
 #ifdef __KVM_NVHE_HYPERVISOR__
 extern unsigned long __hyp_per_cpu_offset(unsigned int cpu);


