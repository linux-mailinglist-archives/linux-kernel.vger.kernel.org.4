Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B772E6AAFF9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCENnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCENnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:43:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575A91351C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 05:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678023708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FePX2+VFBr01iZwaVbBM1HjdLAtX/eNoAgkcl35m848=;
        b=JvX4S//laxqbua2Nms8EsawuhlnLXJ/EPu3aFkmkU2//6xkseOUTuKkLO1twI0unU/WBUW
        7ko8oBIu3TEaRQi9UJ9kqujGvfNtn4JmChBJfrYVRXnHpluTXYmoh0oPk4atupgiEKz5Lo
        Q5Mo2g7jo+fDrHdOXQRn7V1QUIgDktc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-fuXqWRBUPB6hB7qRysWiEA-1; Sun, 05 Mar 2023 08:41:45 -0500
X-MC-Unique: fuXqWRBUPB6hB7qRysWiEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8BAD85CBE0;
        Sun,  5 Mar 2023 13:41:44 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B888492C14;
        Sun,  5 Mar 2023 13:41:44 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 20DCB401A07AA; Sun,  5 Mar 2023 10:41:23 -0300 (-03)
Message-ID: <20230305134053.513805071@redhat.com>
User-Agent: quilt/0.67
Date:   Sun, 05 Mar 2023 10:37:01 -0300
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
Subject: [PATCH v4 04/12] this_cpu_cmpxchg: S390: switch this_cpu_cmpxchg to locked, add _local function
References: <20230305133657.255737580@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
add S390's this_cpu_cmpxchg_local.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/arch/s390/include/asm/percpu.h
===================================================================
--- linux-vmstat-remote.orig/arch/s390/include/asm/percpu.h
+++ linux-vmstat-remote/arch/s390/include/asm/percpu.h
@@ -148,6 +148,11 @@
 #define this_cpu_cmpxchg_4(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 
+#define this_cpu_cmpxchg_local_1(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
+#define this_cpu_cmpxchg_local_2(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
+#define this_cpu_cmpxchg_local_4(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
+#define this_cpu_cmpxchg_local_8(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
+
 #define arch_this_cpu_xchg(pcp, nval)					\
 ({									\
 	typeof(pcp) *ptr__;						\


