Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA095687FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjBBOMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjBBOMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:12:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC5C8F25B;
        Thu,  2 Feb 2023 06:12:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A7A61B6F;
        Thu,  2 Feb 2023 14:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8A0C433EF;
        Thu,  2 Feb 2023 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675347148;
        bh=CKWzMGXU0WqJTApZJUD8QlCgcpBKwEoffsnd8sluork=;
        h=From:To:Cc:Subject:Date:From;
        b=nrkehhi/oELFgt26QD6zVBIoMjtIVlbv6FpkZaMLEiWYLbkmR5ft1RFPhTwXr2c6t
         PVvsBptp8Qaw3KbC7EhdhZ19uSPLr2P/w8XhHlBc1fywrkha8gjR0g8ywcZIVX1U2T
         vf7S4ubu6zFHqwBR7ERhEchVnKlZ4JR1QvSiZ4A0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: pcn_uart: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 15:12:21 +0100
Message-Id: <20230202141221.2293012-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=gregkh@linuxfoundation.org; h=from:subject; bh=CKWzMGXU0WqJTApZJUD8QlCgcpBKwEoffsnd8sluork=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3jxydnnBQ4N4Cdb2ui869guouaaZhfzS3Xq7xuPZR9PQ6 gxfsHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARuWsMC6ZyFT70nLuvod+Sq7ZEdS tj7MvQUoZ51ucKz155Gn8lrf/0m071OxmnpnVvAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/pch_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 9576ba8bbc40..cc83b772b7ca 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1775,7 +1775,7 @@ static void pch_uart_exit_port(struct eg20t_port *priv)
 	char name[32];
 
 	snprintf(name, sizeof(name), "uart%d_regs", priv->port.line);
-	debugfs_remove(debugfs_lookup(name, NULL));
+	debugfs_lookup_and_remove(name, NULL);
 	uart_remove_one_port(&pch_uart_driver, &priv->port);
 	free_page((unsigned long)priv->rxbuf.buf);
 }
-- 
2.39.1

