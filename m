Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160756E6F05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjDRWBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjDRWB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:01:27 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E833A7AB9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:01:23 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 68E092C0488;
        Wed, 19 Apr 2023 10:01:21 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1681855281;
        bh=S3c26+We7SLfEufJw5LOQrCdEaM4ZuM9Y3l58UPipjY=;
        h=From:To:Cc:Subject:Date:From;
        b=FKryFQebAl3UN9necF5ABvtT1V8Nn5sQStNVCyQGCB1R0VKj41BCTb+RgxiJ7CQqK
         BVPWX7TRnVp1WOBH///xbajpiMTZXZfEVQ3sGsV6zlQSwXyIXrUQkLh6/+4SxrS0Pm
         1AkjMfHx9OJX3wTsFGd/dkUe0nYpFYF+affpNw1jqhw//6jgajCBKHS4M0uNY5ITeL
         E0/1AGXGCfUC/j1BXTvC27wFlzJTStJqQx5CwFoiSwGCtIyBY/Zqia/CfrvMY23L8B
         gblbzshAVT8oatyBTfTRg0XrM+RnD0NuEtpS2CfFywzrw+IAj/KYQYh8f4nLtECTns
         /645R7YiTp+ew==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B643f13310000>; Wed, 19 Apr 2023 10:01:21 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 2342213EDC3;
        Wed, 19 Apr 2023 10:01:21 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 1FE02283BBF; Wed, 19 Apr 2023 10:01:21 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, manio@skyboo.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] hwmon: (adt7475) Handle DT unaware platforms
Date:   Wed, 19 Apr 2023 10:01:09 +1200
Message-Id: <20230418220109.787907-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VfuJw2h9 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=dKHAf1wccvYA:10 a=GF2wAtdHAAAA:8 a=QpOaOSl7_tIurUvRHyEA:9 a=QEXdDO2ut3YA:10 a=Vv19E3DM6UNVh-gFiZZL:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configuring the pwm polarity via the adi,pwm-active-state property is an
optional feature. On DT aware platforms of_property_read_u32_array()
returns -EINVAL when the property is absent this is checked for and the
driver probe continues without issue.

On DT unaware platfroms of_property_read_u32_array() returns -ENOSYS
which caused the driver probe to dev_warn(). Update the code to deal
with -ENOSYS so that the dev_warn() only occurs when there is a genuine
issue.

Fixes: 86da28eed4fb ("hwmon: (adt7475) Add support for inverting pwm outp=
ut")
Reported-by: Mariusz Bia=C5=82o=C5=84czyk <manio@skyboo.net>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/adt7475.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 6e4c92b500b8..af906eee480e 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1607,6 +1607,13 @@ static int adt7475_set_pwm_polarity(struct i2c_cli=
ent *client)
 	ret =3D of_property_read_u32_array(client->dev.of_node,
 					 "adi,pwm-active-state", states,
 					 ARRAY_SIZE(states));
+	/*
+	 * -EINVAL indicates that the property is absent, -ENOSYS indicates
+	 * that the platform lacks DT awareness. Neither of these are errors
+	 * for the optional pwm polarity support.
+	 */
+	if (ret =3D=3D -EINVAL || ret =3D=3D -ENOSYS)
+		return 0;
 	if (ret)
 		return ret;
=20
@@ -1741,7 +1748,7 @@ static int adt7475_probe(struct i2c_client *client)
 		adt7475_read_pwm(client, i);
=20
 	ret =3D adt7475_set_pwm_polarity(client);
-	if (ret && ret !=3D -EINVAL)
+	if (ret)
 		dev_warn(&client->dev, "Error configuring pwm polarity\n");
=20
 	/* Start monitoring */
--=20
2.40.0

