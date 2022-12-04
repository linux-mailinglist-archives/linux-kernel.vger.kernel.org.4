Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4456E641A42
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 02:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiLDBc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 20:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLDBcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 20:32:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E795D1A076
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 17:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670117484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5OPg+DQ4r4Z/JFMiJuaclM/YLWn2Go/JtLJ0xxYwus=;
        b=enByNln7ytaE3T+QThfvPczLgEt7+4H6qCqvmfRfZbPzi4FoDhQwqXzUSyDsMWUG+ZLfji
        jidxf4fbMbDKng15ry2+H+8L5LmtMfrwLjiuXFFuvNBrnfY6Gqf6i5Gq2hbZ0QYnPuh42y
        yvjA4Abx6jXM9xUR8tkrj9b5Jnk0tJ4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-uIXwTZ5OO42nv2qg208mSw-1; Sat, 03 Dec 2022 20:31:20 -0500
X-MC-Unique: uIXwTZ5OO42nv2qg208mSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 446C429ABA17;
        Sun,  4 Dec 2022 01:31:20 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E3D4141511E;
        Sun,  4 Dec 2022 01:31:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, stephen.s.brennan@oracle.com, urezki@gmail.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v1 4/7] mm/vmalloc: explicitly identify vm_map_ram area when shown in /proc/vmcoreinfo
Date:   Sun,  4 Dec 2022 09:30:43 +0800
Message-Id: <20221204013046.154960-5-bhe@redhat.com>
In-Reply-To: <20221204013046.154960-1-bhe@redhat.com>
References: <20221204013046.154960-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, by marking VMAP_RAM in vmap_area->flags for vm_map_ram area, we
can clearly differentiate it with other vmalloc areas. So in s_show(),
change the ambiguous checking 'if (!va->vm) to clear
"if (!va->vm && (va->flags & VMAP_RAM))". This let's picks out
vm_map_ram area, and avoids the being unmapped normal vmalloc area to
be mistakenly recognized as vm_map_ram area.

Meanwhile, the code comment above vm_map_ram area checking in s_show()
is not needed any more, remove it here.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmalloc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e6b46da3e044..3c60026fb162 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4181,11 +4181,7 @@ static int s_show(struct seq_file *m, void *p)
 
 	va = list_entry(p, struct vmap_area, list);
 
-	/*
-	 * s_show can encounter race with remove_vm_area, !vm on behalf
-	 * of vmap area is being tear down or vm_map_ram allocation.
-	 */
-	if (!va->vm) {
+	if (!va->vm && (va->flags & VMAP_RAM)) {
 		seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
 			(void *)va->va_start, (void *)va->va_end,
 			va->va_end - va->va_start);
-- 
2.34.1

