Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FDE6F0CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbjD0Tr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343617AbjD0Trz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:47:55 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D912712
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:47:51 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id s7akpPtNdcXjrs7akpwwwP; Thu, 27 Apr 2023 21:47:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682624869;
        bh=uWyb1m5f2X+6JFDK/HL+2kWjKi4n1QTlW4WSNRqI008=;
        h=From:To:Cc:Subject:Date;
        b=qmgSftFaXDoIy7rJcvHk/NEwLPV7x7AwfqnZ4JDXCWvDFcI22zViC8G4u9voe2XMC
         DmrhpMpkwIMvZcqbj+VAdoGWSgG13yFpXKrVrIS14WHb2441bwb02mOodFEqX8cGWc
         TOtKBD3dzDN+X376TuGZhEV4bZCpkXruag3avFeyR4gOkQO2xfv1+xlFePN6HyKJwU
         g5FGI5/rFQC7aNnZFU+LUaG8jp21KDjWm4HlxaBemF1f/hndmMLRkQoX/kxwqUK+IF
         FhBLn9/Ahkn/0NAVTUeKRoaa2jCBbgRrPnA+6nIM4VZ8IuepiSTOjO617jyHPvPSGU
         kTgZrEc9glp7Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 27 Apr 2023 21:47:49 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Date:   Thu, 27 Apr 2023 21:47:45 +0200
Message-Id: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce holes.
On x86_64, this shrinks the size of 'struct nvmet_ns' from 520 to 512
bytes.

When such a structure is allocated in nvmet_ns_alloc(), because of the way
memory allocation works, when 520 bytes were requested, 1024 bytes were
allocated.

So, on x86_64, this change saves 512 bytes per allocation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
More aggressive grouping could be done to be more future proof, but the
way the struct nvmet_ns is written suggest that some fields should be
kept together. So keep grouping as-is.


Using pahole

Before:
======
struct nvmet_ns {
	struct percpu_ref          ref;                  /*     0    16 */
	struct block_device *      bdev;                 /*    16     8 */
	struct file *              file;                 /*    24     8 */
	bool                       readonly;             /*    32     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        nsid;                 /*    36     4 */
	u32                        blksize_shift;        /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	loff_t                     size;                 /*    48     8 */
	u8                         nguid[16];            /*    56    16 */
	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
	uuid_t                     uuid;                 /*    72    16 */
	u32                        anagrpid;             /*    88     4 */
	bool                       buffered_io;          /*    92     1 */
	bool                       enabled;              /*    93     1 */

	/* XXX 2 bytes hole, try to pack */

	struct nvmet_subsys *      subsys;               /*    96     8 */
	const char  *              device_path;          /*   104     8 */
	struct config_group        device_group;         /*   112   136 */
	/* --- cacheline 3 boundary (192 bytes) was 56 bytes ago --- */
	struct config_group        group;                /*   248   136 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	struct completion          disable_done;         /*   384    96 */
	/* --- cacheline 7 boundary (448 bytes) was 32 bytes ago --- */
	mempool_t *                bvec_pool;            /*   480     8 */
	int                        use_p2pmem;           /*   488     4 */

	/* XXX 4 bytes hole, try to pack */

	struct pci_dev *           p2p_dev;              /*   496     8 */
	int                        pi_type;              /*   504     4 */
	int                        metadata_size;        /*   508     4 */
	/* --- cacheline 8 boundary (512 bytes) --- */
	u8                         csi;                  /*   512     1 */

	/* size: 520, cachelines: 9, members: 23 */
	/* sum members: 500, holes: 4, sum holes: 13 */
	/* padding: 7 */
	/* last cacheline: 8 bytes */
};

After:
=====
struct nvmet_ns {
	struct percpu_ref          ref;                  /*     0    16 */
	struct block_device *      bdev;                 /*    16     8 */
	struct file *              file;                 /*    24     8 */
	bool                       readonly;             /*    32     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        nsid;                 /*    36     4 */
	u32                        blksize_shift;        /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	loff_t                     size;                 /*    48     8 */
	u8                         nguid[16];            /*    56    16 */
	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
	uuid_t                     uuid;                 /*    72    16 */
	u32                        anagrpid;             /*    88     4 */
	bool                       buffered_io;          /*    92     1 */
	bool                       enabled;              /*    93     1 */

	/* XXX 2 bytes hole, try to pack */

	struct nvmet_subsys *      subsys;               /*    96     8 */
	const char  *              device_path;          /*   104     8 */
	struct config_group        device_group;         /*   112   136 */
	/* --- cacheline 3 boundary (192 bytes) was 56 bytes ago --- */
	struct config_group        group;                /*   248   136 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	struct completion          disable_done;         /*   384    96 */
	/* --- cacheline 7 boundary (448 bytes) was 32 bytes ago --- */
	mempool_t *                bvec_pool;            /*   480     8 */
	struct pci_dev *           p2p_dev;              /*   488     8 */
	int                        use_p2pmem;           /*   496     4 */
	int                        pi_type;              /*   500     4 */
	int                        metadata_size;        /*   504     4 */
	u8                         csi;                  /*   508     1 */

	/* size: 512, cachelines: 8, members: 23 */
	/* sum members: 500, holes: 3, sum holes: 9 */
	/* padding: 3 */
};
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dc60a22646f7..c50146085fb5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -79,8 +79,8 @@ struct nvmet_ns {
 	struct completion	disable_done;
 	mempool_t		*bvec_pool;
 
-	int			use_p2pmem;
 	struct pci_dev		*p2p_dev;
+	int			use_p2pmem;
 	int			pi_type;
 	int			metadata_size;
 	u8			csi;
-- 
2.34.1

