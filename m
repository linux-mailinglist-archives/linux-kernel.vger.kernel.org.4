Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EAA6F95FA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjEGAi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjEGAh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097C22D429;
        Sat,  6 May 2023 17:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2440961512;
        Sun,  7 May 2023 00:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69306C433D2;
        Sun,  7 May 2023 00:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419712;
        bh=7AVo2wkZIdyPxYpaYZ6pjetQmEMZVYzzUknTyNTa4yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JI/gbgSBlT1dFM7pb+rBbuHg2m4i+H/bQni3kJ2AQc9EezPNWrEEE7lJVW0HbhuL8
         CvE1gdKp+E1B9FvZxvLZWZVstbYzH48q3An9MNqe9Rp3LCOqFd9UjJNYL5btozxku/
         W64uy+5fDqLKmwMzGS0KFc0sUiBPtdecA2gg8y2Ojp5RB7vT7XQ6a//4X04gQg6Poi
         w+xQonY5zdDUdBStJyACTSz4ino33IW5Dm+pjl4gfZPeM/9cndRKj0N17oS+lPXihH
         3YWSxbnXvOWpNm1Oq6GlpmsHIOp+b1wZl0k1Mo9lwPsnW7tzCEPRF9GEFjInEu8FSM
         KQdvrupwJwZlw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
        pmladek@suse.com, john.ogness@linutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/19] serial: 8250: Reinit port->pm on port specific driver unbind
Date:   Sat,  6 May 2023 20:34:16 -0400
Message-Id: <20230507003417.4077259-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003417.4077259-1-sashal@kernel.org>
References: <20230507003417.4077259-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 04e82793f068d2f0ffe62fcea03d007a8cdc16a7 ]

When we unbind a serial port hardware specific 8250 driver, the generic
serial8250 driver takes over the port. After that we see an oops about 10
seconds later. This can produce the following at least on some TI SoCs:

Unhandled fault: imprecise external abort (0x1406)
Internal error: : 1406 [#1] SMP ARM

Turns out that we may still have the serial port hardware specific driver
port->pm in use, and serial8250_pm() tries to call it after the port
specific driver is gone:

serial8250_pm [8250_base] from uart_change_pm+0x54/0x8c [serial_base]
uart_change_pm [serial_base] from uart_hangup+0x154/0x198 [serial_base]
uart_hangup [serial_base] from __tty_hangup.part.0+0x328/0x37c
__tty_hangup.part.0 from disassociate_ctty+0x154/0x20c
disassociate_ctty from do_exit+0x744/0xaac
do_exit from do_group_exit+0x40/0x8c
do_group_exit from __wake_up_parent+0x0/0x1c

Let's fix the issue by calling serial8250_set_defaults() in
serial8250_unregister_port(). This will set the port back to using
the serial8250 default functions, and sets the port->pm to point to
serial8250_pm.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20230418101407.12403-1-tony@atomide.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 94fbf0add2ce2..81a5dab1a8286 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1157,6 +1157,7 @@ void serial8250_unregister_port(int line)
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
 		uart->capabilities = 0;
+		serial8250_init_port(uart);
 		serial8250_apply_quirks(uart);
 		uart_add_one_port(&serial8250_reg, &uart->port);
 	} else {
-- 
2.39.2

