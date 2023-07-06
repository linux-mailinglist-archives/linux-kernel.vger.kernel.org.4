Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BDB74A3EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjGFSvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGFSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:51:10 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA75B2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=rI+8S7w+5wae4yvhZ4wNULs/xtvCq38AsDvZDV1s+XA=; b=R
        69MOA17vuBfB1Penjn6uVmOGkl7d8gMlbQlfxbeXLHuT6j5rTfCGiksUJxFZu5vgHUCtyhB6fIT5p
        sXhGLR+vvpiqKmjLEPcXyNUGz5KrX8NOHzBhUUqzrx6eGO+EuD+9YwIgJ+BAy/Q0I8ExLHVdP5iHS
        scK0kkBM8tzJk26M=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:39080 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qHU4E-0002oN-Iu; Thu, 06 Jul 2023 14:51:03 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Date:   Thu,  6 Jul 2023 14:50:59 -0400
Message-Id: <20230706185100.84322-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] auxdisplay: hd44780: move cursor home after clear display command
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The "clear display" command on the NewHaven NHD-0220DZW-AG5 display
does NOT change the DDRAM address to 00h (home position) like the
standard Hitachi HD44780 controller. As a consequence, the starting
position of the initial string LCD_INIT_TEXT is not guaranteed to be
at 0,0 depending on where the cursor was before the clear display
command.

Extract of CLEAR_DISPLAY command from datasheets of:

    Hitachi HD44780:
        ... It then sets DDRAM address 0 into the address counter...

    NewHaven NHD-0220DZW-AG5 datasheet:
	... This instruction does not change the DDRAM Address

Move the cursor home after sending clear display command to support
non-standard LCDs.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/auxdisplay/hd44780_common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 3934c2eebf33..70c818945a74 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -82,7 +82,13 @@ int hd44780_common_clear_display(struct charlcd *lcd)
 	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
 	/* datasheet says to wait 1,64 milliseconds */
 	long_sleep(2);
-	return 0;
+
+	/*
+	 * Some LCDs (ex: NewHaven) do not reset the DDRAM address when
+	 * executing the CLEAR_DISPLAY command. Explicitely move cursor
+	 * to home position to account for these non-standard LCDs:
+	 */
+	return hd44780_common_home(lcd);
 }
 EXPORT_SYMBOL_GPL(hd44780_common_clear_display);
 

base-commit: c17414a273b81fe4e34e11d69fc30cc8b1431614
-- 
2.30.2

