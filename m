Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD3657912
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiL1O5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiL1O5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:57:16 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93EA1004D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1672239432; x=1674831432;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mGvnyn0duUAqhMmSJfLpbfIJNJ2IKj7YIrD6ZlQLoj8=;
        b=Igta/bR+DgUPr+NC5bEzkuslQdtljdI+WGy9YcNCE2ryfUw8+fC2C1Sphu40X0ym
        VbptcC+9O0s8WkJnhFj+r+lmIaEEq/40TBVtFY/wXBTgg/HMAbyJuJHiZ1C6pvmy
        0AmPKSH3Kx0titRvY3rBOygz3pBPsCYWFHYGJeISeyY=;
X-AuditID: ac14000a-923ff70000007ecb-a0-63ac59484e2b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A8.26.32459.8495CA36; Wed, 28 Dec 2022 15:57:12 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 28 Dec
 2022 15:57:12 +0100
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <upstream@lists.phytec.de>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <daniel@ffwll.ch>, <airlied@gmail.com>, <jernej.skrabec@gmail.com>,
        <jonas@kwiboo.se>, <Laurent.pinchart@ideasonboard.com>,
        <robert.foss@linaro.org>, <neil.armstrong@linaro.org>,
        <andrzej.hajda@intel.com>
Subject: [PATCH] drm/bridge: sii902x: Allow reset line to be tied to a sleepy GPIO controller
Date:   Wed, 28 Dec 2022 15:57:04 +0100
Message-ID: <20221228145704.939801-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWyRpKBR9cjck2ywdfJ+hYnri9isri/+DOL
        xf9tE5ktrnx9z2bxfP46RouTb66yWHROXMJucXnXHDaL9ztvMVp8mvWQ2aL7nboDt8febwtY
        PHbOusvuMbtjJqvH4j0vmTxOTLjE5HHn2h42j/vdx5k8+rtbWD0+b5IL4IzisklJzcksSy3S
        t0vgylh8/QFLwUv2iu4Pm5kbGC+xdTFyckgImEjcXHWSvYuRi0NIYDGTRMPaO6wQzhNGid+f
        17ODVLEJqEvc2fCNFcQWEUiWmHbtHjNIEbPANUaJvrvLWUASwgKxEkfa+sFsFgFViddTvoI1
        8wpYSMxeOQNqnbzEzEvfoeKCEidnPgGrZwaKN2+dzQxhS0gcfPECzBYCir+4BDEfpHfaudfM
        EHaoxJFNq5kmMArMQjJqFpJRs5CMWsDIvIpRKDczOTu1KDNbryCjsiQ1WS8ldRMjKGJEGLh2
        MPbN8TjEyMTBeIhRgoNZSYRX4+zqZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK893uYEoUE0hNL
        UrNTUwtSi2CyTBycUg2MbcvVLY9WP83JOCenmKfUMJNRcWVpxPa3K//atz98/NtFcm1Sp9cd
        Y7WtR1pM9/Rv3ugu6la64GvVqaeCOov57wbPuOMol737trHqxaYTnvssJs9psrrvPX1J4DUr
        Ha3sy4cPz9mqvKWNJ/vOVCnVR/MEM+J81vvf0EyQ+TB1cdSBQ6JNof8alFiKMxINtZiLihMB
        8gCn7oYCAAA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to gpiod_set_value_cansleep() in sii902x_reset().
This is relevant if the reset line is tied to a I2C GPIO
controller.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/gpu/drm/bridge/sii902x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 878fb7d3732b..980611aec2f6 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -240,12 +240,12 @@ static void sii902x_reset(struct sii902x *sii902x)
 	if (!sii902x->reset_gpio)
 		return;
 
-	gpiod_set_value(sii902x->reset_gpio, 1);
+	gpiod_set_value_cansleep(sii902x->reset_gpio, 1);
 
 	/* The datasheet says treset-min = 100us. Make it 150us to be sure. */
 	usleep_range(150, 200);
 
-	gpiod_set_value(sii902x->reset_gpio, 0);
+	gpiod_set_value_cansleep(sii902x->reset_gpio, 0);
 }
 
 static enum drm_connector_status sii902x_detect(struct sii902x *sii902x)
-- 
2.34.1

