Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA1F6A396D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjB0DUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjB0DUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:20:01 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA376189
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:20:00 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677467998;
        bh=c3OID4OHGBiQHj/a18/Na81gQpWQRHYqRW26JTDxHKE=;
        h=From:Date:Subject:To:Cc:From;
        b=LRaNQJCE1bMq4h9CpQ0d3SHamcYhgLiw5ymuYKgB+NoPXTMxE4917X3J3XEQ80Fe5
         MOPFw4YGWznWX+jPlrXwOmWN07wnQGaJ5T83nRdF3uA7N6M/bwJThjIgcpsvk7FNjT
         h8lzTzV/J8zy3aG/aEv3s3PMvOj9b+bQRDGVZXFg=
Date:   Mon, 27 Feb 2023 03:19:56 +0000
Subject: [PATCH] firmware: qemu_fw_cfg: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230227-kobj_type-firmware-qemu-v1-1-fc0c8b44424f@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAFsh/GMC/x2N0QqCQBAAf0X2uYVrFQ/6lYi41TW39LS9LEP89
 44eZ2CYDZKYSoJTsYHJW5NOMcPxUEDTh3gT1DYzkKPSEXl8THy/vr6zYKc2foIJPmVc0Puq5ro
 k17KDXHNIgmwhNn3u4zIMWc4mna7/3fmy7z+XCpCnfgAAAA==
To:     Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677467996; l=1176;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=c3OID4OHGBiQHj/a18/Na81gQpWQRHYqRW26JTDxHKE=;
 b=aqXLp2yOWQMQHYa/WBolEG8uvRfp5q+eCr+6T9EaXn4m0kkl2hArfTv92d+BwFP1JUF5nzDm9
 GQpw3rtLQC3AMcEjhhcnZBojWn9GSfxGIGE+C7ndUaFVGBYp1CyB7kd
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
 drivers/firmware/qemu_fw_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index a69399a6b7c0..f41de793f41b 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -452,7 +452,7 @@ static void fw_cfg_sysfs_release_entry(struct kobject *kobj)
 }
 
 /* kobj_type: ties together all properties required to register an entry */
-static struct kobj_type fw_cfg_sysfs_entry_ktype = {
+static const struct kobj_type fw_cfg_sysfs_entry_ktype = {
 	.default_groups = fw_cfg_sysfs_entry_groups,
 	.sysfs_ops = &fw_cfg_sysfs_attr_ops,
 	.release = fw_cfg_sysfs_release_entry,

---
base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
change-id: 20230227-kobj_type-firmware-qemu-7746b6320db0

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

