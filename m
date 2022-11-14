Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD1627CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiKNLsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbiKNLr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:47:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5010222508;
        Mon, 14 Nov 2022 03:45:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DFF2ACE0F52;
        Mon, 14 Nov 2022 11:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E11C433D7;
        Mon, 14 Nov 2022 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426323;
        bh=2VZ4ODzq0c+qrTqaRhf/GBj3Hij1v5FmA5K2QGdY/7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhEo3a5Lx3UZZADPhb5Wp70Y2vIT2YeqX9rt3iHUK9eS+k/5sSbR2h9BZZZHUn7OB
         t3cI5HGlUnqznWOwYP2wjqyreX+9nSEH+r97DCMAmR1B5BZZnM02A97aSEpHsDmnGV
         Q6iV21VOlcdoSFRKninhJTHK3XUoCvEKM3s7HXBrOWaCLmbDxs7EIB8U/yIKLMLd74
         iUwYaDPgNw9YryLoADxfO/+sdnwJr69IK7wRzQsrU1h6X+1yMqSZG9CgBE0Uxv9NNM
         FNtdG/7I+sxoMD3Gk6bglBTDaKot5bWBlP5pfqsDQ48tN8Hyt83yGvoh4IeUp4VSxB
         tJO24okcYNl3w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 35/46] Kbuild, lto: disable gcc LTO for bounds+asm-offsets
Date:   Mon, 14 Nov 2022 12:43:33 +0100
Message-Id: <20221114114344.18650-36-jirislaby@kernel.org>
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

Disable LTO when generating the bounds+asm-offsets.s files which are
scanned for C constants. With a LTO build, the file would contain the
gcc IR in assembler form, which breaks the scanning scripts.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Kbuild | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Kbuild b/Kbuild
index 464b34a08f51..40744d76d416 100644
--- a/Kbuild
+++ b/Kbuild
@@ -11,6 +11,8 @@ bounds-file := include/generated/bounds.h
 
 targets := kernel/bounds.s
 
+kernel/bounds.s: KBUILD_CFLAGS += $(DISABLE_LTO_GCC)
+
 $(bounds-file): kernel/bounds.s FORCE
 	$(call filechk,offsets,__LINUX_BOUNDS_H__)
 
@@ -30,6 +32,7 @@ offsets-file := include/generated/asm-offsets.h
 targets += arch/$(SRCARCH)/kernel/asm-offsets.s
 
 arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)
+arch/$(SRCARCH)/kernel/asm-offsets.s: KBUILD_CFLAGS += $(DISABLE_LTO_GCC)
 
 $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
-- 
2.38.1

