Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4816C8194
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjCXPl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjCXPlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:41:08 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1104F23120
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:40:47 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679672445;
        bh=bHMcr3MoNlTp50l3EgGBJI+vWJX3PsXfd4JNwbvcv9U=;
        h=From:Date:Subject:To:Cc:From;
        b=A/+aaYdphKJfM8gXSPJNi3UfGZWfGQ1a3mzn5M+6KhzJqnV59JSP0VdhgkYG1smWM
         xm076d2Sj7fs8wjDAd9YwRWQpbixkWXUNhKls0k+mSkMMmgVPaoVHcdlWGILe7b3JC
         I0TOHrcM+3/gcZamq6kv4oSQfmTtw6hIwMQ5vs84=
Date:   Fri, 24 Mar 2023 15:40:41 +0000
Subject: [PATCH] kernel/ksysfs.c: use sysfs_emit for sysfs show handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230324-ksysfs-sysfs_emit-v1-1-67c03cddc8a6@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAHjEHWQC/x2N0QqDMAxFf0XyvECNE3S/MsZou3SGuW40UxTx3
 xd8uXAuHM4GykVY4VJtUHgWlU82qE8VxMHnJ6M8jIEcNa6hM7501aR47J3f8sPUO2rJha5uI5g
 XvDKG4nMczMzTONr5LZxkOULX277/AYoOkfx4AAAA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679672443; l=3949;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bHMcr3MoNlTp50l3EgGBJI+vWJX3PsXfd4JNwbvcv9U=;
 b=OUibhHN9RBy8/McHWgWaboUt+ZjUAxOfVjrWYHQN+RiqebBtytr4qCOP2UWI5N/+2Y5bC7NSQ
 qkiJbSvHj4ICqBYgZaSQBIVYTWvy9p/GIx2t8XaNt/0CSful9ZAoH2v
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs_emit() is the recommended way to format strings for sysfs as per
Documentation/filesystems/sysfs.rst.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/ksysfs.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 0408aab80941..aad7a3bfd846 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -39,7 +39,7 @@ static struct kobj_attribute _name##_attr = __ATTR_RW(_name)
 static ssize_t uevent_seqnum_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)uevent_seqnum);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)uevent_seqnum);
 }
 KERNEL_ATTR_RO(uevent_seqnum);
 
@@ -64,7 +64,7 @@ KERNEL_ATTR_RO(address_bits);
 static ssize_t uevent_helper_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%s\n", uevent_helper);
+	return sysfs_emit(buf, "%s\n", uevent_helper);
 }
 static ssize_t uevent_helper_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
@@ -85,7 +85,7 @@ KERNEL_ATTR_RW(uevent_helper);
 static ssize_t profiling_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", prof_on);
+	return sysfs_emit(buf, "%d\n", prof_on);
 }
 static ssize_t profiling_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
@@ -116,14 +116,14 @@ KERNEL_ATTR_RW(profiling);
 static ssize_t kexec_loaded_show(struct kobject *kobj,
 				 struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", !!kexec_image);
+	return sysfs_emit(buf, "%d\n", !!kexec_image);
 }
 KERNEL_ATTR_RO(kexec_loaded);
 
 static ssize_t kexec_crash_loaded_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", kexec_crash_loaded());
+	return sysfs_emit(buf, "%d\n", kexec_crash_loaded());
 }
 KERNEL_ATTR_RO(kexec_crash_loaded);
 
@@ -135,7 +135,7 @@ static ssize_t kexec_crash_size_show(struct kobject *kobj,
 	if (size < 0)
 		return size;
 
-	return sprintf(buf, "%zd\n", size);
+	return sysfs_emit(buf, "%zd\n", size);
 }
 static ssize_t kexec_crash_size_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
@@ -160,8 +160,8 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
 {
 	phys_addr_t vmcore_base = paddr_vmcoreinfo_note();
-	return sprintf(buf, "%pa %x\n", &vmcore_base,
-			(unsigned int)VMCOREINFO_NOTE_SIZE);
+	return sysfs_emit(buf, "%pa %x\n", &vmcore_base,
+			  (unsigned int)VMCOREINFO_NOTE_SIZE);
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
@@ -171,7 +171,7 @@ KERNEL_ATTR_RO(vmcoreinfo);
 static ssize_t fscaps_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", file_caps_enabled);
+	return sysfs_emit(buf, "%d\n", file_caps_enabled);
 }
 KERNEL_ATTR_RO(fscaps);
 
@@ -180,7 +180,7 @@ int rcu_expedited;
 static ssize_t rcu_expedited_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", READ_ONCE(rcu_expedited));
+	return sysfs_emit(buf, "%d\n", READ_ONCE(rcu_expedited));
 }
 static ssize_t rcu_expedited_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
@@ -197,7 +197,7 @@ int rcu_normal;
 static ssize_t rcu_normal_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", READ_ONCE(rcu_normal));
+	return sysfs_emit(buf, "%d\n", READ_ONCE(rcu_normal));
 }
 static ssize_t rcu_normal_store(struct kobject *kobj,
 				struct kobj_attribute *attr,

---
base-commit: 1e760fa3596e8c7f08412712c168288b79670d78
change-id: 20230324-ksysfs-sysfs_emit-f902520b815c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

