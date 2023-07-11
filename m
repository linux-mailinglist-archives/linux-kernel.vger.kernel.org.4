Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DCA74F763
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjGKRlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGKRll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23281E49
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689097257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vWzL8ieoY5r6fmGrcUdpEwPYQKFs0j5cY8SKpwRqgk4=;
        b=ZIz5Fg3o20vG5tluvMfY/h3Gj584LTGJU/VokrI4W4EoXc6kbUIip0bYOFu+XLix/nINEV
        yRU/yN8meOAfFioBWnfB47RhAzAdTrWEbKupk3tNiBnJZj5TnlAfCUTC2XjHIMvBpEKtDH
        u/yJTAgxAB/JknWDKj7KYJQigU2iC+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-mkZ48wdiNw2C8aPa3j_InQ-1; Tue, 11 Jul 2023 13:40:54 -0400
X-MC-Unique: mkZ48wdiNw2C8aPa3j_InQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ED5610504AC;
        Tue, 11 Jul 2023 17:40:53 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4908492B01;
        Tue, 11 Jul 2023 17:40:51 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] mm/memory_hotplug: document the signal_pending() check in offline_pages()
Date:   Tue, 11 Jul 2023 19:40:50 +0200
Message-ID: <20230711174050.603820-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's update the documentation that any signal is sufficient, and
add a comment that not only checking for fatal signals is historical
baggage: changing it now could break existing user space. although
unlikely.

For example, when an app provides a custom SIGALRM handler and triggers
memory offlining, the timeout cmd would no longer stop memory offlining,
because SIGALRM would no longer be considered a fatal signal.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/memory-hotplug.rst | 2 +-
 mm/memory_hotplug.c                             | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 1b02fe5807cc..bd77841041af 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -669,7 +669,7 @@ when still encountering permanently unmovable pages within ZONE_MOVABLE
 (-> BUG), memory offlining will keep retrying until it eventually succeeds.
 
 When offlining is triggered from user space, the offlining context can be
-terminated by sending a fatal signal. A timeout based offlining can easily be
+terminated by sending a signal. A timeout based offlining can easily be
 implemented via::
 
 	% timeout $TIMEOUT offline_block | failure_handling
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3f231cf1b410..7cfd13c91568 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1843,6 +1843,11 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	do {
 		pfn = start_pfn;
 		do {
+			/*
+			 * Historically we always checked for any signal and
+			 * can't limit it to fatal signals without eventually
+			 * breaking user space.
+			 */
 			if (signal_pending(current)) {
 				ret = -EINTR;
 				reason = "signal backoff";
-- 
2.41.0

