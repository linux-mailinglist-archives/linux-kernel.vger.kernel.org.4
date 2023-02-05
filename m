Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D092968B2C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 00:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBEXSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 18:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBEXSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 18:18:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9F19694
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 15:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675639035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+iHbljQE4cWri51QLXa4Xz+3mOqMYYEFGlGW+CbZSY=;
        b=d0u/kci3SmpyKeK+1bUK6fjGm+okJNWkRBZ9wjAgT6+IxX9HtyawhmwzebeMMVRWZbBbAA
        ro7HQB+/wu6P0WGc1DBtxrmNq4l31jDk2BcuO/V2wmGHo4O0N/rb3NWfooaTaUuGg96lyf
        XKY/nObhEdjEGMVQu5JE9gYM/lWSHGU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-488-yOKTGlCyPCGhDhMcTnprHA-1; Sun, 05 Feb 2023 18:17:13 -0500
X-MC-Unique: yOKTGlCyPCGhDhMcTnprHA-1
Received: by mail-qk1-f200.google.com with SMTP id s7-20020a05620a0bc700b006e08208eb31so6824285qki.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 15:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+iHbljQE4cWri51QLXa4Xz+3mOqMYYEFGlGW+CbZSY=;
        b=0izwM4dUjiIJW5BaB57NngPuugDw4ZAUf0miLTORP3uHM22CgZPVY2p1bmhcpSaKNt
         Ms/4+VHYhiWL5rECjooinsF987QOPoB3B/AgowQW7gt/2nk+Y+4RWC6D3874VTj15Vfq
         1MYjCX3ZlzoQkO07vyH6xRSk3FDE7LVEWprKf7aJTPBXrDRRc17SmHZ9y+ETSqHmD4E1
         wKAXeMGrWwhdGIGjUn6ZLhoNSSfnGMn78K11OtG9WFQWV3bvh2o5nr2QBmh202ffDxLU
         kCrh62bEzoHhmZkBxIeOK+R7nKIzhftiIHafTg4RPb4sgqCyxPQYrAv5ChfyF1gvgXiP
         /CYQ==
X-Gm-Message-State: AO0yUKWeKHI7a3fir+fipQkZ73SwTn+UYBGpNL2ZaHWZjkHYiIpBt2hT
        xpScmEp7TcVRuNxMGdS+NofAPRD199fHbSsWUfdhntYedL8YntWSVoIkQeP8xXovQz12v/tcAnf
        7+TdCSMvnkko0NZJEQnhq0Seu
X-Received: by 2002:ac8:5a0c:0:b0:3b5:87db:f979 with SMTP id n12-20020ac85a0c000000b003b587dbf979mr36968152qta.5.1675639032210;
        Sun, 05 Feb 2023 15:17:12 -0800 (PST)
X-Google-Smtp-Source: AK7set8/HJ9ylfEnCGuGjHiBabf9O5KRa6hhSOUhT6sDqtmC260VVR8y98Nl2i/0VhE4BCc93ILrBA==
X-Received: by 2002:ac8:5a0c:0:b0:3b5:87db:f979 with SMTP id n12-20020ac85a0c000000b003b587dbf979mr36968130qta.5.1675639031977;
        Sun, 05 Feb 2023 15:17:11 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h26-20020ac8515a000000b003b82cb8748dsm5986545qtn.96.2023.02.05.15.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 15:17:10 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/3] mm/s390: Define private VM_FAULT_* reasons from top bits
Date:   Sun,  5 Feb 2023 18:17:04 -0500
Message-Id: <20230205231704.909536-4-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230205231704.909536-1-peterx@redhat.com>
References: <20230205231704.909536-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current definition already collapse with the generic definition of
vm_fault_reason.  Move the private definitions to allocate bits from the
top of uint so they won't collapse anymore.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/fault.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 9649d9382e0a..cebfbd6dcbaf 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -46,11 +46,15 @@
 #define __SUBCODE_MASK 0x0600
 #define __PF_RES_FIELD 0x8000000000000000ULL
 
-#define VM_FAULT_BADCONTEXT	((__force vm_fault_t) 0x010000)
-#define VM_FAULT_BADMAP		((__force vm_fault_t) 0x020000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t) 0x040000)
-#define VM_FAULT_SIGNAL		((__force vm_fault_t) 0x080000)
-#define VM_FAULT_PFAULT		((__force vm_fault_t) 0x100000)
+/*
+ * Allocate private vm_fault_reason from top.  Please make sure it won't
+ * collide with vm_fault_reason.
+ */
+#define VM_FAULT_BADCONTEXT	((__force vm_fault_t) 0x80000000)
+#define VM_FAULT_BADMAP		((__force vm_fault_t) 0x40000000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t) 0x20000000)
+#define VM_FAULT_SIGNAL		((__force vm_fault_t) 0x10000000)
+#define VM_FAULT_PFAULT		((__force vm_fault_t) 0x8000000)
 
 enum fault_type {
 	KERNEL_FAULT,
-- 
2.37.3

