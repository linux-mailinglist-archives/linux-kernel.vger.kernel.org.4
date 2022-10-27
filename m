Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE660FB84
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiJ0PLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbiJ0PJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C2A18F936
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48BC8623B1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7914C43141;
        Thu, 27 Oct 2022 15:09:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oo4Vd-00Bvf2-2y;
        Thu, 27 Oct 2022 11:09:29 -0400
Message-ID: <20221027150929.749620335@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:05:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [RFC][PATCH v2 24/31] timers: pcmcia: Use del_timer_shutdown() before freeing timer
References: <20221027150525.753064657@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a timer is freed, del_timer_shutdown() must be called.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Minghao Chi <chi.minghao@zte.com.cn>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Souptick Joarder
Cc: Cai Huoqing <cai.huoqing@linux.dev>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/pcmcia/bcm63xx_pcmcia.c | 2 +-
 drivers/pcmcia/electra_cf.c     | 2 +-
 drivers/pcmcia/omap_cf.c        | 2 +-
 drivers/pcmcia/pd6729.c         | 4 ++--
 drivers/pcmcia/yenta_socket.c   | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
index bb06311d0b5f..1e96fa905bb0 100644
--- a/drivers/pcmcia/bcm63xx_pcmcia.c
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -443,7 +443,7 @@ static int bcm63xx_drv_pcmcia_remove(struct platform_device *pdev)
 	struct resource *res;
 
 	skt = platform_get_drvdata(pdev);
-	del_timer_sync(&skt->timer);
+	del_timer_shutdown(&skt->timer);
 	iounmap(skt->base);
 	iounmap(skt->io_base);
 	res = skt->reg_res;
diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 40a5cffe24a4..3c9a77a4c5d5 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -317,7 +317,7 @@ static int electra_cf_remove(struct platform_device *ofdev)
 	cf->active = 0;
 	pcmcia_unregister_socket(&cf->socket);
 	free_irq(cf->irq, cf);
-	del_timer_sync(&cf->timer);
+	del_timer_shutdown(&cf->timer);
 
 	iounmap(cf->io_virt);
 	iounmap(cf->mem_base);
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index d3f827d4224a..f4c0ea073f14 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -296,7 +296,7 @@ static int __exit omap_cf_remove(struct platform_device *pdev)
 
 	cf->active = 0;
 	pcmcia_unregister_socket(&cf->socket);
-	del_timer_sync(&cf->timer);
+	del_timer_shutdown(&cf->timer);
 	release_mem_region(cf->phys_cf, SZ_8K);
 	free_irq(cf->irq, cf);
 	kfree(cf);
diff --git a/drivers/pcmcia/pd6729.c b/drivers/pcmcia/pd6729.c
index f0af9985ca09..539aeca0501c 100644
--- a/drivers/pcmcia/pd6729.c
+++ b/drivers/pcmcia/pd6729.c
@@ -727,7 +727,7 @@ static int pd6729_pci_probe(struct pci_dev *dev,
 	if (irq_mode == 1)
 		free_irq(dev->irq, socket);
 	else
-		del_timer_sync(&socket->poll_timer);
+		del_timer_shutdown(&socket->poll_timer);
 err_out_free_res:
 	pci_release_regions(dev);
 err_out_disable:
@@ -754,7 +754,7 @@ static void pd6729_pci_remove(struct pci_dev *dev)
 	if (irq_mode == 1)
 		free_irq(dev->irq, socket);
 	else
-		del_timer_sync(&socket->poll_timer);
+		del_timer_shutdown(&socket->poll_timer);
 	pci_release_regions(dev);
 	pci_disable_device(dev);
 
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 3966a6ceb1ac..8bceaf30d094 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -814,7 +814,7 @@ static void yenta_close(struct pci_dev *dev)
 	if (sock->cb_irq)
 		free_irq(sock->cb_irq, sock);
 	else
-		del_timer_sync(&sock->poll_timer);
+		del_timer_shutdown(&sock->poll_timer);
 
 	iounmap(sock->base);
 	yenta_free_resources(sock);
@@ -1285,7 +1285,7 @@ static int yenta_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (socket->cb_irq)
 		free_irq(socket->cb_irq, socket);
 	else
-		del_timer_sync(&socket->poll_timer);
+		del_timer_shutdown(&socket->poll_timer);
  unmap:
 	iounmap(socket->base);
 	yenta_free_resources(socket);
-- 
2.35.1
