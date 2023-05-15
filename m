Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50CC703BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245070AbjEOSHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbjEOSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FADDC7F
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684173827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Hcv+7yXWUE6dz6IV3pdXnHOeNZqOsphpnY/hyL0+XpA=;
        b=OLxlu9HJyXEZhnoWAvLkuiMTn6LUCC7NF4hYWkUqjNJyHpyu+zJSDbGKvoAA6XWTnGDDUp
        Gl+By/C5QTu33vea79vJvDZgpkeD3zS4fU18TTQRIV3MYUGZLYbDzPbRwNOcMRbIflECRA
        M/OPO6xbCjnh+jwBvREjrU8iJZZmZKM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-lHcv7IUkO2a5FK4nyxKaQw-1; Mon, 15 May 2023 14:03:43 -0400
X-MC-Unique: lHcv7IUkO2a5FK4nyxKaQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0080E88CC41;
        Mon, 15 May 2023 18:03:43 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C62E92166B26;
        Mon, 15 May 2023 18:03:42 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 7B6454133CFAA; Mon, 15 May 2023 15:02:17 -0300 (-03)
Message-ID: <20230515180138.668066640@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 15 May 2023 15:00:25 -0300
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
Subject: [PATCH v8 10/13] mm/vmstat: use xchg in cpu_vm_stats_fold
References: <20230515180015.016409657@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

---

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


