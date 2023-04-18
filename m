Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049446E6FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 01:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjDRXkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 19:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjDRXjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 19:39:55 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF512CBF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:37:11 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CB7572C06BA;
        Wed, 19 Apr 2023 11:37:08 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1681861028;
        bh=Fbv4H9jmdq6VlD5UfEb37WubIhQNFvs8UbIcHX8jjUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3EJpAz0KqODcW1Dx6bXUDkGjIV/FUSYQq8wcotOrz5HmmoleRPcOTMH+MSBWj+jo
         n0Y3Ql6Ye9OV0TLi2fxpOfeON+kCGrj5BKg9uxq5a3gCE7CGc0xqK6TPCwdNmwFeeu
         2y3eD26lza/Rol0B6jy+LV7b6QDRsIDe6HqVJvS0GCeJVdHDMUUlzLQZyjv9fwhasx
         F1l2rYhzPHoK4iiaDGDZdFQDRKL18AjUa9ni3VnC0TivEXTOcrzPMLXCKlgtswaVqp
         vOpHGAVonYW+ao/gD5KF1Bqkv4IzL+jGbPeBOky9rb2pMr6MEm7bdSseAx5tXT0jTE
         LOai0fkTFPpjQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B643f29a40002>; Wed, 19 Apr 2023 11:37:08 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 054D713EE52;
        Wed, 19 Apr 2023 11:37:08 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 0A556283BBF; Wed, 19 Apr 2023 11:37:08 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, manio@skyboo.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/2] hwmon: (adt7475) Convert to use device_property APIs
Date:   Wed, 19 Apr 2023 11:36:56 +1200
Message-Id: <20230418233656.869055-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418233656.869055-1-chris.packham@alliedtelesis.co.nz>
References: <20230418233656.869055-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VfuJw2h9 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=dKHAf1wccvYA:10 a=B2oEPs-dVrQZeniiuWAA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of of_property_read_*() use the equivalent
device_property_read_*() API. This will allow these properties to be
used on DT unaware platforms. For DT aware platforms this will be a
noop.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    This is an additional update for master from the preceeding bugfix
    commit. I've not added a fixes tag for this one because I don't think
    there will be a behaviour change for existing usages.
   =20
    I know we have one upcoming DT unaware platform that we may want to u=
se
    some of these properties via ACPI tables so I won't object if this en=
ds
    up on the stable track but I don't think it meets the criteria for
    stable.

 drivers/hwmon/adt7475.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 6a6ebcc896b1..3b9289bc5997 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1468,7 +1468,7 @@ static int load_config3(const struct i2c_client *cl=
ient, const char *propname)
 	u8 config3;
 	int ret;
=20
-	ret =3D of_property_read_string(client->dev.of_node, propname, &functio=
n);
+	ret =3D device_property_read_string(&client->dev, propname, &function);
 	if (!ret) {
 		ret =3D adt7475_read(REG_CONFIG3);
 		if (ret < 0)
@@ -1494,7 +1494,7 @@ static int load_config4(const struct i2c_client *cl=
ient, const char *propname)
 	u8 config4;
 	int ret;
=20
-	ret =3D of_property_read_string(client->dev.of_node, propname, &functio=
n);
+	ret =3D device_property_read_string(&client->dev, propname, &function);
 	if (!ret) {
 		ret =3D adt7475_read(REG_CONFIG4);
 		if (ret < 0)
@@ -1556,8 +1556,8 @@ static int set_property_bit(const struct i2c_client=
 *client, char *property,
 			    u8 *config, u8 bit_index)
 {
 	u32 prop_value =3D 0;
-	int ret =3D of_property_read_u32(client->dev.of_node, property,
-					&prop_value);
+	int ret =3D device_property_read_u32(&client->dev, property,
+					   &prop_value);
=20
 	if (!ret) {
 		if (prop_value)
--=20
2.40.0

