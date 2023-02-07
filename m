Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0F068DE18
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjBGQlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjBGQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:41:09 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E4344AE;
        Tue,  7 Feb 2023 08:41:05 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675788063;
        bh=TV/He8u1kfiZlTL0/7QF9LBr+vgFExVcFn1jZsSmxKc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Np0p/qX6fF/BkRtANswQUP/kXDWMU/QH1abMmv+dcm/wpn/3u4NL/WGKve8c243XR
         +6Enk9Zt8EX6JSP3TB5VYkS+jHc5Yj0I9x476Mr820QHDAomsCR8YIRoY0kzAvAGWs
         iV3GQ52UEwrRlE1fegGQ2dTI6UdJzQBTh+pwlMEk=
Date:   Tue, 07 Feb 2023 16:40:46 +0000
Subject: [PATCH 3/3] x86/platform/uv: Make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-kobj_type-pdx86-v1-3-8e2c4fb83105@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675788060; l=1514;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=TV/He8u1kfiZlTL0/7QF9LBr+vgFExVcFn1jZsSmxKc=;
 b=JXG663aio6LtX4AEJ6H51TedaQpcygBJSufjXli4A9UDwVKGTZ2zttN9PPdEa3N28PN7WxaRW
 QbPVsrCML4IDqI7067eObmBgetVSZaXP9sFoMGmBmtylvByqxHtX46U
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
 drivers/platform/x86/uv_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 73fc38ee7430..38d1b692d3c0 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -203,7 +203,7 @@ static const struct sysfs_ops hub_sysfs_ops = {
 	.show = hub_type_show,
 };
 
-static struct kobj_type hub_attr_type = {
+static const struct kobj_type hub_attr_type = {
 	.release	= hub_release,
 	.sysfs_ops	= &hub_sysfs_ops,
 	.default_groups	= uv_hub_groups,
@@ -356,7 +356,7 @@ static const struct sysfs_ops uv_port_sysfs_ops = {
 	.show = uv_port_type_show,
 };
 
-static struct kobj_type uv_port_attr_type = {
+static const struct kobj_type uv_port_attr_type = {
 	.release	= uv_port_release,
 	.sysfs_ops	= &uv_port_sysfs_ops,
 	.default_groups	= uv_port_groups,
@@ -528,7 +528,7 @@ static const struct sysfs_ops uv_pci_top_sysfs_ops = {
 	.show = pci_top_type_show,
 };
 
-static struct kobj_type uv_pci_top_attr_type = {
+static const struct kobj_type uv_pci_top_attr_type = {
 	.release	= uv_pci_top_release,
 	.sysfs_ops	= &uv_pci_top_sysfs_ops,
 };

-- 
2.39.1

