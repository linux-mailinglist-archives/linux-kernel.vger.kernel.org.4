Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EDA628766
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiKNRqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiKNRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:46:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B51B7D2;
        Mon, 14 Nov 2022 09:46:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77718B810DE;
        Mon, 14 Nov 2022 17:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A92FC433C1;
        Mon, 14 Nov 2022 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668447985;
        bh=ELuvAh5rXFUq6jZ+XUAJMs1kehBG2jCe/rQKj3uUkBw=;
        h=From:To:Cc:Subject:Date:From;
        b=tn0SBkNysYcB/YKO8/VT1GdiRMg/CPQogLZfl3NaqMu7LYa2UDV9Y5rmgKPKXzAIF
         nQFaceMWnurjrmQEnIkHu/NXgUdd+Xu52gkxe3f1fgsdMVqTucdiKSJtcBtwPTBWKL
         /XX86YgK/7JFXlrgSDT6nN2oGutMP+VbiGmwC+3J1FGaNDfH0JZzB6UBed4SgHwWiA
         5Wenq5Cor/mepfSriy7R8tWtOW5ylngTeHJFKQcgoU3dUwO11qTpZdqfPjxBhzoMwK
         VCn+vFaX6vltbBnRfXdhNeDgZljIzIo3svzU0og/BvEgNBKLcdM5DMD/+gfvR1dZVA
         JHB5DEijc7t3g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: revive parallel execution for .tmp_initcalls.lds rule
Date:   Tue, 15 Nov 2022 02:46:17 +0900
Message-Id: <20221114174617.211980-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Prior to commit 5d45950dfbb1 ("kbuild: move vmlinux.o link to
scripts/Makefile.vmlinux_o"), jobserver-exec was invoked from the shell
script, link-vmlinux.sh. It can get access to the jobserver because
Makefile adds '+' prefix, as in:

    +$(call if_changed_dep,link_vmlinux)

Since 5d45950dfbb1, jobserver-exec is invoked from Makefile, but the
'+' prefix is missing, hence jobserver-exec has no access to the
jobserver.

Fixes: 5d45950dfbb1 ("kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.vmlinux_o | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0edfdb40364b..ae52d3b3f063 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -19,7 +19,7 @@ quiet_cmd_gen_initcalls_lds = GEN     $@
 
 .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
 		vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
-	$(call if_changed,gen_initcalls_lds)
+	+$(call if_changed,gen_initcalls_lds)
 
 targets := .tmp_initcalls.lds
 
-- 
2.34.1

