Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A982F750154
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGLIXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjGLIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:22:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D77421A;
        Wed, 12 Jul 2023 01:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BCA0615C3;
        Wed, 12 Jul 2023 08:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF87FC433C9;
        Wed, 12 Jul 2023 08:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689149909;
        bh=ScFNHJKoC6BpXI9oEWAZOHBoeKXX3SlhqkfMHYY9sAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HU4sclBY8YX9MdgHWS+CmlcQRJIHcji3LEX03h/DyMxFrJ9TdFqMRsBwZlfDJmVTD
         GrEWD2NpRhBa5u0wCQNeD2wHl2k6kNrY9oCUWabqufOX0bRCw+1VO1Jb8R3hTUXyQl
         M7MZcJERe703a/S7ZeWSmhFVVDfyuhE9fn9Ss8MmKbSBS0vJDqQYEVHqTRcrLHK9Xx
         ZKatHwqRQquQtWZDyAf0ZXdpfpAQIKYMnE0g9l9EN3f4MA8rO3bkQrEvdkwox41TGv
         DvpMlve2SOB10b2/Nvk48Vj6sLZwEZsOQd6ZGICUOcHFDv+dL3ANN+3dmgDM/zq3RK
         +TmBueQoiqV/w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/10] serial: make uart_insert_char() accept u8s
Date:   Wed, 12 Jul 2023 10:18:07 +0200
Message-ID: <20230712081811.29004-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712081811.29004-1-jirislaby@kernel.org>
References: <20230712081811.29004-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the character and flag are 8-bit values. So switch from unsigned
ints to u8s. The drivers will be cleaned up in the next round.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 2 +-
 include/linux/serial_core.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7e37db9adbd4..bef507cb804c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3486,7 +3486,7 @@ EXPORT_SYMBOL_GPL(uart_handle_cts_change);
  * @flag: flag for the character (see TTY_NORMAL and friends)
  */
 void uart_insert_char(struct uart_port *port, unsigned int status,
-		 unsigned int overrun, unsigned int ch, unsigned int flag)
+		      unsigned int overrun, u8 ch, u8 flag)
 {
 	struct tty_port *tport = &port->state->port;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 14dd85ee849e..105d2cdc0126 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -903,7 +903,7 @@ void uart_handle_dcd_change(struct uart_port *uport, bool active);
 void uart_handle_cts_change(struct uart_port *uport, bool active);
 
 void uart_insert_char(struct uart_port *port, unsigned int status,
-		      unsigned int overrun, unsigned int ch, unsigned int flag);
+		      unsigned int overrun, u8 ch, u8 flag);
 
 void uart_xchar_out(struct uart_port *uport, int offset);
 
-- 
2.41.0

