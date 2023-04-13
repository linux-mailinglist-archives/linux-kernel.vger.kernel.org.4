Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6BA6E0749
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDMHAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMHAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:00:15 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9659F7280
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aYYjM
        s6sgb58wXmA0ce7H6o1vGXUMJqQKzsl1vTbGpk=; b=jcmkrjdXcvS6G5KG6yHL2
        KzWzP5OrsZiIFA3Mnmx8hhl1uLs5IVd/89uSq83Fc7yIgn6RrR+gVlXjc1IwRofs
        /uji6+DgA9dsQ3MvfYervGA6Pg+JnvCyxI5d/+zK2wwYdg1o2yxrUxmEXVYOTJ53
        t5Lokij8JQJ3szKBc42I74=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wC3x79gqDdkks5dBQ--.23663S2;
        Thu, 13 Apr 2023 14:59:44 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     dri-devel@lists.freedesktop.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        jonas@kwiboo.se, airlied@gmail.com, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v2] drm/bridge: adv7511: fix use after free bug in adv7511_remove due to race condition
Date:   Thu, 13 Apr 2023 14:59:43 +0800
Message-Id: <20230413065943.198088-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3x79gqDdkks5dBQ--.23663S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary7JrW3XFWDtrW7Cry8Zrb_yoW8Ar4fp3
        y3uF90krWUXFnrKa9rJF45Aa4rCw4Dtr1S9FZruwnIvrn8ZF18JrZ0yF15try7XrWkXa12
        qr4UAFykWFn8AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziI38rUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiGg1QU1aEE4gpSgACs8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In adv7511_probe, adv7511->hpd_work is bound with adv7511_hpd_work.
adv7511_irq_process might be called to start the work.

If we call adv7511_remove with an unfinished work. There may be a
race condition. Here is the possible sequence:

CPU0                  CPU1

                     |adv7511_hpd_work
adv7511_remove       |
cec_devnode_release  |
cec_unregister_adapter|
cec_devnode_unregister|
put_device(&devnode->dev);|
cec_devnode_release	|
cec_delete_adapter  |
kfree(adap);		|
                     |cec_phys_addr_invalidate
                     |//use adap

Fix it by canceling the work before cleanup in adv7511_remove.

This is the patch with new title in order to clarify the bug. Old patch
is here. The root cause is the same as old one.

https://lore.kernel.org/all/20230316160548.1566989-1-zyytlz.wz@163.com/

Fixes: 518cb7057a59 ("drm/bridge: adv7511: Use work_struct to defer hotplug handing to out of irq context")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
v2:
- Fix space error from checkpacth script
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index ddceafa7b637..e702a993fe6f 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1349,6 +1349,10 @@ static void adv7511_remove(struct i2c_client *i2c)
 {
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
+	if (i2c->irq)
+		devm_free_irq(&i2c->dev, i2c->irq, adv7511);
+	cancel_work_sync(&adv7511->hpd_work);
+
 	adv7511_uninit_regulators(adv7511);
 
 	drm_bridge_remove(&adv7511->bridge);
-- 
2.25.1

