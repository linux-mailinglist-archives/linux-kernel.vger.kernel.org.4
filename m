Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C655E995B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiIZGQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiIZGQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:16:44 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38DBE1F2E3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:16:42 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.162.98.155])
        by mail-app2 (Coremail) with SMTP id by_KCgDHzSGqQzFjypNUBg--.31490S2;
        Mon, 26 Sep 2022 14:16:16 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     johannes@sipsolutions.net, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH V9] devcoredump: add context check in dev_coredumpm
Date:   Mon, 26 Sep 2022 14:16:09 +0800
Message-Id: <20220926061609.44153-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgDHzSGqQzFjypNUBg--.31490S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDuw4fXrWUAF4DXFWxtFb_yoW8Gr1fpF
        4rGa92krWUGrsa9a4UXanIgFy5Aw18AFyxW34jka4j9an3ArnrJrW8AFWYy3s8XryrtFy8
        XFn8J348KFyIyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
        XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
        6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgkFAVZdtbo+HwAbsx
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

Fixes: 833c95456a70 ("device coredump: add new device coredump class")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v9:
  - Add context check in dev_coredumpm().

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

