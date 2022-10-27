Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93FF60F1DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiJ0IIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJ0IIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:08:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FCC16A4F6;
        Thu, 27 Oct 2022 01:08:42 -0700 (PDT)
Date:   Thu, 27 Oct 2022 10:08:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666858120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MfKIFyyU67Gj1IrfueNH2q1KXlvNeXvyAhLCvopQQRs=;
        b=P6G0RUvRGyqzHesIpk219I5l2aLhAUcO38zwo4ukJ7BB+PbtWATOwr4G+cChpNtWWsAlKq
        7QIgcYSQ5dWKjO+KRk8mZ/34BODGIncTtvi+95jP/lZ5IlcwjhD3n5eep1OY5hu3iDqglj
        O4q5Md9r6wVwoOxDi6ehkI9EDH9Ke7E+ph97ZR5fhHmLqkRw4pQV1ieJuW4xE1nIeAsl1w
        iXdiRAbLo7UQx2FMN9/5JxvRlw6PVuM3OjA/61FSv7Sc1QyrHbDXBqNiU1NbuCk/5Agc5k
        LozElx6z7VIQ1gK7QzUSvzkp7XVFdt6ImPbJ7pzeo5AswkypWNFmSOa1a6i5Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666858120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MfKIFyyU67Gj1IrfueNH2q1KXlvNeXvyAhLCvopQQRs=;
        b=Tjkz3bmtBLroc2rSNqFa65aC7N3x4AjfJLGZaPdmv6O732F+MN9t2e9ixnGLfv6YXR0w0O
        zMJmAzusGTFJvgAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.0.5-rt14
Message-ID: <Y1o8hqwQKDpOTkNr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.0.5-rt14 patch set. 

Changes since v6.0.5-rt13:

  - Replace deprecated API in the Xilinx AXI Ethernet driver so that it
    compiles again. Reported by David Runge.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v6.0.5-rt13 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/incr/patch-6.0.5-rt13-rt14.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.0.5-rt14

The RT patch against v6.0.5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patch-6.0.5-rt14.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patches-6.0.5-rt14.tar.xz

Sebastian

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9262988d26a32..2c233b59e7d93 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1305,16 +1305,16 @@ axienet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	netdev_stats_to_stats64(stats, &dev->stats);
 
 	do {
-		start = u64_stats_fetch_begin_irq(&lp->rx_stat_sync);
+		start = u64_stats_fetch_begin(&lp->rx_stat_sync);
 		stats->rx_packets = u64_stats_read(&lp->rx_packets);
 		stats->rx_bytes = u64_stats_read(&lp->rx_bytes);
-	} while (u64_stats_fetch_retry_irq(&lp->rx_stat_sync, start));
+	} while (u64_stats_fetch_retry(&lp->rx_stat_sync, start));
 
 	do {
-		start = u64_stats_fetch_begin_irq(&lp->tx_stat_sync);
+		start = u64_stats_fetch_begin(&lp->tx_stat_sync);
 		stats->tx_packets = u64_stats_read(&lp->tx_packets);
 		stats->tx_bytes = u64_stats_read(&lp->tx_bytes);
-	} while (u64_stats_fetch_retry_irq(&lp->tx_stat_sync, start));
+	} while (u64_stats_fetch_retry(&lp->tx_stat_sync, start));
 }
 
 static const struct net_device_ops axienet_netdev_ops = {
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb18..08b3e75841adc 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14
