Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F996D3912
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDBQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 12:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjDBQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 12:43:30 -0400
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2324EE38A;
        Sun,  2 Apr 2023 09:43:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id ADAD23FDB5;
        Sun,  2 Apr 2023 18:43:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0FwUw6B1vgxZ; Sun,  2 Apr 2023 18:43:27 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D99D93FD82;
        Sun,  2 Apr 2023 18:43:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id D20DB937B9;
        Sun,  2 Apr 2023 16:43:25 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lIpAZZPFtJfB; Sun,  2 Apr 2023 16:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 6F3DD93792;
        Sun,  2 Apr 2023 16:43:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 6F3DD93792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680453798;
        bh=nzWLhIO9b9yXx9/x0jo6puIZ0zDR+M8hdZYvMF0djdA=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=cMdJOf7/iS7ZcfxYGbb2QdmpHaVat+mlusZk3tJ0RQqDv/D8T2wxboRM5moYqd0uk
         fBIWutP4DLIZixHYfIm6hMh3xCBW7NMG5E9ICgBICUqV7FxkQG5916BDy3flhZSwXq
         BorTyM4I0KUu8elDJ+EOKTD6a4hMPPzadwYYHQ9E60ZbFm4TfF66Gat8Az8My5ykb2
         iti+ju5Y+yxtljtY9w8yf8eT2scesd/Rsqu6yTpM5/F7beu/omIbXTz3FelPV7d5zo
         Nvy/giygc4I60ESnP5XdNMMBA/bhP/QKrp7RDLF/3l2SvzuO1AEN70TVp7ylOkHCyZ
         DrPy/SOU31nkA==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Udpnhxm-cUPj; Sun,  2 Apr 2023 16:43:18 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id BF5EB9378A;
        Sun,  2 Apr 2023 16:43:17 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v2 4/7] iio: adc: palmas: move eventX_enable into palmas_adc_event
Date:   Sun,  2 Apr 2023 18:42:44 +0200
Message-Id: <20230402164247.3089146-5-risca@dalakolonin.se>
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

It just makes more sense to have all information regarding adc events in
one place.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index fca455a4285e..f7eb445495b6 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -77,6 +77,7 @@ static struct palmas_gpadc_info palmas_gpadc_info[] =3D=
 {
 };
=20
 struct palmas_adc_event {
+	bool enabled;
 	int channel;
 	int raw_thresh;
 	enum iio_event_direction direction;
@@ -119,8 +120,6 @@ struct palmas_gpadc {
 	struct completion		conv_completion;
 	struct palmas_adc_event		event0;
 	struct palmas_adc_event		event1;
-	bool				event0_enable;
-	bool				event1_enable;
 	int				auto_conversion_period;
 	struct mutex			lock;
 };
@@ -616,7 +615,7 @@ static int palmas_adc_configure_events(struct palmas_=
gpadc *adc)
 	}
=20
 	conv =3D 0;
-	if (adc->event0_enable) {
+	if (adc->event0.enabled) {
 		struct palmas_adc_event *ev =3D &adc->event0;
 		int polarity;
=20
@@ -652,7 +651,7 @@ static int palmas_adc_configure_events(struct palmas_=
gpadc *adc)
 		}
 	}
=20
-	if (adc->event1_enable) {
+	if (adc->event1.enabled) {
 		struct palmas_adc_event *ev =3D &adc->event1;
 		int polarity;
=20
@@ -727,7 +726,7 @@ static int palmas_gpadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
-	int wakeup =3D adc->event0_enable || adc->event1_enable;
+	int wakeup =3D adc->event0.enabled || adc->event1.enabled;
 	int ret;
=20
 	if (!device_may_wakeup(dev) || !wakeup)
@@ -737,10 +736,10 @@ static int palmas_gpadc_suspend(struct device *dev)
 	if (ret < 0)
 		return ret;
=20
-	if (adc->event0_enable)
+	if (adc->event0.enabled)
 		enable_irq_wake(adc->irq_auto_0);
=20
-	if (adc->event1_enable)
+	if (adc->event1.enabled)
 		enable_irq_wake(adc->irq_auto_1);
=20
 	return 0;
@@ -750,7 +749,7 @@ static int palmas_gpadc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
-	int wakeup =3D adc->event0_enable || adc->event1_enable;
+	int wakeup =3D adc->event0.enabled || adc->event1.enabled;
 	int ret;
=20
 	if (!device_may_wakeup(dev) || !wakeup)
@@ -760,10 +759,10 @@ static int palmas_gpadc_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
=20
-	if (adc->event0_enable)
+	if (adc->event0.enabled)
 		disable_irq_wake(adc->irq_auto_0);
=20
-	if (adc->event1_enable)
+	if (adc->event1.enabled)
 		disable_irq_wake(adc->irq_auto_1);
=20
 	return 0;
--=20
2.25.1

