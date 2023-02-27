Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28B26A3960
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjB0DOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjB0DOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:14:07 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C764DEC66
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:14:06 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677467644;
        bh=C9Fjs5npHIdB4ZTxOUJ7QuJ+shthvhgfrZ1geLsKWLI=;
        h=From:Date:Subject:To:Cc:From;
        b=BCBPtXRVsHAAfzqJr4ZKF7cCSP/TQIOT0AxXo9ALT/HN825O6nX9GYC7ik/1P3ZPN
         vgaxctKxkajJoiTuTNLbSuGNqpHIRJcTYKqn/Lu+C6a/8GWvgOz9pIkwz635ECvqaA
         EyOV/3gcZ1KcH7vKsN4a71kTBsovydd1XQsbdPNo=
Date:   Mon, 27 Feb 2023 03:14:02 +0000
Subject: [PATCH] edd: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230227-kobj_type-firmware-edd-v1-1-c626afe5bd05@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAPof/GMC/x2NWwrCQAwAr1LybaCmWNGriJTNbmqjdVuyPim9u
 8HPGRhmgSKmUuBYLWDy0qJTdthuKohDyBdBTc5ANTU10R5vE1+7x3cW7NXu72CCkhIyN4liS3J
 od+AxhyLIFnIcPM/PcXQ5m/T6+d9O53X9ASkPrCR9AAAA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677467642; l=1050;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=C9Fjs5npHIdB4ZTxOUJ7QuJ+shthvhgfrZ1geLsKWLI=;
 b=PjmhTymHWv4ZK15zn4ExZaRocNspzY+LRm+2Kn3bT6CFuKzgHskL2xoJYCh2kbdpzZ2dwaRD9
 6znKfZegk4mC9txqeJhHTRoAa/Aly31lCKaLUKyG9AfdMqGb7EiKSLQ
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

Greg,

I'm sending this to you as there is no proper maintainer for this file.
---
 drivers/firmware/edd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 5cc238916551..55dec4eb2c00 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -608,7 +608,7 @@ static void edd_release(struct kobject * kobj)
 	kfree(dev);
 }
 
-static struct kobj_type edd_ktype = {
+static const struct kobj_type edd_ktype = {
 	.release	= edd_release,
 	.sysfs_ops	= &edd_attr_ops,
 };

---
base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
change-id: 20230227-kobj_type-firmware-edd-bb3d2c62e965

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

