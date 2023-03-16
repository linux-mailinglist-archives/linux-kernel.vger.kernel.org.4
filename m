Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782B06BD4AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCPQG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCPQG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:06:57 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 141D6B1A73
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kRZV+
        8Q/emx5bHidIKO6PtLhBxtpwJPSftAEhgOkuYk=; b=NVzX9q+f0YmZlVAGydm1J
        zBGA5qBvFyOomt8UAtUkhW2xqZ9+uc6Ir5bvl4z5Ie3VqKRS26ZhN+76A5lTSm9G
        d+kjo3iuPwcZXvyk7eXYuAMbVaWYBOcWbqrO42hZyhN9rdkOh1IgtD+uo6TbsSCF
        4oxpMU6C4hFDu/qWOvDsc0=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wDHi0FdPhNkuGIYAQ--.38781S2;
        Fri, 17 Mar 2023 00:05:49 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     dri-devel@lists.freedesktop.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        jonas@kwiboo.se, airlied@gmail.com, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v3] drm/bridge: adv7511: fix race condition bug in adv7511_remove due to unfinished work
Date:   Fri, 17 Mar 2023 00:05:48 +0800
Message-Id: <20230316160548.1566989-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHi0FdPhNkuGIYAQ--.38781S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtr18Xr4rGw4ktrW3Ww1UGFg_yoW8Jr4Upa
        13uF98CrWUXFnrKayDAF1fta4rAwsrJF1F9a9ruwnavr1UXFyUArZ0yFyYyry7WFWxX3W3
        tr1UtFykWrnxAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zicyCZUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzgM0U2I0XqqgGAAAsw
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In adv7511_probe, adv7511->hpd_work is bound with adv7511_hpd_work.
If we call adv7511_remove with a unfinished work. There may be a 
race condition where bridge->hpd_mutex was destroyed by 
drm_bridge_remove and used in adv7511_hpd_work in drm_bridge_hpd_notify.

Fix it by canceling the work before cleanup in adv7511_remove.
Fixes: 518cb7057a59 ("drm/bridge: adv7511: Use work_struct to defer hotplug handing to out of irq context")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
v3:
- add patch modification information
v2:
- add Fix label
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index ddceafa7b637..9bf72dd6c1d3 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1349,6 +1349,7 @@ static void adv7511_remove(struct i2c_client *i2c)
 {
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
+	cancel_work_sync(&adv7511->hpd_work);
 	adv7511_uninit_regulators(adv7511);
 
 	drm_bridge_remove(&adv7511->bridge);
-- 
2.25.1

