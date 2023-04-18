Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAE56E6FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 01:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjDRXkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 19:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjDRXj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 19:39:59 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7ED13859
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:37:14 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B8E562C0580;
        Wed, 19 Apr 2023 11:37:08 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1681861028;
        bh=y/ABsNUxwyuzEHBQbd2U/Nx2OtSkchcGJaNSSxnkzcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EgRuRWn7Em/KG/+WMhREGjchlxiy0rfMKIzak4XBJuxs8w0qR1Y/61yZDFabUYMtd
         Pdojb5s4G17HJhNnXRUQMEGkEUueDb7xvWP1P+6WTMpHgElEBs/ZLzK3tal+GJav29
         yZe6JjfN59AGFIS7/GrET7OEgbCbxzgmNs9Xr+Qh5YcdaDwVEebW7cN4WnD1MtmhKa
         mYOQGjOxdFBtPaWTqgjF2VZnBgbI9DH6Dn4CCLtyo/V+CfZOfs0WGlzLaPKltXg6Xy
         sFpSsp/LLRKblv61r8CsmhIWJ91oHI/lZLKMQzlDCl3qtx2bKnQ6YzjoKlSZ9T0R75
         2bL7YZjWQKOpg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B643f29a40001>; Wed, 19 Apr 2023 11:37:08 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 03B5E13EE4D;
        Wed, 19 Apr 2023 11:37:08 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 073E7283BB6; Wed, 19 Apr 2023 11:37:08 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, manio@skyboo.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] hwmon: (adt7475) Use device_property APIs when configuring polarity
Date:   Wed, 19 Apr 2023 11:36:55 +1200
Message-Id: <20230418233656.869055-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418233656.869055-1-chris.packham@alliedtelesis.co.nz>
References: <20230418233656.869055-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VfuJw2h9 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=dKHAf1wccvYA:10 a=GF2wAtdHAAAA:8 a=i0TjTk5wKnZJQiLDsWAA:9 a=QEXdDO2ut3YA:10 a=Vv19E3DM6UNVh-gFiZZL:22
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

On DT unaware platforms of_property_read_u32_array() returns -ENOSYS
which wasn't handled by the code treating adi,pwm-active-state as
optional. Update the code to use device_property_read_u32_array() which
deals gracefully with DT unaware platforms.

Fixes: 86da28eed4fb ("hwmon: (adt7475) Add support for inverting pwm outp=
ut")
Reported-by: Mariusz Bia=C5=82o=C5=84czyk <manio@skyboo.net>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    I've not currently got access to a DT unaware platform with an ADT747=
5
    chip so I'm not 100% sure that this will fix the problem Mariusz
    reported but looking at drivers I think this approach is correct.
   =20
    Changes in v2:
    - use device_property_read_u32_array instead of checking for -ENOSYS

 drivers/hwmon/adt7475.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 6e4c92b500b8..6a6ebcc896b1 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1604,9 +1604,9 @@ static int adt7475_set_pwm_polarity(struct i2c_clie=
nt *client)
 	int ret, i;
 	u8 val;
=20
-	ret =3D of_property_read_u32_array(client->dev.of_node,
-					 "adi,pwm-active-state", states,
-					 ARRAY_SIZE(states));
+	ret =3D device_property_read_u32_array(&client->dev,
+					     "adi,pwm-active-state", states,
+					     ARRAY_SIZE(states));
 	if (ret)
 		return ret;
=20
--=20
2.40.0

