Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9F6F35D8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjEASde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEASdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:33:33 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDA1E4B;
        Mon,  1 May 2023 11:33:31 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1ptYKz-00077z-1m;
        Mon, 01 May 2023 20:33:25 +0200
Date:   Mon, 1 May 2023 19:33:14 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH] spi: mt65xx: make sure operations completed before unloading
Message-ID: <ZFAF6pJxMu1z6k4w@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unloading the spi-mt65xx kernel module during an ongoing spi-mem
operation the kernel will Oops shortly after unloading the module.
This is because wait_for_completion_timeout was still running and
returning into the no longer loaded module:

Internal error: Oops: 0000000096000005 [#1] SMP
Modules linked in: [many, but spi-mt65xx is no longer there]
CPU: 0 PID: 2578 Comm: block Tainted: G        W  O       6.3.0-next-20230428+ #0
Hardware name: Bananapi BPI-R3 (DT)
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0x18c/0x20e8
lr : __lock_acquire+0x9b8/0x20e8
sp : ffffffc009ec3400
x29: ffffffc009ec3400 x28: 0000000000000001 x27: 0000000000000004
x26: ffffff80082888c8 x25: 0000000000000000 x24: 0000000000000000
x23: ffffffc009609da8 x22: ffffff8008288000 x21: ffffff8008288968
x20: 00000000000003c2 x19: ffffff8008be7990 x18: 00000000000002af
x17: 0000000000000000 x16: 0000000000000000 x15: ffffffc008d78970
x14: 000000000000080d x13: 00000000000002af x12: 00000000ffffffea
x11: 00000000ffffefff x10: ffffffc008dd0970 x9 : ffffffc008d78918
x8 : 0000000000017fe8 x7 : 0000000000000001 x6 : 0000000000000000
x5 : ffffff807fb53910 x4 : 0000000000000000 x3 : 0000000000000027
x2 : 0000000000000027 x1 : 0000000000000000 x0 : 00000000000c03c2
Call trace:
 __lock_acquire+0x18c/0x20e8
 lock_acquire+0x100/0x2a4
 _raw_spin_lock_irq+0x58/0x74
 __wait_for_common+0xe0/0x1b4
 wait_for_completion_timeout+0x1c/0x24
 0xffffffc000acc8a4 <--- used to be mtk_spi_transfer_wait
 spi_mem_exec_op+0x390/0x3ec
 spi_mem_no_dirmap_read+0x6c/0x88
 spi_mem_dirmap_read+0xcc/0x12c
 spinand_read_page+0xf8/0x1dc
 spinand_mtd_read+0x1b4/0x2fc
 mtd_read_oob_std+0x58/0x7c
 mtd_read_oob+0x8c/0x148
 mtd_read+0x50/0x6c
 ...

Prevent this by completing in mtk_spi_remove if needed.

Fixes: 9f763fd20da7 ("spi: mediatek: add spi memory support for ipm design")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---

A short grep revealed that many if not most other SPI drivers may need
the same fix. However, I can impossibly test all of them, so let's
start with this one.

 drivers/spi/spi-mt65xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 21c321f437667..d7432e2219d85 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1275,6 +1275,9 @@ static int mtk_spi_remove(struct platform_device *pdev)
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	int ret;
 
+	if (mdata->use_spimem && !completion_done(&mdata->spimem_done))
+		complete(&mdata->spimem_done);
+
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
 		return ret;
-- 
2.40.1

