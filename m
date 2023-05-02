Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9DA6F3E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjEBHl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjEBHlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:41:25 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377C3E7A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:41:24 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-517bad1b8c5so3366675a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 00:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683013283; x=1685605283;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4L2V9c4CmIAtK3KFjaBFh5H6J9gLqid7KK9E18ZFAsY=;
        b=buBabAKCzebIEoI0YvCo/l96UaflEhqn7hv/Q+Mi/cHHkpKuMH0Zue5iWzUfOvn8NO
         nRXOxjpEY2DKW/iQu/tT8mHID+TnbtSuBLqkFH5xRdG6gru0Bzxzdu+w89s8WKBOLbmb
         Dq1iqiiNlFtmVJ2xg8wW7u4SKG4d00ZG+BM2kwgZYuQLsS8NO2Yr3MIPRngr5/gDJDGy
         bpt1UiH99ZsnByKISJ8HsyQMGDth2eUZfWGmNK/SppducYy3c/GVWh3SyUPAp6lHEJHK
         oo3t1xDNKvK464q2aDg8tbbNtbnbfr4Nq9wcoZq2CNNMz4FC2odazqaEAxy2vYzGnHk4
         AcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683013283; x=1685605283;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4L2V9c4CmIAtK3KFjaBFh5H6J9gLqid7KK9E18ZFAsY=;
        b=FaVAUCN1GC/r5s9Pr8WfCC0+r5hHKGQ1+HPyYEhFOZZc9VwoFlfCZBlWYeTXPkAx0+
         XpwM0ErBr4pox4NNNeMmd6KvxEeUEbvSBKENC/jgfREhUzdfiN8wRVfYIZV+hlzauX1Q
         8D+htaoLCN2lRvRc5eD2nUfgCuSJ2qIZVLz3vGSwBc/mZDnJH1a+KRXbw7K5DARa6UJR
         goYVl870nKDKyxL80+Afh46IFdNtPr7BKTBw3j6iC/bx6pOBpZGrvAIecygrkLBKOXQA
         iM+kiLaPhOXSlwD3M3TpMRTupFFmwl7idpcx3F7rh8axnV1hbhf2XT6C+Uuj0qPmZdB+
         CVSA==
X-Gm-Message-State: AC+VfDyIR7Hs/bbl+G4XkK0QmOCUzbepFyciy5ajHRT10uyyz/hhxDZJ
        rGrWwwLazRBJARSPfa/cEMLkSGaJyimS
X-Google-Smtp-Source: ACHHUZ6N4sXR/rmHOtONduuauPYGhL1OTBsYWaPVnhILOdVwKsdHmT9krrtc3mSlv0Y81sha5+9tXNDH73S1
X-Received: from meowing-l.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3eba])
 (user=maskray job=sendgmr) by 2002:a63:2a0d:0:b0:528:9f8f:1b92 with SMTP id
 q13-20020a632a0d000000b005289f8f1b92mr4016671pgq.4.1683013283612; Tue, 02 May
 2023 00:41:23 -0700 (PDT)
Date:   Tue,  2 May 2023 07:41:05 +0000
Mime-Version: 1.0
Message-ID: <20230502074105.1541926-1-maskray@google.com>
Subject: [PATCH v3] arm64: lds: move .got section out of .text
From:   Fangrui Song <maskray@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the .got section is placed within the output section .text.
However, when .got is non-empty, the SHF_WRITE flag is set for .text
when linked by lld. GNU ld recognizes .text as a special section and
ignores the SHF_WRITE flag. By renaming .text, we can also get the
SHF_WRITE flag.

The kernel has performed R_AARCH64_RELATIVE resolving very early, and can
then assume that .got is read-only. Let's move .got to the vmlinux_rodata
pseudo-segment.

As Ard Biesheuvel notes:

"This matters to consumers of the vmlinux ELF representation of the
kernel image, such as syzkaller, which disregards writable PT_LOAD
segments when resolving code symbols. The kernel itself does not care
about this distinction, but given that the GOT contains data and not
code, it does not require executable permissions, and therefore does
not belong in .text to begin with."

Signed-off-by: Fangrui Song <maskray@google.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

--
Changes from v1 (https://lore.kernel.org/lkml/20230428050442.180913-1-maskray@google.com/)
* move .got to the vmlinux_rodata pseudo-segment as suggested by Ard Biesheuvel

Changes from v2 (https://lore.kernel.org/r/all/20230501222551.1254686-1-maskray@google.com/)
* add Ard Biesheuvel's Reviewed-by tag and addition to the commit message.
---
 arch/arm64/kernel/vmlinux.lds.S | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b9202c2ee18e..3cd7e76cc562 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -181,10 +181,17 @@ SECTIONS
 			KPROBES_TEXT
 			HYPERVISOR_TEXT
 			*(.gnu.warning)
-		. = ALIGN(16);
-		*(.got)			/* Global offset table		*/
 	}
 
+	. = ALIGN(SEGMENT_ALIGN);
+	_etext = .;			/* End of text section */
+
+	/* everything from this point to __init_begin will be marked RO NX */
+	RO_DATA(PAGE_SIZE)
+
+	HYPERVISOR_DATA_SECTIONS
+
+	.got : { *(.got) }
 	/*
 	 * Make sure that the .got.plt is either completely empty or it
 	 * contains only the lazy dispatch entries.
@@ -193,14 +200,6 @@ SECTIONS
 	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
 	       "Unexpected GOT/PLT entries detected!")
 
-	. = ALIGN(SEGMENT_ALIGN);
-	_etext = .;			/* End of text section */
-
-	/* everything from this point to __init_begin will be marked RO NX */
-	RO_DATA(PAGE_SIZE)
-
-	HYPERVISOR_DATA_SECTIONS
-
 	/* code sections that are never executed via the kernel mapping */
 	.rodata.text : {
 		TRAMP_TEXT
-- 
2.40.1.495.gc816e09b53d-goog

