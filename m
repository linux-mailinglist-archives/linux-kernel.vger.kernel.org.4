Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32F36512C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiLSTT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiLSTTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD913CC2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y133-20020a25328b000000b006f997751950so11675460yby.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIc91OoDv/mBPCGHIucL2csPnIlsRLcBZ/NTNtcT38Q=;
        b=r8vPBYkfeyPzl0oDj/LTaQo+BZJ7LAkSF5428uTADVbbx4PH0krjcafDDu6HZWVLF/
         6PK65zYCRLx/WopxRxp3Uxjzj32xc++LBtmmCjcK2Lyfa7QDmG2wr1AIhBOfBpd0y3F7
         rF2zLFeT9NcKM2MJOlwDxsbVXrKJh0y5EPJTqXSFHIG6d7wT5rmbIPq0ZDA/lSNQWRc5
         KvvsyX7kLtAAyaI7OeQ02ycGiFds8HatG+Vilc1GVYOq7oIhPCaeyM5NLsyGFMozcp/1
         bonJrRbgxss5V5/ewRa+AQlechuVqx9l2/cIaFE8w2rGn+vMfAefFzxcNb/DmiWg4tVI
         5RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIc91OoDv/mBPCGHIucL2csPnIlsRLcBZ/NTNtcT38Q=;
        b=5i9RDjy3yFeh4gJTpjen4weBQeq73VRfgZe2EQ6VY/ZiuaKiJM5ZhV03Q2S134mjGN
         qz5CR/CIBc5lapYO1yl+4pdedhlOow0hvrHZVrRNVqrQLBbMxWmKXlAePGumwM3SFewB
         zEpURuHkAfFMJx9AvvZh4or7G8EVw2u2Vcz+kLE63tCiDagsK+EzhrB3rffQt5fqZRGo
         uGaCjS7J5L6zdemqo0ODJyYryZLNnIM+JARPoUiilGATORPp7uR4CtZTiiyK2xcrMXno
         UwtRnaA4c4bWY4tpzRWevcq8kOFpWwfVlqqbHsM85Wk1TIFa8HiUPNiOJHaKsE16PnNE
         Ycew==
X-Gm-Message-State: AFqh2kqmav9Zd7F3/WZwYVA6FEp7otmU096QcT+Q5/ivpGB5toZidlRl
        TbLaEV88BW9I43rdkqbCGXBwmpoi1hiBP9Q=
X-Google-Smtp-Source: AMrXdXu1UOgFHyAN6NsQ+1XaAW4P5yWDQtrcqIFXvJe7O6WezqPpzlP5r7QSr5cq4wj/GeiMHPgpVcqbt1X8myM=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a0d:c901:0:b0:349:a017:8dcc with SMTP id
 l1-20020a0dc901000000b00349a0178dccmr858068ywd.258.1671477548552; Mon, 19 Dec
 2022 11:19:08 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:55 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-10-allenwebb@google.com>
Subject: [PATCH v8 9/9] build: Add modules.builtin.alias
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
index 47229f98b327b..40a90bca89641 100644
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
index 78525ebea8762..572f364f40538 100644
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
index e41dee64d429c..94c1d66c7769a 100644
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

