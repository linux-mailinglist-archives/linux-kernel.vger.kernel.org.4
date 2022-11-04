Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5D619560
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKDLbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiKDLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC822AF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667561446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s1xZ0vxushGJcgjg7hlatryVRu1/dXqezckzHs4WjGk=;
        b=COW5uz0ajxL5hZkFMm7LmdxJrrcernOz1LjEw1/Ht3FNNvzkahG5YpsV0qFncjoru2MukE
        OKM701B3t2LR7vO1/Ce7RbSI1QTwn7uYaYegx0yW6/mJg2BdUXuz3RGW6Vrk1p4Lu/1x2d
        sTUWQTV3V0W8oAtBIY/vEvMUsIjcIF4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-P2Eaq2iKMt-wSsMCpOVQQA-1; Fri, 04 Nov 2022 07:30:29 -0400
X-MC-Unique: P2Eaq2iKMt-wSsMCpOVQQA-1
Received: by mail-pl1-f198.google.com with SMTP id z15-20020a170903018f00b0018862d520fbso1622208plg.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 04:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1xZ0vxushGJcgjg7hlatryVRu1/dXqezckzHs4WjGk=;
        b=ZBnHE5lnNCmnbZRO0W47nvp5qAFY4XSpZ57hqbrTlov1vCBR+vfIbameNJYxOpUGMc
         p6AQDKnCGFBcoNMZUb2UtYoysekbZhPP5ozK1vzt9xj/hrkHbWSsdFujZTcoZeYprm5H
         hJfbp5Pv99xrRo0zu8UKds+J0xsgmt6SJI9cq4hTm+OrUXKtHXN7PSZK427ujO7oHmQL
         jAAezF6nr3jE686lXy/GAWiys3d1+nGlhaF8tqSqjAtlmNleWPtV+ODmoRW3L4tMMFNx
         tISR3CRzZIEYO0pLJxocZWpjDPX1Tzr9/hzmAmv3yQVEchYVLSLraqasO/kUKUlihNEl
         a6/g==
X-Gm-Message-State: ACrzQf1eWIxvnPJLxmMzAjvWzJ0A3zSP82h1esparu3e9tBJsv/1YRLK
        Bkm9FGU/T677rsMtfrfs0ft9WqOjtcXKuKjJDDX6QW4+Q96SPkRhJLwH0X3xJM+++pUN27gFwIY
        oFN6f837zfKNDAqRaVuIAfGFs
X-Received: by 2002:a17:90b:4f8a:b0:213:48f0:296f with SMTP id qe10-20020a17090b4f8a00b0021348f0296fmr53282527pjb.140.1667561428157;
        Fri, 04 Nov 2022 04:30:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6fOg7xKewtpqLLbefucY7Lfg8o27pnyZIU+pw2e82M8AAb+KPN1hlYZS75bLeAcvDS/QbLoA==
X-Received: by 2002:a17:90b:4f8a:b0:213:48f0:296f with SMTP id qe10-20020a17090b4f8a00b0021348f0296fmr53282509pjb.140.1667561427911;
        Fri, 04 Nov 2022 04:30:27 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902a40c00b00186b1bfbe79sm2429710plq.66.2022.11.04.04.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:30:27 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Subject: [RFC v2 2/5] crash_dump: save the LUKS volume key temporarily
Date:   Fri,  4 Nov 2022 19:29:57 +0800
Message-Id: <20221104113000.487098-3-coxu@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221104113000.487098-1-coxu@redhat.com>
References: <20221104113000.487098-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
 kernel/crash_dump.c        | 88 ++++++++++++++++++++++++++++++++++++++
 kernel/ksysfs.c            | 19 ++++++++
 3 files changed, 109 insertions(+)

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
diff --git a/kernel/crash_dump.c b/kernel/crash_dump.c
index 92da32275af5..9c202bffbb8d 100644
--- a/kernel/crash_dump.c
+++ b/kernel/crash_dump.c
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 
+#include <keys/user-type.h>
 /*
  * stores the physical address of elf header of crash image
  *
@@ -39,3 +40,90 @@ static int __init setup_elfcorehdr(char *arg)
 	return end > arg ? 0 : -EINVAL;
 }
 early_param("elfcorehdr", setup_elfcorehdr);
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
index b1292a57c2a5..e7a7433cb951 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -135,6 +135,24 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
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
@@ -223,6 +241,7 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_CRASH_CORE
 	&vmcoreinfo_attr.attr,
+	&crash_luks_volume_key_attr.attr,
 #endif
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
-- 
2.37.3

