Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC8E6DBA92
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjDHLtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjDHLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:49:09 -0400
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E2CD532;
        Sat,  8 Apr 2023 04:49:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 177C23F586;
        Sat,  8 Apr 2023 13:49:05 +0200 (CEST)
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
        with ESMTP id g1tQhCcjjgA0; Sat,  8 Apr 2023 13:49:03 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id A5C2D3F3E8;
        Sat,  8 Apr 2023 13:49:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 782F295F9F;
        Sat,  8 Apr 2023 11:49:03 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3Sd9tTVk3Z73; Sat,  8 Apr 2023 11:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id AD9C395F9B;
        Sat,  8 Apr 2023 11:49:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se AD9C395F9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680954541;
        bh=XhROZXPSXckR4cXo6YbuNE8r4xKHu7TnEgvgxqLTtlg=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=VtHTbDOyyeXmmfAj5jl8fG5gWoJkSCXcfss5kbCtRzZ8UDyvJ2HfyGlGqu0nnEODe
         6jXv6febDkSi6CXjfR3fDi62idqowsDCCMtcBfmXBTQTYLB/iESXr6INH89nKkR4gD
         ip+xvpzmDERj8YbQZS/2OJY6ltrr0Y7l9S09At8DR5i0gegEClWg+z+/tOFHZln4xc
         w5NXwuVHZaDY7ou83QbK4nBP77lxXw8t2ecX1v9n8IlDUngHdbhYqKiDeM3LxzU7/6
         SBM+pewcUyJtXsZp0MnGGkfwBAgKSG1IjbNuNQMVaDI1djgWQp7IBe2YlFRynDbV7C
         Ia+0wYNAcrDxw==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ye8JcNTTR-Wm; Sat,  8 Apr 2023 11:49:01 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 84AD595F98;
        Sat,  8 Apr 2023 11:49:01 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 1/9] iio: adc: palmas_gpadc: fix NULL dereference on rmmod
Date:   Sat,  8 Apr 2023 13:48:17 +0200
Message-Id: <20230408114825.824505-2-risca@dalakolonin.se>
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

Calling dev_to_iio_dev() on a platform device pointer is undefined and
will make adc NULL.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
Link: https://lore.kernel.org/r/20230313205029.1881745-1-risca@dalakoloni=
n.se
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/palmas_gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index fd000345ec5c..849a697a467e 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -639,7 +639,7 @@ static int palmas_gpadc_probe(struct platform_device =
*pdev)
=20
 static int palmas_gpadc_remove(struct platform_device *pdev)
 {
-	struct iio_dev *indio_dev =3D dev_to_iio_dev(&pdev->dev);
+	struct iio_dev *indio_dev =3D dev_get_drvdata(&pdev->dev);
 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
=20
 	if (adc->wakeup1_enable || adc->wakeup2_enable)
--=20
2.25.1

