Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D3B660CD3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 08:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbjAGHsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 02:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjAGHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 02:48:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5240848D7;
        Fri,  6 Jan 2023 23:48:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1760FB81EBD;
        Sat,  7 Jan 2023 07:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C07CC433A0;
        Sat,  7 Jan 2023 07:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673077683;
        bh=RTLKdjUECYDxN3vnqCPtfGzhyPkDlqfYSeIu5deVu7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=juaCeWzoPppUgCgLAK5poNkr4NGkQHZChSrHnc6v0NXJUrh/bjqfPkLLJPfoKrS/S
         Kx2/niq7Ryk1XIu6Vgc7/0AuEl3+yDECZmIlzNMlN0zeSfbGPQngtfly6fFfUy/nmT
         hVJymkx4kloc6n/XAgK171QkYSC/K0V7H5JzTeuaf1mchFVqjlN6S2lTmr25uAQmym
         iShi9MiZPF7mrU0/57SbX/qydgO1NYZNsY2Q5z9NAhTWPhb7OnPewDMX3OIlMwJoVf
         D14jYp1rTpsU65bAx2rjXncUys3JFYCTVcdBINy4xyS5x6YU0gVS5xOBU8e66lT1kV
         4fSPQ/T5rKP0A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH 3/3] tomoyo: Omit use of bin2c
Date:   Sat,  7 Jan 2023 16:47:43 +0900
Message-Id: <20230107074743.3352242-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230107074743.3352242-1-masahiroy@kernel.org>
References: <20230107074743.3352242-1-masahiroy@kernel.org>
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

bin2c was, as its name implies, introduced to convert a binary file to
C code.

However, I did not see any good reason ever for using this tool because
using the .incbin directive is much faster, and often results in simpler
code.

Most of the uses of bin2c have been killed, for example:

  - 13610aa908dc ("kernel/configs: use .incbin directive to embed config_data.gz")
  - 4c0f032d4963 ("s390/purgatory: Omit use of bin2c")

security/tomoyo/Makefile has even less reason for using bin2c because
the policy files are text data. So, sed is enough for converting them
to C string literals, and what is nicer, generates human-readable
builtin-policy.h.

This is the last user of bin2c. After this commit lands, bin2c will be
removed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 security/tomoyo/Kconfig  |  1 -
 security/tomoyo/Makefile | 15 ++++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/tomoyo/Kconfig b/security/tomoyo/Kconfig
index b9f867100a9f..772d2ab58fd1 100644
--- a/security/tomoyo/Kconfig
+++ b/security/tomoyo/Kconfig
@@ -7,7 +7,6 @@ config SECURITY_TOMOYO
 	select SECURITY_PATH
 	select SECURITY_NETWORK
 	select SRCU
-	select BUILD_BIN2C
 	default n
 	help
 	  This selects TOMOYO Linux, pathname-based access control.
diff --git a/security/tomoyo/Makefile b/security/tomoyo/Makefile
index 1b18a02ccd2e..77358b7655fa 100644
--- a/security/tomoyo/Makefile
+++ b/security/tomoyo/Makefile
@@ -2,13 +2,14 @@
 obj-y = audit.o common.o condition.o domain.o environ.o file.o gc.o group.o load_policy.o memory.o mount.o network.o realpath.o securityfs_if.o tomoyo.o util.o
 
 targets += builtin-policy.h
-define do_policy
-echo "static char tomoyo_builtin_$(1)[] __initdata ="; \
-$(objtree)/scripts/bin2c <$(firstword $(wildcard $(obj)/policy/$(1).conf $(srctree)/$(src)/policy/$(1).conf.default) /dev/null); \
-echo ";"
-endef
-quiet_cmd_policy  = POLICY  $@
-      cmd_policy  = ($(call do_policy,profile); $(call do_policy,exception_policy); $(call do_policy,domain_policy); $(call do_policy,manager); $(call do_policy,stat)) >$@
+
+quiet_cmd_policy = POLICY  $@
+      cmd_policy = { \
+	$(foreach x, profile exception_policy domain_policy manager stat, \
+	printf 'static char tomoyo_builtin_$x[] __initdata =\n'; \
+	sed 's/\(.*\)/\t"\1\\n"/' $(firstword $(filter %/$x.conf %/$x.conf.default, $^) /dev/null);  \
+	printf '\t"";\n';) \
+	} > $@
 
 $(obj)/builtin-policy.h: $(wildcard $(obj)/policy/*.conf $(srctree)/$(src)/policy/*.conf.default) FORCE
 	$(call if_changed,policy)
-- 
2.34.1

