Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F30D69C09D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjBSOQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjBSOQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:16:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F8E3AB;
        Sun, 19 Feb 2023 06:16:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AA47B808BC;
        Sun, 19 Feb 2023 14:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A25C4339B;
        Sun, 19 Feb 2023 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676816184;
        bh=OnHesLJjuM4ndL0bx3IO8J099WVFzKW7b0gcW6zf1HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6MPY1We5Gq+eXc22qp3LVBeZjtQ1Z9K4zYmKOTvBgVXpowHgmidtMRl1lnjX+aHe
         cSwsOa/qSSgrAzai3J6hOjqO7LeJjSxQ6oT/URE6opE63Aff3BmdfC0ENb9J1rixzT
         PHWkYFqeV33fWe0ka3FmpdvF7j8kHwzG01HzNZDrJ0a5ednegxyLc/GpMafMluz80x
         g7dyQAGoHWthtQ+b7M6pDjzdEW/ekzY0vhkK6vtGsxwjILKNnG99lWS/fFhh9QUdkS
         cgES0y3+Bqv99Lk08ydycZp0whkYF4a4j6ajTrlIgfmiR8l/llkW/wifvURuSel9WM
         Kkj0Z+DaVdGqA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: [PATCH 4/4] sh: remove compiler flag duplication
Date:   Sun, 19 Feb 2023 23:15:55 +0900
Message-Id: <20230219141555.2308306-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219141555.2308306-1-masahiroy@kernel.org>
References: <20230219141555.2308306-1-masahiroy@kernel.org>
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

Every compiler flag added by arch/sh/Makefile is passed to the
compiler twice.

$(KBUILD_CPPFLAGS) + $(KBUILD_CFLAGS) is used for compiling *.c
$(KBUILD_CPPFLAGS) + $(KBUILD_AFLAGS) is used for compiling *.S

Given the above, adding $(cflags-y) to all of KBUILD_{CPP/C/A}FLAGS
ends up with duplication.

Add -I options to $(KBUILD_CPPFLAGS), and the rest of $(cflags-y)
to KBUILD_{C,A}FLAGS.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index f1c6aace8acb..cab2f9c011a8 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -145,10 +145,8 @@ cpuincdir-y			+= cpu-common	# Must be last
 
 drivers-y			+= arch/sh/drivers/
 
-cflags-y	+= $(addprefix -I $(srctree)/arch/sh/include/, $(cpuincdir-y) $(machdir-y))
-
+KBUILD_CPPFLAGS		+= $(addprefix -I $(srctree)/arch/sh/include/, $(cpuincdir-y) $(machdir-y))
 KBUILD_CFLAGS		+= -pipe $(cflags-y)
-KBUILD_CPPFLAGS		+= $(cflags-y)
 KBUILD_AFLAGS		+= $(cflags-y)
 
 ifeq ($(CONFIG_MCOUNT),y)
-- 
2.34.1

