Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5375F169D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiI3XYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiI3XYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:24:18 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7411715A700;
        Fri, 30 Sep 2022 16:24:12 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 63B39E0EB5;
        Fri, 30 Sep 2022 01:46:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=wuhxWCVeXVlJVS/RfP/AZNvPaB2WtIt+hlprDEaQew8=; b=tp0ozYnJRVZb
        3eOjGM6LN8TCwm25Q+QFgtbgIAcq6fonGNSvoBN/ax9zXSP9KuFKSHRRJhS6lHBY
        Hp9D7/pv0NAdDxGCXECCbCHCzU+5HbRntTZwP29CWCnCUKnIXExi1hNXj9wDXbL1
        rI4PnhJFrDkO3LC4RvuG+ywABgJbY1w=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 56706E0E6B;
        Fri, 30 Sep 2022 01:46:56 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 01:46:57 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Rafael Antognolli <Rafael.Antognolli@intel.com>,
        Scott Bauer <scott.bauer@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] block: sed-opal: Cache-line-align the cmd/resp buffers
Date:   Fri, 30 Sep 2022 01:46:48 +0300
Message-ID: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with [1] the DMA-able memory buffers must be
cacheline-aligned otherwise the cache writing-back and invalidation
performed during the mapping may cause the adjacent data being lost. It's
specifically required for the DMA-noncoherent platforms. Seeing the
opal_dev.{cmd,resp} buffers are used for DMAs in the NVME and SCSI/SD
drivers in framework of the nvme_sec_submit() and sd_sec_submit() methods
respectively we must make sure the passed buffers are cacheline-aligned to
prevent the denoted problem.

[1] Documentation/core-api/dma-api.rst

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 block/sed-opal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9700197000f2..222acbd1f03a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -73,6 +73,7 @@ struct parsed_resp {
 	struct opal_resp_tok toks[MAX_TOKS];
 };
 
+/* Presumably DMA-able buffers must be cache-aligned */
 struct opal_dev {
 	bool supported;
 	bool mbr_enabled;
@@ -88,8 +89,8 @@ struct opal_dev {
 	u64 lowest_lba;
 
 	size_t pos;
-	u8 cmd[IO_BUFFER_LENGTH];
-	u8 resp[IO_BUFFER_LENGTH];
+	u8 cmd[IO_BUFFER_LENGTH] ____cacheline_aligned;
+	u8 resp[IO_BUFFER_LENGTH] ____cacheline_aligned;
 
 	struct parsed_resp parsed;
 	size_t prev_d_len;
-- 
2.37.3


