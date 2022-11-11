Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D12625FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiKKQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiKKQk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:40:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A5061BA1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:40:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA2176205E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 16:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D15BC433D6;
        Fri, 11 Nov 2022 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668184826;
        bh=T+/dE65GaUmXRopapuVAGdXHeGWYexFvnU1S9HJYdgU=;
        h=From:To:Cc:Subject:Date:From;
        b=q5VD19RBLIE0Dl4VZ5MJt/arDRok1DPp/7l+obdroYnEh96Zd4QzWuixEvDWq1CtU
         ipPwopyOGquhC/3iDqCmypNa06VNC3bkovZRI9s5+UxyM9x5hPEL2nJZcN8qnwtRR5
         gFp84Ng2Z0tQaXFAWxmgtqb7WEiR1oS9q0JaNgo/OoSBdIaxrJpJDS+X7STnbV8hwI
         6SHk3uiH6qV4eC9l7k5mwOkJUKNTVsf1MCaE8rsvwOWJWdTOnBeloBiH5UyNKEZ9rz
         grtfmAmsumg2bG72G8uaABzDigHL3EhKMoVGh4AjlMn9AtGT9ZPTMXhQyT1qpDJPZD
         op70qqFjhZieA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-mtd@lists.infradead.org
Cc:     dinguyen@kernel.org, tudor.ambarus@microchip.com,
        pratyush@kernel.org, michael@walle.cc,
        linux-kernel@vger.kernel.org,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Subject: [PATCHv2] mtd: spi-nor: macronix: Add support for mx66u1g45g
Date:   Fri, 11 Nov 2022 10:40:14 -0600
Message-Id: <20221111164015.165581-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MX66U1G45G is the smaller sibling (128MB) of the MX66U2G45G (256MB)
that is already supported.

Tested on Intel N5X socdk board,
  - random data write, erase, read   - verified erase operations
  - random data write, read and compare  - verified write/read operations

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: fixed compile error by removing , after PARSE_SFDP
---
 drivers/mtd/spi-nor/macronix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index d81a4cb2812b..07ace9da74b7 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -97,6 +97,10 @@ static const struct flash_info macronix_nor_parts[] = {
 			      SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
+	{ "mx66u1g45g",  INFO(0xc2253b, 0, 64 * 1024, 2048)
+		PARSE_SFDP
+		FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-- 
2.25.1

