Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4723C666DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbjALJOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbjALJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:11:24 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AD4B7FC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=lWWvuOMqhkCrkQtWw3xRYcDQAaz
        uxzjPQUYCZsAk/uM=; b=lV7BS4+NowWgKAvYXrCIBRLeql7HgAzFYSXSVOTRDBI
        3nIudy4+C3902axEHVNSLzJ8137JOP2FjECpTe0j1GP+KTcwAk0moxA5Stebcq09
        CEdVKQT6Ex3PEGp3gYRN3bLwq8dr8rFKY0s21yzs0qQ51cxLvxdb1vb178/gKNQI
        =
Received: (qmail 673347 invoked from network); 12 Jan 2023 10:06:59 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jan 2023 10:06:59 +0100
X-UD-Smtp-Session: l3s3148p1@ebt8cA3yRLZehh9g
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memory: renesas-rpc-if: Remove redundant division of dummy
Date:   Thu, 12 Jan 2023 10:06:55 +0100
Message-Id: <20230112090655.43367-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Dang <cong.dang.xn@renesas.com>

The dummy cycles value was wrongly calculated if dummy.buswidth > 1,
which affects QSPI, OSPI, HyperFlash on various SoCs. We're lucky in
Single SPI case since its dummy.buswidth equals to 1, so the result of
the division is unchanged

This issue can be reproduced using something like the following commands
A. QSPI mode: Mount device with jffs2 format
    jffs2: CLEANMARKER node found at 0x00000004, not first node in block (0x00000000)

B. QSPI mode: Write data to mtd10, where mtd10 is a parition on SPI Flash
storage, defined properly in a device tree

[Correct fragment, read from SPI Flash]

  root@v3x:~# echo "hello" > /dev/mtd10
  root@v3x:~# hexdump -C -n100 /dev/mtd10
  00000000  68 65 6c 6c 6f 0a ff ff  ff ff ff ff ff ff ff ff  |hello...........|
  00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|

[Incorrect read of the same fragment: see the difference at offsets 0-3]

  root@v3x:~# echo "hello" > /dev/mtd10
  root@v3x:~# hexdump -C -n100 /dev/mtd10
  00000000  00 00 00 00 68 65 6c 6c  6f 0a ff ff ff ff ff ff  |....hello.......|
  00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|

As seen from the result, 4 NULL bytes were inserted before the test data.
Wrong calculation in rpcif_prepare() led to miss of some dummy cycle. A
division by bus width is redundant because it had been performed already
in spi-rpc-if.c::rpcif_spi_mem_prepare()

Fix this by removing the redundant division.

Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Sadly, I cannot test this patch myself because I don't have access to
hardware which uses a buswidth > 1 for the dummy read. However, from
code review, this patch makes sense. The division by buswidth is done
twice, once in the SPI driver and once in the RPC core. It should stay
only in the SPI driver.

 drivers/memory/renesas-rpc-if.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 09cd4318a83d..c36b407851ff 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -430,8 +430,7 @@ void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
 
 	if (op->dummy.buswidth) {
 		rpc->enable |= RPCIF_SMENR_DME;
-		rpc->dummy = RPCIF_SMDMCR_DMCYC(op->dummy.ncycles /
-						op->dummy.buswidth);
+		rpc->dummy = RPCIF_SMDMCR_DMCYC(op->dummy.ncycles);
 	}
 
 	if (op->option.buswidth) {
-- 
2.30.2

