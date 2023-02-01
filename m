Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB08686F50
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjBATxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBATxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:53:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D874125A0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675281152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UNuyx8K2ySiAV6ZnRT9lDE7gCUj8cZTtuvFWAoUAsDg=;
        b=fuh4WPSmO2zZKy24bvQPxMb7NES03h2rbC2bjy2RUmZLJAdtLtAY6GsWZ3S2DzcIosFWb+
        /EqYVyJRIOkjzfbp5Jrv0B/E6eTVSxF6SJIHGd8CzWXmOQqjrRmbiYwFbC2/Yt3UZZbfNS
        kyypSu48Syfjf5EVKSMc8Bc2j+bpaCk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594--FZ7uIvhM-eLBBPBAMydmw-1; Wed, 01 Feb 2023 14:52:30 -0500
X-MC-Unique: -FZ7uIvhM-eLBBPBAMydmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 497DE386B751;
        Wed,  1 Feb 2023 19:52:30 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E39C42166B34;
        Wed,  1 Feb 2023 19:52:29 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 12F5E403C47C6; Wed,  1 Feb 2023 16:51:49 -0300 (-03)
Message-ID: <20230201195104.460373427@redhat.com>
User-Agent: quilt/0.67
Date:   Wed, 01 Feb 2023 16:50:16 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 3/5] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
References: <20230201195013.881721887@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
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
+				} while (cmpxchg(&pzstats->vm_stat_diff[i], v, 0) != v);
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
+				} while (cmpxchg(&pzstats->vm_numa_event[i], v, 0) != v);
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
+				} while (cmpxchg(&p->vm_node_stat_diff[i], v, 0) != v);
 				atomic_long_add(v, &pgdat->vm_stat[i]);
 				global_node_diff[i] += v;
 			}


