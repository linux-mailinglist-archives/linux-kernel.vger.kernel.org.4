Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A62A68DE1B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjBGQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjBGQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:41:09 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E681B274B0;
        Tue,  7 Feb 2023 08:41:05 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675788063;
        bh=tp+CWN/+yd0W5v40fAP7KUNvPikSs18mqdmw2p/hWRQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uU7CtPzTe5MIdEJlgHEWag/l3jX6vrydTTGUfZIqXOaWJdnWufzuyGe4O3asl+pnH
         QHnYdovuCepK5wCDGKe+9dBUucVotrl4L+q6KzIUd28cHpwn1d7DHroyNmisN0yZNK
         xkxmx494gvgBM3oRi2zlVU4ffreGvxvgjQJAfDDg=
Date:   Tue, 07 Feb 2023 16:40:44 +0000
Subject: [PATCH 1/3] platform/x86: dell-wmi-sysman: Make kobj_type
 structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-kobj_type-pdx86-v1-1-8e2c4fb83105@weissschuh.net>
References: <20230207-kobj_type-pdx86-v1-0-8e2c4fb83105@weissschuh.net>
In-Reply-To: <20230207-kobj_type-pdx86-v1-0-8e2c4fb83105@weissschuh.net>
To:     Divya Bharathi <divya.bharathi@dell.com>,
        Prasanth Ksr <prasanth.ksr@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Justin Ernst <justin.ernst@hpe.com>
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675788060; l=970;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tp+CWN/+yd0W5v40fAP7KUNvPikSs18mqdmw2p/hWRQ=;
 b=r+Yj3iPMAqit28OyyFW6s0X1kVp5YaUfTfUEdIhs49LoYnIfd25FZNQBxHpJ8uatoR5RJoIM5
 oD3j9bavBN/DztOA/U4NVZEbGhwbLBuFvhxNPYL5w631fosssBW3lpv
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
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 0a6411a8a104..0285b47d99d1 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -255,7 +255,7 @@ static void attr_name_release(struct kobject *kobj)
 	kfree(kobj);
 }
 
-static struct kobj_type attr_name_ktype = {
+static const struct kobj_type attr_name_ktype = {
 	.release	= attr_name_release,
 	.sysfs_ops	= &wmi_sysman_kobj_sysfs_ops,
 };

-- 
2.39.1

