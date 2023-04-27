Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531046F0488
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbjD0Kxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243647AbjD0Kx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:53:27 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A76191733
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UbHr1
        2EJRcLJX0m3zx6AJ7EMJL6PWOk64x85CYnjWxw=; b=RCF39ueX7fR2yfN0mhOLR
        91mVTrJGYaPzmh0TdD4mY4nFfrnit+Yy2B9Zn/YxAfsLXfEIlgxVEzaCC7W3/Pkh
        CLbyY8kyQnA0apRzNKR80FcxkgVa41OCWzaZvmGDCA7ZIfBhDleHLUlEZfJ4xPZQ
        ADimtJWmBFymOI77lAxdQM=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
        by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wDnU7DwU0pkyUYQAQ--.4631S2;
        Thu, 27 Apr 2023 18:52:33 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v3 0/2] *** drivers: net: sun4i-emac: Fix emac_timeout ***
Date:   Thu, 27 Apr 2023 18:52:29 +0800
Message-Id: <20230427105231.13900-1-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912063331.23369-1-qianfanguijin@163.com>
References: <20220912063331.23369-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnU7DwU0pkyUYQAQ--.4631S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWfXFy8Gr15Cr1xCFy3urg_yoWrJr17pF
        WjgrW3KrW8ta4jqw48CF1DCFyrXw1rJF90krZxA3yfta45K3s2qryIqrWqyFWjyFs5Ga1a
        vFn0grW3uas8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMVbgUUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbBzhNe7WI0ZAL7CwAAsu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

History:

2022-09-12:
Introduce the first patch and can read it from:
https://lkml.kernel.org/lkml/20220912063331.23369-1-qianfanguijin@163.com/
That was reviewed by Jernej Skrabec <jernej.skrabec@gmail.com> but have not
marged.

2023-04-27:

Apply the first patch and I found the bug was not fully fixed.
I also get those error messages sometimes:

[  108.581230] spi_master spi2: spi2.1: timeout transferring 1025 bytes@100000Hz for 190(164)ms
[  108.590337] spidev spi2.1: SPI transfer failed: -110
[  108.595443] spi_master spi2: failed to transfer one message from queue
...

I had tried `kdump` and `crash` tools but noting is useful.

Few days later I found `softirq` takes about 100% cpu of a cpu core, listen
softirq_entry, softirq_exit, net_dev_xmit events and I got those flood
messages:

289.902631: softirq_entry: vec=2 [action=NET_TX]
289.902651: net_dev_xmit: dev=eth0 skbaddr=(ptrval) len=98 rc=16
289.902656: softirq_exit: vec=2 [action=NET_TX]
289.902659: softirq_entry: vec=2 [action=NET_TX]
289.902664: net_dev_xmit: dev=eth0 skbaddr=(ptrval) len=98 rc=16
289.902668: softirq_exit: vec=2 [action=NET_TX]
...

And then I debug the linux kernel under qemu, make the emac-driver in qemu
drop some tx packages by this way:

diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 372e5b66da..28dfb1116b 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -349,9 +349,14 @@ static void aw_emac_write(void *opaque, hwaddr offset, uint64_t value,
                               "allwinner_emac: TX length > fifo data length\n");
             }
             if (len > 0) {
+                int ignore = random() % 10 < 1;
                 data = fifo8_pop_buf(fifo, len, &ret);
-                qemu_send_packet(nc, data, ret);
+                if (!ignore)
+                    qemu_send_packet(nc, data, ret);
                 aw_emac_tx_reset(s, chan);
+
+                if (ignore)
+                    break;
                 /* Raise TX interrupt */
                 s->int_sta |= EMAC_INT_TX_CHAN(chan);
                 aw_emac_update_irq(s);

It's very easy to reproduce this bug now.

Next is the backtrace of gdb when softirq was raise again:

#0  __raise_softirq_irqoff (nr=nr@entry=2) at kernel/softirq.c:699
#1  raise_softirq_irqoff (nr=nr@entry=2) at kernel/softirq.c:671
#2  0xc0855a34 in __netif_reschedule (q=0xc2027c00) at net/core/dev.c:3041
#3  __netif_schedule (q=q@entry=0xc2027c00) at net/core/dev.c:3048
#4  0xc085b0ec in qdisc_run_end (qdisc=0xc2027c00) at ./include/net/sch_generic.h:227
#5  qdisc_run (q=0xc2027c00) at ./include/net/pkt_sched.h:133
#6  net_tx_action (h=<optimized out>) at net/core/dev.c:5046
#7  0xc0101298 in __do_softirq () at kernel/softirq.c:558
#8  0xc0127cd0 in run_ksoftirqd (cpu=<optimized out>) at kernel/softirq.c:920
#9  0xc01487d0 in smpboot_thread_fn (data=0xc14a2780) at kernel/smpboot.c:164
#10 0xc0144b58 in kthread (_create=0xc14a2800) at kernel/kthread.c:319
#11 0xc0100130 in ret_from_fork () at arch/arm/kernel/entry-common.S:146
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

`net_tx_action` is running in `__do_softirq` and it will send package when
`qdisc_run`. But the emac driver in linux alway return NETDEV_TX_BUSY(16)
after emac_timeout due to we forget reset `db->tx_fifo_stat`,
that will make `__netif_schedule` raise softirq again and again.

qianfan Zhao (2):
  drivers: net: sun4i-emac: Fix double spinlock in emac_timeout
  drivers: net: sun4i-emac: Fix emac_timeout

 drivers/net/ethernet/allwinner/sun4i-emac.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--
2.25.1

