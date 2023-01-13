Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5AA668A01
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjAMDUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjAMDUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:20:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDE1559CB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673579999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Up8qi8mg3f3bZdJKv/Nh+iddy7WejAjVd5WVI12Zbwk=;
        b=Yt2O2/Q7nfrjBcT5aQaxSbGwdTkP21QQkVSVF6WxSxeDNEXFkBDmh2DahZ3kbZcjMErVEl
        J4FAXBo6NXhBL//PToSdnaay/FW37dLZ3zY1mQuEuKzVN9g4sZRsIG1TsABEtjFXXM1l05
        IKXy/KeE+GEBedbCi95z98Vh2NjFjh4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-inWm5Br4NZyUUv9IZui68Q-1; Thu, 12 Jan 2023 22:19:55 -0500
X-MC-Unique: inWm5Br4NZyUUv9IZui68Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 667518027FE;
        Fri, 13 Jan 2023 03:19:55 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D15164078903;
        Fri, 13 Jan 2023 03:19:49 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, urezki@gmail.com, lstoakes@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 4/7] mm/vmalloc: explicitly identify vm_map_ram area when shown in /proc/vmcoreinfo
Date:   Fri, 13 Jan 2023 11:19:18 +0800
Message-Id: <20230113031921.64716-5-bhe@redhat.com>
In-Reply-To: <20230113031921.64716-1-bhe@redhat.com>
References: <20230113031921.64716-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
index 13875bc41e27..4a10b3b692fa 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4225,11 +4225,7 @@ static int s_show(struct seq_file *m, void *p)
 
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

