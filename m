Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8A6627C98
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbiKNLoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiKNLoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD60615713
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 656C6B80E72
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABCFC433C1;
        Mon, 14 Nov 2022 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426242;
        bh=t+kVodx/FyufZNDsyZR/TwnYyg/ybb2UIRRgGwwP+eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXOb2fLuZw/2J8Qd9Ved8cY7hYxzzQuae6NEGFIpy9dPRy+cozgBPKXVlAB2uLWOy
         dXU04R/FNA0em0A0rfrKr4uL80Gcm8yAYgJUlUHpjUNFICoq+Sam/mPP/qN31VQ+ie
         6yt+twlhe/DAmiD1WfWogfoTOcFMyKv2iZw5UoI8821X7FE6tsFPpUjDDqGDhRNFzm
         LjhsqrZEHZPdBviitzbEz5nw0VltGJ6e8HRBWmdl/J4c7ADc7wwtOzk5WFVTOPFC33
         vBq2yv1AQkbHnqZrx6ES0Pc2Z542HkVxcds5k64rFEXIPkvduVn49AGCtvTkL4L++u
         d2RYjtNihgHRw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.cz>, Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Martin Liska <mliska@suse.cz>
Subject: [PATCH 02/46] kbuild: pass jobserver to cmd_ld_vmlinux.o
Date:   Mon, 14 Nov 2022 12:43:00 +0100
Message-Id: <20221114114344.18650-3-jirislaby@kernel.org>
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

From: Jiri Slaby <jslaby@suse.cz>

Until the link-vmlinux.sh split (cf. the commit below), the linker was
run with jobserver set in MAKEFLAGS. After the split, the command in
Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
is lost.

Restore it as linkers working in parallel (namely gcc LTO) make a use of
it. Actually, they complain, if jobserver is not set:
  lto-wrapper: warning: jobserver is not available: '--jobserver-auth=' is not present in 'MAKEFLAGS'

Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 scripts/Makefile.vmlinux_o | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0edfdb40364b..1c86895cfcf8 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -58,7 +58,7 @@ define rule_ld_vmlinux.o
 endef
 
 vmlinux.o: $(initcalls-lds) vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
-	$(call if_changed_rule,ld_vmlinux.o)
+	+$(call if_changed_rule,ld_vmlinux.o)
 
 targets += vmlinux.o
 
-- 
2.38.1

