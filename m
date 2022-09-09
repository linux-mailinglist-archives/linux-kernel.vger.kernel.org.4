Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74F5B3F5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiIITTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiIITTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:19:42 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75D0D2A42B;
        Fri,  9 Sep 2022 12:19:40 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 3D9A2DBB;
        Fri,  9 Sep 2022 22:23:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 3D9A2DBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662751391;
        bh=k04JpT/Stk+B/Zc/3fGfPQL4s7cQC+RHy2d6ex7akDU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=O4gzvBhHAEGnSNm1f2kkZ6UEROqGLedhiAQeKD2i2IPo4oHcWkAVshH5GltVljce7
         PudFDDrmSGjqMFYD5fBijw38Upb/+TrRtwNPdD3nUpAlpRee9joZr4YINs3kF+CCCd
         YSIPFPKpAb7az2+yxffnEs0ilQlNlpMIxlPTfu5g=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Sep 2022 22:19:21 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Rafael Antognolli <Rafael.Antognolli@intel.com>,
        Scott Bauer <scott.bauer@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] block: sed-opal: Cache-line-align the cmd/resp buffers
Date:   Fri, 9 Sep 2022 22:19:16 +0300
Message-ID: <20220909191916.16013-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.37.2

