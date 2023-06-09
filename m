Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0DA728F16
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjFIEp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbjFIEpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:45:54 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CE630EC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:45:53 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 7U0KqPBjCDGHG7U0Wq4YHb; Fri, 09 Jun 2023 06:45:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686285952;
        bh=PEZXQDap3pTmCCLCcgCzrjYNlvmhAuSx1kWCIhd8mYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MNXndMF/jixUheplVtvmjAeKNdqfUNPyGiPl/BQL6RB8FmYTuDSD0XJmujKY+yCAI
         K8mm0h/Hajyw1zqBxN2m49rlL2K7GdkZHpirX8vjjktGce6QqrHJ2urq8Kbw1oFoI9
         d2BG20yCDVqYhP+vEZa1utxMtwu9T7VINxnej2aA2xyqPiIjc0Df7W0qYLbgw211M0
         6SmE2i5hucStjfdLlyJN2J+2o2udu9+UeBaAQOD3JcgLWLUWXt8cnfb29x4oS3XqIs
         cqUPy0HgV5AHSz+16w13cITmb50wgy8gu8KfTMBW3Reosssbtncwh9BThkQOggKGQi
         38sMb7mq0Pp+w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 09 Jun 2023 06:45:52 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk
Date:   Fri,  9 Jun 2023 06:45:39 +0200
Message-Id: <93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the best clk is searched, we iterate over all possible clk.

If we find a better match, the previous one, if any, needs to be freed.
If a better match has already been found, we still need to free the new
one, otherwise it leaks.

Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative. Review with care.

I think that some clk_put() are also missing somewhere else in the driver
but won't be able to investigate further.
---
 drivers/tty/serial/samsung_tty.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index dd751e7010e3..c07877dd25fa 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1488,10 +1488,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			calc_deviation = -calc_deviation;
 
 		if (calc_deviation < deviation) {
+			/*
+			 * If we find a better clk, release the previous one, if
+			 * any.
+			 */
+			if (!IS_ERR(*best_clk))
+				clk_put(*best_clk);
 			*best_clk = clk;
 			best_quot = quot;
 			*clk_num = cnt;
 			deviation = calc_deviation;
+		} else {
+			clk_put(clk);
 		}
 	}
 
-- 
2.34.1

