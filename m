Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6546F69EC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjBVAwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjBVAwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:52:37 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CB230EA7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 16:52:32 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CA2982C05FA;
        Wed, 22 Feb 2023 13:52:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1677027148;
        bh=TYh0L7puoigJesDl5k0VL2vq3huoljw2XZ7XIA34gfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWBWNSeBOV2Tqcb/Svn+AK1h6ONGO7ePMd5DjQgRTmeAcdfCl3EdTi29H3JxCpHqV
         5lhGua+qD6UacxVJQ0rGoeXcB8RSMUGqL/aReGUDMlMmywZVX6NQiteY4+tAXQ3fqu
         4oFsU2TghKamB+xK6tqEuIavAvnuqwEmJpBNPEqOT5+UOMAa+PEQBftToyXFYtTplG
         FCNaTRPDP3J8c7fX7xcPv2DRjTykD/KTTv3i85p/na4D9tm87Py4/XLE4wp2V4whaw
         M4PvYlsifVoNlwxR7dJ2zH08NWw24P03+pI1vWpPL1uMfKuLwZwvMN4rx25tpAXjMj
         h7CMfkr/P4wgw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63f5674c0002>; Wed, 22 Feb 2023 13:52:28 +1300
Received: from tonyo-dl.ws.atlnz.lc (tonyo-dl.ws.atlnz.lc [10.33.12.31])
        by pat.atlnz.lc (Postfix) with ESMTP id 7E6C513EE4C;
        Wed, 22 Feb 2023 13:52:28 +1300 (NZDT)
Received: by tonyo-dl.ws.atlnz.lc (Postfix, from userid 1161)
        id 7CDBDA0083; Wed, 22 Feb 2023 13:52:28 +1300 (NZDT)
From:   Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     chris.packham@alliedtelesis.co.nz, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: (adt7475) Display smoothing attributes in correct order
Date:   Wed, 22 Feb 2023 13:52:27 +1300
Message-Id: <20230222005228.158661-2-tony.obrien@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222005228.158661-1-tony.obrien@alliedtelesis.co.nz>
References: <20230222005228.158661-1-tony.obrien@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GdlpYjfL c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=m04uMKEZRckA:10 a=KrNswd0lE-T674yN-f0A:9
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

Throughout the ADT7475 driver, attributes relating to the temperature
sensors are displayed in the order Remote 1, Local, Remote 2.  Make
temp_st_show() conform to this expectation so that values set by
temp_st_store() can be displayed using the correct attribute.

Fixes: 8f05bcc33e74 ("hwmon: (adt7475) temperature smoothing")
Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
---
Changes in v2:
- None
 drivers/hwmon/adt7475.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 51b3d16c3223..77222c35a38e 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -556,11 +556,11 @@ static ssize_t temp_st_show(struct device *dev, str=
uct device_attribute *attr,
 		val =3D data->enh_acoustics[0] & 0xf;
 		break;
 	case 1:
-		val =3D (data->enh_acoustics[1] >> 4) & 0xf;
+		val =3D data->enh_acoustics[1] & 0xf;
 		break;
 	case 2:
 	default:
-		val =3D data->enh_acoustics[1] & 0xf;
+		val =3D (data->enh_acoustics[1] >> 4) & 0xf;
 		break;
 	}
=20
--=20
2.39.2

