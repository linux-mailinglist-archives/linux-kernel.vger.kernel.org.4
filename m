Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB0B695DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjBNI73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjBNI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:59:25 -0500
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736CC23131
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:59:05 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Rr9TpP4Ql5qOuRr9TpVthu; Tue, 14 Feb 2023 09:59:04 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Feb 2023 09:59:04 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mfd: core: Reorder fields in 'struct mfd_cell' to save some memory
Date:   Tue, 14 Feb 2023 09:58:59 +0100
Message-Id: <bb631974888dfe1af593b6280cf30fb913d2d1a4.1676365116.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size from 144 to 128 bytes.

As an example:

$ size drivers/mfd/as3722.o (Before)
   text	   data	    bss	    dec	    hex	filename
   9441	    680	     16	  10137	   2799	drivers/mfd/as3722.o

$ size drivers/mfd/as3722.o (After)
   text	   data	    bss	    dec	    hex	filename
   9345	    680	     16	  10041	   2739	drivers/mfd/as3722.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct mfd_cell {
	const char  *              name;                 /*     0     8 */
	int                        id;                   /*     8     4 */
	int                        level;                /*    12     4 */
	int                        (*enable)(struct platform_device *); /*    16     8 */
	int                        (*disable)(struct platform_device *); /*    24     8 */
	int                        (*suspend)(struct platform_device *); /*    32     8 */
	int                        (*resume)(struct platform_device *); /*    40     8 */
	void *                     platform_data;        /*    48     8 */
	size_t                     pdata_size;           /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	const struct software_node  * swnode;            /*    64     8 */
	const char  *              of_compatible;        /*    72     8 */
	const u64                  of_reg;               /*    80     8 */
	bool                       use_of_reg;           /*    88     1 */

	/* XXX 7 bytes hole, try to pack */

	const struct mfd_cell_acpi_match  * acpi_match;  /*    96     8 */
	int                        num_resources;        /*   104     4 */

	/* XXX 4 bytes hole, try to pack */

	const struct resource  *   resources;            /*   112     8 */
	bool                       ignore_resource_conflicts; /*   120     1 */
	bool                       pm_runtime_no_callbacks; /*   121     1 */

	/* XXX 6 bytes hole, try to pack */

	/* --- cacheline 2 boundary (128 bytes) --- */
	const char  * const *      parent_supplies;      /*   128     8 */
	int                        num_parent_supplies;  /*   136     4 */

	/* size: 144, cachelines: 3, members: 20 */
	/* sum members: 123, holes: 3, sum holes: 17 */
	/* padding: 4 */
	/* last cacheline: 16 bytes */
};


After:
=====
struct mfd_cell {
	const char  *              name;                 /*     0     8 */
	int                        id;                   /*     8     4 */
	int                        level;                /*    12     4 */
	int                        (*enable)(struct platform_device *); /*    16     8 */
	int                        (*disable)(struct platform_device *); /*    24     8 */
	int                        (*suspend)(struct platform_device *); /*    32     8 */
	int                        (*resume)(struct platform_device *); /*    40     8 */
	void *                     platform_data;        /*    48     8 */
	size_t                     pdata_size;           /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	const struct mfd_cell_acpi_match  * acpi_match;  /*    64     8 */
	const struct software_node  * swnode;            /*    72     8 */
	const char  *              of_compatible;        /*    80     8 */
	const u64                  of_reg;               /*    88     8 */
	bool                       use_of_reg;           /*    96     1 */

	/* XXX 3 bytes hole, try to pack */

	int                        num_resources;        /*   100     4 */
	const struct resource  *   resources;            /*   104     8 */
	bool                       ignore_resource_conflicts; /*   112     1 */
	bool                       pm_runtime_no_callbacks; /*   113     1 */

	/* XXX 2 bytes hole, try to pack */

	int                        num_parent_supplies;  /*   116     4 */
	const char  * const *      parent_supplies;      /*   120     8 */

	/* size: 128, cachelines: 2, members: 20 */
	/* sum members: 123, holes: 2, sum holes: 5 */
};
---
 include/linux/mfd/core.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 14ca7b471576..fc4a0e9fb3bb 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -78,6 +78,9 @@ struct mfd_cell {
 	void			*platform_data;
 	size_t			pdata_size;
 
+	/* Matches ACPI */
+	const struct mfd_cell_acpi_match	*acpi_match;
+
 	/* Software node for the device. */
 	const struct software_node *swnode;
 
@@ -97,9 +100,6 @@ struct mfd_cell {
 	/* Set to 'true' to use 'of_reg' (above) - allows for of_reg=0 */
 	bool use_of_reg;
 
-	/* Matches ACPI */
-	const struct mfd_cell_acpi_match	*acpi_match;
-
 	/*
 	 * These resources can be specified relative to the parent device.
 	 * For accessing hardware you should use resources from the platform dev
@@ -119,8 +119,8 @@ struct mfd_cell {
 	/* A list of regulator supplies that should be mapped to the MFD
 	 * device rather than the child device when requested
 	 */
-	const char * const	*parent_supplies;
 	int			num_parent_supplies;
+	const char * const	*parent_supplies;
 };
 
 /*
-- 
2.34.1

