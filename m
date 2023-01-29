Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571746800C0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjA2SXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjA2SXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:23:40 -0500
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7021B1C311
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 10:23:37 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id MCKlpGwDQMaRbMCL1pnjjv; Sun, 29 Jan 2023 19:23:35 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Jan 2023 19:23:35 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, peterz@infradead.org, pmladek@suse.com,
        john.ogness@linutronix.de, baolu.lu@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] usb: early: xhci-dbc: Optimize early_xdbc_write()
Date:   Sun, 29 Jan 2023 19:23:09 +0100
Message-Id: <687bbcd940c59fbddd0e3a8b578fd3422962e50f.1675016180.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1675016180.git.christophe.jaillet@wanadoo.fr>
References: <cover.1675016180.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in zeroing 'buf'.
It would be cleared only once, and if the 'while' loop is executed several
times, all but the first run would have a 'dirty' buffer.
Moreover, the size of the chunk is computed in the loop and this size is
passed to xdbc_bulk_write().

So remove this useless memset().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Untested.
---
 drivers/usb/early/xhci-dbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index f3e23be227d4..965a24e47c0f 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -881,7 +881,7 @@ static void early_xdbc_write(struct console *con, const char *str, u32 n)
 
 	if (!xdbc.xdbc_reg)
 		return;
-	memset(buf, 0, XDBC_MAX_PACKET);
+
 	while (n > 0) {
 		for (chunk = 0; chunk < XDBC_MAX_PACKET && n > 0; str++, chunk++, n--) {
 
-- 
2.34.1

