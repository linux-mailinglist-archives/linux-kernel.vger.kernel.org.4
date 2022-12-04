Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF33641A46
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 02:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLDBdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 20:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiLDBcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 20:32:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456E71A21D
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 17:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670117496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++X/DNxCXN/sOFk0nHQ8NlaSzg5UKadXXJTnhV6jxJs=;
        b=ZWeFaibB5tZSTGfAET0HIg3AbxbzYzIue0CGp6SfwNXz6N2xaT8zselAotUKFhc4JDzwnT
        y2R9NQQlvxLgQEp+som8b/tKygNEs6+m2DLX12JjZtA5qfAKWYHWe/nE+1b+9pPZluttFa
        ndUfMAOpu4HKtLV+f/uSsatyXCg+ocE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-obr3vKRTO-qsZA4wEXD53A-1; Sat, 03 Dec 2022 20:31:33 -0500
X-MC-Unique: obr3vKRTO-qsZA4wEXD53A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 406C0185A794;
        Sun,  4 Dec 2022 01:31:32 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A41F141511E;
        Sun,  4 Dec 2022 01:31:25 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, stephen.s.brennan@oracle.com, urezki@gmail.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 6/7] powerpc: mm: add VM_IOREMAP flag to the vmalloc area
Date:   Sun,  4 Dec 2022 09:30:45 +0800
Message-Id: <20221204013046.154960-7-bhe@redhat.com>
In-Reply-To: <20221204013046.154960-1-bhe@redhat.com>
References: <20221204013046.154960-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Pali Rohár" <pali@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
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

