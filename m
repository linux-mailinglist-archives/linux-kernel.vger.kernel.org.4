Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1485267620E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjAUARc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjAUARV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:17:21 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3B0BAF19
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:16:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a14-20020a5b0ace000000b007bf99065fcbso7437957ybr.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSSiGqnlhzGiDLCzSAtleJIHOm3o/jPruEIVdPoSPmM=;
        b=i3bQf8fOpOKYn4DsIRRzCUmnsCj+LMJV96+HJVERlyQV50GGhU4m9vph9dFvXLxh33
         a6PijOok3GOHph4F2aF0Uo8zDnzeIuzhlwcNn/lmpe5ODxgUHA6krkenLMHAVsTMVG8A
         DQOBErL8T8utFKaa2hBwsfFZN+8NkBWs2+uZyhMMxhKrvH43FYJ7I3M1J/lUsHYsC3JO
         fw9Xc1e8mfpAWmMp8YsemFubhIbnl6sBYlN9R8OgKxypq4dN68xuIBEA7FNjAMYzR1gV
         Yu5F1WkIRQy/QQlujBYRghEm0b6qOSbdB7fBbpYVu8C0LSyi/b3WnM5jtqRfovPdsPgx
         hPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSSiGqnlhzGiDLCzSAtleJIHOm3o/jPruEIVdPoSPmM=;
        b=aiVLeTYVPKLFTBOqHSjYXV8XkOBDXwXj08bzJ54nXnLnnHpHzLpa+0flxTerwd5mhM
         kzrGIi5u0gEms/GLrxYYiewjeZ30uwXD7Cny99vx/MOodqE5X/AGYi2yJ+QJ5ndelHPd
         1v+UK1LemwTFgvdS1bO80DmN73yPqirM9UsTBAaRZfBbCeNRdohz2pbNG0RXuM5A1Laj
         +rYI0rA8dakH0gs3KR4ipU3rkap1XH4fhxCEEGRCdIrclfI1cQGbUcypVMd8bJKENxXQ
         gP8KXV2CVJbSXYnzWabC/Q46r6RPsEtZbrHug3T37mB9Xn9xBJmleFCYNF82OBozKJ5q
         vK9Q==
X-Gm-Message-State: AFqh2kovC8Zgjy243aNk5moxIqzqlkf9uFk5Kmbuinbz7ykt230gEtRY
        0JQdaJ4ZI4mAQW7BnFCX8VaVA5ITbJ6TMyU//Q==
X-Google-Smtp-Source: AMrXdXtNm9J3NZyrFD1KxSqYxPFs466v/i5MLLy+izXPoRIE2JNGfeNALA/eYTNAOnPBcLdA/BrRIezn5OXkpRyumg==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a81:bc9:0:b0:471:d0:fcdf with SMTP id
 192-20020a810bc9000000b0047100d0fcdfmr1932256ywl.108.1674260206107; Fri, 20
 Jan 2023 16:16:46 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:19 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-9-ackerleytng@google.com>
Subject: [RFC PATCH v3 08/31] KVM: selftests: Require GCC to realign stacks on
 function entry
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SSE instructions assume a 16-byte aligned stack, and GCC compiles
assuming the stack is aligned:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=40838. This combination
results in a #GP in guests.

Adding this compiler flag will generate an alternate prologue and
epilogue to realign the runtime stack, which makes selftest code
slower and bigger, but this is okay since we do not need selftest code
to be extremely performant.

Similar issue discussed at
https://lore.kernel.org/all/CAGtprH9yKvuaF5yruh3BupQe4BxDGiBQk3ExtY2m39yP-tppsg@mail.gmail.com/

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 317927d9c55bd..5f9cc1e6ee67e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -205,7 +205,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
 else
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
-CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
+CFLAGS += -mstackrealign -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
 	-I$(<D) -Iinclude/$(UNAME_M) -I ../rseq -I.. $(EXTRA_CFLAGS) \
-- 
2.39.0.246.g2a6d74b583-goog

