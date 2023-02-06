Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA1468B788
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBFIlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjBFIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:41:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E88B18160
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675672850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sogBXQhtIR7vZucKmKsbqW5MbruC+cj6YTx4qBV1xD0=;
        b=BayCutNNAaQn2i7aCQpY5iHEDjg1CYaf0ge3n6bh5blTeSJgo53psy/rGF6Gju5QZzJB5A
        VjdxNmUZT7mbZFyCYWV/CcVtot6OJjAhy4/BILzMU0zf/q0huQteM4K/9zS9mEZ6tjMqRf
        t9AeKjU14x2j3BO7mWc7L676B3IfEXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-T_gvIW3LMJm5jXCXZZ71cw-1; Mon, 06 Feb 2023 03:40:47 -0500
X-MC-Unique: T_gvIW3LMJm5jXCXZZ71cw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28E7D80D0ED;
        Mon,  6 Feb 2023 08:40:47 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0267E2166B2A;
        Mon,  6 Feb 2023 08:40:42 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, lstoakes@gmail.com,
        error27@gmail.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 4/7] mm/vmalloc: explicitly identify vm_map_ram area when shown in /proc/vmcoreinfo
Date:   Mon,  6 Feb 2023 16:40:17 +0800
Message-Id: <20230206084020.174506-5-bhe@redhat.com>
In-Reply-To: <20230206084020.174506-1-bhe@redhat.com>
References: <20230206084020.174506-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
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

Now, by marking VMAP_RAM in vmap_area->flags for vm_map_ram area, we can
clearly differentiate it with other vmalloc areas. So identify
vm_map_area area by checking VMAP_RAM of vmap_area->flags when shown
in /proc/vmcoreinfo.

Meanwhile, the code comment above vm_map_ram area checking in s_show()
is not needed any more, remove it here.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/vmalloc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4bb78ebd70f6..dea76e73e57c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4233,14 +4233,11 @@ static int s_show(struct seq_file *m, void *p)
 
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

