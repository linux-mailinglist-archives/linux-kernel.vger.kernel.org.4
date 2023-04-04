Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9FE6D5B51
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjDDI53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjDDI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5F21735
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680598602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mfDdyKVcifJZLH02TcTIG5kV3xa5JKdcM7nY2dpg5xs=;
        b=KKJsCgwhhzj7bVCeawec5RmQRQVvyorys7rYxe+dEafr21cx7391+bOaRizAFQ+AfEK2NR
        HcHBsQH9krw+z4n5pqPyZUu+CsBVXOOMjZj79hZFX0DioWFtbxOWMNx/0TE0lTFCVfJdwi
        zbV5kjzpaCdtECBxbBkroayOyWoGcKc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-rcAuzLC2OHW6ZU8PpU3jBQ-1; Tue, 04 Apr 2023 04:56:39 -0400
X-MC-Unique: rcAuzLC2OHW6ZU8PpU3jBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EE9C85A588;
        Tue,  4 Apr 2023 08:56:38 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF92E40C83AC;
        Tue,  4 Apr 2023 08:56:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] m68k/mm: Use correct bit number in _PAGE_SWP_EXCLUSIVE comment
Date:   Tue,  4 Apr 2023 10:56:36 +0200
Message-Id: <20230404085636.121409-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noticed by Geert, commit b5c88f21531c ("microblaze/mm: support
__HAVE_ARCH_PTE_SWP_EXCLUSIVE") modified m68k code by accident. While
replacing 0x080 by CF_PAGE_NOCACHE is correct, although it should have
been part of commit ed4154067a08 ("m68k/mm: support
__HAVE_ARCH_PTE_SWP_EXCLUSIVE"), replacing "bit 7" by "bit 24" in the
comment was wrong.

Let's revert to the previous, correct, comment.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/m68k/include/asm/mcf_pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 13741c1245e1..d97fbb812f63 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -46,7 +46,7 @@
 #define _CACHEMASK040		(~0x060)
 #define _PAGE_GLOBAL040		0x400   /* 68040 global bit, used for kva descs */
 
-/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
+/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
 #define _PAGE_SWP_EXCLUSIVE	CF_PAGE_NOCACHE
 
 /*
-- 
2.39.2

