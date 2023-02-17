Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CA769AB10
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBQMKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBQMKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:10:52 -0500
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9546D64B33
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:10:50 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id SzZgpJS69fKYFSzZgpVsgJ; Fri, 17 Feb 2023 13:10:48 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 17 Feb 2023 13:10:48 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: EC: Reorder fields in 'struct acpi_ec'
Date:   Fri, 17 Feb 2023 13:10:46 +0100
Message-Id: <334a5e2d8c9a05ce7cbac126bfbc6b39d05e1c9c.1676635829.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct acpi_ec'
from 520 to 512 bytes.

This size is much better when the struct is kmalloc()'ed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct acpi_ec {
	acpi_handle                handle;               /*     0     8 */
	acpi_handle                address_space_handler_holder; /*     8     8 */
	int                        gpe;                  /*    16     4 */
	int                        irq;                  /*    20     4 */
	long unsigned int          command_addr;         /*    24     8 */
	long unsigned int          data_addr;            /*    32     8 */
	bool                       global_lock;          /*    40     1 */

	/* XXX 7 bytes hole, try to pack */

	long unsigned int          flags;                /*    48     8 */
	long unsigned int          reference_count;      /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct mutex               mutex;                /*    64   160 */
	/* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
	wait_queue_head_t          wait;                 /*   224    88 */
	/* --- cacheline 4 boundary (256 bytes) was 56 bytes ago --- */
	struct list_head           list;                 /*   312    16 */
	/* --- cacheline 5 boundary (320 bytes) was 8 bytes ago --- */
	struct transaction *       curr;                 /*   328     8 */
	spinlock_t                 lock;                 /*   336    72 */
	/* --- cacheline 6 boundary (384 bytes) was 24 bytes ago --- */
	struct work_struct         work;                 /*   408    80 */
	/* --- cacheline 7 boundary (448 bytes) was 40 bytes ago --- */
	long unsigned int          timestamp;            /*   488     8 */
	enum acpi_ec_event_state   event_state;          /*   496     4 */
	unsigned int               events_to_process;    /*   500     4 */
	unsigned int               events_in_progress;   /*   504     4 */
	unsigned int               queries_in_progress;  /*   508     4 */
	/* --- cacheline 8 boundary (512 bytes) --- */
	bool                       busy_polling;         /*   512     1 */

	/* XXX 3 bytes hole, try to pack */

	unsigned int               polling_guard;        /*   516     4 */

	/* size: 520, cachelines: 9, members: 22 */
	/* sum members: 510, holes: 2, sum holes: 10 */
	/* last cacheline: 8 bytes */
};


After:
=====
struct acpi_ec {
	acpi_handle                handle;               /*     0     8 */
	acpi_handle                address_space_handler_holder; /*     8     8 */
	int                        gpe;                  /*    16     4 */
	int                        irq;                  /*    20     4 */
	long unsigned int          command_addr;         /*    24     8 */
	long unsigned int          data_addr;            /*    32     8 */
	bool                       global_lock;          /*    40     1 */
	bool                       busy_polling;         /*    41     1 */

	/* XXX 2 bytes hole, try to pack */

	unsigned int               polling_guard;        /*    44     4 */
	long unsigned int          flags;                /*    48     8 */
	long unsigned int          reference_count;      /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct mutex               mutex;                /*    64   160 */
	/* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
	wait_queue_head_t          wait;                 /*   224    88 */
	/* --- cacheline 4 boundary (256 bytes) was 56 bytes ago --- */
	struct list_head           list;                 /*   312    16 */
	/* --- cacheline 5 boundary (320 bytes) was 8 bytes ago --- */
	struct transaction *       curr;                 /*   328     8 */
	spinlock_t                 lock;                 /*   336    72 */
	/* --- cacheline 6 boundary (384 bytes) was 24 bytes ago --- */
	struct work_struct         work;                 /*   408    80 */
	/* --- cacheline 7 boundary (448 bytes) was 40 bytes ago --- */
	long unsigned int          timestamp;            /*   488     8 */
	enum acpi_ec_event_state   event_state;          /*   496     4 */
	unsigned int               events_to_process;    /*   500     4 */
	unsigned int               events_in_progress;   /*   504     4 */
	unsigned int               queries_in_progress;  /*   508     4 */

	/* size: 512, cachelines: 8, members: 22 */
	/* sum members: 510, holes: 1, sum holes: 2 */
};
---
 drivers/acpi/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 06ad497067ac..acfdd23c8dec 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -179,6 +179,8 @@ struct acpi_ec {
 	unsigned long command_addr;
 	unsigned long data_addr;
 	bool global_lock;
+	bool busy_polling;
+	unsigned int polling_guard;
 	unsigned long flags;
 	unsigned long reference_count;
 	struct mutex mutex;
@@ -192,8 +194,6 @@ struct acpi_ec {
 	unsigned int events_to_process;
 	unsigned int events_in_progress;
 	unsigned int queries_in_progress;
-	bool busy_polling;
-	unsigned int polling_guard;
 };
 
 extern struct acpi_ec *first_ec;
-- 
2.34.1

