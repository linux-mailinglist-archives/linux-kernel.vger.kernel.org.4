Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62776690D07
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjBIPeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBIPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:34:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC28947087
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675956801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LGWVlVnJpdpZsY64OC4/IsULi3iGJlzsOgwi06Ffb5I=;
        b=OMwp7q2g3Dx2cqRDfgY5KaO/WyAGXlNOXbTW38puODzE3dYtaVxft27AR+bcs+6QqSpNoG
        YKC0exqqGahS7qaQOMjHTQI9W+gkGI81YEF18sppXRi260tC6NsElMJgaZE2ay+t5xTlzF
        h/kzPmmckhSn0pPSovfya6mlgNBQjBk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-LPxsHX8gOi6p7L8Li5eumw-1; Thu, 09 Feb 2023 10:33:18 -0500
X-MC-Unique: LPxsHX8gOi6p7L8Li5eumw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 902DD1C29D4F;
        Thu,  9 Feb 2023 15:33:16 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 625EB40C83B6;
        Thu,  9 Feb 2023 15:33:16 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 86BD4400E5701; Thu,  9 Feb 2023 12:32:51 -0300 (-03)
Message-ID: <20230209153204.873999366@redhat.com>
User-Agent: quilt/0.67
Date:   Thu, 09 Feb 2023 12:01:59 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v2 09/11] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
References: <20230209150150.380060673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
per-CPU counters remotely, use a cmpxchg loop 
instead of a pair of read/write instructions.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -885,7 +885,7 @@ static int refresh_cpu_vm_stats(void)
 }
 
 /*
- * Fold the data for an offline cpu into the global array.
+ * Fold the data for a cpu into the global array.
  * There cannot be any access by the offline cpu and therefore
  * synchronization is simplified.
  */
@@ -906,8 +906,9 @@ void cpu_vm_stats_fold(int cpu)
 			if (pzstats->vm_stat_diff[i]) {
 				int v;
 
-				v = pzstats->vm_stat_diff[i];
-				pzstats->vm_stat_diff[i] = 0;
+				do {
+					v = pzstats->vm_stat_diff[i];
+				} while (!try_cmpxchg(&pzstats->vm_stat_diff[i], &v, 0));
 				atomic_long_add(v, &zone->vm_stat[i]);
 				global_zone_diff[i] += v;
 			}
@@ -917,8 +918,9 @@ void cpu_vm_stats_fold(int cpu)
 			if (pzstats->vm_numa_event[i]) {
 				unsigned long v;
 
-				v = pzstats->vm_numa_event[i];
-				pzstats->vm_numa_event[i] = 0;
+				do {
+					v = pzstats->vm_numa_event[i];
+				} while (!try_cmpxchg(&pzstats->vm_numa_event[i], &v, 0));
 				zone_numa_event_add(v, zone, i);
 			}
 		}
@@ -934,8 +936,9 @@ void cpu_vm_stats_fold(int cpu)
 			if (p->vm_node_stat_diff[i]) {
 				int v;
 
-				v = p->vm_node_stat_diff[i];
-				p->vm_node_stat_diff[i] = 0;
+				do {
+					v = p->vm_node_stat_diff[i];
+				} while	(!try_cmpxchg(&p->vm_node_stat_diff[i], &v, 0));
 				atomic_long_add(v, &pgdat->vm_stat[i]);
 				global_node_diff[i] += v;
 			}


