Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507166B808B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCMSaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCMSaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F60746FF;
        Mon, 13 Mar 2023 11:29:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C2FCB811D8;
        Mon, 13 Mar 2023 18:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC4FC433D2;
        Mon, 13 Mar 2023 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732161;
        bh=F5jf/JTxW3R0JUCStVxeFrVkNOg4tNx9+6PiesOi5Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5+h/FwcgMxm2RjkgHinbqRrDA77EWxq/o7knveMcMtDIzlPCfFnTqw5V/1PxJiQg
         zFsA9bxqVx2KJSICOO2UileuoWlC6nJjRl7M3ZHuoH5/BI38+/RPxNaEro7zbdT4GU
         NNLFzrMNVoMeJiMIdLUZzbNmaQUnf6uG1gPE5FIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH 02/36] ACPI: LPIT: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:44 +0100
Message-Id: <20230313182918.1312597-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2324; i=gregkh@linuxfoundation.org; h=from:subject; bh=F5jf/JTxW3R0JUCStVxeFrVkNOg4tNx9+6PiesOi5Z8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82aXsiSHvwmLzbOPu+O+yzVkcvPHv/zdVcpOtbZKie +cfXxvdEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABOZt51hnt6lmX6hmkefHOS9 pevItv7wV6dKc4YF+37K+2lxMZxkfX1Ae5mG0QWp0OqtAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 drivers/acpi/acpi_lpit.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index 3843d2576d3f..73b5c4800150 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -98,6 +98,8 @@ EXPORT_SYMBOL_GPL(lpit_read_residency_count_address);
 static void lpit_update_residency(struct lpit_residency_info *info,
 				 struct acpi_lpit_native *lpit_native)
 {
+	struct device *dev_root = bus_get_dev_root(&cpu_subsys);
+
 	info->frequency = lpit_native->counter_frequency ?
 				lpit_native->counter_frequency : tsc_khz * 1000;
 	if (!info->frequency)
@@ -111,15 +113,18 @@ static void lpit_update_residency(struct lpit_residency_info *info,
 			return;
 
 		/* Silently fail, if cpuidle attribute group is not present */
-		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
-					&dev_attr_low_power_idle_system_residency_us.attr,
-					"cpuidle");
+		if (dev_root)
+			sysfs_add_file_to_group(&dev_root->kobj,
+						&dev_attr_low_power_idle_system_residency_us.attr,
+						"cpuidle");
 	} else if (info->gaddr.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
 		/* Silently fail, if cpuidle attribute group is not present */
-		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
-					&dev_attr_low_power_idle_cpu_residency_us.attr,
-					"cpuidle");
+		if (dev_root)
+			sysfs_add_file_to_group(&dev_root->kobj,
+						&dev_attr_low_power_idle_cpu_residency_us.attr,
+						"cpuidle");
 	}
+	put_device(dev_root);
 }
 
 static void lpit_process(u64 begin, u64 end)
-- 
2.39.2

