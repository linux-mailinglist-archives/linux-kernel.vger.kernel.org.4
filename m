Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E389D639520
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 11:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKZKEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 05:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKZKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 05:04:15 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6101E3CF;
        Sat, 26 Nov 2022 02:04:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NK6lC4PnKz4f3lWy;
        Sat, 26 Nov 2022 18:04:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgAXwa+Z5IFj6S94BA--.56716S4;
        Sat, 26 Nov 2022 18:04:10 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        kvalo@kernel.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yebin10@huawei.com
Subject: [PATCH] mmc: core: refactor debugfs code
Date:   Sat, 26 Nov 2022 18:25:20 +0800
Message-Id: <20221126102520.2824574-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAXwa+Z5IFj6S94BA--.56716S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy5WF1rAFyDGrWDZr1UKFg_yoW5Xw1kp3
        Z8Wryakryjkr15ua47Ca9F9F9aqws7KFW7W3yxW34fZFWUGw15AFyv9ayYvFy8JFyUKFs3
        AFWFqry3G343ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQ6p9UUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Now, CONFIG_DEBUG_FS is scattered in various functions, to make code
clean centralized processing CONFIG_DEBUG_FS in mmc debugfs module.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/mmc/core/bus.c  |  4 ----
 drivers/mmc/core/core.h | 15 +++++++++++++++
 drivers/mmc/core/host.c |  4 ----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index d8762fa3d5cd..36679f4e9acc 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -359,9 +359,7 @@ int mmc_add_card(struct mmc_card *card)
 			uhs_bus_speed_mode, type, card->rca);
 	}
 
-#ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
-#endif
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
 
 	device_enable_async_suspend(&card->dev);
@@ -383,9 +381,7 @@ void mmc_remove_card(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 
-#ifdef CONFIG_DEBUG_FS
 	mmc_remove_card_debugfs(card);
-#endif
 
 	if (mmc_card_present(card)) {
 		if (mmc_host_is_spi(card->host)) {
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index f5f3f623ea49..37091a6589ed 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -86,11 +86,26 @@ int mmc_attach_sdio(struct mmc_host *host);
 extern bool use_spi_crc;
 
 /* Debugfs information for hosts and cards */
+#ifdef CONFIG_DEBUG_FS
 void mmc_add_host_debugfs(struct mmc_host *host);
 void mmc_remove_host_debugfs(struct mmc_host *host);
 
 void mmc_add_card_debugfs(struct mmc_card *card);
 void mmc_remove_card_debugfs(struct mmc_card *card);
+#else
+static inline void mmc_add_host_debugfs(struct mmc_host *host)
+{
+}
+static inline void mmc_remove_host_debugfs(struct mmc_host *host)
+{
+}
+static inline void mmc_add_card_debugfs(struct mmc_card *card)
+{
+}
+static inline void mmc_remove_card_debugfs(struct mmc_card *card)
+{
+}
+#endif
 
 int mmc_execute_tuning(struct mmc_card *card);
 int mmc_hs200_to_hs400(struct mmc_card *card);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 5457c8aeeea1..d17eda753b7e 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -629,9 +629,7 @@ int mmc_add_host(struct mmc_host *host)
 
 	led_trigger_register_simple(dev_name(&host->class_dev), &host->led);
 
-#ifdef CONFIG_DEBUG_FS
 	mmc_add_host_debugfs(host);
-#endif
 
 	mmc_start_host(host);
 	return 0;
@@ -651,9 +649,7 @@ void mmc_remove_host(struct mmc_host *host)
 {
 	mmc_stop_host(host);
 
-#ifdef CONFIG_DEBUG_FS
 	mmc_remove_host_debugfs(host);
-#endif
 
 	device_del(&host->class_dev);
 
-- 
2.31.1

