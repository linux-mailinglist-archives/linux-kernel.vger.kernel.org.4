Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FDD6CA7D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjC0OiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjC0OiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:38:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F76A12E;
        Mon, 27 Mar 2023 07:38:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so9056330pjt.5;
        Mon, 27 Mar 2023 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679927884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uD1W0aOOSyJUX8G07q2tBuB9nbX6WLqGBeIcqU8ehr0=;
        b=CLjz6nn4EMYj6lrHavTh4k6DQdiC6WlA68kjUt7ArAK3WqDtbg6snM7xnivHn7R8fh
         ZijxShB6I6nOK6+5npGemMq8MRgcUZ8cqgCH2fVCHt2+gbKT9Iurgrs3584EQ26Es61Y
         Jx2ma922lXOBQjtcP3BLHxXnS5GuaJaQ+iBNW1WUFksTzSitQiEDQ3EGxDKhdVB5/+jb
         ftrMUN08dshQxhk1jsVp7DuG2aUpGLwP+exMYsfF5W7AxtwbWx4wNB9Z1eJASEKM4q55
         aHiam/VypU+21TelyXMrcDMAXkENaZ5lp48mEZ4GdDH90pj1sySBNwoQ6+VlXTCX8er1
         DmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679927884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uD1W0aOOSyJUX8G07q2tBuB9nbX6WLqGBeIcqU8ehr0=;
        b=MFSGjnITc6dvK/ZmgrsFZqVAIJHw2xaCJ4tv5Kt5WhcLfg02aua0y65XpSuBUmVAur
         70WUiyGTR0OnC+T7OkbSY4BLP+SfctqWNj23XXcbyVeazLbD0w1RNMfvIt5qsS/lS6SU
         D0JZwvrecGrG+r3El/7Voz1OG7iefyrPKWZFDWs3/Kb9zLtU1tJHuPuQTdxBZW/cN2KB
         wtWykjYk6Ws60jRqG7G3JGA53vRy6h4LDycuV185VlKlzqT0efbIQmsX8wuSHhTcEQIC
         ua692pzzlAFBxtIyx5eFKFbgzDKV4HMdXCUdW6dsQuITa0/P4Cjmf5GfKh+f5S2eESqz
         oPzw==
X-Gm-Message-State: AO0yUKVSXTS3CUzGJRNjgX/+indpkrAqfCPyxZZggFfgaDbjma//IH5O
        lKBk/V5CP5o0MLfwEMES8sGYoiOxj1U=
X-Google-Smtp-Source: AK7set9R8gJlYxmPLjmxckMkY2p099Vm1QQP3Ud2uCc1UCGgMohdAWu5T0iRs/39ED78zz+NAx8WqQ==
X-Received: by 2002:a05:6a20:c129:b0:cd:1808:87c7 with SMTP id bh41-20020a056a20c12900b000cd180887c7mr10064209pzb.15.1679927883836;
        Mon, 27 Mar 2023 07:38:03 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:b47c:3979:4a3b:2b03])
        by smtp.gmail.com with ESMTPSA id u16-20020aa78490000000b00627df85cd72sm17204404pfn.199.2023.03.27.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:38:03 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, axboe@kernel.dk
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/2] fault-inject: allow configuration via configfs
Date:   Mon, 27 Mar 2023 23:37:32 +0900
Message-Id: <20230327143733.14599-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327143733.14599-1-akinobu.mita@gmail.com>
References: <20230327143733.14599-1-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a helper function to allow configuration of fault-injection
for configfs-based drivers.

The config items created by this function have the same interface as the
one created under debugfs by fault_create_debugfs_attr().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 include/linux/fault-inject.h |  22 ++++
 lib/Kconfig.debug            |  13 ++-
 lib/fault-inject.c           | 191 +++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+), 1 deletion(-)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 444236dadcf0..481abf530b3c 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/debugfs.h>
+#include <linux/configfs.h>
 #include <linux/ratelimit.h>
 #include <linux/atomic.h>
 
@@ -65,6 +66,27 @@ static inline struct dentry *fault_create_debugfs_attr(const char *name,
 
 #endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
 
+#ifdef CONFIG_FAULT_INJECTION_CONFIGFS
+
+struct fault_config {
+	struct fault_attr attr;
+	struct config_group group;
+};
+
+void fault_config_init(struct fault_config *config, const char *name);
+
+#else /* CONFIG_FAULT_INJECTION_CONFIGFS */
+
+struct fault_config {
+};
+
+static inline void fault_config_init(struct fault_config *config,
+			const char *name)
+{
+}
+
+#endif /* CONFIG_FAULT_INJECTION_CONFIGFS */
+
 #endif /* CONFIG_FAULT_INJECTION */
 
 struct kmem_cache;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f0d5b82e478d..6f64b49a2a8e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1977,9 +1977,20 @@ config FAIL_SUNRPC
 	  Provide fault-injection capability for SunRPC and
 	  its consumers.
 
+config FAULT_INJECTION_CONFIGFS
+	bool "Configfs interface for fault-injection capabilities"
+	depends on FAULT_INJECTION && CONFIGFS_FS
+	help
+	  This option allows configfs-based drivers to dynamically configure
+	  fault-injection via configfs.  Each parameter for driver-specific
+	  fault-injection can be made visible as a configfs attribute in a
+	  configfs group.
+
+
 config FAULT_INJECTION_STACKTRACE_FILTER
 	bool "stacktrace filter for fault-injection capabilities"
-	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
+	depends on FAULT_INJECTION
+	depends on (FAULT_INJECTION_DEBUG_FS || FAULT_INJECTION_CONFIGFS) && STACKTRACE_SUPPORT
 	select STACKTRACE
 	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	help
diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 6cff320c4eb4..d608f9b48c10 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -244,3 +244,194 @@ struct dentry *fault_create_debugfs_attr(const char *name,
 EXPORT_SYMBOL_GPL(fault_create_debugfs_attr);
 
 #endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+#ifdef CONFIG_FAULT_INJECTION_CONFIGFS
+
+/* These configfs attribute utilities are copied from drivers/block/null_blk/main.c */
+
+static ssize_t fault_uint_attr_show(unsigned int val, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", val);
+}
+
+static ssize_t fault_ulong_attr_show(unsigned long val, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%lu\n", val);
+}
+
+static ssize_t fault_bool_attr_show(bool val, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", val);
+}
+
+static ssize_t fault_atomic_t_attr_show(atomic_t val, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%d\n", atomic_read(&val));
+}
+
+static ssize_t fault_uint_attr_store(unsigned int *val, const char *page, size_t count)
+{
+	unsigned int tmp;
+	int result;
+
+	result = kstrtouint(page, 0, &tmp);
+	if (result < 0)
+		return result;
+
+	*val = tmp;
+	return count;
+}
+
+static ssize_t fault_ulong_attr_store(unsigned long *val, const char *page, size_t count)
+{
+	int result;
+	unsigned long tmp;
+
+	result = kstrtoul(page, 0, &tmp);
+	if (result < 0)
+		return result;
+
+	*val = tmp;
+	return count;
+}
+
+static ssize_t fault_bool_attr_store(bool *val, const char *page, size_t count)
+{
+	bool tmp;
+	int result;
+
+	result = kstrtobool(page, &tmp);
+	if (result < 0)
+		return result;
+
+	*val = tmp;
+	return count;
+}
+
+static ssize_t fault_atomic_t_attr_store(atomic_t *val, const char *page, size_t count)
+{
+	int tmp;
+	int result;
+
+	result = kstrtoint(page, 0, &tmp);
+	if (result < 0)
+		return result;
+
+	atomic_set(val, tmp);
+	return count;
+}
+
+#define CONFIGFS_ATTR_NAMED(_pfx, _name, _attr_name)	\
+static struct configfs_attribute _pfx##attr_##_name = {	\
+	.ca_name	= _attr_name,			\
+	.ca_mode	= 0644,				\
+	.ca_owner	= THIS_MODULE,			\
+	.show		= _pfx##_name##_show,		\
+	.store		= _pfx##_name##_store,		\
+}
+
+static struct fault_config *to_fault_config(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct fault_config, group);
+}
+
+#define FAULT_CONFIGFS_ATTR_NAMED(NAME, ATTR_NAME, MEMBER, TYPE)				\
+static ssize_t fault_##NAME##_show(struct config_item *item, char *page)			\
+{												\
+	return fault_##TYPE##_attr_show(to_fault_config(item)->attr.MEMBER, page);		\
+}												\
+static ssize_t fault_##NAME##_store(struct config_item *item, const char *page, size_t count)	\
+{												\
+	struct fault_config *config = to_fault_config(item);					\
+	return fault_##TYPE##_attr_store(&config->attr.MEMBER, page, count);			\
+}												\
+CONFIGFS_ATTR_NAMED(fault_, NAME, ATTR_NAME)
+
+#define FAULT_CONFIGFS_ATTR(NAME, TYPE)	\
+	FAULT_CONFIGFS_ATTR_NAMED(NAME, __stringify(NAME), NAME, TYPE)
+
+FAULT_CONFIGFS_ATTR(probability, ulong);
+FAULT_CONFIGFS_ATTR(interval, ulong);
+FAULT_CONFIGFS_ATTR(times, atomic_t);
+FAULT_CONFIGFS_ATTR(space, atomic_t);
+FAULT_CONFIGFS_ATTR(verbose, ulong);
+FAULT_CONFIGFS_ATTR_NAMED(ratelimit_interval, "verbose_ratelimit_interval_ms",
+		ratelimit_state.interval, uint);
+FAULT_CONFIGFS_ATTR_NAMED(ratelimit_burst, "verbose_ratelimit_burst",
+		ratelimit_state.burst, uint);
+FAULT_CONFIGFS_ATTR_NAMED(task_filter, "task-filter", task_filter, bool);
+
+#ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
+
+static ssize_t fault_stacktrace_depth_show(struct config_item *item, char *page)
+{
+	return fault_ulong_attr_show(to_fault_config(item)->attr.stacktrace_depth, page);
+}
+
+static ssize_t fault_stacktrace_depth_store(struct config_item *item, const char *page,
+		size_t count)
+{
+	int result;
+	unsigned long tmp;
+
+	result = kstrtoul(page, 0, &tmp);
+	if (result < 0)
+		return result;
+
+	to_fault_config(item)->attr.stacktrace_depth =
+		min_t(unsigned long, tmp, MAX_STACK_TRACE_DEPTH);
+
+	return count;
+}
+
+CONFIGFS_ATTR_NAMED(fault_, stacktrace_depth, "stacktrace-depth");
+
+static ssize_t fault_xul_attr_show(unsigned long val, char *page)
+{
+	return snprintf(page, PAGE_SIZE,
+			sizeof(val) == sizeof(u32) ? "0x%08lx\n" : "0x%016lx\n", val);
+}
+
+static ssize_t fault_xul_attr_store(unsigned long *val, const char *page, size_t count)
+{
+	return fault_ulong_attr_store(val, page, count);
+}
+
+FAULT_CONFIGFS_ATTR_NAMED(require_start, "require-start", require_start, xul);
+FAULT_CONFIGFS_ATTR_NAMED(require_end, "require-end", require_end, xul);
+FAULT_CONFIGFS_ATTR_NAMED(reject_start, "reject-start", reject_start, xul);
+FAULT_CONFIGFS_ATTR_NAMED(reject_end, "reject-end", reject_end, xul);
+
+#endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
+
+static struct configfs_attribute *fault_config_attrs[] = {
+	&fault_attr_probability,
+	&fault_attr_interval,
+	&fault_attr_times,
+	&fault_attr_space,
+	&fault_attr_verbose,
+	&fault_attr_ratelimit_interval,
+	&fault_attr_ratelimit_burst,
+	&fault_attr_task_filter,
+#ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
+	&fault_attr_stacktrace_depth,
+	&fault_attr_require_start,
+	&fault_attr_require_end,
+	&fault_attr_reject_start,
+	&fault_attr_reject_end,
+#endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
+	NULL,
+};
+
+static const struct config_item_type fault_config_type = {
+	.ct_attrs	= fault_config_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+void fault_config_init(struct fault_config *config, const char *name)
+{
+	config_group_init_type_name(&config->group, name, &fault_config_type);
+}
+EXPORT_SYMBOL_GPL(fault_config_init);
+
+#endif /* CONFIG_FAULT_INJECTION_CONFIGFS */
-- 
2.34.1

