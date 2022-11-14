Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF1627CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiKNLtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiKNLsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:48:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BF026577;
        Mon, 14 Nov 2022 03:45:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBC0361090;
        Mon, 14 Nov 2022 11:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600C5C433C1;
        Mon, 14 Nov 2022 11:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426342;
        bh=LDDWnbc0G82XezA7Wy98vToKYOH6Yv/7cEWA4wpWfUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7n13i8yGgCA6xfsV2rnP2Sn2LRC3XAIWA67SLNgXWXfb/KLM+FpdCj3dH7Y7MK0K
         ZFpnJPsia5D9y+j37HQE+wvcQCcPCYKPwpaIDH51AgBam6gDc6YnjzSOGzjhAQtPPZ
         BuV4mFX63jbFtrHwGzWF9uefmuk5uCwWd1AOjOwgT4jwgucnZo4DcyvqVMncXkX/Xi
         ww1vFk+Vd4oYdxIVzT2mt40FyMs70o9Y5xW55gLvnX0UaCWguDqZvgBrD98tHkTAfc
         qiUDD4bphIEkYCn0zqfMmUAy4ulNVj39L1XzJ3XsV5tmWEYlmcMH5X/1DnAGDPj/st
         KXI7Ob2C7SEtQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 43/46] scripts, lto: check C symbols for modversions
Date:   Mon, 14 Nov 2022 12:43:41 +0100
Message-Id: <20221114114344.18650-44-jirislaby@kernel.org>
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

From: Andi Kleen <ak@linux.intel.com>

The gcc LTO nm doesn't output assembler symbols, which makes the
symversions check fail because ksymtab is defined in assembler. Instead,
check for a C symbol that is generated too.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9b522c9efcb6..dafa8aeed9c2 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -173,7 +173,7 @@ ifdef CONFIG_MODVERSIONS
 #   be compiled and linked to the kernel and/or modules.
 
 gen_symversions =								\
-	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
+	if $(NM) $@ 2>/dev/null | grep -q __kstrtab; then			\
 		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
 			>> $(dot-target).cmd;					\
 	fi
-- 
2.38.1

