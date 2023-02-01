Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B5B6862A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjBAJPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjBAJPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:15:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5A73CE17
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675242867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yf8UeWDRzlFUhfaCSIXW0vSnsYH1u1H+pSaVUFMvrEs=;
        b=LVAVB2lHVw6mKb86SQ8WIJeBsLvO+4Gt0kFpV62NfUTRZRctPkgHI6xYJNMcij+objSGcG
        iTcngLQdI2HvpI6oe1Rb2NC4IV0qce4IaKaVmY8l2fvdhEYiVcufyOUzYuj+kewXKWRcr7
        c+otzi3BciwPsKZMXac3OqQ709wioDk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-WDpjG_CZM1Gl0d4Xg9d3Gg-1; Wed, 01 Feb 2023 04:14:24 -0500
X-MC-Unique: WDpjG_CZM1Gl0d4Xg9d3Gg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F68F29AB3F3;
        Wed,  1 Feb 2023 09:14:23 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-89.pek2.redhat.com [10.72.13.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DDC8492C3E;
        Wed,  1 Feb 2023 09:14:17 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        stephen.s.brennan@oracle.com, urezki@gmail.com, lstoakes@gmail.com,
        willy@infradead.org, hch@infradead.org, error27@gmail.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 7/7] sh: mm: set VM_IOREMAP flag to the vmalloc area
Date:   Wed,  1 Feb 2023 17:13:39 +0800
Message-Id: <20230201091339.61761-8-bhe@redhat.com>
In-Reply-To: <20230201091339.61761-1-bhe@redhat.com>
References: <20230201091339.61761-1-bhe@redhat.com>
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

Currently, for vmalloc areas with flag VM_IOREMAP set, except of the
specific alignment clamping in __get_vm_area_node(), they will be
1) Shown as ioremap in /proc/vmallocinfo;
2) Ignored by /proc/kcore reading via vread()

So for the ioremap in __sq_remap() of sh, we should set VM_IOREMAP
in flag to make it handled correctly as above.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 arch/sh/kernel/cpu/sh4/sq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index a76b94e41e91..27f2e3da5aa2 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -103,7 +103,7 @@ static int __sq_remap(struct sq_mapping *map, pgprot_t prot)
 #if defined(CONFIG_MMU)
 	struct vm_struct *vma;
 
-	vma = __get_vm_area_caller(map->size, VM_ALLOC, map->sq_addr,
+	vma = __get_vm_area_caller(map->size, VM_IOREMAP, map->sq_addr,
 			SQ_ADDRMAX, __builtin_return_address(0));
 	if (!vma)
 		return -ENOMEM;
-- 
2.34.1

