Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F74F627CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiKNLsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbiKNLrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:47:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9488E25EBD;
        Mon, 14 Nov 2022 03:45:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45B37B80E26;
        Mon, 14 Nov 2022 11:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF98FC433C1;
        Mon, 14 Nov 2022 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426320;
        bh=DJF+imgy2HAxwvL4BHvytn2wHCCnLG9Lu7S4hynUjxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4KLVe8QD97rdiLvx0ybBKluX02uyPznww0DIzficAchO+9g5a627u9P/z0nD682k
         OtGx4Ppr4+qjnsK0CkMv+SJsF0CikUkpWdPEu+cbAUS9yjVgtS+Us8ZZVPC4LU1JPv
         b/N4tv8tXiXLdB6DTEZ4/BkwygPZqexBuh20hhiOgsgGptRq0/GoyA0HFXDr5URhsZ
         DxACqxfyXs4loradezI38i/S0zOEhS/+Q/nDm3n/ltR8xMwKH8R9r1WwM1F3XKjqw/
         Kb3EVH4XNqZyglviCHlikYMRMFV+K+T9v2iDSBhFPuODIOEC2c9zsk8bnkcJfhc1iZ
         LEZf0p+BLa2nA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 34/46] scripts, lto: disable gcc LTO for some mod sources
Date:   Mon, 14 Nov 2022 12:43:32 +0100
Message-Id: <20221114114344.18650-35-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

The mod tools scan assembler (devicetable-offsets.s) to generate symbols
into devicetable-offsets.h and binary (empty.o) to find out ELF setup.
That doesn't work with LTO. So just disable LTO for empty.o and
devicetable-offsets.s.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 scripts/mod/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index c9e38ad937fd..aa3465d6bc4a 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
 CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
+CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO_GCC)
 
 hostprogs-always-y	+= modpost mk_elfconfig
 always-y		+= empty.o
@@ -9,6 +10,8 @@ modpost-objs	:= modpost.o file2alias.o sumversion.o
 
 devicetable-offsets-file := devicetable-offsets.h
 
+$(obj)/devicetable-offsets.s: KBUILD_CFLAGS += $(DISABLE_LTO_GCC)
+
 $(obj)/$(devicetable-offsets-file): $(obj)/devicetable-offsets.s FORCE
 	$(call filechk,offsets,__DEVICETABLE_OFFSETS_H__)
 
-- 
2.38.1

