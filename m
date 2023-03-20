Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07E46C1F68
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCTSUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjCTST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0309141B79
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679335927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Hcv+7yXWUE6dz6IV3pdXnHOeNZqOsphpnY/hyL0+XpA=;
        b=Mp3A37UDIH34B5E06Vba5VUikhPvTao2jlZ0bB6NPYtrDmF8We9SPTBi+ku3mTHJedIABL
        58hAEOofRS3YJACqYi8oLZZKJXD6jQBI+5lO0D8VFUXzBu8Qv7oc/MN9L53jAVH6icfXIm
        Im2pcqo5gxBdw2e+d3AKg3v6v02mKdA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-5Z2d1MOjMb2V2UyjiOPjmg-1; Mon, 20 Mar 2023 14:12:04 -0400
X-MC-Unique: 5Z2d1MOjMb2V2UyjiOPjmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7273338173CB;
        Mon, 20 Mar 2023 18:12:03 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2094F18EC2;
        Mon, 20 Mar 2023 18:12:03 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 0360D403BCD84; Mon, 20 Mar 2023 15:08:03 -0300 (-03)
Message-ID: <20230320180745.783045641@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 20 Mar 2023 15:03:42 -0300
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
Subject: [PATCH v7 10/13] mm/vmstat: use xchg in cpu_vm_stats_fold
References: <20230320180332.102837832@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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


