Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03D96C4529
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCVIhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCVIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:37:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EB05D89A;
        Wed, 22 Mar 2023 01:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFA49B81B8B;
        Wed, 22 Mar 2023 08:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35703C433D2;
        Wed, 22 Mar 2023 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679474210;
        bh=WUxmnRvTd0FvURbgK1vrDNjlJjS1QMteze29duvTQlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ug0Xo6ptb8cXZCjg0bvriKbTToHXMFAko5RoPZUFXg74hC8e9pU20mV/GsLnO5IzA
         wZDjEHdrAdxqcguMYWQHthnTBLXjqPP9Gk4YAZaqIQtVfmoq/y0uRgcffu+RXn9iDh
         nv31Vvb3ezs3ezV7bQ5P5f9T0qiK3teuq2CZamBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v2 02/19] ACPI: LPIT: move to use bus_get_dev_root()
Date:   Wed, 22 Mar 2023 09:36:46 +0100
Message-Id: <20230322083646.2937580-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <CAJZ5v0goaS5O1_Hds2DnWsw_G-Dg4fU9NEY0=chyn5ECTcBmDw@mail.gmail.com>
References: <CAJZ5v0goaS5O1_Hds2DnWsw_G-Dg4fU9NEY0=chyn5ECTcBmDw@mail.gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262; i=gregkh@linuxfoundation.org; h=from:subject; bh=WUxmnRvTd0FvURbgK1vrDNjlJjS1QMteze29duvTQlM=; b=owGbwMvMwCRo6H6F97bub03G02pJDClS++QKCxKDdEo//Uyrurjk0ZIrv5xckoN3/RF+U22Vt yi2fsKVjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIlycMC/o7pvxlvOiSN81t VeT9/o17D0/eepRhroy1RWq46BkmaRWh2RJLbf/uEgqdBgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: - change logic to test for dev_root at the beginning of the function
      and error out then based on review comments from Rafael.
    - fix error handling for ioremap() call to properly drop the
      reference on dev_root if it failed.

 drivers/acpi/acpi_lpit.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index 3843d2576d3f..c5598b6d5db8 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -98,6 +98,12 @@ EXPORT_SYMBOL_GPL(lpit_read_residency_count_address);
 static void lpit_update_residency(struct lpit_residency_info *info,
 				 struct acpi_lpit_native *lpit_native)
 {
+	struct device *dev_root = bus_get_dev_root(&cpu_subsys);
+
+	/* Silently fail, if cpuidle attribute group is not present */
+	if (!dev_root)
+		return;
+
 	info->frequency = lpit_native->counter_frequency ?
 				lpit_native->counter_frequency : tsc_khz * 1000;
 	if (!info->frequency)
@@ -108,18 +114,18 @@ static void lpit_update_residency(struct lpit_residency_info *info,
 		info->iomem_addr = ioremap(info->gaddr.address,
 						   info->gaddr.bit_width / 8);
 		if (!info->iomem_addr)
-			return;
+			goto exit;
 
-		/* Silently fail, if cpuidle attribute group is not present */
-		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
+		sysfs_add_file_to_group(&dev_root->kobj,
 					&dev_attr_low_power_idle_system_residency_us.attr,
 					"cpuidle");
 	} else if (info->gaddr.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
-		/* Silently fail, if cpuidle attribute group is not present */
-		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
+		sysfs_add_file_to_group(&dev_root->kobj,
 					&dev_attr_low_power_idle_cpu_residency_us.attr,
 					"cpuidle");
 	}
+exit:
+	put_device(dev_root);
 }
 
 static void lpit_process(u64 begin, u64 end)
-- 
2.40.0

