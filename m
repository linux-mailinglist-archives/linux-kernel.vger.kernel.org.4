Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2E270A084
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjESUXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjESUXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:23:04 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4881A8;
        Fri, 19 May 2023 13:23:02 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 606AF1A1941;
        Fri, 19 May 2023 22:04:41 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 26D6D1A1936;
        Fri, 19 May 2023 22:04:41 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id A9AEC405E0;
        Fri, 19 May 2023 13:04:39 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, Jia He <justin.he@arm.com>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] apei/ghes: correctly return NULL for ghes_get_devices()
Date:   Fri, 19 May 2023 15:03:41 -0500
Message-Id: <20230519200342.30817-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 315bada690e0 ("EDAC: Check for GHES preference in the
chipset-specific EDAC drivers"), vendor specific EDAC driver will not
probe correctly when CONFIG_ACPI_APEI_GHES is enabled but no GHES device
is present.  Make ghes_get_devices() return NULL when the GHES device
list is empty to fix the problem.

Fixes: 9057a3f7ac36 ("EDAC/ghes: Prepare to make ghes_edac a proper module")
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Cc: Jia He <justin.he@arm.com>
---
 drivers/acpi/apei/ghes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 34ad071a64e9..da1a712f370b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1544,9 +1544,11 @@ struct list_head *ghes_get_devices(void)
 
 			pr_warn_once("Force-loading ghes_edac on an unsupported platform. You're on your own!\n");
 		}
+	} else if (list_empty(&ghes_devs)) {
+		return NULL;
+	} else {
+		return &ghes_devs;
 	}
-
-	return &ghes_devs;
 }
 EXPORT_SYMBOL_GPL(ghes_get_devices);
 
-- 
2.38.0

