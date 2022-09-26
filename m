Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADC5E99E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiIZGv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiIZGvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:51:54 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1416B2716E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:51:52 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.162.98.155])
        by mail-app3 (Coremail) with SMTP id cC_KCgAnn6rvSzFjTFQYBw--.30427S2;
        Mon, 26 Sep 2022 14:51:33 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     johannes@sipsolutions.net, rafael@kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH V10] devcoredump: add context check in dev_coredumpm
Date:   Mon, 26 Sep 2022 14:51:26 +0800
Message-Id: <20220926065126.46080-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgAnn6rvSzFjTFQYBw--.30427S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDuw4fXrWUAF4DXFWxtFb_yoW8JFW3pF
        4rGa92krWUGrsa9a4DJa1a9F15Aw18JFyxW34jka4j9an3ArnrGrWrAFWYy3s8Xr1rtFyr
        XFn8J34vkFy2yF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAg0FAVZdtbpalgAFsG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_coredumpm(), dev_coredumpv() and dev_coredumpsg() could not
be used in atomic context, because they call kvasprintf_const() and
kstrdup() with GFP_KERNEL parameter. The process is shown below:

dev_coredumpv(.., gfp_t gfp)
  dev_coredumpm(.., gfp_t gfp)
    dev_set_name
      kobject_set_name_vargs
        kvasprintf_const(GFP_KERNEL, ...); //may sleep
          kstrdup(s, GFP_KERNEL); //may sleep

This patch adds context check in dev_coredumpm() in order to show
dev_coredumpm() and its callers could not be used in atomic context.

What's more, this change can allow the api to evolve and will not
influence the users that call this api.

Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes since v9:
  - v9: Add context check in dev_coredumpm().
  - v10: Remove the "Fixes" tag.

 drivers/base/devcoredump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f4d794d6bb8..806ee872f5f 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -255,6 +255,9 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	struct devcd_entry *devcd;
 	struct device *existing;
 
+	if (!gfpflags_normal_context(gfp))
+		goto free;
+
 	if (devcd_disabled)
 		goto free;
 
-- 
2.17.1

