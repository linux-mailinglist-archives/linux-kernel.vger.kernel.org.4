Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F160C6EBA6D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDVQoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDVQoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:44:32 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A089B1FE4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 09:44:31 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Q3cg96TThz9skl;
        Sat, 22 Apr 2023 18:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1682181861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h2//rKNTfQwBhjD3uoD6LBbhesyy6m9jrkKD0mIcRH0=;
        b=CZBBUzgDwBXnBK/JZJSYDOMwkb8L+mUcz0sDz1WZjtiw+lfqvZOrnvh0SJcdCwnF476Uwq
        rwDyR8nLvS78QEtj66f4Bt30AgYS+KPXClJvyiZb4fSXhWenWU9K09pFAkklzSZs1uIJ9U
        m5rhK8QtmhjluXuNRznxRwFEbnx3QwsZA+sdmNLDcGV2yfIzOZbmxGd1szCAUjhcXtNiFM
        xGp9J884yQC22UgndLsWl7soOqAFbs/BzxedkgTn3jcVhvj1U3NSp91MDCyrylkqIh0IN5
        DzdKXSpjIgfGNmY5qUjU6G/RDtlfxEJ+WQbOOGd6GMhUGusfYU0jW6aap4X8+A==
From:   Marius Hoch <mail@mariushoch.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH] ACPI: x86: utils: Remove Lenovo Yoga Tablet 2's MAGN0001
Date:   Sat, 22 Apr 2023 18:44:01 +0200
Message-Id: <20230422164401.5986-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LSM303D on the Lenovo Yoga Tablet 2 series is present
as both ACCL0001 and MAGN0001. As we can only ever register an
i2c client for one of them, ignore MAGN0001.

Currently this errors:
i2c i2c-4: Failed to register i2c client MAGN0001:00 at 0x1d (-16)

Tested on a Lenovo Yoga Tablet 2 1051-F.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/acpi/x86/utils.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index ba420a28a4aa..9c2d6f35f88a 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -143,6 +143,16 @@ static const struct override_status_id override_status_ids[] = {
 		DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
 		DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
 	      }),
+
+	/*
+	 * The LSM303D on the Lenovo Yoga Tablet 2 series is present
+	 * as both ACCL0001 and MAGN0001. As we can only ever register an
+	 * i2c client for one of them, ignore MAGN0001.
+	 */
+	NOT_PRESENT_ENTRY_HID("MAGN0001", "1", ATOM_SILVERMONT, {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_FAMILY, "YOGATablet2"),
+	      }),
 };
 
 bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status)
-- 
2.40.0

