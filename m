Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211766A3967
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjB0DRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0DRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:17:44 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1F415C90
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:17:44 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677467861;
        bh=nlVtaQtPNlAkJE/2M7+PVGD/nWU6e+KZ3K+YxuoE0xY=;
        h=From:Date:Subject:To:Cc:From;
        b=ZzgQ4wGUgHD8RcJ39T/bEtdxbQoCg6i9u5k4RRRLhP/iN8pR3YDTAKFqNuGuqOoDN
         iZBzw42VcTiRZVAkVhmS8Gch0TVmT1v9QktZplHmeFyw0OE3vqy3XKx26uhGSoiB1V
         S5Z0C2y1E7SkTNWRQ25FlHwlZ9TrSQcMDSUp+vLQ=
Date:   Mon, 27 Feb 2023 03:17:37 +0000
Subject: [PATCH] firmware: dmi-sysfs: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230227-kobj_type-firmware-dmi-v1-1-d1131d4e7a2b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANAg/GMC/x2N0Q6CMAwAf4X02SZzQ4j+iiFmG0WqMEinoiH8u
 w2Pd8nlVsgkTBkuxQpCH848JYXjoYDY+3Qn5FYZrLHOWFvjcwqP2+s3E3Ys4+KFsB0ZT6Vztav
 MOVIEjYPPhEF8ir3m6T0MKmehjr/77dps2x8EyEgwfQAAAA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677467858; l=1533;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nlVtaQtPNlAkJE/2M7+PVGD/nWU6e+KZ3K+YxuoE0xY=;
 b=QhqSmeglQSOmecMsHIdb/x3SSfBmvYjSqOPgn57XPR2Uf5TplPMaSLXTaeC7zn1gRHs9FTvLq
 mwQ+Gmm+mnPADE/g0uFvJDFhy6YbPYAwlwFntiHq50pYgupf1jvswpv
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

Greg, I'm sending this to you as there is no proper maintainer for this file.
---
 drivers/firmware/dmi-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index ed5aff0a4204..03708ab64e56 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -304,7 +304,7 @@ static struct attribute *dmi_sysfs_sel_attrs[] = {
 };
 ATTRIBUTE_GROUPS(dmi_sysfs_sel);
 
-static struct kobj_type dmi_system_event_log_ktype = {
+static const struct kobj_type dmi_system_event_log_ktype = {
 	.release = dmi_entry_free,
 	.sysfs_ops = &dmi_sysfs_specialize_attr_ops,
 	.default_groups = dmi_sysfs_sel_groups,
@@ -563,7 +563,7 @@ static void dmi_sysfs_entry_release(struct kobject *kobj)
 	kfree(entry);
 }
 
-static struct kobj_type dmi_sysfs_entry_ktype = {
+static const struct kobj_type dmi_sysfs_entry_ktype = {
 	.release = dmi_sysfs_entry_release,
 	.sysfs_ops = &dmi_sysfs_attr_ops,
 	.default_groups = dmi_sysfs_entry_groups,

---
base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
change-id: 20230227-kobj_type-firmware-dmi-543373609cec

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

