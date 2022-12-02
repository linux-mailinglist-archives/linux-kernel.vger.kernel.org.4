Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5A6410D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiLBWsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiLBWsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:48:01 -0500
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633CC7BC08
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 14:47:59 -0800 (PST)
Received: by mail-io1-xd49.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso5744556iot.15
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 14:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kr2FFYjrlmKQpl0FW9cRYWBpZCQQ4WxEePYVPH7PqT0=;
        b=aig6Am3XKh1f74fIoP78XmyYoMV06xOmH0SRrk9TCuJ30vcxCB6RIZVxlkWc4IW82q
         2uIqiG3js6ixvzMtrv2w3qAX1gMUNHU9Jpd+qiPXSNFHKbehWNF7Yhw2hnsYzBVHiz+U
         /xJtJBId/qyG3lUq5Gebw3wMCtj97OgR8Iuh+NX2oUJTao+RSD97NbqgA6jJbdPMvs0d
         v0DCQHtlp3kq5Ddfnf3WHfDLXQoDLyzfX18K4SfCv7rdPhWhlGu0YOEWfi4OkK0rmIKe
         Vz8L0l0NKQWQ8QpriqE46JttBua6QTtUfOf6j36qUTSKJGD76Wfrp8mqX71XIjDSw2Ur
         J52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kr2FFYjrlmKQpl0FW9cRYWBpZCQQ4WxEePYVPH7PqT0=;
        b=mb3tCCh1B4KqqXLGNRJjMDssBaSKvoES5oQd6RAYsLuIK8kCwePXa/tbuEHOXW8poP
         t2DX8jWsb8Ds5qrpNB7IPGN5vQy13Q0zpMUBHxnj4rPz3kGYaSEakq4HpDsXYEY0KFaF
         oFVqOSk8KXaccqrqFL1mQR8nZWZHhpTjESHaZHSsqZekBHtoRq7q0jiA+LuTrr0KR+eo
         QcqZosY2ZUAs4s5kGfXfhr3oLxRIH7f1FKUe5B0/alXU5H1NYU5wD9snOqqp2obwMoAi
         kd7lCgclj5HFOP8+G7aACwgW+pCxs4yfYkkgL6clcKipvH2yMdxCB7HFgRHtmj0y1d9U
         82Tw==
X-Gm-Message-State: ANoB5plVqoqBI6MNx8HZEoyx6rlVyMcWueng3ZZziWU+Ep/EVDB5n4fL
        1EqNuvhYHmKgvRAQrtRf5eMQFcJK+3R1H/I=
X-Google-Smtp-Source: AA0mqf6Pfb/78vXpVbkKCzqWVQv6p/o5CGfleflTWNDSxkmzuLudt9k+BC1QXoNkn4IL0y9f0t/YX3baNUddM3A=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a6b:fb13:0:b0:6de:383e:4146 with SMTP id
 h19-20020a6bfb13000000b006de383e4146mr27314176iog.48.1670021278767; Fri, 02
 Dec 2022 14:47:58 -0800 (PST)
Date:   Fri,  2 Dec 2022 16:47:40 -0600
In-Reply-To: <20221202224540.1446952-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221202224540.1446952-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221202224744.1447448-1-allenwebb@google.com>
Subject: [PATCH v6 1/5] module: Add empty modalias sysfs attribute
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

This adds the modalias sysfs attribute in preparation for its
implementation.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 include/linux/module.h   |  1 +
 kernel/module/internal.h |  2 ++
 kernel/module/sysfs.c    | 33 +++++++++++++++++++++++++++++++++
 kernel/params.c          |  7 +++++++
 4 files changed, 43 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index ec61fb53979a9..0bfa859a21566 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -47,6 +47,7 @@ struct module_kobject {
 	struct kobject *drivers_dir;
 	struct module_param_attrs *mp;
 	struct completion *kobj_completion;
+	struct bin_attribute modalias_attr;
 } __randomize_layout;
 
 struct module_attribute {
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 2e2bf236f5582..8d7ae37584868 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -259,11 +259,13 @@ static inline void add_kallsyms(struct module *mod, const struct load_info *info
 #endif /* CONFIG_KALLSYMS */
 
 #ifdef CONFIG_SYSFS
+void add_modalias_attr(struct module_kobject *mk);
 int mod_sysfs_setup(struct module *mod, const struct load_info *info,
 		    struct kernel_param *kparam, unsigned int num_params);
 void mod_sysfs_teardown(struct module *mod);
 void init_param_lock(struct module *mod);
 #else /* !CONFIG_SYSFS */
+static inline void add_modalias_attr(struct module_kobject *mk) {}
 static inline int mod_sysfs_setup(struct module *mod,
 			   	  const struct load_info *info,
 			   	  struct kernel_param *kparam,
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index ce68f821dcd12..8dafec7455fbe 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -240,6 +240,37 @@ static inline void add_notes_attrs(struct module *mod, const struct load_info *i
 static inline void remove_notes_attrs(struct module *mod) { }
 #endif /* CONFIG_KALLSYMS */
 
+static ssize_t module_modalias_read(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *bin_attr,
+				    char *buf, loff_t pos, size_t count)
+{
+	return 0;
+}
+
+/* Used in kernel/params.c for builtin modules.
+ *
+ * `struct module_kobject` is used instead of `struct module` because for
+ * builtin modules, the `struct module` is not available when this is called.
+ */
+void add_modalias_attr(struct module_kobject *mk)
+{
+	sysfs_bin_attr_init(&mk->modalias_attr);
+	mk->modalias_attr.attr.name = "modalias";
+	mk->modalias_attr.attr.mode = 0444;
+	mk->modalias_attr.read = module_modalias_read;
+	if (sysfs_create_bin_file(&mk->kobj, &mk->modalias_attr)) {
+		/* We shouldn't ignore the return type, but there is nothing to
+		 * do.
+		 */
+		return;
+	}
+}
+
+static void remove_modalias_attr(struct module_kobject *mk)
+{
+	sysfs_remove_bin_file(&mk->kobj, &mk->modalias_attr);
+}
+
 static void del_usage_links(struct module *mod)
 {
 #ifdef CONFIG_MODULE_UNLOAD
@@ -398,6 +429,7 @@ int mod_sysfs_setup(struct module *mod,
 
 	add_sect_attrs(mod, info);
 	add_notes_attrs(mod, info);
+	add_modalias_attr(&mod->mkobj);
 
 	return 0;
 
@@ -415,6 +447,7 @@ int mod_sysfs_setup(struct module *mod,
 
 static void mod_sysfs_fini(struct module *mod)
 {
+	remove_modalias_attr(&mod->mkobj);
 	remove_notes_attrs(mod);
 	remove_sect_attrs(mod);
 	mod_kobject_put(mod);
diff --git a/kernel/params.c b/kernel/params.c
index 5b92310425c50..b7fd5313a3118 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -14,6 +14,12 @@
 #include <linux/ctype.h>
 #include <linux/security.h>
 
+#ifdef CONFIG_MODULES
+#include "module/internal.h"
+#else
+static inline void add_modalias_attr(struct module_kobject *mk) {}
+#endif /* !CONFIG_MODULES */
+
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
 static DEFINE_MUTEX(param_lock);
@@ -815,6 +821,7 @@ static void __init kernel_add_sysfs_param(const char *name,
 	BUG_ON(err);
 	kobject_uevent(&mk->kobj, KOBJ_ADD);
 	kobject_put(&mk->kobj);
+	add_modalias_attr(mk);
 }
 
 /*
-- 
2.37.3

