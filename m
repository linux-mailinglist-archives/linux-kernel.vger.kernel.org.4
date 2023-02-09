Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB25690D08
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBIPeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBIPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:34:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ECB4226
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675956801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xttH7836oXgQ2gV7qXbyD6NGWlFVj+CDeiD3JQB+5E4=;
        b=VUbEwTbq2UObIG4CHg4wlLVgxr8/amvl3aOU8tb0z5RGuUbueIETdcFCoKeKxTvXV7C57Y
        /ykt3gal6iKncmBEm57gMCx1Zh+OkRJotOzKXd+jy/1PBJD/6CJ+4uB1bxX0rM453IZXz1
        G3aOnAhZ0jCOjzehyCARFn8u0kvXzog=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-HxuIk-9sP12Q212hs8jtxA-1; Thu, 09 Feb 2023 10:33:18 -0500
X-MC-Unique: HxuIk-9sP12Q212hs8jtxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 937E12807D6E;
        Thu,  9 Feb 2023 15:33:16 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6690740398A2;
        Thu,  9 Feb 2023 15:33:16 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 77799403CC079; Thu,  9 Feb 2023 12:32:51 -0300 (-03)
Message-ID: <20230209153204.791818567@redhat.com>
User-Agent: quilt/0.67
Date:   Thu, 09 Feb 2023 12:01:56 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v2 06/11] this_cpu_cmpxchg: asm-generic: switch this_cpu_cmpxchg to locked, add _local function
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


