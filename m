Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA96035C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJRWQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJRWQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:16:15 -0400
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46A7D8BBB9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:16:11 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kub2omqjesjaWkub3oJ4jq; Tue, 18 Oct 2022 23:58:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666130282; bh=a8oTHWoDPOIQF47GHhSIrxsKaQ/Iu/lrAtlAUr+eRSo=;
        h=From:To:Subject:Date:MIME-Version;
        b=bH7jWveRojiKBSLhRcmWnH1WifnDX/PHR9ZDeGXtEf1Y1rmOgXjcdg4yAj51bLQuQ
         5bEIo64O8bV9knY+cMjoTHaHzSkZFsFnqjPRLvFqT33ISDNgHMBqt5qw3/eVDOfaYC
         sOJ6CzjbCABCMo7RnE2Cl/4V7aCPI+gsfNc20Fl4bSm9fDzuDSNIaLXOiglemAOODg
         SIJW9exVxIuy8U3/fwSwqd3WE3/v73W0d7LGYz9xIV5ZtBlQZ9rYebDKdEYE3hWxfQ
         Q3SsY5vew+iYjOS0h/VExWQhC5pMv1ESnrw1JASfzZdmPAAiDUcC83dAq0o7Trmu+G
         iiUwN0dbNNreA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-raid@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Song Liu <song@kernel.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 1/3] ACPI: scan: substitute empty_zero_page with helper ZERO_PAGE(0)
Date:   Tue, 18 Oct 2022 23:57:53 +0200
Message-Id: <20221018215755.33566-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLP2urURZfQFB1yAY55ub1PVpneyUyJ0CHOO3oG9A8j9epcn57H4WVK+0ow2sxVOxI/GMoQzCt3q4X9ONmIe6QPNrjBO+Pu3SC60MP1YHQ0YnsUZpEhs
 kppXUQ/W23tfU8VcLha7d6EfRUCpvKaOHPmyQj4oDi4PHXJfLl/k5083pJzmbwdKc4sab0oP9kM88PqZjhZbsLlb+7af01eviIlOVmxeQgtfNIrA3r9PtuCM
 38tjmV0Rvf8iRqJg3GclatvHMBMastuttgrqZfWIM96yUj/bbZx904Tok7HVi5rbJdmxvhhuXBvEk7pWnsw5AWxBhQRPjCdEQ6cXU1ceWAVoh5EThxOy67mB
 pnnEoIHN8bPt1SahRnxY7XY5/eUQrxsFole9s6cvRinoSVA7CFTdnkRoCdSgP+BLnjunBjUbAYYXy3q/ZeO0JKDgENo5W0HDcs8Dm2KkEHiYJSE5ebUxorax
 jmzqjWu4h8c6iyQlNseXLWIrqT+vHcYeO934LA8PJ2Cc5l7QWNvLtXVfQR+EaO/VH7/VS9dA1FMmQ2yT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all zero page implementations use empty_zero_page global pointer so
let's substitute empty_zero_page occurence with helper ZERO_PAGE(0).

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 drivers/acpi/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 558664d169fc..4d2d274cc8ad 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -30,7 +30,7 @@ extern struct acpi_device *acpi_root;
 #define ACPI_BUS_HID			"LNXSYBUS"
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
-#define INVALID_ACPI_HANDLE	((acpi_handle)empty_zero_page)
+#define INVALID_ACPI_HANDLE	((acpi_handle)ZERO_PAGE(0))
 
 static const char *dummy_hid = "device";
 
-- 
2.34.1

