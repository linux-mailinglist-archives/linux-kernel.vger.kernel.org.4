Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBB463F9B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiLAVQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLAVQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:16:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2982C0577
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:16:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 187-20020a250dc4000000b006f8cd26bfcfso1389928ybn.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhnFA6WLviCf2MgPqr3VNvtnWHosamMdhsn/Vjioo18=;
        b=U6O2sBNI7GOntiRxdhtgYDdq9ffKNX9sZIY3UbF+C7CIiWWFI2+8yGqyNtA56GA5LN
         XDMkoG1bIcnHqzyJq7AuFLmZT18vHzCkRsvERGiazYHTCZmZJK/uJsbc6rq3eYrY83Xf
         K23JIteMcT5RrxWHTRgB6mc2LAWvat5KqKlyTU73/xDYunDfBLdDOA9c1vmGeaV7OmcX
         TOwmhngQ2yktpHOLkMlfLRjbjXQ/E3Osn81sYWwqf1fR44wXUHkmGNs0gN8Ol1ozEqOV
         XWsty3uQ2I3gqWhQodd+YlrFw+Xi/YLTkScywFf3o54yBVgcZdWx/DUq80+pa2VDjaTb
         B74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhnFA6WLviCf2MgPqr3VNvtnWHosamMdhsn/Vjioo18=;
        b=DOmHGHdaeWXGNYFaauijvTm8KmWFtlCeBmvt6XFisJBWvW4rw1lr1jJS9urcDbNfVg
         OaKzl14Pv2R80dOtngX0s6WQT8aF05M/K5xKxwxE6svwlub7arsxSYiQOh5UIJ0NohmU
         mXF2oLMWpkct6W07q+OPNiQg7cKo43OyEQ9Na8dyP9MXFPN+kna9zJ1d7q86wEPaGbGr
         fSGqNmqheNdmLQrPEe9j3HxsdNa+cF49kttIpVqhpaWgEzOZ1Nu91Qt88kmDmQ0tRbCz
         GtIsZMXC+nP4A7D1dkugwTDcKGiqC1GSnh3B8SaC0Gi6EKP7d995e6H4fhYXUulFSf8i
         eWJg==
X-Gm-Message-State: ANoB5plZEBSwRAGRT/0pp8gRb1VZxO8bXdmHj5Drtj7kkywT3U7AG+0K
        L+MqyrblYLPJxuP1Uxwfe4ko1mmLPlD1Rzo=
X-Google-Smtp-Source: AA0mqf4bfPKq2L91x9ALU+AxEGRWwsH8EZ8Fl2YAaz59EfBZytRv//UH+8V9tEymBQn6gBa3/7ebVmWwq17g8+Q=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a0d:d491:0:b0:3cc:5892:fd07 with SMTP id
 w139-20020a0dd491000000b003cc5892fd07mr17957983ywd.420.1669929412028; Thu, 01
 Dec 2022 13:16:52 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:16:29 -0600
In-Reply-To: <CAJzde07w6U83U_63eaF0-6zaq0cOkaymuLb3CBZ++JQi+Y9JdA@mail.gmail.com>
Mime-Version: 1.0
References: <CAJzde07w6U83U_63eaF0-6zaq0cOkaymuLb3CBZ++JQi+Y9JdA@mail.gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201211630.101541-1-allenwebb@google.com>
Subject: [PATCH v5 0/1] Fix CONFIG_USB=y && CONFIG_MODULES not set
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

# Patch Review Discussion

Luis Chamberlain <mcgrof@kernel.org> would prefer something generic and
mentioned kmod already has builtin.alias.bin.

Something generic would be preferable, but I don't see a path to a
generic solution without handling the nuances of each subsystem. The
problem I am trying to solve is to expose the match id's for builtin
kernel modules. The aliases associated with match ids are not included
in builtin.alias.bin, so work would be needed to handle them (ideally
files2alias.c would be used since it already handles each subsystem).
I have an experimental patch (https://crrev.com/c/3840672) that
generates buildin.alias at kernel build time which I could upload
separately if that is preferred. Note that approach would involve
adding a new file to the kernel packaging requirements.

I have some concern that builtin.alias.bin might be used in cases where
the match-id-based aliases are not desired. There are much more
match-id-based aliases than regular aliases.

One advantage of the sysfs approach is there wouldn't be a reliance on
the buildin.alias file being in sync with the running kernel. The
output of sysfs would reflect the match ids for the currently running
kernel and modules.

# Patch change history

I have included incremental diffs to make the between patch-version
changes clear.

## Changes made in v5 - this version

* Fix a build issue when CONFIG_MODULES is not set, but CONFIG_USB=y.
* Add this cover letter

diff --git a/drivers/base/base.h b/drivers/base/base.h
index beaa252c04388..fec56271104fa 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -173,7 +173,7 @@ static inline void module_add_driver(struct module *mod,
 static inline void module_remove_driver(struct device_driver *drv) { }
 #endif

-#if defined(CONFIG_SYSFS)
+#if defined(CONFIG_SYSFS) && defined(CONFIG_MODULES)
 ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
 			    size_t count);
 #else


## Changes made in v4

* Fix some issues reported by checkpatch.pl
* Add an explanitory comment for the ADD macro
* Fix a build issue when CONFIG_MODULES is not set.

diff --git a/drivers/base/mod_devicetable.c b/drivers/base/mod_devicetable.c
index f1d3de9f111c4..d7f198aad430f 100644
--- a/drivers/base/mod_devicetable.c
+++ b/drivers/base/mod_devicetable.c
@@ -12,24 +12,33 @@
 #include "base.h"
 #include "../usb/core/usb.h"

+/* Helper macro to add a modalias field to the string buffer associated with
+ * a match id.
+ *
+ * Note that:
+ *   + len should be a ssize_t and is modified in the macro
+ *   + sep should be a string literal and is concatenated as part of a format
+ *     string
+ *   + field is the struct field of the match id
+ */
 #define ADD(buf, count, len, sep, cond, field)				\
-do {									\
+do {				                                        \
+	char *buf_ = buf;						\
+	size_t count_ = count;                                          \
 	if (cond)							\
-		(len) += scnprintf(&(buf)[len],				\
-			(count) - (len),				\
+		(len) += scnprintf(&buf_[len],				\
+			count_ - (len),					\
 			sizeof(field) == 1 ? (sep "%02X") :		\
 			sizeof(field) == 2 ? (sep "%04X") :		\
 			sizeof(field) == 4 ? (sep "%08X") : "",		\
 			(field));					\
 	else								\
-		(len) += scnprintf(&(buf)[len], (count) - (len), (sep "*")); \
+		(len) += scnprintf(&buf_[len], count_ - (len), (sep "*")); \
 } while (0)

 #ifdef CONFIG_USB
 /* USB related modaliases can be split because of device number matching, so
  * this function handles individual modaliases for one segment of the range.
- *
- *
  */
 static ssize_t usb_id_to_modalias(const struct usb_device_id *id,
 				  unsigned int bcdDevice_initial,
@@ -134,8 +143,7 @@ static unsigned int incbcd(unsigned int *bcd,
 	return init;
 }

-/* Print the modaliases for the specified struct usb_device_id.
- */
+/* Print the modaliases for the specified struct usb_device_id. */
 static ssize_t usb_id_to_modalias_multi(const struct usb_device_id *id,
 					const char *mod_name, char *buf,
 					size_t count)
diff --git a/kernel/params.c b/kernel/params.c
index 111024196361a..b7fd5313a3118 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -13,7 +13,12 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/security.h>
+
+#ifdef CONFIG_MODULES
 #include "module/internal.h"
+#else
+static inline void add_modalias_attr(struct module_kobject *mk) {}
+#endif /* !CONFIG_MODULES */

 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */


## Changes made in v3

* Fixed more build errors found by the Intel bot
  * uint64_t division isn't always available so use `do_div` instead.
* Removed extra print statements that are not needed in the modalias
  output.

diff --git a/drivers/base/mod_devicetable.c b/drivers/base/mod_devicetable.c
index b04442207668c..f1d3de9f111c4 100644
--- a/drivers/base/mod_devicetable.c
+++ b/drivers/base/mod_devicetable.c
@@ -101,7 +101,7 @@ static unsigned int incbcd(unsigned int *bcd,
 			   size_t chars)
 {
 	unsigned int init = *bcd, i, j;
-	unsigned long long c, dec = 0;
+	unsigned long long c, dec = 0, div;

 	/* If bcd is not in BCD format, just increment */
 	if (max > 0x9) {
@@ -126,7 +126,9 @@ static unsigned int incbcd(unsigned int *bcd,
 	for (i = 0 ; i < chars ; i++) {
 		for (c = 1, j = 0 ; j < i ; j++)
 			c = c * 10;
-		c = (dec / c) % 10;
+		div = dec;
+		(void)do_div(div, c); /* div = div / c */
+		c = do_div(div, 10); /* c = div % 10; div = div / 10 */
 		*bcd += c << (i << 2);
 	}
 	return init;
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index e80bfa4639765..651c677c4ab96 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -272,9 +272,6 @@ static int print_modalias_for_drv(struct device_driver *drv, void *p)
 			return len;
 		s->len += len;
 	}
-
-	s->len += scnprintf(&s->buf[s->len], s->count - s->len, "driver %s\n",
-			    drv->name);
 	return 0;
 }

@@ -299,15 +296,6 @@ static ssize_t module_modalias_read(struct file *filp, struct kobject *kobj,
 	if (error)
 		return error;

-	if (mk->mod)
-		state.len += scnprintf(&buf[state.len], count - state.len,
-				       "modalias %s %s\n", kobject_name(kobj),
-				       mk->mod->name);
-	else
-		state.len += scnprintf(&buf[state.len], count - state.len,
-				       "modalias %s NULL\n",
-				       kobject_name(kobj));
-
 	/*
 	 * The caller checked the pos and count against our size.
 	 */


## Changes made in v2

Fixed build errors found by the Intel bot.
* `ENOSUP` is not always available so use `EINVAL` instead
* Include the header that declares `usb_drv_to_modalias` where it is defined
* Only implement `usb_drv_to_modalias` for `CONFIG_USB=y`

diff --git a/drivers/base/base.h b/drivers/base/base.h
index b3dec55fc6e87..beaa252c04388 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -178,7 +178,7 @@ ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
 			    size_t count);
 #else
 static inline ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
-					  size_t count) { return -ENOSUP; }
+					  size_t count) { return -EINVAL; }
 #endif

 #ifdef CONFIG_DEVTMPFS
diff --git a/drivers/base/mod_devicetable.c b/drivers/base/mod_devicetable.c
index da8d524cdf57a..b04442207668c 100644
--- a/drivers/base/mod_devicetable.c
+++ b/drivers/base/mod_devicetable.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/usb.h>

+#include "base.h"
 #include "../usb/core/usb.h"

 #define ADD(buf, count, len, sep, cond, field)				\
@@ -24,6 +25,7 @@ do {									\
 		(len) += scnprintf(&(buf)[len], (count) - (len), (sep "*")); \
 } while (0)

+#ifdef CONFIG_USB
 /* USB related modaliases can be split because of device number matching, so
  * this function handles individual modaliases for one segment of the range.
  *
@@ -239,3 +241,7 @@ ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
 	}
 	return len;
 }
+#else
+inline ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
+				   size_t count){ return 0; }
+#endif


Allen Webb (1):
  modules: add modalias file to sysfs for modules.

 drivers/base/Makefile          |   2 +-
 drivers/base/base.h            |   8 +
 drivers/base/bus.c             |  42 ++++++
 drivers/base/mod_devicetable.c | 257 +++++++++++++++++++++++++++++++++
 drivers/usb/core/driver.c      |   2 +
 include/linux/device/bus.h     |   8 +
 include/linux/module.h         |   1 +
 kernel/module/internal.h       |   2 +
 kernel/module/sysfs.c          |  88 +++++++++++
 kernel/params.c                |   7 +
 10 files changed, 416 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/mod_devicetable.c

-- 
2.37.3

