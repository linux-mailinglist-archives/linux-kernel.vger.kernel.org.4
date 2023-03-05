Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0EB6AAFFD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCENnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjCENnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:43:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A749136C8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 05:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678023708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cF55NXqs40Wyum0JJGwIV1sBIg7Uydwtt1diuU4lxVY=;
        b=SNpZIfIWxd2qLWNQeU0E450wZfOxOCtyt7jUJAJcq+0NJtpl3QBNS/MTKjBFPWFDKspWRg
        F/vQww1N+SgPLGsiZTfpFcWQjOoT4YrF6IHFwewNTKtp3LsoiVRdS+dEPhn5CutBfRBlC9
        QhMMIgIFfYlhjilt1nmtzxgvtdD1guo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-p4wUfcAPNJCRL6VWbVgU_A-1; Sun, 05 Mar 2023 08:41:45 -0500
X-MC-Unique: p4wUfcAPNJCRL6VWbVgU_A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB6C885A5A3;
        Sun,  5 Mar 2023 13:41:44 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B64C492B00;
        Sun,  5 Mar 2023 13:41:44 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 38FBB401A1935; Sun,  5 Mar 2023 10:41:23 -0300 (-03)
Message-ID: <20230305134053.638239404@redhat.com>
User-Agent: quilt/0.67
Date:   Sun, 05 Mar 2023 10:37:06 -0300
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
Subject: [PATCH v4 09/12] vmstat: switch per-cpu vmstat counters to 32-bits
References: <20230305133657.255737580@redhat.com>
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

Some architectures only provide xchg/cmpxchg in 32/64-bit quantities.

Since the next patch is about to use xchg on per-CPU vmstat counters,
switch them to s32.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/include/linux/mmzone.h
===================================================================
--- linux-vmstat-remote.orig/include/linux/mmzone.h
+++ linux-vmstat-remote/include/linux/mmzone.h
@@ -686,8 +686,8 @@ struct per_cpu_pages {
 
 struct per_cpu_zonestat {
 #ifdef CONFIG_SMP
-	s8 vm_stat_diff[NR_VM_ZONE_STAT_ITEMS];
-	s8 stat_threshold;
+	s32 vm_stat_diff[NR_VM_ZONE_STAT_ITEMS];
+	s32 stat_threshold;
 #endif
 #ifdef CONFIG_NUMA
 	/*
@@ -700,8 +700,8 @@ struct per_cpu_zonestat {
 };
 
 struct per_cpu_nodestat {
-	s8 stat_threshold;
-	s8 vm_node_stat_diff[NR_VM_NODE_STAT_ITEMS];
+	s32 stat_threshold;
+	s32 vm_node_stat_diff[NR_VM_NODE_STAT_ITEMS];
 };
 
 #endif /* !__GENERATING_BOUNDS.H */
Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -351,7 +351,7 @@ static inline void mod_zone_state(struct
 				  long delta, int overstep_mode)
 {
 	struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
-	s8 __percpu *p = pcp->vm_stat_diff + item;
+	s32 __percpu *p = pcp->vm_stat_diff + item;
 	long o, n, t, z;
 
 	do {
@@ -428,7 +428,7 @@ static inline void mod_node_state(struct
 				  int delta, int overstep_mode)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
 	long o, n, t, z;
 
 	if (vmstat_item_in_bytes(item)) {
@@ -525,7 +525,7 @@ void __mod_zone_page_state(struct zone *
 			   long delta)
 {
 	struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
-	s8 __percpu *p = pcp->vm_stat_diff + item;
+	s32 __percpu *p = pcp->vm_stat_diff + item;
 	long x;
 	long t;
 
@@ -556,7 +556,7 @@ void __mod_node_page_state(struct pglist
 				long delta)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
 	long x;
 	long t;
 
@@ -614,8 +614,8 @@ EXPORT_SYMBOL(__mod_node_page_state);
 void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 {
 	struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
-	s8 __percpu *p = pcp->vm_stat_diff + item;
-	s8 v, t;
+	s32 __percpu *p = pcp->vm_stat_diff + item;
+	s32 v, t;
 
 	/* See __mod_node_page_state */
 	preempt_disable_nested();
@@ -623,7 +623,7 @@ void __inc_zone_state(struct zone *zone,
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
-		s8 overstep = t >> 1;
+		s32 overstep = t >> 1;
 
 		zone_page_state_add(v + overstep, zone, item);
 		__this_cpu_write(*p, -overstep);
@@ -635,8 +635,8 @@ void __inc_zone_state(struct zone *zone,
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
-	s8 v, t;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 v, t;
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
@@ -646,7 +646,7 @@ void __inc_node_state(struct pglist_data
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
-		s8 overstep = t >> 1;
+		s32 overstep = t >> 1;
 
 		node_page_state_add(v + overstep, pgdat, item);
 		__this_cpu_write(*p, -overstep);
@@ -670,8 +670,8 @@ EXPORT_SYMBOL(__inc_node_page_state);
 void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 {
 	struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
-	s8 __percpu *p = pcp->vm_stat_diff + item;
-	s8 v, t;
+	s32 __percpu *p = pcp->vm_stat_diff + item;
+	s32 v, t;
 
 	/* See __mod_node_page_state */
 	preempt_disable_nested();
@@ -679,7 +679,7 @@ void __dec_zone_state(struct zone *zone,
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
-		s8 overstep = t >> 1;
+		s32 overstep = t >> 1;
 
 		zone_page_state_add(v - overstep, zone, item);
 		__this_cpu_write(*p, overstep);
@@ -691,8 +691,8 @@ void __dec_zone_state(struct zone *zone,
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
-	s8 v, t;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 v, t;
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
@@ -702,7 +702,7 @@ void __dec_node_state(struct pglist_data
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
-		s8 overstep = t >> 1;
+		s32 overstep = t >> 1;
 
 		node_page_state_add(v - overstep, pgdat, item);
 		__this_cpu_write(*p, overstep);


