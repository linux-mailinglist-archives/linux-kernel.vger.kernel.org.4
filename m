Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF697291E8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbjFIH6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbjFIH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13F6423C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686297384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0wYOGjo01By5N6ypk4T/kszJYngB2yHKY4BDovVrGlY=;
        b=O7G+H0SbD04zNIRChWZD/Ck4riOoFzaosmzUb5px7vcfZPxULGkmUIGX/QD2vt1kCOSkjr
        nBLsCx9AtPj7s5kk4EvGXVG6GRlnI2NKdRFvUyxfapPq3EXodAT8bmzphJZ6/EWWDRCtK8
        tTvn9YHiIVshpx6p7ZNtkfgmDCeTZrc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-G5FEyEG6MS-Y-nyIC9k_aA-1; Fri, 09 Jun 2023 03:56:20 -0400
X-MC-Unique: G5FEyEG6MS-Y-nyIC9k_aA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D69A4811E7C;
        Fri,  9 Jun 2023 07:56:19 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47A0A20268C6;
        Fri,  9 Jun 2023 07:56:13 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@lst.de, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 06/19] mm/ioremap: add slab availability checking in ioremap_prot
Date:   Fri,  9 Jun 2023 15:55:15 +0800
Message-Id: <20230609075528.9390-7-bhe@redhat.com>
In-Reply-To: <20230609075528.9390-1-bhe@redhat.com>
References: <20230609075528.9390-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several architectures has done checking if slab if available in
ioremap_prot(). In fact it should be done in generic ioremap_prot()
since on any architecutre, slab allocator must be available before
get_vm_area_caller() and vunmap() are used.

Add the checking into generic_ioremap_prot().

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
v5-v6:
  Add WARN_ON_ONCE to aid debugging - Christoph.

 mm/ioremap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/ioremap.c b/mm/ioremap.c
index 9f34a8f90b58..86b82ec27d2b 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -18,6 +18,10 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 	phys_addr_t last_addr;
 	struct vm_struct *area;
 
+	/* An early platform driver might end up here */
+	if (WARN_ON_ONCE(!slab_is_available()))
+		return NULL;
+
 	/* Disallow wrap-around or zero size */
 	last_addr = phys_addr + size - 1;
 	if (!size || last_addr < phys_addr)
-- 
2.34.1

