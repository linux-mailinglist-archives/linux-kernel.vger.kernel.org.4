Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC9C6B7D83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjCMQ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjCMQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5798C7A911
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678724866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/KQqYUQDwTZyYbpRZbwn7x1mgss03C//4Fvg72sL2vY=;
        b=FhD3SrXgba+o3IGaYO1N+xSdPXm3hKxP8jD/KWPrylLxrrycjfYf0BDnTwUvVoKOld7V18
        heEuP0qkx9wtiM0Ly6rjcJObZXrl6MLYqsWxF1NDW8St/LdOiE3fzZsfyvhiXuK3T3douJ
        g9aLR/lkQTE1q50vC77LUY/fbHhsdNE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-DQQRGpshNVW6Jcd0FnfZLw-1; Mon, 13 Mar 2023 12:27:43 -0400
X-MC-Unique: DQQRGpshNVW6Jcd0FnfZLw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0474C803481;
        Mon, 13 Mar 2023 16:27:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9959400F4F;
        Mon, 13 Mar 2023 16:27:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 348BF4038AB89; Mon, 13 Mar 2023 13:26:44 -0300 (-03)
Message-ID: <20230313162634.482796394@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 13 Mar 2023 13:25:16 -0300
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
Subject: [PATCH v5 09/12] mm/vmstat: use xchg in cpu_vm_stats_fold
References: <20230313162507.032200398@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to switch vmstat shepherd to flush
per-CPU counters remotely, use xchg instead of a
pair of read/write instructions.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -924,7 +924,7 @@ static int refresh_cpu_vm_stats(bool do_
 }
 
 /*
- * Fold the data for an offline cpu into the global array.
+ * Fold the data for a cpu into the global array.
  * There cannot be any access by the offline cpu and therefore
  * synchronization is simplified.
  */
@@ -945,8 +945,7 @@ void cpu_vm_stats_fold(int cpu)
 			if (pzstats->vm_stat_diff[i]) {
 				int v;
 
-				v = pzstats->vm_stat_diff[i];
-				pzstats->vm_stat_diff[i] = 0;
+				v = xchg(&pzstats->vm_stat_diff[i], 0);
 				atomic_long_add(v, &zone->vm_stat[i]);
 				global_zone_diff[i] += v;
 			}
@@ -956,8 +955,7 @@ void cpu_vm_stats_fold(int cpu)
 			if (pzstats->vm_numa_event[i]) {
 				unsigned long v;
 
-				v = pzstats->vm_numa_event[i];
-				pzstats->vm_numa_event[i] = 0;
+				v = xchg(&pzstats->vm_numa_event[i], 0);
 				zone_numa_event_add(v, zone, i);
 			}
 		}
@@ -973,8 +971,7 @@ void cpu_vm_stats_fold(int cpu)
 			if (p->vm_node_stat_diff[i]) {
 				int v;
 
-				v = p->vm_node_stat_diff[i];
-				p->vm_node_stat_diff[i] = 0;
+				v = xchg(&p->vm_node_stat_diff[i], 0);
 				atomic_long_add(v, &pgdat->vm_stat[i]);
 				global_node_diff[i] += v;
 			}


