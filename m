Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463B064F6D2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiLQBz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQBzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:55:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173254A5BF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671242110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJATgAbP8LGsegtuj/VmrUG/8tlhpffFE1cUvqDdgpk=;
        b=MmnW7Xk/nTVo0Fc1nhrCT2hiziSkK77wmQKNjfKBgCV4cw3vbMoDI4rSR2vYkEPrBxV1Z2
        IGiqMEOifE5njBv3BIMbmBjFMnKIgBXDIAvlZ8Gl7fCY+QahBL58f6OLhqR+vUGQTEjQUu
        NwTfUcWw7rBSbYu2vmt/A1p2PURRqD0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-qDVspNCuOqqB61dUmUcbRA-1; Fri, 16 Dec 2022 20:55:06 -0500
X-MC-Unique: qDVspNCuOqqB61dUmUcbRA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C50B101A55E;
        Sat, 17 Dec 2022 01:55:05 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EE9549BB6A;
        Sat, 17 Dec 2022 01:54:57 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, urezki@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 4/7] mm/vmalloc: explicitly identify vm_map_ram area when shown in /proc/vmcoreinfo
Date:   Sat, 17 Dec 2022 09:54:32 +0800
Message-Id: <20221217015435.73889-5-bhe@redhat.com>
In-Reply-To: <20221217015435.73889-1-bhe@redhat.com>
References: <20221217015435.73889-1-bhe@redhat.com>
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

Now, by marking VMAP_RAM in vmap_area->flags for vm_map_ram, we can
clearly differentiate it with other vmalloc areas. So identify
vm_map_area area by checking VMAP_RAM of vmap_area->flags when shown
in /proc/vmcoreinfo.

Meanwhile, the code comment above vm_map_ram area checking in s_show()
is not needed any more, remove it here.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmalloc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6612914459cf..3bfa872a4513 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4182,11 +4182,7 @@ static int s_show(struct seq_file *m, void *p)
 
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

