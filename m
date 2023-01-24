Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24EA67A5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjAXWdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbjAXWdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:33:33 -0500
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFCC51C50;
        Tue, 24 Jan 2023 14:33:09 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 221E3C0000ED;
        Tue, 24 Jan 2023 14:33:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 221E3C0000ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1674599589;
        bh=18Ek0713v7vE0bPalztY5hN2JappTwYnAApR8lFJahg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejj2vlPJ9RhhtsBnSABd/A1rORbBKrKgNCHAwgaBDNnhRRUQ6MUrQ8NxIaVdjQuGY
         XhWwY/US/dI3BYCuoCpIG1Na1QKAqW67PuoAsJVzsz2j18qDpVD9I1CaXtCF1+5cxJ
         aVdu/g/F61+L9iZ2TMp/C+s37EtZ/pLJrADdnBd4=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 20A2A18041CAC6;
        Tue, 24 Jan 2023 14:33:09 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 1E950101ACF; Tue, 24 Jan 2023 14:33:09 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/14] spi: spi-mem: Allow controller supporting mem_ops without exec_op
Date:   Tue, 24 Jan 2023 14:12:14 -0800
Message-Id: <20230124221218.341511-12-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230124221218.341511-1-william.zhang@broadcom.com>
References: <20230124221218.341511-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently exec_op is always required if controller driver provides
mem_ops. But some controller such as bcm63xx-hsspi may only need to
implement other operation like supports_op and use the default
execution operation. This patch removes this restriction.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

(no changes since v1)

 drivers/spi/spi-mem.c |  2 +-
 drivers/spi/spi.c     | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 0c79193d9697..701838b6f0c4 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -325,7 +325,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!spi_mem_internal_supports_op(mem, op))
 		return -ENOTSUPP;
 
-	if (ctlr->mem_ops && !mem->spi->cs_gpiod) {
+	if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !mem->spi->cs_gpiod) {
 		ret = spi_mem_access_start(mem);
 		if (ret)
 			return ret;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3cc7bb4d03de..6faa77592e93 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3051,15 +3051,14 @@ static int spi_controller_check_ops(struct spi_controller *ctlr)
 	 * The controller may implement only the high-level SPI-memory like
 	 * operations if it does not support regular SPI transfers, and this is
 	 * valid use case.
-	 * If ->mem_ops is NULL, we request that at least one of the
-	 * ->transfer_xxx() method be implemented.
+	 * If ->mem_ops or ->mem_ops->exec_op is NULL, we request that at least
+	 * one of the ->transfer_xxx() method be implemented.
 	 */
-	if (ctlr->mem_ops) {
-		if (!ctlr->mem_ops->exec_op)
-			return -EINVAL;
-	} else if (!ctlr->transfer && !ctlr->transfer_one &&
+	if (!ctlr->mem_ops || (ctlr->mem_ops && !ctlr->mem_ops->exec_op)) {
+		if (!ctlr->transfer && !ctlr->transfer_one &&
 		   !ctlr->transfer_one_message) {
-		return -EINVAL;
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.37.3

