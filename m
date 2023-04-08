Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DD26DBAA6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjDHLu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjDHLuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:50:17 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE2FF33;
        Sat,  8 Apr 2023 04:49:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 071AC3FF56;
        Sat,  8 Apr 2023 13:49:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qG3G_D5UE7Hc; Sat,  8 Apr 2023 13:49:50 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 317083FF15;
        Sat,  8 Apr 2023 13:49:50 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (2048-bit key; unprotected) header.d=dalakolonin.se header.i=@dalakolonin.se header.b="YojNMbdt";
        dkim-atps=neutral
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 413E696022;
        Sat,  8 Apr 2023 11:49:49 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id w4m7C-XTXzVi; Sat,  8 Apr 2023 11:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 7A6479601D;
        Sat,  8 Apr 2023 11:49:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 7A6479601D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680954586;
        bh=46bAIQhprw5uAV/CIe/YRgQOYjSd553x4RWwfAtfJJI=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=YojNMbdtND9v8ITXzm4Tt2IlR6p1LvEnQauRLpBqzHOq7yLK0xmsdB2QbN9ogJVsL
         jXwKsWvV3k2i3mu5UE8mmqpm3XHqGvZg/NjYrvGragEelR6MFVWAC9i4Igc0SyJI/L
         7CfjPHtm/enCvTqkFV3fiQ/NdkmgEd8PdZxF6os3LMqxw5VDKlpMiXtNYX41YP82kE
         EEPkShlDbLtU11P9QlqIUBRGNdKoMtGTBfEqGvBlKwVtyfFc41fk9tySiaUrkCtjux
         09y7MU0u9JWFFdgJZCL0M1P90tHb8UFpTtOr8ie2fGwPg71N/3cyZ8Ay9wsqQ4aVnW
         BSo7APa2igLag==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AakoBU_a_1zt; Sat,  8 Apr 2023 11:49:46 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id D0C409601A;
        Sat,  8 Apr 2023 11:49:45 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v4 7/9] iio: adc: palmas: always reset events on unload
Date:   Sat,  8 Apr 2023 13:48:23 +0200
Message-Id: <20230408114825.824505-8-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230408114825.824505-1-risca@dalakolonin.se>
References: <20230408114825.824505-1-risca@dalakolonin.se>
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

