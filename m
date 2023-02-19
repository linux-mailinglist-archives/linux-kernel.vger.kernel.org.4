Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B3869C367
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 00:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBSXaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 18:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBSXaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 18:30:01 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990981ABC7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 15:30:00 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 40A6C2C05FA;
        Mon, 20 Feb 2023 12:29:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1676849396;
        bh=bD34Flb4PZpQOH+aca7SIHb4GcyA+Pc/7slSPHD7C/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zs4StTFrxzmPDAtLrb45oG7NG+/1eRHkCRQzNlhXqZzGJR4zTRI2yRpY6l1Pcrkqi
         YmwXxiQ2W9zPmjAEHIhZS1vyxTZpZyQlDB3MzTDv1ZIk0Bo9YjQAUprtE39m4puf/q
         +9YX8JIGg80tww3wW1Ihp+vG6/1bqRtC9rTOK0e1GbHTcb/8INtX2tLifqF/FZ/rFB
         gOrVBYT2enFYm7bGIMIQ4RchwqGeda9HbP+1WhbHoAPgU3dgNwzSE7uRtX5B8pOfm6
         MShDr+hJfDD7Lw4DZM8h4aceoyD8lqzzg1oVIxheEUBeTl7o5gMgJgFe/UYWc4k3TG
         2lLLW/+gB1h2Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63f2b0f40002>; Mon, 20 Feb 2023 12:29:56 +1300
Received: from tonyo-dl.ws.atlnz.lc (tonyo-dl.ws.atlnz.lc [10.33.12.31])
        by pat.atlnz.lc (Postfix) with ESMTP id 14A2913EE56;
        Mon, 20 Feb 2023 12:29:56 +1300 (NZDT)
Received: by tonyo-dl.ws.atlnz.lc (Postfix, from userid 1161)
        id 1252DA008A; Mon, 20 Feb 2023 12:29:56 +1300 (NZDT)
From:   Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     chris.packham@alliedtelesis.co.nz, hdegoede@redhat.com,
        jordan.crouse@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (adt7475) Fix setting of hysteresis registers
Date:   Mon, 20 Feb 2023 12:29:56 +1300
Message-Id: <20230219232956.23784-3-tony.obrien@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230219232956.23784-1-tony.obrien@alliedtelesis.co.nz>
References: <20230219232956.23784-1-tony.obrien@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GdlpYjfL c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=m04uMKEZRckA:10 a=528Z5tJWtxPNw0CsBnAA:9
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

In temp_store(), for the hysteresis setting calculation there were two
errors.  The first tries to clamp the hysteresis value by comparing the
required hysteresis value to THERM - 15C.  This is incorrect since the
hysteresis value is a relative value whereas THERM - 15C is an absolute
value. This causes it to always select 15C for hysteresis.  Change the
first parameter to THERM - val to compare two absolute temperatures.
The second error masks the wrong bits in the hysteresis register; indices
0 and 2 should zero bits [7:4] and preserve bits [3:0], and index 1 shoul=
d
zero bits [3:0] and preserve bits [7:4].

Fixes: 1c301fc5394f ("hwmon: Add a driver for the ADT7475 hardware monito=
ring chip")
Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
---
 drivers/hwmon/adt7475.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 77222c35a38e..68233191798e 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -484,14 +484,14 @@ static ssize_t temp_store(struct device *dev, struc=
t device_attribute *attr,
 		adt7475_read_hystersis(client);
=20
 		temp =3D reg2temp(data, data->temp[THERM][sattr->index]);
-		val =3D clamp_val(val, temp - 15000, temp);
+		val =3D clamp_val(temp - val, temp - 15000, temp);
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

