Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A233764F6D9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiLQB47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQB4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:56:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC9A67DA9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671242131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQCOjBquH4pkVeAMaXmqGzrHd+dzzqTdFcVytK4qewc=;
        b=A5k2jNrFRmJvFAWDIhrl7KfNnx24nPFGiBg+f4+YrQFSdco7VJwZos+KE8O8EVyt0MPnII
        FzJ3ITm8iNXQtrnVEbh2zNSJL0gzTvcrb4DhjLU6dq9yT1o5zp4kzpsAICVtyY98KJBppl
        Nk5Ql45qQ/G+5tbeEpUyVMcue8bd55E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-GWwgl6saO368hRoPTIHngg-1; Fri, 16 Dec 2022 20:55:25 -0500
X-MC-Unique: GWwgl6saO368hRoPTIHngg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B12A2811E9C;
        Sat, 17 Dec 2022 01:55:24 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46C0F400F5A;
        Sat, 17 Dec 2022 01:55:18 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, urezki@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sh@vger.kernel.org
Subject: [PATCH v2 7/7] sh: mm: set VM_IOREMAP flag to the vmalloc area
Date:   Sat, 17 Dec 2022 09:54:35 +0800
Message-Id: <20221217015435.73889-8-bhe@redhat.com>
In-Reply-To: <20221217015435.73889-1-bhe@redhat.com>
References: <20221217015435.73889-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sh@vger.kernel.org
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

