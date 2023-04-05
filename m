Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B76D8985
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjDEVXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjDEVXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:23:37 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A9FCA;
        Wed,  5 Apr 2023 14:23:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 10D443F716;
        Wed,  5 Apr 2023 23:23:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7qB-PXVyeJ_f; Wed,  5 Apr 2023 23:23:21 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 3C6893F56D;
        Wed,  5 Apr 2023 23:23:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 923D194E2A;
        Wed,  5 Apr 2023 21:23:18 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BhJ80WM7Jc-I; Wed,  5 Apr 2023 21:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 9F22094DEF;
        Wed,  5 Apr 2023 21:23:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 9F22094DEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680729782;
        bh=46bAIQhprw5uAV/CIe/YRgQOYjSd553x4RWwfAtfJJI=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=W1n9mCzIB0IzFCnyUDHPyVLdpqLfBFKhQ2kIloBOSjzwKePoRZQ0IPQD/hhh9BORf
         sOpeVYT8OEwF9KQSs/xAbaPUvhGF9phAoHLVJaQvVhtNjGU2gPYxcrOEKjn/+AGzm2
         sm+YDhX9umMgPm+YEh0YoARv8S76jNPiYlez1opD/kW7s32NiUxodTnQV0GEaN+j6o
         XGhfQQwyqn3rLTKNwDXbnA/brz++EhSMKKNY+WzH1P5jQLQ7SxtO/y/d7fRDMJxrAh
         1SXHT2fuVPDzxCsh/xlFS/iCpW0om3YhVT73nv9a1PGceeLneg3f4JPXh5EaKQUvAw
         nyLlsWDWUoxiA==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aZw-piB1XN1t; Wed,  5 Apr 2023 21:23:02 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 750DA94DE6;
        Wed,  5 Apr 2023 21:22:59 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v3 5/7] iio: adc: palmas: always reset events on unload
Date:   Wed,  5 Apr 2023 23:22:31 +0200
Message-Id: <20230405212233.4167986-6-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405212233.4167986-1-risca@dalakolonin.se>
References: <20230405212233.4167986-1-risca@dalakolonin.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prevents leaving the adc in freerunning mode when removing the
driver.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index 8c6ea4a3cd2e..da4908608a27 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -498,6 +498,13 @@ static int palmas_gpadc_get_adc_dt_data(struct platf=
orm_device *pdev,
 	return 0;
 }
=20
+static void palmas_gpadc_reset(void *data)
+{
+	struct palmas_gpadc *adc =3D data;
+	if (adc->event0.enabled || adc->event1.enabled)
+		palmas_adc_reset_events(adc);
+}
+
 static int palmas_gpadc_probe(struct platform_device *pdev)
 {
 	struct palmas_gpadc *adc;
@@ -587,6 +594,10 @@ static int palmas_gpadc_probe(struct platform_device=
 *pdev)
 			palmas_gpadc_calibrate(adc, i);
 	}
=20
+	ret =3D devm_add_action(&pdev->dev, palmas_gpadc_reset, adc);
+	if (ret)
+		return ret;
+
 	return 0;
 }
=20
--=20
2.25.1

