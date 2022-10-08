Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDCE5F8598
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 16:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJHO3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 10:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJHO3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 10:29:42 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D539B1114;
        Sat,  8 Oct 2022 07:29:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ml6vb2YfczKG84;
        Sat,  8 Oct 2022 22:27:23 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP1 (Coremail) with SMTP id cCh0CgDXWy9PiUFjwdKvBw--.2626S2;
        Sat, 08 Oct 2022 22:29:36 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH] clk: bcm: rpi: Fix an out-of-bound access to raspberrypi_clk_variants
Date:   Sat,  8 Oct 2022 10:45:44 -0400
Message-Id: <20221008144544.283945-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDXWy9PiUFjwdKvBw--.2626S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1fXr17uF1Uuw1xWF48Zwb_yoW5uw4kpF
        Z8XFyfCrW8tryjqF4UJr1jyr1Fgr4jy3W7Jrn7Jr13XF4UGFyDAr1UJryDGr15Gr15A3W3
        Ja4DJw4Dtr1UJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

KASAN reports an out-of-bound access to raspberrypi_clk_variants[]:

==================================================================
BUG: KASAN: global-out-of-bounds in raspberrypi_clk_probe+0x1dc/0x690
Read of size 1 at addr ffffcc7116d615a0 by task kworker/u8:0/8

CPU: 1 PID: 8 Comm: kworker/u8:0 Not tainted 6.0.0-rc3-00900-g08f4df4a3c53 raspberrypi#10
Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
  dump_backtrace.part.0+0xd4/0xf4
  show_stack+0x24/0x7c
  dump_stack_lvl+0x68/0x84
  print_report+0x130/0x620
  kasan_report+0x94/0x160
  __asan_load1+0x68/0x74
  raspberrypi_clk_probe+0x1dc/0x690
  platform_probe+0x98/0x12c
  really_probe+0x118/0x42c
  __driver_probe_device+0xc0/0x150
  driver_probe_device+0x64/0x1c0
  __device_attach_driver+0x128/0x1ac
  bus_for_each_drv+0xf8/0x17c
  __device_attach+0x128/0x294
  device_initial_probe+0x20/0x40
  bus_probe_device+0xf8/0x120
  deferred_probe_work_func+0xf4/0x150
  process_one_work+0x3c4/0x800
  worker_thread+0x3dc/0x6b4
  kthread+0x194/0x1b0
  ret_from_fork+0x10/0x20

The buggy address belongs to the variable:
  raspberrypi_clk_variants+0x1e0/0xaa0

The buggy address belongs to the virtual mapping at
                [ffffcc7116a00000, ffffcc7117061000) created by:
                paging_init+0x2b8/0x7a8

The buggy address belongs to the physical page:
page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2961
flags: 0x3fffc0000001000(reserved|node=0|zone=0|lastcpupid=0xffff)
raw: 03fffc0000001000 fffffcb2ee0a5848 fffffcb2ee0a5848 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffffcc7116d61480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffcc7116d61500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ffffcc7116d61580: 00 00 00 00 f9 f9 f9 f9 00 00 00 00 00 00 00 00
                                ^
  ffffcc7116d61600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffcc7116d61680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Since raspberrypi_clk_variants[] size is RPI_FIRMWARE_NUM_CLK_ID, fix it
by making the access index clks->id less than RPI_FIRMWARE_NUM_CLK_ID and
setting clks[RPI_FIRMWARE_NUM_CLK_ID - 1].id to 0.

Fixes: 12c90f3f27bb ("clk: bcm: rpi: Add variant structure")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 73518009a0f2..3ad0d2d2e3b6 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -356,10 +356,12 @@ static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
 	if (ret)
 		return ret;
 
+	clks[RPI_FIRMWARE_NUM_CLK_ID - 1].id = 0;
+
 	while (clks->id) {
 		struct raspberrypi_clk_variant *variant;
 
-		if (clks->id > RPI_FIRMWARE_NUM_CLK_ID) {
+		if (clks->id >= RPI_FIRMWARE_NUM_CLK_ID) {
 			dev_err(rpi->dev, "Unknown clock id: %u", clks->id);
 			return -EINVAL;
 		}
-- 
2.30.2

