Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830C26D2BBE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCaXov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCaXot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:44:49 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Mar 2023 16:44:47 PDT
Received: from helium.impl.it (helium.impl.it [IPv6:2a01:4f8:c0c:b78a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08F110A82;
        Fri, 31 Mar 2023 16:44:47 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a02:ab88:1380:6600:79f7:20e6:6650:f439; helo=localhost; envelope-from=noreply@impl.it; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impl.it; s=mail;
        t=1680305131; bh=SZqPCakegtWX1R1qWrI7INznL0Z1cwGdHEenYechGH8=;
        h=From:To:Cc:Subject:Date;
        b=c+sn60TTvHUyBB7xoT7Q9W2rs7VPzvXvCEtLl7Mwh5xafHo8MFbJ6EMu1X/TvmYYS
         rzQ412/nOl7GJCcPbt3uYzXLr2bC8IhTBTI8YMmG99Ar9n5PA3kDUIMjgmJ2+y0YoU
         6q2+P+PFIAWUlQjJpIUOudMoNWequIoo9mAe8Mfs=
Received: from localhost (unknown [IPv6:2a02:ab88:1380:6600:79f7:20e6:6650:f439])
        by helium.impl.it (Postfix) with ESMTPSA id 46749443150;
        Sat,  1 Apr 2023 01:25:31 +0200 (CEST)
From:   Benjamin Asbach <asbachb.kernel@impl.it>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <markpearson@lenvo.com>,
        Benjamin Asbach <asbachb.kernel@impl.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: thinkpad_acpi: Add missing T14s Gen1 type to s2idle quirk list
Date:   Sat,  1 Apr 2023 01:24:47 +0200
Message-Id: <20230331232447.37204-1-asbachb.kernel@impl.it>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Lenovo laptops that contain NVME SSDs across a variety of generations have
> trouble resuming from suspend to idle when the IOMMU translation layer is
> active for the NVME storage device.
>
> This generally manifests as a large resume delay or page faults. These
> delays and page faults occur as a result of a Lenovo BIOS specific SMI
> that runs during the D3->D0 transition on NVME devices.

Link: https://lore.kernel.org/all/20220503183420.348-1-mario.limonciello@amd.com/

As Lenovo distributes T14s Gen1 laptops with different product names
a missing one is added by this patch.

Note: Based on lenovo support page there might be some more variants which
are not represented in s2idle quirk list.

Signed-off-by: Benjamin Asbach <asbachb.kernel@impl.it>
Tested-by: Benjamin Asbach <asbachb.kernel@impl.it>

Link: https://bbs.archlinux.org/viewtopic.php?pid=2084655#p2084655
---
 drivers/platform/x86/thinkpad_acpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 32c10457399e..57428d7a392d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -4478,6 +4478,15 @@ static const struct dmi_system_id fwbug_list[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "20UH"),
 		}
 	},
+	{
+		.ident = "T14s Gen1 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20UJ"),
+		}
+	},
+
 	{
 		.ident = "P14s Gen1 AMD",
 		.driver_data = &quirk_s2idle_bug,
-- 
2.40.0

