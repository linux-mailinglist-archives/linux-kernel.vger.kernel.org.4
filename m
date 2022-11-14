Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6085C627BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiKNLLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiKNLKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:10:46 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27AC22BF8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:08:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N9mkm05LVz4f3m6n
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:08:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP4 (Coremail) with SMTP id gCh0CgAnmdaiIXJjjUwLAg--.26174S4;
        Mon, 14 Nov 2022 19:08:19 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/wpcm450: fix memory leak in ap_init_qci_info()
Date:   Mon, 14 Nov 2022 11:08:54 +0000
Message-Id: <20221114110854.554220-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnmdaiIXJjjUwLAg--.26174S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4fXw4kAFy5Ar4ftryxXwb_yoW3tFb_u3
        yUWr9xXFs2kFWrJ347uF45X34qyF1kWrnYg3WIyry5ZFW2qws3Grn7Z3s8tF47WF4xtrn3
        Cr97ZFyxZryxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3Jw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUrku4UUUUU
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

If of_iomap() failed, 'aic' should be freed before return. Otherwise
there is a memory leak.

Fixes: fead4dd49663 ("irqchip: Add driver for WPCM450 interrupt controller")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/irqchip/irq-wpcm450-aic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-wpcm450-aic.c b/drivers/irqchip/irq-wpcm450-aic.c
index 0dcbeb1a05a1..91df62a64cd9 100644
--- a/drivers/irqchip/irq-wpcm450-aic.c
+++ b/drivers/irqchip/irq-wpcm450-aic.c
@@ -146,6 +146,7 @@ static int __init wpcm450_aic_of_init(struct device_node *node,
 	aic->regs = of_iomap(node, 0);
 	if (!aic->regs) {
 		pr_err("Failed to map WPCM450 AIC registers\n");
+		kfree(aic);
 		return -ENOMEM;
 	}
 
-- 
2.34.1

