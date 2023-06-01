Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69A371941F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjFAHZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjFAHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852EB13E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685604297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVNhkRwZAfrMBhKh//wi6Z59DrttLTByCXwnmuvQ7Sk=;
        b=fwFKzULvG2I2S94hr65HA1VMsl3EkViDqVU3iLf0yXX8DlHXrfXGTz6VeASXbcbASgqrD0
        2TRfgodcPK6hHz8OlLkL423mJ8cB7iE3GptQO9hSN4ZDwz8KTfkctqlG8VyNUpD6CtB/F8
        4at0iTlMMOdYk7RMB5MuTxCfbULQRgM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-mI8yZIRROdCh5DcXlQSo0A-1; Thu, 01 Jun 2023 03:24:56 -0400
X-MC-Unique: mI8yZIRROdCh5DcXlQSo0A-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f80c977f15so5029071cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 00:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604296; x=1688196296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVNhkRwZAfrMBhKh//wi6Z59DrttLTByCXwnmuvQ7Sk=;
        b=QT22WzI6/67PnXgtEOBUp4lA+Ww10w8KLsnNHotAbEQc1+/YWCfQxvajomqwrO6hMR
         l5TfIeQN6H/69/DNDFUdMiiL7M02NlegSIC+m6GkGc9hnLV8TrikuIIXl6/QrDCPpn9o
         kfJXpYts/KyO93B44ZLwYTkMmvoe348pSRusUBGDywnBrjQC7RNW6fb3bwVRiMmrz+8Z
         0n7br4j3pAuYoGu/wtdDkLOaRTUCEoAN40H6JLpbPRY6bkxWhmgyLZN3GgWnqfo4M+3T
         rf6osgq2o+dSLAzbvI+mAPv/38KsbJHxOjTvgsBTgumLq1U2rIxJq0IzR/QDTgiuMWgD
         HZNQ==
X-Gm-Message-State: AC+VfDzryhWxJzgE40e3pcbiby2AvedtMPEH45kvQ31182TkKBBmDF1H
        pUjWs/x5pJYxhnutU8UTXRNzxwcMr5z5GucwUvJFUIyjiKtMAaQjqpF1o1kEoT4NSA7HUZn9iRU
        kA8BhggmEE7N0FsnBL74GW6fr
X-Received: by 2002:a05:622a:3c7:b0:3f4:eb26:6d42 with SMTP id k7-20020a05622a03c700b003f4eb266d42mr7982586qtx.63.1685604295826;
        Thu, 01 Jun 2023 00:24:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6UZAxm2RuiVCtGixZ0U45XGL7fm+89xCNa6kmGqARldADNGbnk+xAiazKcrMefCa2tIl3eZQ==
X-Received: by 2002:a05:622a:3c7:b0:3f4:eb26:6d42 with SMTP id k7-20020a05622a03c700b003f4eb266d42mr7982558qtx.63.1685604295538;
        Thu, 01 Jun 2023 00:24:55 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i28-20020a63541c000000b0053efb8fae02sm2465297pgb.24.2023.06.01.00.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:24:55 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 2/5] crash_dump: save the LUKS volume key temporarily
Date:   Thu,  1 Jun 2023 15:24:41 +0800
Message-Id: <20230601072444.2033855-3-coxu@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601072444.2033855-1-coxu@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After having the volume key, crytpsetup/systemd-cryptsetup saves the
volume key as a logon key to its thread keyring and this key is
destroyed immediately with the terminated thread. So a temporary copy of
the volume key is needed in order to later save it to kdump reserved
memory when the crash kernel is loaded later.

crytpsetup/systemd-cryptsetup will write the key description to
/sys/kernel/crash_luks_volume_key so the kernel will read the logon key
and save a temporary copy for later user. kdump has 1 hour at maximum to
get the temporary copy before the key gets wiped. And after kdump
retrieves the key, the key will be wiped immediately.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h |  2 +
 kernel/Makefile            |  2 +-
 kernel/crash_dump_luks.c   | 90 ++++++++++++++++++++++++++++++++++++++
 kernel/ksysfs.c            | 19 ++++++++
 4 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 kernel/crash_dump_luks.c

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..596d83b8f362 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -83,5 +83,7 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
+int crash_sysfs_luks_volume_key_write(const char *key_des, size_t count);
+int crash_pass_temp_luks_volume_key(void **addr, unsigned long *sz);
 
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index b69c95315480..8412afa4a9f0 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -118,7 +118,7 @@ obj-$(CONFIG_PERF_EVENTS) += events/
 
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
 obj-$(CONFIG_PADATA) += padata.o
-obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
+obj-$(CONFIG_CRASH_DUMP) += crash_dump.o crash_dump_luks.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
diff --git a/kernel/crash_dump_luks.c b/kernel/crash_dump_luks.c
new file mode 100644
index 000000000000..2d88b77a93f8
--- /dev/null
+++ b/kernel/crash_dump_luks.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <keys/user-type.h>
+#include <linux/crash_dump.h>
+
+static u8 *luks_volume_key;
+static unsigned int luks_volume_key_size;
+
+void wipe_luks_volume_key(void)
+{
+	if (luks_volume_key) {
+		memset(luks_volume_key, 0, luks_volume_key_size * sizeof(u8));
+		kfree(luks_volume_key);
+		luks_volume_key = NULL;
+	}
+}
+
+static void _wipe_luks_volume_key(struct work_struct *dummy)
+{
+	wipe_luks_volume_key();
+}
+
+static DECLARE_DELAYED_WORK(wipe_luks_volume_key_work, _wipe_luks_volume_key);
+
+static unsigned __read_mostly wipe_key_delay = 3600; /* 1 hour */
+
+static int crash_save_temp_luks_volume_key(const char *key_desc, size_t count)
+{
+	const struct user_key_payload *ukp;
+	struct key *key;
+
+
+	if (luks_volume_key) {
+		memset(luks_volume_key, 0, luks_volume_key_size * sizeof(u8));
+		kfree(luks_volume_key);
+	}
+
+	pr_debug("Requesting key %s", key_desc);
+	key = request_key(&key_type_logon, key_desc, NULL);
+
+	if (IS_ERR(key)) {
+		pr_debug("No such key %s", key_desc);
+		return PTR_ERR(key);
+	}
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp)
+		return -EKEYREVOKED;
+
+	luks_volume_key = kmalloc(ukp->datalen, GFP_KERNEL);
+	if (!luks_volume_key)
+		return -ENOMEM;
+	memcpy(luks_volume_key, ukp->data, ukp->datalen);
+	luks_volume_key_size = ukp->datalen;
+	pr_debug("LUKS master key (size=%u): %8ph\n", luks_volume_key_size, luks_volume_key);
+	schedule_delayed_work(&wipe_luks_volume_key_work,
+			      round_jiffies_relative(wipe_key_delay * HZ));
+	return 0;
+}
+
+int crash_sysfs_luks_volume_key_write(const char *key_desc, size_t count)
+{
+	if (!is_kdump_kernel())
+		return crash_save_temp_luks_volume_key(key_desc, count);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(crash_sysfs_luks_volume_key_write);
+
+int crash_pass_temp_luks_volume_key(void **addr, unsigned long *sz)
+{
+	unsigned long luks_key_sz;
+	unsigned char *buf;
+	unsigned int *size_ptr;
+
+	if (!luks_volume_key)
+		return -EINVAL;
+
+	luks_key_sz = sizeof(unsigned int) + luks_volume_key_size * sizeof(u8);
+
+	buf = vzalloc(luks_key_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	size_ptr = (unsigned int *)buf;
+	memcpy(size_ptr, &luks_volume_key_size, sizeof(unsigned int));
+	memcpy(size_ptr + 1, luks_volume_key, luks_volume_key_size * sizeof(u8));
+	*addr = buf;
+	*sz = luks_key_sz;
+	wipe_luks_volume_key();
+	return 0;
+}
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index aad7a3bfd846..cc64a895c334 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -165,6 +165,24 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+static ssize_t crash_luks_volume_key_show(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *buf)
+{
+	return 0;
+}
+
+static ssize_t crash_luks_volume_key_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int ret;
+
+	ret = crash_sysfs_luks_volume_key_write(buf, count);
+	return ret < 0 ? ret : count;
+}
+KERNEL_ATTR_RW(crash_luks_volume_key);
+
 #endif /* CONFIG_CRASH_CORE */
 
 /* whether file capabilities are enabled */
@@ -255,6 +273,7 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_CRASH_CORE
 	&vmcoreinfo_attr.attr,
+	&crash_luks_volume_key_attr.attr,
 #endif
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
-- 
2.40.1

