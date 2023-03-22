Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205196C4066
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCVCbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjCVCbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:31:08 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CD017EC2;
        Tue, 21 Mar 2023 19:31:06 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 22 Mar 2023 11:31:05 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B07682059034;
        Wed, 22 Mar 2023 11:31:05 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Wed, 22 Mar 2023 11:31:05 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 72809B6343;
        Wed, 22 Mar 2023 11:31:05 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] spi: f_ospi: Add missing spi_mem_default_supports_op() helper
Date:   Wed, 22 Mar 2023 11:31:01 +0900
Message-Id: <20230322023101.24490-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .supports_op() callback function returns true by default after
performing driver-specific checks. Therefore the driver cannot apply
the buswidth in devicetree.

Call spi_mem_default_supports_op() helper to handle the buswidth
in devicetree.

Fixes: 1b74dd64c861 ("spi: Add Socionext F_OSPI SPI flash controller driver")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/spi/spi-sn-f-ospi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index 348c6e1edd38..87302d51be42 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -561,7 +561,7 @@ static bool f_ospi_supports_op(struct spi_mem *mem,
 	if (!f_ospi_supports_op_width(mem, op))
 		return false;
 
-	return true;
+	return spi_mem_default_supports_op(mem, op);
 }
 
 static int f_ospi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
-- 
2.25.1

