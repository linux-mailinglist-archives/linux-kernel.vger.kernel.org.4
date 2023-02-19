Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1D969C364
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 00:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBSXaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 18:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBSXaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 18:30:01 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142041A97E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 15:29:58 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3B8532C04AB;
        Mon, 20 Feb 2023 12:29:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1676849396;
        bh=bNQb+gQOaBtreCBt0BLkW2YGZ45trg8UW779LoHpoHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xhbdc6eRkPxvNpKmcxABLZRJNNb7lcAEhjfYgB4eelpjvH9v1+mmdJT8n+dn8FvBh
         Jgf7OwwB6KG0XLz4vCDg5YQng+t0PO4v+4K1Sjnn9ZQHc7W/Y0kVIatmRUbJAkMjZt
         sP17iOreqc83rTRw8aYTrPfYP5wfq+Qvp9wgHSKxd7+CsSfHVnf4j1rKr/s+xNWe13
         qN+B6NVBV4dpciFuxue9oV/meeMMPAIVE0YDaDXlu5UPKcGQ+Tl0s94xNZfBUJFl/d
         Nhu2qRChcvLmE+njETPETYZhS7Zpf8Hqoo+DHxr2BikOYAYSVzT+rtzPWxwg0Mr1mC
         2ajK9AAjMWytA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63f2b0f40001>; Mon, 20 Feb 2023 12:29:56 +1300
Received: from tonyo-dl.ws.atlnz.lc (tonyo-dl.ws.atlnz.lc [10.33.12.31])
        by pat.atlnz.lc (Postfix) with ESMTP id 1242C13EE3F;
        Mon, 20 Feb 2023 12:29:56 +1300 (NZDT)
Received: by tonyo-dl.ws.atlnz.lc (Postfix, from userid 1161)
        id 0FCC1A007D; Mon, 20 Feb 2023 12:29:56 +1300 (NZDT)
From:   Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     chris.packham@alliedtelesis.co.nz, hdegoede@redhat.com,
        jordan.crouse@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (adt7475) Display smoothing attributes in correct order
Date:   Mon, 20 Feb 2023 12:29:55 +1300
Message-Id: <20230219232956.23784-2-tony.obrien@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230219232956.23784-1-tony.obrien@alliedtelesis.co.nz>
References: <20230219232956.23784-1-tony.obrien@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GdlpYjfL c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=m04uMKEZRckA:10 a=KrNswd0lE-T674yN-f0A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

