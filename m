Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC09651451
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiLSUrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiLSUqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:43 -0500
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0247E1275B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:32 -0800 (PST)
Received: by mail-io1-xd49.google.com with SMTP id s22-20020a6bdc16000000b006e2d7c78010so4619810ioc.21
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gekU6kKP7IIk6R91i2D+kYhQ2/5+ZzFfnfqT/fUlpic=;
        b=irlGYLfrTeZP9BJWrJoWnhdGeWqcT/6M3D430+H48yklmxreMzES9RrMjRQ7R9s5lo
         HBLGGYcMEHFXWH/mEAkKPbAtckwDjcL7QW1b+QX4AUICKJZH2LI/wh3nklHQHZN0d0LK
         dSiNzTmkxNr14tIC+jO2mIGbQTDGo0v0w87//seyz99GDAJFm1RAmNfiuuHAWROQZtb1
         YWk6K9arXkw5/2XZzbRnqRQf6+JyYif9lrBHjpWotBKUYZuGLcSOG+4gQu3c0hP9oyUg
         v0/wHO/Z7PK56gb2l7g5hwVIiBB5IpFU9iFdp8ZwhbJ0BfX5BxjAoZdVDUrWQH2QB/Cx
         +K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gekU6kKP7IIk6R91i2D+kYhQ2/5+ZzFfnfqT/fUlpic=;
        b=K8/n3BKpyEWsNDNEfCMS6VEo/YHYV6guMj6fzJ1FzJZQEB3+tp88TikspTTp379Krl
         EDfI5sZ1v9FN57ZwOxJlKVHpahnamMwu/cgnZYdJAVlL4XJRn6YJrI+P5grHvD2sBnnU
         wKyZ2GFuv3YOCmfu+dvqbEbm+J9tY6cCHBsfu3IbibjfBsH1K25ntekR/p5gHFjuQFTP
         Yn825ktVxq4gv86yYNG0bzysGaHpq6rboTOnQQsMCrfm2l6j1o0jRWAeKWMBe+oq3vfJ
         Tmo7JmPTJ+U1dT7c1jSHoySK+twxk/kDv6+GFuw8FTrfyuOeMXVl8HbbS/lim7NQhoKf
         +sxQ==
X-Gm-Message-State: ANoB5plOfoYd3rZx7chdy5qtz2yL+CEK8ddpPrfXT+TvQvB4n5w8hsNB
        0o29wqTLcpKY4eoi7fA5VCkM+QCG4zSRpdY=
X-Google-Smtp-Source: AA0mqf4aN7bGxk42XefP/nBp103XKoDM2Xgp8PcWWbeWtkZkSiF3OLgesagNVAAmy5OIWYOD9DDURkstGs6TMOI=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a5e:a711:0:b0:6e3:1926:f46e with SMTP id
 b17-20020a5ea711000000b006e31926f46emr2270722iod.162.1671482791701; Mon, 19
 Dec 2022 12:46:31 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:17 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-10-allenwebb@google.com>
Subject: [PATCH v9 09/10] build: Add modules.builtin.alias
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generate modules.builtin.alias using modpost and install it with the
modules.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 .gitignore               |  1 +
 Makefile                 |  1 +
 scripts/Makefile.modpost | 17 ++++++++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 47229f98b327..40a90bca8964 100644
--- a/.gitignore
+++ b/.gitignore
@@ -67,6 +67,7 @@ modules.order
 /System.map
 /Module.markers
 /modules.builtin
+/modules.builtin.alias
 /modules.builtin.modinfo
 /modules.nsdeps
 
diff --git a/Makefile b/Makefile
index 78525ebea876..572f364f4053 100644
--- a/Makefile
+++ b/Makefile
@@ -1558,6 +1558,7 @@ __modinst_pre:
 	fi
 	@sed 's:^:kernel/:' modules.order > $(MODLIB)/modules.order
 	@cp -f modules.builtin $(MODLIB)/
+	@cp -f modules.builtin.alias $(MODLIB)/
 	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
 
 endif # CONFIG_MODULES
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index e41dee64d429..94c1d66c7769 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -15,6 +15,7 @@
 # 2) modpost is then used to
 # 3)  create one <module>.mod.c file per module
 # 4)  create one Module.symvers file with CRC for all exported symbols
+# 5)  create modules.builtin.alias the aliases for built-in modules
 
 # Step 3 is used to place certain information in the module's ELF
 # section, including information such as:
@@ -51,6 +52,21 @@ ifneq ($(findstring i,$(filter-out --%,$(MAKEFLAGS))),)
 modpost-args += -n
 endif
 
+vmlinux.o-if-present := $(wildcard vmlinux.o)
+ifneq ($(vmlinux.o-if-present),)
+output-builtin.alias := modules.builtin.alias
+modpost-args += -b .modules.builtin.alias.in
+.modules.builtin.alias.in: $(output-symdump)
+	@# Building $(output-symdump) generates .modules.builtin.alias.in as a
+	@# side effect.
+	@[ -e $@ ] || $(MODPOST) -b .modules.builtin.alias.in $(vmlinux.o-if-present)
+
+$(output-builtin.alias): .modules.builtin.alias.in
+	sort -o $@ $^
+
+__modpost: $(output-builtin.alias)
+endif
+
 ifeq ($(KBUILD_EXTMOD),)
 
 # Generate the list of in-tree objects in vmlinux
@@ -78,7 +94,6 @@ targets += .vmlinux.objs
 .vmlinux.objs: vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
 	$(call if_changed,vmlinux_objs)
 
-vmlinux.o-if-present := $(wildcard vmlinux.o)
 output-symdump := vmlinux.symvers
 
 ifdef KBUILD_MODULES
-- 
2.37.3

