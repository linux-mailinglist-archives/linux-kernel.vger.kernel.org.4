Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA1E68B786
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjBFIlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBFIlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:41:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBC918142
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675672854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hiVEWJoEN/c7PwG6FQD6hYWxpoLbbmsKmDjpAMaWIR0=;
        b=C1ZgDxm17Z6zTPM/85h3MgVE+xoaPAbEDaoR6NyNzn1xf8PYLZDADxhPDQsPnCw2KA8FtX
        Y28YA/7xbOBrZLDdkfddSWU+LY77+IQJtrZ6XkIdZnK6AAjTiXbP5LTQtjR4+Zyfj3ZGlF
        HbGi0pNIxWXsnOSCMWILxAs3L1tCFSY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-GSAZ0BOoM8aVUFekIGNdrA-1; Mon, 06 Feb 2023 03:40:52 -0500
X-MC-Unique: GSAZ0BOoM8aVUFekIGNdrA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 120E687B2A0;
        Mon,  6 Feb 2023 08:40:52 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFD372166B2A;
        Mon,  6 Feb 2023 08:40:47 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, lstoakes@gmail.com,
        error27@gmail.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 5/7] mm/vmalloc: skip the uninitilized vmalloc areas
Date:   Mon,  6 Feb 2023 16:40:18 +0800
Message-Id: <20230206084020.174506-6-bhe@redhat.com>
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

For areas allocated via vmalloc_xxx() APIs, it searches for unmapped area
to reserve and allocates new pages to map into, please see function
__vmalloc_node_range(). During the process, flag VM_UNINITIALIZED is set
in vm->flags to indicate that the pages allocation and mapping haven't
been done, until clear_vm_uninitialized_flag() is called to clear
VM_UNINITIALIZED.

For this kind of area, if VM_UNINITIALIZED is still set, let's ignore
it in vread() because pages newly allocated and being mapped in that
area only contains zero data. reading them out by aligned_vread() is
wasting time.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index dea76e73e57c..8037527774db 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3668,6 +3668,11 @@ long vread(char *buf, char *addr, unsigned long count)
 		if (!vm && !flags)
 			continue;
 
+		if (vm && (vm->flags & VM_UNINITIALIZED))
+			continue;
+		/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
+		smp_rmb();
+
 		vaddr = (char *) va->va_start;
 		size = vm ? get_vm_area_size(vm) : va_size(va);
 
-- 
2.34.1

