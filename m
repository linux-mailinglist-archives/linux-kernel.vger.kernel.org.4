Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4717774BD39
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 12:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGHKOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 06:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGHKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 06:14:01 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B7A1FD9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 03:13:55 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id I4wlqeROQBC88I4wlqne8P; Sat, 08 Jul 2023 12:13:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1688811228;
        bh=9O9yEyZRJBIiLE4+IqXvqAN9ixKeBIx6+ibfzyadF5o=;
        h=From:To:Cc:Subject:Date;
        b=cU+NAgl8Ayr2k12EeZ8TTODNngu8q5zX2SPR1YT3RykLA+r9UeqMtCf6A4HyDuXJp
         IpZORkJ3jcErhBjaVeAKGB38tD2U6rCOTtM0AJWGVJ15xvcNgdVeQrkaKX5o4/Cznh
         FrJjWb5pQpoGTGqTaroNV2YS33AaGblLSnC0ZKQUYdEY7vYEc+xBnket4EgS7S8beP
         MX8AFtX2ziZFeaENzmNZeXaVd6ntNeeuZ7c8pfeiRmb+NgcuUYtaAIDXoRfgu2UQeT
         4uI+qwa995A5cdWn8eQip6eVrJrfecV4CstgyCZS4fiXObURj6VPinxgfO/vMidKH4
         wRdS9LJ4v5SAg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Jul 2023 12:13:48 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] kobject: Reorder fields in 'struct kobject'
Date:   Sat,  8 Jul 2023 12:13:45 +0200
Message-Id: <6c7d1e3005dbec5483bdb9b7b60071175bf7bf70.1688811201.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct kobject' from 256 to 244 bytes.

This structure is often included in some other structures. So these other
structures will also benefit from this 8 bytes saving.

This is especially nice for structure like 'cma_kobject' or 'class_dir'
that are now 256 bytes long. When they are kzalloc()'ed, 256 bytes are
allocated, instead of 512.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Try to see how often this is included in another struct. Certainly not
perfect, but gives an idea.
   git grep -P \\tstruct\ kobj[^*]*$ | wc -l
   163


Using pahole

Before:
======
struct kobject {
	const char  *              name;                 /*     0     8 */
	struct list_head           entry;                /*     8    16 */
	struct kobject *           parent;               /*    24     8 */
	struct kset *              kset;                 /*    32     8 */
	const struct kobj_type  *  ktype;                /*    40     8 */
	struct kernfs_node *       sd;                   /*    48     8 */
	struct kref                kref;                 /*    56     4 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 1 boundary (64 bytes) --- */
	struct delayed_work        release;              /*    64   184 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 3 boundary (192 bytes) was 56 bytes ago --- */
	unsigned int               state_initialized:1;  /*   248: 0  4 */
	unsigned int               state_in_sysfs:1;     /*   248: 1  4 */
	unsigned int               state_add_uevent_sent:1; /*   248: 2  4 */
	unsigned int               state_remove_uevent_sent:1; /*   248: 3  4 */
	unsigned int               uevent_suppress:1;    /*   248: 4  4 */

	/* size: 256, cachelines: 4, members: 13 */
	/* sum members: 244, holes: 1, sum holes: 4 */
	/* sum bitfield members: 5 bits (0 bytes) */
	/* padding: 4 */
	/* paddings: 1, sum paddings: 4 */
	/* bit_padding: 27 bits */
};


After:
=====
struct kobject {
	const char  *              name;                 /*     0     8 */
	struct list_head           entry;                /*     8    16 */
	struct kobject *           parent;               /*    24     8 */
	struct kset *              kset;                 /*    32     8 */
	const struct kobj_type  *  ktype;                /*    40     8 */
	struct kernfs_node *       sd;                   /*    48     8 */
	struct kref                kref;                 /*    56     4 */
	unsigned int               state_initialized:1;  /*    60: 0  4 */
	unsigned int               state_in_sysfs:1;     /*    60: 1  4 */
	unsigned int               state_add_uevent_sent:1; /*    60: 2  4 */
	unsigned int               state_remove_uevent_sent:1; /*    60: 3  4 */
	unsigned int               uevent_suppress:1;    /*    60: 4  4 */

	/* XXX 27 bits hole, try to pack */

	/* --- cacheline 1 boundary (64 bytes) --- */
	struct delayed_work        release;              /*    64   184 */

	/* XXX last struct has 4 bytes of padding */

	/* size: 248, cachelines: 4, members: 13 */
	/* sum members: 244 */
	/* sum bitfield members: 5 bits, bit holes: 1, sum bit holes: 27 bits */
	/* paddings: 1, sum paddings: 4 */
	/* last cacheline: 56 bytes */
};
---
 include/linux/kobject.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c392c811d9ad..c30affcc43b4 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -69,14 +69,16 @@ struct kobject {
 	const struct kobj_type	*ktype;
 	struct kernfs_node	*sd; /* sysfs directory entry */
 	struct kref		kref;
-#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
-	struct delayed_work	release;
-#endif
+
 	unsigned int state_initialized:1;
 	unsigned int state_in_sysfs:1;
 	unsigned int state_add_uevent_sent:1;
 	unsigned int state_remove_uevent_sent:1;
 	unsigned int uevent_suppress:1;
+
+#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
+	struct delayed_work	release;
+#endif
 };
 
 __printf(2, 3) int kobject_set_name(struct kobject *kobj, const char *name, ...);
-- 
2.34.1

