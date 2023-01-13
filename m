Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E6668A05
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjAMDVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjAMDU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:20:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E32559F7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673580011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNFgggokfEpsJ+m9XSJUb906E+70pgaIWc+RI3TMVHY=;
        b=JzTvnxZeXHAaNI+38qcD/L9rBtkgsd081UyfJkX94O8HHPSjzdlSOEtuP37sb2ooghKXsL
        7et2hqUi+px7NkmSMXq02l/niJtZlv7gj/wx+HNH3LoBIclbKsloqsd3+d0LFzNHR4KXj6
        c4zOPDnI/e7WoKRwfs4OieLQkCBYVI4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-wvxQxbrsOFieE4CbX1MW9A-1; Thu, 12 Jan 2023 22:20:08 -0500
X-MC-Unique: wvxQxbrsOFieE4CbX1MW9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A16EF3804063;
        Fri, 13 Jan 2023 03:20:07 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54F1E4078903;
        Fri, 13 Jan 2023 03:20:02 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, urezki@gmail.com, lstoakes@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 6/7] powerpc: mm: add VM_IOREMAP flag to the vmalloc area
Date:   Fri, 13 Jan 2023 11:19:20 +0800
Message-Id: <20230113031921.64716-7-bhe@redhat.com>
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

Currently, for vmalloc areas with flag VM_IOREMAP set, except of the
specific alignment clamping in __get_vm_area_node(), they will be
 1) Shown as ioremap in /proc/vmallocinfo;
 2) Ignored by /proc/kcore reading via vread()

So for the io mapping in ioremap_phb() of ppc, we should set VM_IOREMAP
in flag to make it handled correctly as above.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/kernel/pci_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 0c7cfb9fab04..fd42059ae2a5 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -132,7 +132,7 @@ void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size)
 	 * address decoding but I'd rather not deal with those outside of the
 	 * reserved 64K legacy region.
 	 */
-	area = __get_vm_area_caller(size, 0, PHB_IO_BASE, PHB_IO_END,
+	area = __get_vm_area_caller(size, VM_IOREMAP, PHB_IO_BASE, PHB_IO_END,
 				    __builtin_return_address(0));
 	if (!area)
 		return NULL;
-- 
2.34.1

