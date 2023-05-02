Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893BD6F46E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjEBPTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjEBPTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:19:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310C31FD8
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:19:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24ddf274039so2276540a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683040753; x=1685632753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1x1mbgDLzclcZwAJOmV4gnyFDUjf/yM7yiHAaAecRm4=;
        b=CSfZ0A0M6DzS9I3wOxqXtpu5roghrXv8OcQQgL4I1AsGb2DfJyN/qyRPHR4m3yQHWz
         uiicm3xUNAbMEuo2LIsEcCjuGhlv6Y772uZPJhQPggV3w+MWrdugV69uZIdw7j9E3Lhj
         tP+way+TUw/FyoxBAnSAecH6tBeHDZUrcTVrM4bYWWn/SpaV4RInGuGyJ6fbRm/JEttB
         KZdLvRFi+C3sJ7kz9xFmVxu42nderO/29jLQL5l9cVa1iVQWt++si5eb2AfI90dlwnbu
         Wifj2t9dzuj2uqXUAjsUG3f27j5Et6/EjE6ZRJD55Mo+dG2NSXT4sWYTp0vlnEqlNR5z
         T0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683040753; x=1685632753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1x1mbgDLzclcZwAJOmV4gnyFDUjf/yM7yiHAaAecRm4=;
        b=cZEwsFhost6X9beIQHkKEJcOry9CQUp6dJ6uVxY20o0jeASP3pnOF61GRzR1Ih/3ln
         3oruTYzmYbe8rGmgdJGT9UbsoweKfZbYJE0Id6k+xhF0GrhNgUwLDI85Q0FIi2xhk7HF
         qJasDe+FhGP+uvLJdVWwbfQayemlsh2hbt+sj/tfsiFqM2NaKC+lHTGOomjegsw5SusN
         a0AUV8tzr8VxMnhnHjbxZ+KRzqiqb4uBXvU0s5GxV5h+tfw3WMx++toEbY6WGBsQIFa5
         McO9iByhKBMtcE+6kANabC/EFuBW86BSEWcU+3l2+lFJd3C5/X3peXy59gWJLmV0X3lF
         iPXg==
X-Gm-Message-State: AC+VfDz3b6bOMsNyeBDhcVg1dQSxtMd/olKoW8NNi6Ah4lvNBuS07t8d
        TdCfxDwpj+80od0EE4UbnLk=
X-Google-Smtp-Source: ACHHUZ5oKp2uLyIC2/5hZAZzLg0ruBsLK0vBlZtiyDSCLEfVgc/J2fWup1CnfKX/d0NHFPFTzoMLAg==
X-Received: by 2002:a17:90a:e018:b0:23f:1159:c0db with SMTP id u24-20020a17090ae01800b0023f1159c0dbmr18887637pjy.26.1683040753556;
        Tue, 02 May 2023 08:19:13 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-99-123.dynamic-ip.hinet.net. [36.228.99.123])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090b070100b0024499d4b72esm21325114pjz.51.2023.05.02.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:19:13 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: mark private VM_FAULT_X defines as vm_fault_t
Date:   Tue,  2 May 2023 23:19:06 +0800
Message-Id: <20230502151909.128810-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes several sparse warnings for fault.c:

arch/arm64/mm/fault.c:493:24: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:493:24: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:493:24: sparse:    got int
arch/arm64/mm/fault.c:501:32: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:501:32: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:501:32: sparse:    got int
arch/arm64/mm/fault.c:503:32: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:503:32: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:503:32: sparse:    got int
arch/arm64/mm/fault.c:511:24: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:511:24: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:511:24: sparse:    got int
arch/arm64/mm/fault.c:670:13: sparse: warning: restricted vm_fault_t degrades to integer
arch/arm64/mm/fault.c:670:13: sparse: warning: restricted vm_fault_t degrades to integer
arch/arm64/mm/fault.c:713:39: sparse: warning: restricted vm_fault_t degrades to integer

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 arch/arm64/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9e0db5c387e3..cb21ccd7940d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -480,8 +480,8 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 	}
 }
 
-#define VM_FAULT_BADMAP		0x010000
-#define VM_FAULT_BADACCESS	0x020000
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 				  unsigned int mm_flags, unsigned long vm_flags,
-- 
2.34.1

