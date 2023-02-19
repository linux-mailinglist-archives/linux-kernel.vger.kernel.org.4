Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2600069C09C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjBSOQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBSOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:16:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C08E3AB;
        Sun, 19 Feb 2023 06:16:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4A6B0CE0A2C;
        Sun, 19 Feb 2023 14:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17897C433EF;
        Sun, 19 Feb 2023 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676816182;
        bh=iWMd5wrtVPvc8Hq0qKNuEJ6Iz+dFfZvSN+y/ZKP5/jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLPmV5URKbngJEMO+9f5JJ5r541PYQUP0VC4agmu5KYvgdSnc6LS8gXbOGGm6F3Vn
         4mD3iv77Xu9j4KGsOecwUOYhoKKHfAzL9KBmiMsMfpLll9exf9eFX6uf0k1mnoA6Fp
         pTD2ZbfwnRPiwYl9ISPXfVa/WwFEV1CpErcfXhjH1mytDiMlV2TrQHee4QFiBmphOM
         4oMObvwqWaI/JIbfSX37bMEmqTr4aQMP+r3XZvyDdXvcjteIaASNr1FsR1wtCixAC9
         A14tWryoGRceMmOB8b5cPjlLX8w9kJ6sGr67sQgfWJhB4pY7MzRI/i47EtFKwIDb8F
         yq6MAuLkpiNlg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: [PATCH 3/4] sh: refactor header include path addition
Date:   Sun, 19 Feb 2023 23:15:54 +0900
Message-Id: <20230219141555.2308306-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219141555.2308306-1-masahiroy@kernel.org>
References: <20230219141555.2308306-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the code. No functional change intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 0625796cfe7f..f1c6aace8acb 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -145,8 +145,7 @@ cpuincdir-y			+= cpu-common	# Must be last
 
 drivers-y			+= arch/sh/drivers/
 
-cflags-y	+= $(foreach d, $(cpuincdir-y), -I $(srctree)/arch/sh/include/$(d)) \
-		   $(foreach d, $(machdir-y), -I $(srctree)/arch/sh/include/$(d))
+cflags-y	+= $(addprefix -I $(srctree)/arch/sh/include/, $(cpuincdir-y) $(machdir-y))
 
 KBUILD_CFLAGS		+= -pipe $(cflags-y)
 KBUILD_CPPFLAGS		+= $(cflags-y)
-- 
2.34.1

