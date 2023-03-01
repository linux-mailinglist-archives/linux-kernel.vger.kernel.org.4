Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2904A6A75B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCAU7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCAU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:58:59 -0500
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9344E5C7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:58:56 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id XTXKp7HLjYdrCXTXKp7FeZ; Wed, 01 Mar 2023 21:58:55 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Mar 2023 21:58:55 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: Reorder fields in 'struct spi_message'
Date:   Wed,  1 Mar 2023 21:58:52 +0100
Message-Id: <c112aad16eb47808e1ec10abd87b3d273c969a68.1677704283.git.christophe.jaillet@wanadoo.fr>
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
On x86_64, this shrinks the size from 112 to 96 bytes.

This should have no real impact on memory allocation because 'struct
spi_message' is mostly used on stack, but it can save a few cycles
when the structure is initialized with spi_message_init() and co.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct spi_message {
	struct list_head           transfers;            /*     0    16 */
	struct spi_device *        spi;                  /*    16     8 */
	unsigned int               is_dma_mapped:1;      /*    24: 0  4 */

	/* XXX 31 bits hole, try to pack */
	/* XXX 4 bytes hole, try to pack */

	void                       (*complete)(void *);  /*    32     8 */
	void *                     context;              /*    40     8 */
	unsigned int               frame_length;         /*    48     4 */
	unsigned int               actual_length;        /*    52     4 */
	int                        status;               /*    56     4 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 1 boundary (64 bytes) --- */
	struct list_head           queue;                /*    64    16 */
	void *                     state;                /*    80     8 */
	struct list_head           resources;            /*    88    16 */
	bool                       prepared;             /*   104     1 */

	/* size: 112, cachelines: 2, members: 12 */
	/* sum members: 93, holes: 2, sum holes: 8 */
	/* sum bitfield members: 1 bits, bit holes: 1, sum bit holes: 31 bits */
	/* padding: 7 */
	/* last cacheline: 48 bytes */
};


After:
=====
struct spi_message {
	struct list_head           transfers;            /*     0    16 */
	struct spi_device *        spi;                  /*    16     8 */
	unsigned int               is_dma_mapped:1;      /*    24: 0  4 */

	/* XXX 7 bits hole, try to pack */
	/* Bitfield combined with next fields */

	bool                       prepared;             /*    25     1 */

	/* XXX 2 bytes hole, try to pack */

	int                        status;               /*    28     4 */
	void                       (*complete)(void *);  /*    32     8 */
	void *                     context;              /*    40     8 */
	unsigned int               frame_length;         /*    48     4 */
	unsigned int               actual_length;        /*    52     4 */
	struct list_head           queue;                /*    56    16 */
	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
	void *                     state;                /*    72     8 */
	struct list_head           resources;            /*    80    16 */

	/* size: 96, cachelines: 2, members: 12 */
	/* sum members: 93, holes: 1, sum holes: 2 */
	/* sum bitfield members: 1 bits, bit holes: 1, sum bit holes: 7 bits */
	/* last cacheline: 32 bytes */
};
---
 include/linux/spi/spi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4fa26b9a3572..bdb35a91b4bf 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1093,6 +1093,9 @@ struct spi_message {
 
 	unsigned		is_dma_mapped:1;
 
+	/* spi_prepare_message() was called for this message */
+	bool			prepared;
+
 	/* REVISIT:  we might want a flag affecting the behavior of the
 	 * last transfer ... allowing things like "read 16 bit length L"
 	 * immediately followed by "read L bytes".  Basically imposing
@@ -1105,11 +1108,11 @@ struct spi_message {
 	 */
 
 	/* Completion is reported through a callback */
+	int			status;
 	void			(*complete)(void *context);
 	void			*context;
 	unsigned		frame_length;
 	unsigned		actual_length;
-	int			status;
 
 	/* For optional use by whatever driver currently owns the
 	 * spi_message ...  between calls to spi_async and then later
@@ -1120,9 +1123,6 @@ struct spi_message {
 
 	/* List of spi_res reources when the spi message is processed */
 	struct list_head        resources;
-
-	/* spi_prepare_message() was called for this message */
-	bool			prepared;
 };
 
 static inline void spi_message_init_no_memset(struct spi_message *m)
-- 
2.34.1

