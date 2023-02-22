Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7669F146
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjBVJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjBVJWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:22:06 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B75E23800B;
        Wed, 22 Feb 2023 01:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DeQ/6
        Wg6lCPjtMRr4pxv9XxI1Hel4asFkhrnEA7ev8o=; b=WTcqOP1keISfPABnywlkF
        cNZFX67faoKmnJRzrwb0YYRDHV78MJ6uoMoEJbkjeByeEQpdoFCYhEamCMCQhfmc
        XiEUFQ/h0ntSVrskfqu9pPQ/RipQCZ16/8ZQgtYa0VP8e6+zxpjYmNjEVRuu0GtA
        Lq3/DsxH9mjRb6VlpLZhhQ=
Received: from localhost.localdomain (unknown [113.105.127.219])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wAH3Cmn3vVjDYgBAw--.40923S2;
        Wed, 22 Feb 2023 17:21:43 +0800 (CST)
From:   Hongbin Ji <jhb_ee@163.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongbin Ji <jhb_ee@163.com>
Subject: [PATCH] spi: cadence-quadspi: Fix cancel the indirect read mask
Date:   Wed, 22 Feb 2023 17:21:28 +0800
Message-Id: <20230222092128.4237-1-jhb_ee@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAH3Cmn3vVjDYgBAw--.40923S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWfArW3trWUXr4rZrW5Jrb_yoW3uwcEkF
        n7GF12qFsxKr4a93Wayr15ZFn2qFWUZ3W8uF1qq3W5ArZrZry7ZrZav398GrWUAw47CF13
        uF1xX3yvyr13tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtq2NJUUUUU==
X-Originating-IP: [113.105.127.219]
X-CM-SenderInfo: 5mkesvrh6rljoofrz/1tbiRQgefGDuywgB+AAAsb
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to cancel the indirect read transfer process,
so should be use CQSPI_REG_INDIRECTRD_CANCEL_MASK

Signed-off-by: Hongbin Ji <jhb_ee@163.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 676313e1bdad..967cb8ec0eec 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -766,7 +766,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
 	/* Cancel the indirect read */
-	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
+	writel(CQSPI_REG_INDIRECTRD_CANCEL_MASK,
 	       reg_base + CQSPI_REG_INDIRECTRD);
 	return ret;
 }
-- 
2.34.1

