Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4022E6095EA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 21:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJWTxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 15:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiJWTxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 15:53:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8416CD0D;
        Sun, 23 Oct 2022 12:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82329B80DC8;
        Sun, 23 Oct 2022 19:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB0DC433C1;
        Sun, 23 Oct 2022 19:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666554785;
        bh=i+HEk9TAvLe+0FbY+wjKbL1YcPdrh2JGQJPuRGg151k=;
        h=From:To:Cc:Subject:Date:From;
        b=VhhSzBXWJ5a3NKY/3eZ+G7uzha4RY2AozuBXH0jTX6kEOsamEurJzBTAPvkyBbfLR
         MCWBzgdRg2F6VxvB9P0YbWjU42w36Io8J8BUeotd4BUGluT70SoFymUyscrDHBycQX
         6JesOi+qbA7CX/Tx3lQdlbTfCN1cldn2EWdxLN1BI0j3PFNanVm7I5YO7yrtYgRjyM
         Eyp+90enI1k04ASbrfxpRbFRRL5SIipwbsYCE/UmF3YRG3cMHjHAqJgefon71o3smW
         vmIdidh5d8B9NblxAWFRqdD3JRvxP/8ZoIreBEdWAkLnEAfDurjfiVN+TADe4eq5YG
         dkpwCQ/YJJBtg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix 'Broken pipe' message for AR=gcc-ar
Date:   Mon, 24 Oct 2022 04:52:57 +0900
Message-Id: <20221023195257.175946-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 321648455061 ("kbuild: use obj-y instead extra-y for
objects placed at the head"), 'make AR=gcc-ar' shows the following
message:

  /usr/bin/ar terminated with signal 13 [Broken pipe]

The resulting vmlinux is correct, but it is better to silence this.

'head -n1' exits after reading the first line, so the pipe is closed.

Use 'sed -n 1p' to eat the stream till the end.

Fixes: 321648455061 ("kbuild: use obj-y instead extra-y for objects placed at the head")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f41ec8c8426b..0e42a7982826 100644
--- a/Makefile
+++ b/Makefile
@@ -1218,7 +1218,7 @@ quiet_cmd_ar_vmlinux.a = AR      $@
       cmd_ar_vmlinux.a = \
 	rm -f $@; \
 	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
-	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)
+	$(AR) mPiT $$($(AR) t $@ | sed -n 1p) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)
 
 targets += vmlinux.a
 vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
-- 
2.34.1

