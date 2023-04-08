Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02336DBAAD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjDHLuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjDHLug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:50:36 -0400
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C81113D2;
        Sat,  8 Apr 2023 04:50:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 5BBE33F645;
        Sat,  8 Apr 2023 13:50:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X6S5QeEvuOoQ; Sat,  8 Apr 2023 13:50:02 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 4CECB3F6DD;
        Sat,  8 Apr 2023 13:50:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 9BDBD96041;
        Sat,  8 Apr 2023 11:50:01 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gJ1cKA0nyg2p; Sat,  8 Apr 2023 11:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 633F996034;
        Sat,  8 Apr 2023 11:49:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 633F996034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680954599;
        bh=kMqSuljo5JCHHUyQ0/vT6PhpwoOLfZm0bs5vSN/fU20=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=FsGhAvL5t44Z1SD8WHPbetsORlyRXP+vtByn3xsRhQCLc+eYKMax3K5QQRel+VCDD
         yGKAjtTAMuAKNwCeyC++eSq+bKPbmy7IbgeXBu1ZsX9vE7qOeduTEz3TjM6q++FpTN
         xqar/NuLj9qV0LGY34Gdxf4SuUVozUJAKb5NgriQzak85ns3Z4ZAICSADouY/I3LgG
         fX9nBHjtDl+ud/LsUV7npB7gEE0DJnz08tTN2gz3huTr9IeO59qVIeLWIrT9se0qft
         DW8W/GcucplWGbLTKjYYJahd1VwzopppZeWueBPv4nb2+vZ9QQpeZr3/Iieki1VnF4
         D6CZmz7Owrbog==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a4pO92bMA4Nq; Sat,  8 Apr 2023 11:49:59 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id BB72996031;
        Sat,  8 Apr 2023 11:49:58 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v4 9/9] iio: adc: palmas: don't alter event config on suspend/resume
Date:   Sat,  8 Apr 2023 13:48:25 +0200
Message-Id: <20230408114825.824505-10-risca@dalakolonin.se>
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

The event config is controlled through the IIO events subsystem and
device wakeup is controlled by /sys/devices/.../power/wakeup. Let's keep
those two knobs independent.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index f16f4ef184e4..f2ea3f2de363 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -1134,16 +1134,10 @@ static int palmas_gpadc_suspend(struct device *de=
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
@@ -1157,16 +1151,10 @@ static int palmas_gpadc_resume(struct device *dev=
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

