Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D8768B2BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 00:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBEXR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 18:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBEXR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 18:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DAF2698
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 15:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675639031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qONcW0u0rSlhga0NbKyxqeLooMqDqXOYmnEPrTgV3J4=;
        b=NwDki4L4KmNw56uC3T+KTFhy26MfFO7pFMDgpqZtfkPNZZ/Uf0iIJLklJ9vw5yAu4+yDm+
        V1Asiql4ffUcNrn7YQAjI0BRhyBhN0ClDDTVcFzb5koS7Bn8Cz8S3EqxPoxGjmu1Fz7orJ
        zbDYJVmlr5+zN8xdxEkZ/fEts25UJUE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-368-ySfTW5yuMNiEMIZsAjfbDQ-1; Sun, 05 Feb 2023 18:17:09 -0500
X-MC-Unique: ySfTW5yuMNiEMIZsAjfbDQ-1
Received: by mail-qk1-f197.google.com with SMTP id a6-20020a05620a102600b00729952b4c73so6771833qkk.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 15:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qONcW0u0rSlhga0NbKyxqeLooMqDqXOYmnEPrTgV3J4=;
        b=dqTF+ZBcJZt1PzDcQIljNBz9zlUlKNuYNlq5DJVedYztWbudOkRFb56MVGbuYHOjs0
         RvD9+DFqTLt2ZEsLZkbvTdJvojqrQYlmHl4zA7p7IS9J2kHmg/mpCYKHS4VyavenosOQ
         FnKf5DbAC0lYlrkH1O8gbZ6kWfyThz85FAplt7hzghOiOBweVkIeFcWSew0jI2JEAhqh
         ojB00SAWQOGO4zU0Y0crhG6KV+KRkFd4wsvgXitYoVleDypWI9TyGa/xpHsRrjUy/1oq
         204ub1Xb2kR5HvuBRGpBojwzZpCon87XHtOBu9Kodl3i1dSFqLmrvGwnlmnPPMLgCmOW
         q0pQ==
X-Gm-Message-State: AO0yUKX2BxnLHdIeN1WEImpb2CpztLq3h+v2E+2si8VuqHJkTU0ruCaO
        BHHb41fuQnPvesOZv+xbFhf4vS55ywo/m2O3Ht3vwoowWJV5XrpiF0xXRaLZYYsV5OoWQdBHqxG
        HYyTTMueddLDMh1uQc7SdIuYW
X-Received: by 2002:ac8:5a0c:0:b0:3b5:87db:f979 with SMTP id n12-20020ac85a0c000000b003b587dbf979mr36967893qta.5.1675639028663;
        Sun, 05 Feb 2023 15:17:08 -0800 (PST)
X-Google-Smtp-Source: AK7set9kqgEL6o3t7eGoOILoA6rSeOClso5mcvRwdEtgXNoCUXmYbAoESbFf+GAMsxjDlz50rZUFyQ==
X-Received: by 2002:ac8:5a0c:0:b0:3b5:87db:f979 with SMTP id n12-20020ac85a0c000000b003b587dbf979mr36967876qta.5.1675639028460;
        Sun, 05 Feb 2023 15:17:08 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h26-20020ac8515a000000b003b82cb8748dsm5986545qtn.96.2023.02.05.15.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 15:17:07 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/3] mm/arm: Define private VM_FAULT_* reasons from top bits
Date:   Sun,  5 Feb 2023 18:17:02 -0500
Message-Id: <20230205231704.909536-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230205231704.909536-1-peterx@redhat.com>
References: <20230205231704.909536-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
 arch/arm/mm/fault.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2418f1efabd8..67879d995835 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -216,8 +216,12 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_MMU
-#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
+/*
+ * Allocate private vm_fault_reason from top.  Please make sure it won't
+ * collide with vm_fault_reason.
+ */
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x80000000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x40000000)
 
 static inline bool is_permission_fault(unsigned int fsr)
 {
-- 
2.37.3

