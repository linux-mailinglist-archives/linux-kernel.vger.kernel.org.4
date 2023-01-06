Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328436607A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjAFUKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjAFUKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:10:21 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvacalvio01.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4253B84084;
        Fri,  6 Jan 2023 12:10:20 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id F12ABC0000E5;
        Fri,  6 Jan 2023 12:10:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F12ABC0000E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1673035820;
        bh=KiC8m8hbRUbZZ8J7JMyhYa4Wy5NUsmvaw9AEXPtTsRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTSOz+zoi32DSZV8vKmJe7+27+ywJpVtFdRfmWW5XIdTSdmlYrYOjGC5PpkGKxY6Y
         wjRrMNJWv5IhBIfGtJcS6hKvKDCjCxYHhs0TIKjDEKLz7TA2ljI4xojmenAAdQw553
         zt0n6YZ2eG4y/bKZd6abewsX4dzR98QWY2bRKh9E=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id EF4BE18041CAC6;
        Fri,  6 Jan 2023 12:10:19 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 48D13101B33; Fri,  6 Jan 2023 12:10:13 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/16] spi: spi-mem: Allow controller supporting mem_ops without exec_op
Date:   Fri,  6 Jan 2023 12:08:05 -0800
Message-Id: <20230106200809.330769-14-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230106200809.330769-1-william.zhang@broadcom.com>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
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

