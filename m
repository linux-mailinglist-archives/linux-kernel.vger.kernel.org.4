Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F2069EC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjBVAwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjBVAwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:52:37 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E530EB5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 16:52:32 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B99EB2C034F;
        Wed, 22 Feb 2023 13:52:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1677027148;
        bh=Xlh9A+BoXGtR8DrhR/XI5BLDTPxz9tqhvxVveNnAApo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAltNOuCvDt36H85cwBdysEZAmrr7MpZlzk2dfQ3eMSCsW77J8CUCByc5ei9GCU0x
         ENc2jqfmU1Ga/aXTdClMlneUztULGTDHFUwZDhMInxlilR5FxHm8MvsJAJp8V+SN0v
         PLoy7aXB6YWiHi6cc4wwMlohC2xZ790Mk+oABc+UnnV0jOe1BpdEYnjKGBmh3KgOB6
         sjAPTLXKGbfdPIvQley/56AdsrlnrdE9lUaB8teKdCELofuLg956Jy7+cib0gzciNW
         TnqhtZmB4GX0Yef9PzoTvGVoW2mr/J64JyaWOR+l27Xn9XPUPI/PalhRtYpwhqEzt5
         vZMC0Qnq1+3VA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63f5674c0001>; Wed, 22 Feb 2023 13:52:28 +1300
Received: from tonyo-dl.ws.atlnz.lc (tonyo-dl.ws.atlnz.lc [10.33.12.31])
        by pat.atlnz.lc (Postfix) with ESMTP id 7D10013EE3F;
        Wed, 22 Feb 2023 13:52:28 +1300 (NZDT)
Received: by tonyo-dl.ws.atlnz.lc (Postfix, from userid 1161)
        id 7A51FA007D; Wed, 22 Feb 2023 13:52:28 +1300 (NZDT)
From:   Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     chris.packham@alliedtelesis.co.nz, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (adt7475) Fix masking of hysteresis registers
Date:   Wed, 22 Feb 2023 13:52:28 +1300
Message-Id: <20230222005228.158661-3-tony.obrien@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222005228.158661-1-tony.obrien@alliedtelesis.co.nz>
References: <20230222005228.158661-1-tony.obrien@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GdlpYjfL c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=m04uMKEZRckA:10 a=1utJVCOB_o5uIfT7QvUA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrong bits are masked in the hysteresis register; indices 0 and 2
should zero bits [7:4] and preserve bits [3:0], and index 1 should zero
bits [3:0] and preserve bits [7:4].

Fixes: 1c301fc5394f ("hwmon: Add a driver for the ADT7475 hardware monito=
ring chip")
Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
---
Changes in v2:
- Patch headline changed.
- Removed erroneous fix for clamping the hysteresis value. It should be
  an absolute value and not a relative value.
 drivers/hwmon/adt7475.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 77222c35a38e..6e4c92b500b8 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -488,10 +488,10 @@ static ssize_t temp_store(struct device *dev, struc=
t device_attribute *attr,
 		val =3D (temp - val) / 1000;
=20
 		if (sattr->index !=3D 1) {
-			data->temp[HYSTERSIS][sattr->index] &=3D 0xF0;
+			data->temp[HYSTERSIS][sattr->index] &=3D 0x0F;
 			data->temp[HYSTERSIS][sattr->index] |=3D (val & 0xF) << 4;
 		} else {
-			data->temp[HYSTERSIS][sattr->index] &=3D 0x0F;
+			data->temp[HYSTERSIS][sattr->index] &=3D 0xF0;
 			data->temp[HYSTERSIS][sattr->index] |=3D (val & 0xF);
 		}
=20
--=20
2.39.2

