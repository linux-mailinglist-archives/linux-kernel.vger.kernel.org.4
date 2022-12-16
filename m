Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D66564F203
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiLPTxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiLPTx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:53:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FB1659BE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671220360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kyxh01Z6aQw9/MQYaoI58SSLBFSUwnSJa8fNd5lmbmc=;
        b=Pc6GAknHVru0jDDUdiEOUCmXEkySXRTKi+jp3N62g0vB9ktKXLLO4MFXxu7Yff49Hw9bka
        QW6ae9eZIoEsxPwx4LhFvw9zJKYm8DZ0QIqYANI4QWHwXZkveO90Pv/4XmApCNOzLVTv4G
        NhvwgDrvRYFhgSiqWQwlUS9M0GwFHaQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-kZFRYmw_Ofm-GfhYazO0XA-1; Fri, 16 Dec 2022 14:52:37 -0500
X-MC-Unique: kZFRYmw_Ofm-GfhYazO0XA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2681D85CCE3;
        Fri, 16 Dec 2022 19:52:36 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CA27492C14;
        Fri, 16 Dec 2022 19:52:35 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id C48684097957F; Fri, 16 Dec 2022 16:52:10 -0300 (-03)
Message-ID: <20221216194904.075275493@redhat.com>
User-Agent: quilt/0.66
Date:   Fri, 16 Dec 2022 16:45:41 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v10 1/6] mm/vmstat: Add CPU-specific variable to track a vmstat discrepancy
References: <20221216194540.202752779@redhat.com>
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

From: Aaron Tomlin <atomlin@redhat.com>

Introduce a CPU-specific variable namely vmstat_dirty to indicate
if a vmstat imbalance is present for a given CPU. Therefore, at
the appropriate time, we can fold all the remaining differentials.
This patch also provides trivial helpers for modification and testing.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
---
 mm/vmstat.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -194,6 +194,22 @@ void fold_vm_numa_events(void)
 #endif
 
 #ifdef CONFIG_SMP
+static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+
+static inline void vmstat_mark_dirty(void)
+{
+	this_cpu_write(vmstat_dirty, true);
+}
+
+static inline void vmstat_clear_dirty(void)
+{
+	this_cpu_write(vmstat_dirty, false);
+}
+
+static inline bool is_vmstat_dirty(void)
+{
+	return this_cpu_read(vmstat_dirty);
+}
 
 int calculate_pressure_threshold(struct zone *zone)
 {


