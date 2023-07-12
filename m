Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8F7509E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjGLNpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjGLNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:45:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3D4E4D;
        Wed, 12 Jul 2023 06:45:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F41E31F893;
        Wed, 12 Jul 2023 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689169539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+kzlCw/SCEEe9a86Jj/6fxE8wGtEPp1cF0uqUxJXbY=;
        b=WIilWt8PA4uZmrnmW+mk+UJaoE5N7LsZBv14GAXDJamGClORjV6AaedgU+81krZ/Dl6yXg
        3JWG4czVlAyz5nyQTq7d95HQ5pbybQEVj+uj0SxbedPzkA/yfx0VwZm2S96J65PmkRkDF2
        63FhZ77cJ0ffor6VgDjx3zaVTSWF6ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689169539;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+kzlCw/SCEEe9a86Jj/6fxE8wGtEPp1cF0uqUxJXbY=;
        b=umhHv+grXQ8dOfv81wH9k9xTDQjcnRVnp74XMx8ajHLPBEmlUJNyEbOTOR+WfgsG3umNc5
        AUWEfD0cN2OK2aAg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 9BC152C142;
        Wed, 12 Jul 2023 13:45:38 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
Cc:     Michal Suchanek <msuchanek@suse.de>, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2--to=linux-modules@vger.kernel.org] depmod: Handle installing modules under a prefix
Date:   Wed, 12 Jul 2023 15:45:31 +0200
Message-ID: <20230712134533.4419-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <da2fdd15-fae1-2bf6-04e7-568c715372ce@kernel.org>
References: <da2fdd15-fae1-2bf6-04e7-568c715372ce@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some distributions aim at not shipping any files in / ustside of usr.

The path under which kernel modules are instaleld is hardcoded to /lib
which conflicts with this goal.

When kmod provides the config command use it to determine the correct
module installation prefix.

On kmod that does not provide the command / is used as before.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: Avoid error on systems with kmod that does not support config
command
---
 Makefile          | 4 +++-
 scripts/depmod.sh | 8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 47690c28456a..b1fea135bdec 100644
--- a/Makefile
+++ b/Makefile
@@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
 # makefile but the argument can be passed to make if needed.
 #
 
-MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
+export KERNEL_MODULE_PREFIX := $(shell kmod config &> /dev/null && kmod config | jq -r .module_prefix)
+
+MODLIB	= $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/modules/$(KERNELRELEASE)
 export MODLIB
 
 PHONY += prepare0
diff --git a/scripts/depmod.sh b/scripts/depmod.sh
index 3643b4f896ed..88ac79056153 100755
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -27,16 +27,16 @@ fi
 # numbers, so we cheat with a symlink here
 depmod_hack_needed=true
 tmp_dir=$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
-mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
+mkdir -p "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE"
 if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
-	if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
-		-e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
+	if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep" -o \
+		-e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
 		depmod_hack_needed=false
 	fi
 fi
 rm -rf "$tmp_dir"
 if $depmod_hack_needed; then
-	symlink="$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
+	symlink="$INSTALL_MOD_PATH$KERNEL_MODULE_PREFIX/lib/modules/99.98.$KERNELRELEASE"
 	ln -s "$KERNELRELEASE" "$symlink"
 	KERNELRELEASE=99.98.$KERNELRELEASE
 fi
-- 
2.41.0

