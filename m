Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6A2719429
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjFAH0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjFAHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40F9F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685604302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSdEOOvVOvBHgbxdtA0aSxX16fM93R7Xrib46N4HMRQ=;
        b=esm0yLUVbBXHsbucG2ZuTgmO4I9hOD6eap4CqfacLceGVnnC59lU87xoE4fIqwxXyLC94P
        vjGU0r03Kl1WzqEcATesreacg/byuEN4ElTAJ9QI/+eAZWXIcEPDPOaklvWkDNdF9IpT45
        4QqkCmE/m0iGeO7TFY8tf/HDT9QB0v0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-0WOvoThUO4OfG3aQVH3dIA-1; Thu, 01 Jun 2023 03:25:01 -0400
X-MC-Unique: 0WOvoThUO4OfG3aQVH3dIA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-650abd6d92eso44108b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 00:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604300; x=1688196300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSdEOOvVOvBHgbxdtA0aSxX16fM93R7Xrib46N4HMRQ=;
        b=XrTTX8X9zLSy1a9OLTVPSm9H6O6RLdFrOWRSSMYMv/bWMS9IWs0fSGzsoB6hY0/CcR
         JDoBO+ynC4vYXsGsmR6aT9rwNR969jac9BZipkXgLkT3c5XbZAlWsmz3VnYEKb0cQUO+
         35Pb3LWj3t5vFTGLTOlfNephhIJnqaaOozzFh1XxNqd6bfMeQKZZPrs4cjpOenxJoccd
         Yh2lDTVvELIGhtz/W3HfA+eCkkoxlu12ZJxkahA5MEfGx6lZ7bOhaY2r2fKPiRIdosbF
         EPYWmAkDvR4/0Tnq+0DivNa/5X6kG0Fzcat5Eyu4Pr3AymlTCAHc5hWds1wcMnNuNUr4
         u2Ug==
X-Gm-Message-State: AC+VfDxNzRb2G0OcB1U5mVk9qc5F2zedtmxn9xsvkHkNoQvITkzIidFs
        t1OapTDCLa2oiNU7dYmv70J384l0HP9vH1d62KQT5okHjMhS7DuKklX/8xgIRa8fSUXpPyVliXp
        iDqQGRsKRxX9WPw+BxxbZNQ2P
X-Received: by 2002:a05:6a00:1a51:b0:63b:5496:7af5 with SMTP id h17-20020a056a001a5100b0063b54967af5mr7757653pfv.1.1685604300240;
        Thu, 01 Jun 2023 00:25:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dvgVyrzGCsjuOATzcCkMb2NCswn1qLkQ0iET/24u8jgUcZoCb8ABgYZHVIPusFMkwCuiucw==
X-Received: by 2002:a05:6a00:1a51:b0:63b:5496:7af5 with SMTP id h17-20020a056a001a5100b0063b54967af5mr7757634pfv.1.1685604299873;
        Thu, 01 Jun 2023 00:24:59 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f18-20020aa78b12000000b0064d27a28451sm4433388pfd.100.2023.06.01.00.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:24:59 -0700 (PDT)
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
Subject: [PATCH 3/5] crash_dump: retrieve LUKS volume key in kdump kernel
Date:   Thu,  1 Jun 2023 15:24:42 +0800
Message-Id: <20230601072444.2033855-4-coxu@redhat.com>
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

Crash kernel will retrieve the LUKS volume key based on the
luksvolumekey command line parameter. When libcryptsetup writes the key
description to /sys/kernel/crash_luks_volume_key, crash kernel will
create a thread keyring and add a logon key.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_dump.h |   2 +
 kernel/crash_dump_luks.c   | 116 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 0f3a656293b0..bc848e058c64 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -15,6 +15,8 @@
 extern unsigned long long elfcorehdr_addr;
 extern unsigned long long elfcorehdr_size;
 
+extern unsigned long long luks_volume_key_addr;
+
 #ifdef CONFIG_CRASH_DUMP
 extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
 extern void elfcorehdr_free(unsigned long long addr);
diff --git a/kernel/crash_dump_luks.c b/kernel/crash_dump_luks.c
index 2d88b77a93f8..63718db318c3 100644
--- a/kernel/crash_dump_luks.c
+++ b/kernel/crash_dump_luks.c
@@ -1,7 +1,82 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 
+unsigned long long luks_volume_key_addr;
+EXPORT_SYMBOL_GPL(luks_volume_key_addr);
+
+static int __init setup_luksvolumekey(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	luks_volume_key_addr = memparse(arg, &end);
+	if (end > arg)
+		return 0;
+
+	luks_volume_key_addr = 0;
+	return -EINVAL;
+}
+
+early_param("luksvolumekey", setup_luksvolumekey);
+
+/*
+ * Architectures may override this function to read LUKS master key
+ */
+ssize_t __weak luks_key_read(char *buf, size_t count, u64 *ppos)
+{
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	return read_from_oldmem(&iter, count, ppos, false);
+}
+
+static int retrive_kdump_luks_volume_key(u8 *buffer, unsigned int *sz)
+{
+	unsigned int key_size;
+	size_t lukskeybuf_sz;
+	unsigned int *size_ptr;
+	char *lukskeybuf;
+	u64 addr;
+	int r;
+
+	if (luks_volume_key_addr == 0) {
+		pr_debug("LUKS master key memory address inaccessible");
+		return -EINVAL;
+	}
+
+	addr = luks_volume_key_addr;
+
+	/* Read LUKS master key size */
+	r = luks_key_read((char *)&key_size, sizeof(unsigned int), &addr);
+
+	if (r < 0)
+		return r;
+
+	pr_debug("Retrieve LUKS master key: size=%u\n", key_size);
+	/* Read in LUKS maste rkey */
+	lukskeybuf_sz = sizeof(unsigned int) + key_size * sizeof(u8);
+	lukskeybuf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					      get_order(lukskeybuf_sz));
+	if (!lukskeybuf)
+		return -ENOMEM;
+
+	addr = luks_volume_key_addr;
+	r = luks_key_read((char *)lukskeybuf, lukskeybuf_sz, &addr);
+
+	if (r < 0)
+		return r;
+	size_ptr = (unsigned int *)lukskeybuf;
+	memcpy(buffer, size_ptr + 1, key_size * sizeof(u8));
+	pr_debug("Retrieve LUKS master key (size=%u): %48ph...\n", key_size, buffer);
+	*sz = key_size;
+	return 0;
+}
+
 static u8 *luks_volume_key;
 static unsigned int luks_volume_key_size;
 
@@ -23,12 +98,48 @@ static DECLARE_DELAYED_WORK(wipe_luks_volume_key_work, _wipe_luks_volume_key);
 
 static unsigned __read_mostly wipe_key_delay = 3600; /* 1 hour */
 
+static int retore_luks_volume_key_to_thread_keyring(const char *key_desc)
+{
+	key_ref_t keyring_ref, key_ref;
+	int ret;
+
+	/* find the target keyring (which must be writable) */
+	keyring_ref = lookup_user_key(KEY_SPEC_THREAD_KEYRING, 0x01, KEY_NEED_WRITE);
+	if (IS_ERR(keyring_ref)) {
+		pr_alert("Failed to get keyring");
+		return PTR_ERR(keyring_ref);
+	}
+
+	luks_volume_key = kmalloc(128, GFP_KERNEL);
+	ret = retrive_kdump_luks_volume_key(luks_volume_key, &luks_volume_key_size);
+	if (ret) {
+		kfree(luks_volume_key);
+		return ret;
+	}
+
+	/* create or update the requested key and add it to the target keyring */
+	key_ref = key_create_or_update(keyring_ref, "logon", key_desc,
+				       luks_volume_key, luks_volume_key_size,
+				       KEY_PERM_UNDEF, KEY_ALLOC_IN_QUOTA);
+
+	if (!IS_ERR(key_ref)) {
+		ret = key_ref_to_ptr(key_ref)->serial;
+		key_ref_put(key_ref);
+		pr_alert("Success adding key %s", key_desc);
+	} else {
+		ret = PTR_ERR(key_ref);
+		pr_alert("Error when adding key");
+	}
+
+	key_ref_put(keyring_ref);
+	return ret;
+}
+
 static int crash_save_temp_luks_volume_key(const char *key_desc, size_t count)
 {
 	const struct user_key_payload *ukp;
 	struct key *key;
 
-
 	if (luks_volume_key) {
 		memset(luks_volume_key, 0, luks_volume_key_size * sizeof(u8));
 		kfree(luks_volume_key);
@@ -61,7 +172,8 @@ int crash_sysfs_luks_volume_key_write(const char *key_desc, size_t count)
 {
 	if (!is_kdump_kernel())
 		return crash_save_temp_luks_volume_key(key_desc, count);
-	return -EINVAL;
+	else
+		return retore_luks_volume_key_to_thread_keyring(key_desc);
 }
 EXPORT_SYMBOL(crash_sysfs_luks_volume_key_write);
 
-- 
2.40.1

