Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B064612637
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 00:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJ2W0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 18:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2WZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 18:25:59 -0400
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Oct 2022 15:25:58 PDT
Received: from redpilled.dev (redpilled.dev [195.201.122.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FE6BCB4;
        Sat, 29 Oct 2022 15:25:57 -0700 (PDT)
From:   Mia Kanashi <chad@redpilled.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redpilled.dev;
        s=mail; t=1667082042;
        bh=JFw+n83nZJpSZhV8ijuCWuTJVYs2LY1MtKNjLbgwIOw=;
        h=From:To:Cc:Subject:Date;
        b=E8jj4IqrN9K0yBvYQoAo6TctXzJVx8xO11uliHBweD+1oqj2XR410YFe2GpNaSCUw
         Vr6Za4xuZV3prlbLYY80TfA8PY8iKXs9ymxXEmSpqTNmntV0YFMfDMX7yvLt2CZell
         rkRs3IO4kI/RsNT3Pg80ZXqmeqMDTdaje5vnEkC8=
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Mia Kanashi <chad@redpilled.dev>
Subject: [PATCH] ACPI: EC: Add quirk for the HP Pavilion Gaming 15-cx0041ur
Date:   Sun, 30 Oct 2022 01:20:08 +0300
Message-Id: <20221029222008.32793-1-chad@redpilled.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added GPE quirk entry for the HP Pavilion Gaming 15-cx0041ur.
There is a quirk entry for the 15-cx0xxx laptops, but this one has
different DMI_PRODUCT_NAME.

Notably backlight keys and other ACPI events now function correctly.

Signed-off-by: Mia Kanashi <chad@redpilled.dev>
---
 drivers/acpi/ec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9b42628cf21b..9751b84c1b22 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1875,6 +1875,16 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-cx0xxx"),
 		},
 	},
+	{
+		/*
+		 * HP Pavilion Gaming Laptop 15-cx0041ur
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP 15-cx0041ur"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
-- 
2.37.3

