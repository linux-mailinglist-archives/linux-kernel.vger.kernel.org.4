Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42E1690D16
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjBIPfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjBIPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:34:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA165ACFC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675956802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iUvNynje4NLXuVViJqGVXz34mfwfY1r+EmC29iXiBlQ=;
        b=EwDBUPVWdyTl9lxExTL6/sPyvIxpIzni24vXNIPqEc517DE12Un9e1rZeaa6hW+mwYH/MV
        PTeoZnhPT5i5gxCmkt7IF/kLMyGnehOhk4UmVn7xZg5wM7lKvsMtcekBxwzhf/5BqVK2xz
        Sp2kHFDZxBkQxqoUhNqtPtU1ifTNGes=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-Qjur93AHP26bSv2h0FSKcg-1; Thu, 09 Feb 2023 10:33:18 -0500
X-MC-Unique: Qjur93AHP26bSv2h0FSKcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC7EC85CCE9;
        Thu,  9 Feb 2023 15:33:14 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2D7E40398A2;
        Thu,  9 Feb 2023 15:33:14 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 6718A403CC06F; Thu,  9 Feb 2023 12:32:51 -0300 (-03)
Message-ID: <20230209153204.683821550@redhat.com>
User-Agent: quilt/0.67
Date:   Thu, 09 Feb 2023 12:01:52 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v2 02/11] this_cpu_cmpxchg: ARM64: switch this_cpu_cmpxchg to locked, add _local function
References: <20230209150150.380060673@redhat.com>
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


