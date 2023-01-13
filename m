Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15220668A08
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjAMDVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjAMDUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:20:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954FB559F9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673580006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VSIbSzL2bxKjEoqavrvpRp0pIuSz+KbDY87ApaDwMng=;
        b=FoTF2/86i83RCxZg1XY9j+RN4ilevmExl3cITgEusJSQQxS/mZVBst6Jz9tbjf0Irqs8+T
        Lba2kDgSk4OS6rbcCd/F4BaMDEOIFMVJf35a906ka4lV0qzSkG+oV90r8cfA3tj530iKyp
        PrJB0U1AlTOYkBEBbm36eOcSb9y2pSo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-QVWkk8okPcyjXl0ZR1WrbQ-1; Thu, 12 Jan 2023 22:20:03 -0500
X-MC-Unique: QVWkk8okPcyjXl0ZR1WrbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8544E85C069;
        Fri, 13 Jan 2023 03:20:02 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31AFB4078903;
        Fri, 13 Jan 2023 03:19:56 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, urezki@gmail.com, lstoakes@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 5/7] mm/vmalloc: skip the uninitilized vmalloc areas
Date:   Fri, 13 Jan 2023 11:19:19 +0800
Message-Id: <20230113031921.64716-6-bhe@redhat.com>
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

For areas allocated via vmalloc_xxx() APIs, it searches for unmapped area
to reserve and allocates new pages to map into, please see function
__vmalloc_node_range(). During the process, flag VM_UNINITIALIZED is set
in vm->flags to indicate that the pages allocation and mapping haven't
been done, until clear_vm_uninitialized_flag() is called to clear it.

For this kind of area, if VM_UNINITIALIZED is still set, let's ignore
it in vread() because pages newly allocated and being mapped in that
area only contains zero data. reading them out by aligned_vread() is
wasting time.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmalloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4a10b3b692fa..dbcdcad2276b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3660,6 +3660,11 @@ long vread(char *buf, char *addr, unsigned long count)
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

