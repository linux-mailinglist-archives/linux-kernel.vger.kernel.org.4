Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03268DE19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjBGQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBGQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:41:09 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7260B227BA;
        Tue,  7 Feb 2023 08:41:05 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675788063;
        bh=sIINCN7IeSQnZAy+3mzwnlsDKx8GVmGFg6BN70eqw0Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=RUKWslX5NK+uR2zMHAaLg8sRLcKc5KnQ8I4RgGW1I8k8rYyjLlE4SQ8QrzH0BvHfG
         QTrGmBMRvB6LrC6d0APNr/4GzdhsNg/5gBFNMS+fxOyREVvssT4Pk+UifRBY5uG455
         NW3yxZK5nUwfbL2L7Cd+ebx1hBJ56ifVXDn5gDig=
Date:   Tue, 07 Feb 2023 16:40:45 +0000
Subject: [PATCH 2/3] platform/x86: think-lmi: Make kobj_type structure
 constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-kobj_type-pdx86-v1-2-8e2c4fb83105@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675788060; l=1130;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=sIINCN7IeSQnZAy+3mzwnlsDKx8GVmGFg6BN70eqw0Q=;
 b=BLAqaxlzMZjuN+CxSMEkYS+JiIpaysfVsDa9fZY5W6OT26a8bZ83Ei0smpmgFWxNkHrZz7sUj
 De9jdoAKlJHAG6GyqiLerzVyLWwIE5hPXslSTLzRibzpdaS5kTIlu5Z
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
 drivers/platform/x86/think-lmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index a01a92769c1a..b616e4501cb2 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1089,12 +1089,12 @@ static void tlmi_pwd_setting_release(struct kobject *kobj)
 	kfree(setting);
 }
 
-static struct kobj_type tlmi_attr_setting_ktype = {
+static const struct kobj_type tlmi_attr_setting_ktype = {
 	.release        = &tlmi_attr_setting_release,
 	.sysfs_ops	= &tlmi_kobj_sysfs_ops,
 };
 
-static struct kobj_type tlmi_pwd_setting_ktype = {
+static const struct kobj_type tlmi_pwd_setting_ktype = {
 	.release        = &tlmi_pwd_setting_release,
 	.sysfs_ops	= &tlmi_kobj_sysfs_ops,
 };

-- 
2.39.1

