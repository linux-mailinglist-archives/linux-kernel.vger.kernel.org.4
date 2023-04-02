Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCD6D3918
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjDBQnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 12:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjDBQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 12:43:35 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2129D18FAA;
        Sun,  2 Apr 2023 09:43:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id CA8F43FB38;
        Sun,  2 Apr 2023 18:43:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hRrvXlEvjyb2; Sun,  2 Apr 2023 18:43:32 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 0A8193FA8F;
        Sun,  2 Apr 2023 18:43:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 8F7B0937C0;
        Sun,  2 Apr 2023 16:43:31 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JKD4FSV4JqrC; Sun,  2 Apr 2023 16:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id E6B38937B0;
        Sun,  2 Apr 2023 16:43:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se E6B38937B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680453801;
        bh=sSdmlIjoRWn1yhuvWO68xTpxveh96xI8zNrDWx1+g80=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=QN37+ZQlGkNnqNukzY2lOZdWzQIlxyBP7dIa83CocW7N78+4cYRz76YT17Y9E2dlG
         pFuIGkAM+ck2lpRT4KHurFg/uHeCUqD6ri0mwQMhdWH5IWWGUC3ebcpYzS4mnZuLmh
         EfcEjGFRqx+1d4jLwjrVd1wG9OOdAXYPLRhn8B0YdKglGdbbDhAes5xNBg8mcsphml
         HvZXEyESMDF9/ZvNM1wRKSfRw61WAZ/bk3vzj9Fw7Hq0xmKEP15GqasrSUUzHeMgdp
         O3gnaK9DpwMMyHgmKN6HcTg60NOMzdNcALkDXxdSFOdgHqXg/LW/Ym40XP17g3VDXb
         yiCSSiZA+v/TA==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5a8U8w8BseHi; Sun,  2 Apr 2023 16:43:21 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 65C38937A7;
        Sun,  2 Apr 2023 16:43:20 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v2 7/7] iio: adc: palmas: don't alter event config on suspend/resume
Date:   Sun,  2 Apr 2023 18:42:47 +0200
Message-Id: <20230402164247.3089146-8-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230402164247.3089146-1-risca@dalakolonin.se>
References: <20230402164247.3089146-1-risca@dalakolonin.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event config is controlled through the IIO events subsystem and
device wakeup is controlled by /sys/devices/.../power/wakeup. Let's keep
those two knobs independent.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index f693d69a10a8..d4e1e80296d0 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -1127,16 +1127,10 @@ static int palmas_gpadc_suspend(struct device *de=
v)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
-	int wakeup =3D adc->event0.enabled || adc->event1.enabled;
-	int ret;
=20
-	if (!device_may_wakeup(dev) || !wakeup)
+	if (!device_may_wakeup(dev))
 		return 0;
=20
-	ret =3D palmas_adc_configure_events(adc);
-	if (ret < 0)
-		return ret;
-
 	if (adc->event0.enabled)
 		enable_irq_wake(adc->irq_auto_0);
=20
@@ -1150,16 +1144,10 @@ static int palmas_gpadc_resume(struct device *dev=
)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
-	int wakeup =3D adc->event0.enabled || adc->event1.enabled;
-	int ret;
=20
-	if (!device_may_wakeup(dev) || !wakeup)
+	if (!device_may_wakeup(dev))
 		return 0;
=20
-	ret =3D palmas_adc_reset_events(adc);
-	if (ret < 0)
-		return ret;
-
 	if (adc->event0.enabled)
 		disable_irq_wake(adc->irq_auto_0);
=20
--=20
2.25.1

