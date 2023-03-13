Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD106B74F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCMK7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCMK6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:58:49 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64AD25299
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:58:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:7ed1:e2c6:b94:264a])
        by xavier.telenet-ops.be with bizsmtp
        id Xmyg2900201Vtj801mygFM; Mon, 13 Mar 2023 11:58:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbfsQ-00C3I7-GY;
        Mon, 13 Mar 2023 11:58:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbft1-008cWp-UL;
        Mon, 13 Mar 2023 11:58:39 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Min Li <min.li.xe@renesas.com>,
        Lee Jones <lee@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/6] spi: Constify spi_get_drvdata()'s spi parameter
Date:   Mon, 13 Mar 2023 11:58:36 +0100
Message-Id: <0f1700ade27a8f3935d04480ff7bef8a887331eb.1678704562.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1678704562.git.geert+renesas@glider.be>
References: <cover.1678704562.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "spi" parameter of spi_get_drvdata() can be const.
dev_get_drvdata() has been taking a const pointer since commit
7d1d8999b4bec0ba ("i2c: Constify i2c_get_clientdata's parameter").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6097d2f5126624eb..e09a61dd34594330 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -261,7 +261,7 @@ static inline void spi_set_drvdata(struct spi_device *spi, void *data)
 	dev_set_drvdata(&spi->dev, data);
 }
 
-static inline void *spi_get_drvdata(struct spi_device *spi)
+static inline void *spi_get_drvdata(const struct spi_device *spi)
 {
 	return dev_get_drvdata(&spi->dev);
 }
-- 
2.34.1

