Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11D973BADD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjFWOzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjFWOya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:54:30 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD95F2D51
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:20 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a1a47b33d8so590964b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532060; x=1690124060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mID52grCp6Rp54xaXRizHugggYXYdBQ2o2Zac2oS8OE=;
        b=r782OTN0tKztTuYEy6p38EC3wIYDRKkD+VZk30VaEDBZf1QuXEP3mGk+kiACiMj93k
         HNIy8P0TDoE2cQiVTrBk+JFXNvEAA84V9CbnZEkcZC/hD9W+g+ijWnxtg0jfYMDpwJiC
         ESgzixA1YvLSoKJhvW9LnessNUBLqEogXP7QM3XyrRFByfDVhTBXm5HTqIH/Yyiff9Ng
         PdO3+LITXMqqSjJ8vmuApX7Ml3AZuGf3i1iPdCINOXlkMo5hoWaltNYXQZtZf3SACK84
         G7vcMqcPwWAJhsH45soixQ7RFXd5WBcDI8d29KGo+zewTcLmMaOwb1RxUyJxiQbOs6Rm
         Aktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532060; x=1690124060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mID52grCp6Rp54xaXRizHugggYXYdBQ2o2Zac2oS8OE=;
        b=bqTwcUsYEd5E9Klv7b6rIPtIyP29J6hrpaCwLYKsP06sCU+4JjHfLjQfXDB8MFwc6O
         ZMvSbcMOe7ogQKEvrsVa7ncwSfKfj+4N9JgGLhv+mmyMs5qstin3I39ucEk96OFsfb1u
         GfD8QIlWBlL9lgYnttiOz24KK/FsoDkFbqjck1VPBV6Ogsani/uQ11uBwdnJdpTI8XT9
         2UO/LIAS17XazX4VMXiLBl6ut35fqNsMafASbl2nosN7mPjR6KzkpRAOaozXsSN41k1s
         gEn4+Zgpi3wyBSynGqEnhqhIseBQ5Zn3DoLnz7kLTo3iQQwz+y5VId7JRL5BXG1382vr
         +r1g==
X-Gm-Message-State: AC+VfDyMk7YOdnTd3jxzkHN2xjbST1t2yKeh6eMSfU/tNlZUkzBTXvWX
        U8Cmi4T+I2DRkAbtKEIcven2LZgqOf4nnA==
X-Google-Smtp-Source: ACHHUZ4qxHUvPmHy2pjhsiu1qXVzfe5/xzm7G2Q2uC0n0X3KvTYN8jkssEib9I5+Y7XnYD3cBtEFKQ==
X-Received: by 2002:aca:f0b:0:b0:396:11b3:5851 with SMTP id 11-20020aca0f0b000000b0039611b35851mr23788128oip.54.1687532059774;
        Fri, 23 Jun 2023 07:54:19 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id fa17-20020a17090af0d100b002565cd237cdsm3359624pjb.3.2023.06.23.07.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:54:19 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v7 8/8] kbuild: modinst: do modules_install step by step
Date:   Fri, 23 Jun 2023 20:23:58 +0530
Message-ID: <20230623145358.568971-9-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623145358.568971-1-yesshedi@gmail.com>
References: <20230623145358.568971-1-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently Makefile.modinst does three tasks on each module built:
- Install modules
- Sign modules
- Compress modules

All the above tasks happen from a single place.

This patch divides this task further and uses a different makefile for
each task.
Signing module logic is completely refactored and everything happens
from a shell script now.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/Makefile.compress |  53 ++++++++++++++++++
 scripts/Makefile.install  |  66 +++++++++++++++++++++++
 scripts/Makefile.modinst  | 111 +++-----------------------------------
 scripts/Makefile.sign     |  37 +++++++++++++
 scripts/signfile.sh       |  24 +++++++++
 5 files changed, 186 insertions(+), 105 deletions(-)
 create mode 100644 scripts/Makefile.compress
 create mode 100644 scripts/Makefile.install
 create mode 100644 scripts/Makefile.sign
 create mode 100755 scripts/signfile.sh

diff --git a/scripts/Makefile.compress b/scripts/Makefile.compress
new file mode 100644
index 000000000000..35d337ac9b6c
--- /dev/null
+++ b/scripts/Makefile.compress
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Compressing modules
+# ==========================================================================
+
+PHONY := __modcompress
+__modcompress:
+
+include include/config/auto.conf
+include $(srctree)/scripts/Kbuild.include
+
+modules := $(call read-file, $(MODORDER))
+
+ifeq ($(KBUILD_EXTMOD),)
+dst := $(MODLIB)/kernel
+else
+INSTALL_MOD_DIR ?= updates
+dst := $(MODLIB)/$(INSTALL_MOD_DIR)
+endif
+
+suffix-y				:=
+suffix-$(CONFIG_MODULE_COMPRESS_GZIP)	:= .gz
+suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
+suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:= .zst
+
+modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
+
+__modcompress: $(modules)
+	@:
+
+#
+# Compression
+#
+quiet_cmd_gzip = GZIP    $@
+      cmd_gzip = $(KGZIP) -n -f $<
+quiet_cmd_xz = XZ      $@
+      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
+quiet_cmd_zstd = ZSTD    $@
+      cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
+
+$(dst)/%.ko.gz: $(dst)/%.ko FORCE
+	$(call cmd,gzip)
+
+$(dst)/%.ko.xz: $(dst)/%.ko FORCE
+	$(call cmd,xz)
+
+$(dst)/%.ko.zst: $(dst)/%.ko FORCE
+	$(call cmd,zstd)
+
+PHONY += FORCE
+FORCE:
+
+.PHONY: $(PHONY)
diff --git a/scripts/Makefile.install b/scripts/Makefile.install
new file mode 100644
index 000000000000..40c496cb99dc
--- /dev/null
+++ b/scripts/Makefile.install
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Installing modules
+# ==========================================================================
+
+PHONY := __modinstall
+__modinstall:
+
+include include/config/auto.conf
+include $(srctree)/scripts/Kbuild.include
+
+modules := $(call read-file, $(MODORDER))
+
+ifeq ($(KBUILD_EXTMOD),)
+dst := $(MODLIB)/kernel
+else
+INSTALL_MOD_DIR ?= updates
+dst := $(MODLIB)/$(INSTALL_MOD_DIR)
+endif
+
+$(foreach x, % :, $(if $(findstring $x, $(dst)), \
+	$(error module installation path cannot contain '$x')))
+
+modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
+
+__modinstall: $(modules)
+	@:
+
+#
+# Installation
+#
+quiet_cmd_install = INSTALL $@
+      cmd_install = mkdir -p $(dir $@); cp $< $@
+
+# Strip
+#
+# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
+# are installed. If INSTALL_MOD_STRIP is '1', then the default option
+# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
+# as the options to the strip command.
+ifdef INSTALL_MOD_STRIP
+
+ifeq ($(INSTALL_MOD_STRIP),1)
+strip-option := --strip-debug
+else
+strip-option := $(INSTALL_MOD_STRIP)
+endif
+
+quiet_cmd_strip = STRIP   $@
+      cmd_strip = $(STRIP) $(strip-option) $@
+
+else
+
+quiet_cmd_strip =
+      cmd_strip = :
+
+endif
+
+$(dst)/%.ko: $(extmod_prefix)%.ko FORCE
+	$(call cmd,install)
+	$(call cmd,strip)
+
+PHONY += FORCE
+FORCE:
+
+.PHONY: $(PHONY)
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index ab0c5bd1a60f..d87e09e57963 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -1,116 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
 # ==========================================================================
-# Installing modules
+# Install, Sign & Compress modules
 # ==========================================================================
 
-PHONY := __modinst
-__modinst:
-
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
-modules := $(call read-file, $(MODORDER))
-
-ifeq ($(KBUILD_EXTMOD),)
-dst := $(MODLIB)/kernel
-else
-INSTALL_MOD_DIR ?= updates
-dst := $(MODLIB)/$(INSTALL_MOD_DIR)
-endif
-
-$(foreach x, % :, $(if $(findstring $x, $(dst)), \
-	$(error module installation path cannot contain '$x')))
-
-suffix-y				:=
-suffix-$(CONFIG_MODULE_COMPRESS_GZIP)	:= .gz
-suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
-suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:= .zst
-
-modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
-
-__modinst: $(modules)
-	@:
-
-#
-# Installation
-#
-quiet_cmd_install = INSTALL $@
-      cmd_install = mkdir -p $(dir $@); cp $< $@
-
-# Strip
-#
-# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
-# are installed. If INSTALL_MOD_STRIP is '1', then the default option
-# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
-# as the options to the strip command.
-ifdef INSTALL_MOD_STRIP
-
-ifeq ($(INSTALL_MOD_STRIP),1)
-strip-option := --strip-debug
-else
-strip-option := $(INSTALL_MOD_STRIP)
-endif
-
-quiet_cmd_strip = STRIP   $@
-      cmd_strip = $(STRIP) $(strip-option) $@
-
-else
-
-quiet_cmd_strip =
-      cmd_strip = :
-
-endif
-
-#
-# Signing
-# Don't stop modules_install even if we can't sign external modules.
-#
-ifeq ($(CONFIG_MODULE_SIG_ALL),y)
-ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
-sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
-else
-sig-key := $(CONFIG_MODULE_SIG_KEY)
-endif
-quiet_cmd_sign = SIGN    $@
-      cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) "$(sig-key)" certs/signing_key.x509 $@ \
-                 $(if $(KBUILD_EXTMOD),|| true)
-else
-quiet_cmd_sign :=
-      cmd_sign := :
-endif
-
-ifeq ($(modules_sign_only),)
-
-$(dst)/%.ko: $(extmod_prefix)%.ko FORCE
-	$(call cmd,install)
-	$(call cmd,strip)
-	$(call cmd,sign)
-
-else
-
-$(dst)/%.ko: FORCE
-	$(call cmd,sign)
-
-endif
-
-#
-# Compression
-#
-quiet_cmd_gzip = GZIP    $@
-      cmd_gzip = $(KGZIP) -n -f $<
-quiet_cmd_xz = XZ      $@
-      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
-quiet_cmd_zstd = ZSTD    $@
-      cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
-
-$(dst)/%.ko.gz: $(dst)/%.ko FORCE
-	$(call cmd,gzip)
-
-$(dst)/%.ko.xz: $(dst)/%.ko FORCE
-	$(call cmd,xz)
+PHONY := __modinst
 
-$(dst)/%.ko.zst: $(dst)/%.ko FORCE
-	$(call cmd,zstd)
+__modinst: FORCE
+	$(MAKE) -f scripts/Makefile.install
+	$(MAKE) -f scripts/Makefile.sign
+	$(MAKE) -f scripts/Makefile.compress
 
 PHONY += FORCE
 FORCE:
diff --git a/scripts/Makefile.sign b/scripts/Makefile.sign
new file mode 100644
index 000000000000..d6b242b16657
--- /dev/null
+++ b/scripts/Makefile.sign
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Signing modules
+# ==========================================================================
+
+PHONY := __modsign
+__modsign:
+
+include include/config/auto.conf
+include $(srctree)/scripts/Kbuild.include
+
+#
+# Signing
+# Don't stop modules_install even if we can't sign external modules.
+#
+ifeq ($(CONFIG_MODULE_SIG_ALL),y)
+ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
+sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
+else
+sig-key := $(CONFIG_MODULE_SIG_KEY)
+endif
+quiet_cmd_sign = SIGNING ALL MODULES ...
+      cmd_sign = $(CONFIG_SHELL) $(srctree)/scripts/signfile.sh \
+					 "$(CONFIG_MODULE_SIG_HASH)" \
+					 "$(sig-key)"
+else
+quiet_cmd_sign :=
+      cmd_sign := :
+endif
+
+__modsign: FORCE
+	$(call cmd,sign)
+
+PHONY += FORCE
+FORCE:
+
+.PHONY: $(PHONY)
diff --git a/scripts/signfile.sh b/scripts/signfile.sh
new file mode 100755
index 000000000000..b2b58bfbd5ba
--- /dev/null
+++ b/scripts/signfile.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# A sign-file wrapper used by scripts/Makefile.sign
+
+#set -x
+
+if test $# -ne 2; then
+	echo "Usage: $0 <hash-algo> <sign-key>" >&2
+	exit 1
+fi
+
+SIG_HASH="$1"
+SIG_KEY="$2"
+
+MODULES_PATH="${INSTALL_MOD_PATH}/lib/modules/${KERNELRELEASE}"
+
+find "${MODULES_PATH}" -name *.ko -type f -print0 | \
+	xargs -r -0 -P$(nproc) -x -n32 sh -c "\
+${srctree}/scripts/sign-file \
+-a \"${SIG_HASH}\" \
+-i \"${SIG_KEY}\" \
+-x ${srctree}/certs/signing_key.x509 \
+-b \$@ \$0"
-- 
2.41.0

