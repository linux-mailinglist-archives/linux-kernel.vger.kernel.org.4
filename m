Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA79695761
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjBNDX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBNDX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:23:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AAB15567;
        Mon, 13 Feb 2023 19:23:55 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676345033;
        bh=TTSAmGKfo5YnaIP4eesYGxg0Xl6iUUUV5EHJZXyVtLA=;
        h=From:Date:Subject:To:Cc:From;
        b=h8oQVBcO1hsftab0fR5er/unuOMTuZfxb7MjQ/02yc+IoOLEKZLP189gvvmAOcDOn
         kdlergwa8ON4hDKA0dlgZtxBSgt24vAPSZcQfFGmOYJm1yZA4VOXi1R60Ylj/ratGU
         5OtRX4L/RnXtaRXR9yOS7PW2NP19Eck92RuO0jeU=
Date:   Tue, 14 Feb 2023 03:23:52 +0000
Subject: [PATCH] ACPI: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230214-kobj_type-acpi-v1-1-6dbe3840208b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAMf+6mMC/x2N0QrCMAwAf2Xk2UDbDZT9ioyRZtFljq60KsrYv
 xt8vIPjdqhSVCr0zQ5F3lp1Swb+1ADPlO6COhlDcKF1wXf42OIyPr9ZkDgrtjSJ67xczsxgUaQ
 qGAslni1Lr3U1mYvc9PO/XIfj+AF/WYMhdQAAAA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676345031; l=2075;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=TTSAmGKfo5YnaIP4eesYGxg0Xl6iUUUV5EHJZXyVtLA=;
 b=f8o9s+RsVmovqxd5Tt0zc7aXzGlgXE6+5PnTTW1Zik+cdBVehPkMR6ptYyvNSFftJrAvp7qc8
 vWPPldJtKYkBNkTY/Ar0SAq1/JJ3ZkDll68Sdh3nfQI2JLl82jhKVto
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
 drivers/acpi/cppc_acpi.c    | 2 +-
 drivers/acpi/device_sysfs.c | 2 +-
 drivers/acpi/sysfs.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 0f17b1c32718..a8f58b32d66f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -193,7 +193,7 @@ static struct attribute *cppc_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cppc);
 
-static struct kobj_type cppc_ktype = {
+static const struct kobj_type cppc_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = cppc_groups,
 };
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 120873dad2cc..c3aa15571f16 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -78,7 +78,7 @@ static void acpi_data_node_release(struct kobject *kobj)
 	complete(&dn->kobj_done);
 }
 
-static struct kobj_type acpi_data_node_ktype = {
+static const struct kobj_type acpi_data_node_ktype = {
 	.sysfs_ops = &acpi_data_node_sysfs_ops,
 	.default_groups = acpi_data_node_default_groups,
 	.release = acpi_data_node_release,
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 7db3b530279b..7f4ff56c9d42 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -953,7 +953,7 @@ static struct attribute *hotplug_profile_attrs[] = {
 };
 ATTRIBUTE_GROUPS(hotplug_profile);
 
-static struct kobj_type acpi_hotplug_profile_ktype = {
+static const struct kobj_type acpi_hotplug_profile_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = hotplug_profile_groups,
 };

---
base-commit: f6feea56f66d34259c4222fa02e8171c4f2673d1
change-id: 20230214-kobj_type-acpi-3ade041e87cc

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

