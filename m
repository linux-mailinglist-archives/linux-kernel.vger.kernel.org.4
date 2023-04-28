Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194846F113B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 07:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbjD1FFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjD1FFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:05:06 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49BC26B3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 22:05:04 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1a950b97dafso78025495ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682658304; x=1685250304;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WMs1qPhxL/BS9MMmSEsgwTMurDosjtHWEBwSfQK3U8A=;
        b=4GQDh6mFwGATF9SJtXccUcdoequAkNrAXmgbZCy+DaIB7+el/ymFviB3yK7LVIm2M8
         VN1vsubPIJ5SyXXQJikcLodRrSIaBMpdQoNvRG24JP8if5fs6/cCJk0IoWw1VSYayg1N
         dqv9ueQiWwz1aqAY0YDTe1S3GhZM/GxyI1XFUAPFugFoes/8x94MvQoAIu/ApUWoE+YL
         TVIxlsnTrtWoWKUoM9DpCVRY3hHcWcvAhhBeRlY3LSZc3xhWrw4dtG7rWkuT/0raTxC6
         DmVzRMLCqEgog5SNtBSA6WzBAxs/aFSqF6wKihf34mXXXiPkJk/AOj3XqBWnEXg1Rgr/
         ZqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682658304; x=1685250304;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMs1qPhxL/BS9MMmSEsgwTMurDosjtHWEBwSfQK3U8A=;
        b=De6QzGEkSLa7TAayvx1QeN4IOnjYw2Mi5KsNco9UqlX1tP18V2U3xpuo+VxhfLsb0o
         zBQuHXbdDMe2tw2aMcy4RYVjHJvV+gGefZ3PEfxQYB9pWCCJXwPV+dqBJ8rZwdpFMflX
         zHo8yCGWKp47muVDAe0Vun+jSyh8lUAfdBHWEVtLEbh5HoZwX1eaAMFDJWDSPOpR2s6y
         VekZRr3E+o2R0vmrsYIQ6RttTakvSwGWPRlmf90MVSqnjwuDoOoSlaDagkhekX208sYo
         T1hFL8QbpGwdoeXPxY6lUe75wba9nxCqxZV4796cUuPCr+5qLGadvEQ0JDP8Isum8VGN
         hirg==
X-Gm-Message-State: AC+VfDwIxPEtgzS2H1WsE+PprbmqGW1FNdHAdL/9B7/bDnxE5UZBnbR3
        65wgtalThRK34NCuHtv6htv4oMckmsCb
X-Google-Smtp-Source: ACHHUZ6ZzBcN/mv/MeJEVTey2sDWypLXT1OQBkVfztH0jlUTTZf6QjJzrkb1J7kPJ1stM2edHFOvR6PdI0XK
X-Received: from meowing-l.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3eba])
 (user=maskray job=sendgmr) by 2002:a17:902:e541:b0:1a2:1fd0:226b with SMTP id
 n1-20020a170902e54100b001a21fd0226bmr1419587plf.5.1682658304294; Thu, 27 Apr
 2023 22:05:04 -0700 (PDT)
Date:   Fri, 28 Apr 2023 05:04:42 +0000
Mime-Version: 1.0
Message-ID: <20230428050442.180913-1-maskray@google.com>
Subject: [PATCH] arm64: lds: move .got section out of .text
From:   Fangrui Song <maskray@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
However, when .got is non-empty, the SHF_WRITE flag is set when linked
by lld. GNU ld recognizes .text as a special section and ignores the
SHF_WRITE flag. By renaming .text, we can also get the SHF_WRITE flag.

Conventionally, the .got section is placed just before .got.plt (which
should be empty and omitted in the kernel). Therefore, we move the .got
section to a conventional location (between .text and .data) and remove
the unneeded `. = ALIGN(16)`.

Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b9202c2ee18e..2bcb3b30db41 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -181,18 +181,8 @@ SECTIONS
 			KPROBES_TEXT
 			HYPERVISOR_TEXT
 			*(.gnu.warning)
-		. = ALIGN(16);
-		*(.got)			/* Global offset table		*/
 	}
 
-	/*
-	 * Make sure that the .got.plt is either completely empty or it
-	 * contains only the lazy dispatch entries.
-	 */
-	.got.plt : { *(.got.plt) }
-	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
-	       "Unexpected GOT/PLT entries detected!")
-
 	. = ALIGN(SEGMENT_ALIGN);
 	_etext = .;			/* End of text section */
 
@@ -247,6 +237,16 @@ SECTIONS
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__inittext_end = .;
+
+	.got : { *(.got) }
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the lazy dispatch entries.
+	 */
+	.got.plt : { *(.got.plt) }
+	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
+	       "Unexpected GOT/PLT entries detected!")
+
 	__initdata_begin = .;
 
 	init_idmap_pg_dir = .;
-- 
2.40.1.495.gc816e09b53d-goog

