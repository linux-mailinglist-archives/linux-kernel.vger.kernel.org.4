Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB086DA097
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjDFTBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbjDFTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:30 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599929039
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:01:06 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id s1-20020a92ae01000000b0032637be81d1so15770465ilh.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIFZuvNlh3Q7f5viDBmDdFqHrpvMkDaR3sC9sXOJCEg=;
        b=r6Dgw36L4ye+f7TRQYGeV5tzr0btpwq3zzgs/UuXhg7VhxHkEGdn4IEj/h2PQMM8C7
         9XrmV58b2OYGBa/Itz+04VD1lyNfP8oKVgBL+a+JqxD9bgvLCoGGT9xlOS7M7FSZhlrL
         dgPrDoQF1NMokITcEqaqE16eLq+/TyrGqoh7gwe5XUJYnNmAwK+1UyWGWYmy5FrIUyET
         RBrF9++/dM7QoNSpDAic5FyiBVC0USYGzK5MLgC687r/qXuqx0qG4J/VlJlQEiwErT5K
         pXhpKWhcW9txjXhgoS8Wh4mQInW++2qbyZT76CeylXl4fLCs7gG2hexuiYdjLRP04I53
         0URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIFZuvNlh3Q7f5viDBmDdFqHrpvMkDaR3sC9sXOJCEg=;
        b=SIqAvB+EmJyYJoLNVPMPNxJPrrHfnKMVo8oGjfaYR7ltMdpzbRjmYO3JyDhyTe4ykZ
         B7bGSavjJEtTrO+exY0Min4yuf0M/0Cca5Kw6G6u+/TFmDZo1lEFa+zguMKkg3PExBnY
         IytFY/6nd6CxiLjnh3lOwP0dC+5gEC3vjgxm619AYUZU61+1DRUROUC/M95X5IcQyHE7
         oXtty7gcjZ0xWVpDurAmYtIT+SRjUPALtQvb4O3UBjhBCapax9cg/fhY6kpoamhnVApO
         l4qvFYQ9kq7S+rItJ7mFSmJtfc5n30gmJBnkmir/mzk7QPKy/8l5hi/IZ80e6k+mgw4+
         eHiA==
X-Gm-Message-State: AAQBX9cvLjgjgLT39Bcwtezk0LAPwuvokdUS3IdCAQFrcU8CPCzJe97y
        M2Z23DwFMYJgqEIIopTeSrQ2rftD+GHVcKo=
X-Google-Smtp-Source: AKy350YazP6AHiQUBJHLnELBlt24GFwGrksJ3FmwYx1omjP2DXfHXKkoCpwyla4mFW8rQJlG/AJrwns8MJ8tans=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6e02:f44:b0:310:9afc:aa6 with SMTP
 id y4-20020a056e020f4400b003109afc0aa6mr6249545ilj.0.1680807665734; Thu, 06
 Apr 2023 12:01:05 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:27 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-9-allenwebb@google.com>
Subject: [PATCH v10 08/11] build: Add modules.builtin.alias
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu, nick.alcock@oracle.com,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 scripts/Makefile.modpost | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/.gitignore b/.gitignore
index 13a7f08a3d73..ddaa622bddac 100644
--- a/.gitignore
+++ b/.gitignore
@@ -71,6 +71,7 @@ modules.order
 /System.map
 /Module.markers
 /modules.builtin
+/modules.builtin.alias
 /modules.builtin.modinfo
 /modules.nsdeps
 
diff --git a/Makefile b/Makefile
index a2c310df2145..43dcc1ea5fcf 100644
--- a/Makefile
+++ b/Makefile
@@ -1578,6 +1578,7 @@ __modinst_pre:
 	fi
 	@sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/modules.order
 	@cp -f modules.builtin $(MODLIB)/
+	@cp -f modules.builtin.alias $(MODLIB)/
 	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
 
 endif # CONFIG_MODULES
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 0980c58d8afc..e3ecc17a7a19 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -15,6 +15,7 @@
 # 2) modpost is then used to
 # 3)  create one <module>.mod.c file per module
 # 4)  create one Module.symvers file with CRC for all exported symbols
+# 5)  create modules.builtin.alias the aliases for built-in modules
 
 # Step 3 is used to place certain information in the module's ELF
 # section, including information such as:
@@ -63,6 +64,20 @@ modpost-args += -T $(MODORDER)
 modpost-deps += $(MODORDER)
 endif
 
+ifneq ($(wildcard vmlinux.o),)
+output-builtin.alias := modules.builtin.alias
+modpost-args += -b .modules.builtin.alias.in
+.modules.builtin.alias.in: $(output-symdump)
+	@# Building $(output-symdump) generates .modules.builtin.alias.in as a
+	@# side effect.
+	@[ -e $@ ] || $(MODPOST) -b .modules.builtin.alias.in vmlinux.o
+
+$(output-builtin.alias): .modules.builtin.alias.in
+	sort -o $@ $^
+
+__modpost: $(output-builtin.alias)
+endif
+
 ifeq ($(KBUILD_EXTMOD),)
 
 # Generate the list of in-tree objects in vmlinux
-- 
2.39.2

