Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028176533DD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiLUQSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiLUQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:18:03 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E1220EB;
        Wed, 21 Dec 2022 08:18:02 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671639480;
        bh=5Kuf8mtaECc9i8ymD5ug9Qtqh/WLjoDjMBBE59Rmcpw=;
        h=From:Date:Subject:To:Cc:From;
        b=AifvGmYkaWzleaaxUikPI2TSj/gYzlkmx3hdToqFvQqnW1I04q1d1tkMHPMse+N3p
         HVVS34JHIPAf7K8tL929JiePLRtbVvIzOi3MsV3mffQxodNHCAnl6m09hT+IvHee6U
         5v63enPS8AyTyGOrIF4W6YDVq5tHICmdP+x8kjHg=
Date:   Wed, 21 Dec 2022 16:17:52 +0000
Subject: [PATCH] kernels/ksysfs.c: export kernel address bits
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221221-address-bits-v1-1-8446b13244ac@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALAxo2MC/x2NQQqDQAxFryJZG6gpqPQq0kXGiTUgU0mqFMS7G
 4S/eR8e7wAXU3F4VQeY7Or6LQFNXcE4c/kIag4GehA1MeScTdwx6c+xJeK+60m6Z4ZQErtgMi7j
 HFLZliXO1WTS/90Y3ud5Ad40RvZzAAAA
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        linux-api@vger.kernel.org
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671639477; l=2240;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5Kuf8mtaECc9i8ymD5ug9Qtqh/WLjoDjMBBE59Rmcpw=;
 b=CbJ7PXGbE8At50zccR/KhIolZERvRK+sBE2voTyCEXgFgvKGp0Iz66Uitr0NhE5l4EFZxXfypASI
 7w1XZWQHA8sgg0TRx6YQEdqtg+LNHI5uXVgAlbhu7d5mChicbR1f
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used by userspace to determine the address size of the
running kernel.
It frees userspace from having to interpret this information from the
UTS machine field.

Userspace implementation:
https://github.com/util-linux/util-linux/pull/1966

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Cc: linux-kernel@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Karel Zak" <kzak@redhat.com>
Cc: linux-api@vger.kernel.org
---
 Documentation/ABI/testing/sysfs-kernel-address_bits | 10 ++++++++++
 kernel/ksysfs.c                                     |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-address_bits b/Documentation/ABI/testing/sysfs-kernel-address_bits
new file mode 100644
index 000000000000..5d09ff84d4d6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-address_bits
@@ -0,0 +1,10 @@
+What:		/sys/kernel/address_bit
+Date:		May 2023
+KernelVersion:	6.3
+Contact:	Thomas Weißschuh <linux@weissschuh.net>
+Description:
+		The address size of the running kernel in bits.
+
+		Access: Read
+
+Users:		util-linux
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 2df00b789b90..0408aab80941 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -51,6 +51,14 @@ static ssize_t cpu_byteorder_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(cpu_byteorder);
 
+/* address bits */
+static ssize_t address_bits_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%zu\n", sizeof(void *) * 8 /* CHAR_BIT */);
+}
+KERNEL_ATTR_RO(address_bits);
+
 #ifdef CONFIG_UEVENT_HELPER
 /* uevent helper program, used during early boot */
 static ssize_t uevent_helper_show(struct kobject *kobj,
@@ -233,6 +241,7 @@ static struct attribute * kernel_attrs[] = {
 	&fscaps_attr.attr,
 	&uevent_seqnum_attr.attr,
 	&cpu_byteorder_attr.attr,
+	&address_bits_attr.attr,
 #ifdef CONFIG_UEVENT_HELPER
 	&uevent_helper_attr.attr,
 #endif

---
base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
change-id: 20221221-address-bits-622a8782e73d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
