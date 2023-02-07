Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19E868E194
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBGTzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjBGTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:55:31 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A33E634;
        Tue,  7 Feb 2023 11:55:30 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675799728;
        bh=phkTdwEsx6EtyXDvxa4tKP6b/qMwbSxmjLtikUgTCNA=;
        h=From:Date:Subject:To:Cc:From;
        b=J8k8+Sy9q+8KBef5bWvFeXWZBjVNBkpeO/w131sD5cltruNxpq0F9SKUG/Z1oOCnI
         XC2lAysmY0ARnLnXdhF8amMDwQP+455q5vWoU9fSxCWJmPSBqEsdmBxoVVcK9vEJAu
         UZHWUHzMs73+575qA/upf36ggQ/PvJr5z5V3eWKI=
Date:   Tue, 07 Feb 2023 19:55:19 +0000
Subject: [PATCH] cpuidle: sysfs: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-kobj_type-cpuidle-v1-1-2ef73398283f@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKas4mMC/x2NQQqDMBAAvyJ77kKMrWn7lVIkidu6bYghUbGIf
 +/icQaG2aBQZipwrzbItHDhMQrUpwr8YOObkHth0Eo3SiuD39F9uumXCH2auQ+E16ZW9tyay80
 4kM7ZQuiyjX6QMs4hiEyZXrweo8dz3/+0Yc1AeAAAAA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675799722; l=1776;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=phkTdwEsx6EtyXDvxa4tKP6b/qMwbSxmjLtikUgTCNA=;
 b=fmfxqvzsPCrT2ha9FXCthzbYvjOBYLhjQV/qVztPdXluRtSMIcIUddLkmGvesmhwV4dBwlwY9
 bueFZQuBP9iCHEijexSzFBPSBcToG+6R3qEPJW5oF1hly8Jz9ILTrR5
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

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/cpuidle/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 2b496a53cbca..48948b171749 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -200,7 +200,7 @@ static void cpuidle_sysfs_release(struct kobject *kobj)
 	complete(&kdev->kobj_unregister);
 }
 
-static struct kobj_type ktype_cpuidle = {
+static const struct kobj_type ktype_cpuidle = {
 	.sysfs_ops = &cpuidle_sysfs_ops,
 	.release = cpuidle_sysfs_release,
 };
@@ -447,7 +447,7 @@ static void cpuidle_state_sysfs_release(struct kobject *kobj)
 	complete(&state_obj->kobj_unregister);
 }
 
-static struct kobj_type ktype_state_cpuidle = {
+static const struct kobj_type ktype_state_cpuidle = {
 	.sysfs_ops = &cpuidle_state_sysfs_ops,
 	.default_groups = cpuidle_state_default_groups,
 	.release = cpuidle_state_sysfs_release,
@@ -594,7 +594,7 @@ static struct attribute *cpuidle_driver_default_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cpuidle_driver_default);
 
-static struct kobj_type ktype_driver_cpuidle = {
+static const struct kobj_type ktype_driver_cpuidle = {
 	.sysfs_ops = &cpuidle_driver_sysfs_ops,
 	.default_groups = cpuidle_driver_default_groups,
 	.release = cpuidle_driver_sysfs_release,

---
base-commit: 513c1a3d3f1982fb850c910937099525b0d35e24
change-id: 20230207-kobj_type-cpuidle-8310a467597b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

