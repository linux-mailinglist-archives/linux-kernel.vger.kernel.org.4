Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75A6B7D80
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjCMQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjCMQ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D3C79B3D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678724863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FePX2+VFBr01iZwaVbBM1HjdLAtX/eNoAgkcl35m848=;
        b=QG3Jtyex1mPPAnDb92thpz1Oo1U+aA3pcYsw9KLmg7TSCi3dgzbnMeyO5KwPOqBTjlaIpS
        FYnzdgYOxOn4XKlG3eBf5Lrba1Dk9XOZy6s+oAM352O7ThGBMScylnZ6RsjxsN/Ycac2Hs
        tETs+wXZVO1C43Cc6SQgl6Q0aiO4w3Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-rgJUFS3UNpO8OZyHkd8jqg-1; Mon, 13 Mar 2023 12:27:42 -0400
X-MC-Unique: rgJUFS3UNpO8OZyHkd8jqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D28E680280D;
        Mon, 13 Mar 2023 16:27:41 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A603C140E96A;
        Mon, 13 Mar 2023 16:27:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 17C3B401CB959; Mon, 13 Mar 2023 13:26:44 -0300 (-03)
Message-ID: <20230313162634.333370216@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 13 Mar 2023 13:25:10 -0300
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
Subject: [PATCH v5 03/12] this_cpu_cmpxchg: S390: switch this_cpu_cmpxchg to locked, add _local function
References: <20230313162507.032200398@redhat.com>
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


