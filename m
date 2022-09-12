Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8615B5C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiILOjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiILOjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:39:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38763197
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:39:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t7so15673991wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=G6Kgwh0FOpFSSJdpcBHkyiAMZDwuR29zQdpZ1Wj8JwU=;
        b=izMrUpgLEUaemO8W05IaXiKI63GBjOqAD8ViJsqyAX6RzqNIkGq2+7zvQhYCt0dMpB
         /A0Ey1Ejr1TZfM70/BDY5qgkbhvrLRKOZEMjqnD0cgIuqy7y1xJBs2tnLHoHnH80Nqdh
         W+b8YTaUhtPh2iQZo+vr2bAaFF3VdWDYjGO5YiId52iLykGDh81iSdbYeZFRjqm0dpol
         DE8gkFuvjwCYvoh9zOyrV8LcOKPhup8iZopAadmofCgRf+DaDIYiT+lZBdat4YVvH3sQ
         N1kWfuVN9XVkjYlGV0xoaCcu1Tcg4ITt+Q1+snUfrrePySAKeIvP+kNJxYo88hpW2Qbz
         2I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=G6Kgwh0FOpFSSJdpcBHkyiAMZDwuR29zQdpZ1Wj8JwU=;
        b=4D5cWNsjqDvG5M2ekRoPVwRrmPhG0byUrBn2z9CDiHDjoY09WeG7M3gS/GxH/iOLF+
         Xzaim+R2ZrBXHGwFcmbbmujBoUNDYnf8jmEcwyfjvqqn/XiEonTBNGZ364cxRtO2MibY
         V1pk585jAYWLxrEdeU7faE6j7e4+qZZ/NgpNpdsMpqqk73YtSFTVRA2398bYBivXoAwp
         bOJboXE4YreEDgrJcyKgXdNm0oG/PKtWInNQzn1eC2gVy4ZS62ovNfmZnRpWwNq88syS
         vGb0Vz1WVi235PlOReldMu3/567/BGqae9oeeTjUYnvdKAEQVte8YDMXf5LRl/g5fJBO
         +Vzg==
X-Gm-Message-State: ACgBeo1M0UysO3TUMOLBnGA6mSGUrSJYwfrxCZ6zxXJxNjlKXzn9nE42
        iVxKZYNB2VNI5hl+a+9Zkw/o9VXWKgp7SA==
X-Google-Smtp-Source: AA6agR5Zu5EmVqdrUSRuRmZWLvpaCfrp5NF29pUz9eWwI0PHPbfv/8tYCcWHh4BV3RQNbC9XpFQLYw==
X-Received: by 2002:adf:eb02:0:b0:227:1c:e760 with SMTP id s2-20020adfeb02000000b00227001ce760mr15127244wrn.635.1662993565337;
        Mon, 12 Sep 2022 07:39:25 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb44000000b0022a2c600d5csm7681733wrs.55.2022.09.12.07.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:39:24 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF for X86_CMPXCHG64
Date:   Mon, 12 Sep 2022 16:39:03 +0200
Message-Id: <20220912143903.3198-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Commit bc08b449ee14ace4d869adaa1bb35a44ce68d775 enabled lockless
reference count updates using cmpxchg() only for x86_64 and
left x86_32 behind due to inability to detect support for
cmpxchg8b instruction. Nowadays, we can use CONFIG_X86_CMPXCHG64
for this purpose. Also, by using try_cmpxchg64() instead of cmpxchg64()
in CMPXCHG_LOOP macro, the compiler actually produces sane code,
improving lockref_get_not_zero main loop from:

  eb:	8d 48 01             	lea    0x1(%eax),%ecx
  ee:	85 c0                	test   %eax,%eax
  f0:	7e 2f                	jle    121 <lockref_get_not_zero+0x71>
  f2:	8b 44 24 10          	mov    0x10(%esp),%eax
  f6:	8b 54 24 14          	mov    0x14(%esp),%edx
  fa:	8b 74 24 08          	mov    0x8(%esp),%esi
  fe:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
 102:	8b 7c 24 14          	mov    0x14(%esp),%edi
 106:	89 c1                	mov    %eax,%ecx
 108:	89 c3                	mov    %eax,%ebx
 10a:	8b 74 24 10          	mov    0x10(%esp),%esi
 10e:	89 d0                	mov    %edx,%eax
 110:	31 fa                	xor    %edi,%edx
 112:	31 ce                	xor    %ecx,%esi
 114:	09 f2                	or     %esi,%edx
 116:	75 58                	jne    170 <lockref_get_not_zero+0xc0>

to:

 350:	8d 4f 01             	lea    0x1(%edi),%ecx
 353:	85 ff                	test   %edi,%edi
 355:	7e 79                	jle    3d0 <lockref_get_not_zero+0xb0>
 357:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
 35b:	75 53                	jne    3b0 <lockref_get_not_zero+0x90>

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
---
v3:
 - Update commit message to refer to lockref_get_not_zero
   instead of removed lockref_get_or_lock
v2:
 - select ARCH_USE_CMPXCHG_LOCKREF for CONFIG_X86_CMPXCHG which
   is unconditionally defined for X86_64
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..93c8e6cf1cff 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -27,7 +27,6 @@ config X86_64
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
-	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
@@ -110,6 +109,7 @@ config X86
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_USE_BUILTIN_BSWAP
+	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
-- 
2.37.2

