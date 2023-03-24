Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F716C8253
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjCXQ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:27:57 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629C110DA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:27:56 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679675274;
        bh=w1AtCKbY6nnJO2/ZZs3qGl6Rm9TfeXKRDa5zeO4CX/o=;
        h=From:Date:Subject:To:Cc:From;
        b=s0xdX41BeEC7aFzuWR2AZr+zmTWO3NXUfeoruVuO5x4LyiKgF83KbN4Ex52+3tB74
         U2AxQhroqYG1XxOlRBSBre19UmAx0etMNNPjCFfH7CV3ZesWZdBE1DCaLSHtmmJJyZ
         TkWlCUHBnTpuKBLDBP0y/wENAMfLPxk3427KwlHc=
Date:   Fri, 24 Mar 2023 16:27:50 +0000
Subject: [PATCH RESEND] firmware: turris-mox-rwtm: make kobj_type structure
 constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230227-kobj_type-firmware-turris-v1-1-e48f65155ec5@weissschuh.net>
To:     =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679675272; l=1061;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=w1AtCKbY6nnJO2/ZZs3qGl6Rm9TfeXKRDa5zeO4CX/o=;
 b=JHdCkDQfdyDUYKGWt/2PKvbeMKl+uiEqFhs1/oBfitKVSCNZfm8MMnGDnkfB0zuyxnwg4sQeN
 neLqzYd443pABVdvR6MQTCxt+tb2FkVRno7zy8tm/Dc5TfLraEk6ijO
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

