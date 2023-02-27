Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D356A396B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjB0DTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0DS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:18:57 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AC71BC2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:18:56 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677467934;
        bh=w1AtCKbY6nnJO2/ZZs3qGl6Rm9TfeXKRDa5zeO4CX/o=;
        h=From:Date:Subject:To:Cc:From;
        b=m6Hpz0U1sC56xRomUs70m2/ZD7jQg+bxBVs/cmxw2Wh5dKgn2GGKJ7PL6d4yB8HKb
         icfO7d//c1Wm8iQ3++dV5ww9N5ndyYV9BH6rc08RhXzjB0ueiCMXitvOu8UR4g58lL
         7Zk6vLRz7CA0fmb2IAfQDnxlO6+7MtwnoLAV0SJI=
Date:   Mon, 27 Feb 2023 03:18:50 +0000
Subject: [PATCH] firmware: turris-mox-rwtm: make kobj_type structure
 constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230227-kobj_type-firmware-turris-v1-1-e97f79827db1@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABkh/GMC/x2N0QqCQBBFf0XmuQHdYqN+JUJm1zGnbJVZTUP89
 4Yez4VzzwaZVTjDtdhA+SNZhmRQHQqIHaUHozTG4Ep3LJ0742sIz3r6joyt6HshZZxmVcnoY3M
 i7wPF6gLmB8qMQSnFzh7S3Pc2jsqtrP/g7b7vP3O5wTyAAAAA
To:     =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677467931; l=1061;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=w1AtCKbY6nnJO2/ZZs3qGl6Rm9TfeXKRDa5zeO4CX/o=;
 b=9FjjhCetLP6JW4ew3dtvloDV5JXCEaNnACDzD1e6WFVFXRjJoxR/D3BSIDGIbVC+IgJMk+8P1
 Dint9ql0v3oBAR3HvdDPDrH1k0OvVA3zvCzvmfS09zQOzVNF5Kph1kC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/firmware/turris-mox-rwtm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 6ea5789a89e2..2de0fb139ce1 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -104,7 +104,7 @@ static void mox_kobj_release(struct kobject *kobj)
 	kfree(to_rwtm(kobj)->kobj);
 }
 
-static struct kobj_type mox_kobj_ktype = {
+static const struct kobj_type mox_kobj_ktype = {
 	.release	= mox_kobj_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 };

---
base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
change-id: 20230227-kobj_type-firmware-turris-6cd4a66bac19

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

