Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386326862A0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjBAJPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjBAJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D08A51
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675242849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwQwhIj1auad521gDBOFO4aLd61Z5eggdloWlWE1BFg=;
        b=JKJCggTsy5oy3S9JmD8yk5d4peLM6cv7uLgxaZNpAPF0GL/hEORpwXFRSu2uK4zUNk1ALD
        g3h3sZmS/FjsGta16UGPyUjjhtGzEQdjIpiG+dhray3h+f8WYOmbdJeJaq6zuiOs8gextR
        6dGd9nKVjhqhaO0wbsHK4J1PgvBua4g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-jqZCJ4_SMc2RbMYr6ekGIg-1; Wed, 01 Feb 2023 04:14:08 -0500
X-MC-Unique: jqZCJ4_SMc2RbMYr6ekGIg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57E7B1C04B71;
        Wed,  1 Feb 2023 09:14:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-89.pek2.redhat.com [10.72.13.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9A6E492C3E;
        Wed,  1 Feb 2023 09:14:02 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, lstoakes@gmail.com,
        willy@infradead.org, hch@infradead.org, error27@gmail.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 4/7] mm/vmalloc: explicitly identify vm_map_ram area when shown in /proc/vmcoreinfo
Date:   Wed,  1 Feb 2023 17:13:36 +0800
Message-Id: <20230201091339.61761-5-bhe@redhat.com>
In-Reply-To: <20230201091339.61761-1-bhe@redhat.com>
References: <20230201091339.61761-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
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

Now, by marking VMAP_RAM in vmap_area->flags for vm_map_ram area, we can
clearly differentiate it with other vmalloc areas. So identify
vm_map_area area by checking VMAP_RAM of vmap_area->flags when shown
in /proc/vmcoreinfo.

Meanwhile, the code comment above vm_map_ram area checking in s_show()
is not needed any more, remove it here.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmalloc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5a3ea6cb7ec2..e515dbacb0cb 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4232,14 +4232,11 @@ static int s_show(struct seq_file *m, void *p)
 
 	va = list_entry(p, struct vmap_area, list);
 
-	/*
-	 * s_show can encounter race with remove_vm_area, !vm on behalf
-	 * of vmap area is being tear down or vm_map_ram allocation.
-	 */
 	if (!va->vm) {
-		seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
-			(void *)va->va_start, (void *)va->va_end,
-			va->va_end - va->va_start);
+		if (va->flags & VMAP_RAM)
+			seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
+				(void *)va->va_start, (void *)va->va_end,
+				va->va_end - va->va_start);
 
 		goto final;
 	}
-- 
2.34.1

