Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D346F9AE1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjEGS0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjEGS0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:26:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3569D83DE;
        Sun,  7 May 2023 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rjFO1Lqn1x0xYjMf0ILF6MLtATeOnoQcHm1en6+Aq34=; b=EVEE6s760hOjO25mtyEk9/Y7Ks
        SeMR6ZOnyQwVwLTYkyPhNiqL6H5AeP6fZtRDASraitSurY4kbrqRyLAoRoU6rQsspMjshByV83eHU
        nVkZipKjQKTf16s+DHDGnirYutnV/bfIMBjcomBbCvShClgimml2PKH/uP2zelVZdzZFx6wTAAn7g
        1uKVxt2idqzIKBsyV14PCO+vyYWPs+rlvYct5fDy5HLOqiJqRbY8MCfogmSt1t3lJbJumb58auhKD
        0y2fVFY77IkxdHXFVKW2RIux48ICHX7gzJ4dUbouCFG4EErsArONNkjyWyMVBDlv2HZm/sk/UPxrX
        op9hbZuQ==;
Received: from [2601:1c2:980:9ec0:e65e:37ff:febd:ee53] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pvj5D-00GXmV-1m;
        Sun, 07 May 2023 18:26:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH] Documentation/block: drop the request.rst file
Date:   Sun,  7 May 2023 11:26:06 -0700
Message-Id: <20230507182606.12647-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/block/request.rst is outdated and should be removed.
Also delete its entry in the block/index.rst file.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index 102953166429..9fea696f9daa 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -18,7 +18,6 @@ Block
    kyber-iosched
    null_blk
    pr
-   request
    stat
    switching-sched
    writeback_cache_control
diff --git a/Documentation/block/request.rst b/Documentation/block/request.rst
deleted file mode 100644
index 747021e1ffdb..000000000000
--- a/Documentation/block/request.rst
+++ /dev/null
@@ -1,99 +0,0 @@
-============================
-struct request documentation
-============================
-
-Jens Axboe <jens.axboe@oracle.com> 27/05/02
-
-
-.. FIXME:
-   No idea about what does mean - seems just some noise, so comment it
-
-   1.0
-   Index
-
-   2.0 Struct request members classification
-
-       2.1 struct request members explanation
-
-   3.0
-
-
-   2.0
-
-
-
-Short explanation of request members
-====================================
-
-Classification flags:
-
-	=	====================
-	D	driver member
-	B	block layer member
-	I	I/O scheduler member
-	=	====================
-
-Unless an entry contains a D classification, a device driver must not access
-this member. Some members may contain D classifications, but should only be
-access through certain macros or functions (eg ->flags).
-
-<linux/blkdev.h>
-
-=============================== ======= =======================================
-Member				Flag	Comment
-=============================== ======= =======================================
-struct list_head queuelist	BI	Organization on various internal
-					queues
-
-``void *elevator_private``	I	I/O scheduler private data
-
-unsigned char cmd[16]		D	Driver can use this for setting up
-					a cdb before execution, see
-					blk_queue_prep_rq
-
-unsigned long flags		DBI	Contains info about data direction,
-					request type, etc.
-
-int rq_status			D	Request status bits
-
-kdev_t rq_dev			DBI	Target device
-
-int errors			DB	Error counts
-
-sector_t sector			DBI	Target location
-
-unsigned long hard_nr_sectors	B	Used to keep sector sane
-
-unsigned long nr_sectors	DBI	Total number of sectors in request
-
-unsigned long hard_nr_sectors	B	Used to keep nr_sectors sane
-
-unsigned short nr_phys_segments	DB	Number of physical scatter gather
-					segments in a request
-
-unsigned short nr_hw_segments	DB	Number of hardware scatter gather
-					segments in a request
-
-unsigned int current_nr_sectors	DB	Number of sectors in first segment
-					of request
-
-unsigned int hard_cur_sectors	B	Used to keep current_nr_sectors sane
-
-int tag				DB	TCQ tag, if assigned
-
-``void *special``		D	Free to be used by driver
-
-``char *buffer``		D	Map of first segment, also see
-					section on bouncing SECTION
-
-``struct completion *waiting``	D	Can be used by driver to get signalled
-					on request completion
-
-``struct bio *bio``		DBI	First bio in request
-
-``struct bio *biotail``		DBI	Last bio in request
-
-``struct request_queue *q``	DB	Request queue this request belongs to
-
-``struct request_list *rl``	B	Request list this request came from
-=============================== ======= =======================================
