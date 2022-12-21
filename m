Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85075653752
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiLUUF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLUUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:05:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D326ACF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:05:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso2245563wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GCVPxNOfZPjoH+iSfPJoYT9Y7Q3SbCUZMuBG+FFY/r4=;
        b=P1g+Cwpc1WDGimKmvk+WiCpsK7FonHsr//o5NpUfEEr9vCZaeBxP9iBUJzoz82tvpF
         /NBkcz7Zhc2dY4ZNFoXTB0DHvIP4Ncd0KQWuOoAiBpF7WDqwawtlqhvx1UFBx+JdICqk
         RGuEfqAquJV58Uzf/1ZeX2r5HnIszAuxaW0wdn8PVq5CsHj5CDS+c9SQyjhNFFmx0f7y
         6Ao7kADIIXx+FB1hrI9uCn17nlJdBjufFE2wb7RudBeowmCfQ8bJKEd6F5MleHgevmkw
         axNGPie6p1QLHoIOSwuln22c+zMfr0H5QFdkk+tZAnaGwybslSC11t4DWRsT3PTJ4fpC
         PqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCVPxNOfZPjoH+iSfPJoYT9Y7Q3SbCUZMuBG+FFY/r4=;
        b=AuMfsehQH8glTvGRcanujX6OiYTbFapRWNkRBtK0+7FUDH7iA0ctK919wyiHkEoNyr
         VWbyL/W8o0joMvUZQ9oOXIZ6fuU4OmaAeJUbI6p337afa61pKTyAU3adfVsq4o1WxmL3
         yppSx2KMhMXXl65CcUN+JeNN+ll7bH4T+h1j9W+CcfolvTgrGQZST2AH7k2o+VuE7nqD
         NH095RKwPDQa8dO8hK9J/8U7JqIQ9k/efIiu3ha/YpjdvwZCAgJ8/hjVY4PwIIwuOArd
         ay/uTw6wpYIjgk5nCE0jdwXDtQO0ZrvihOajvTRjC5+TKb5TH0zvEjprMH9H2B2B8sFU
         pytw==
X-Gm-Message-State: AFqh2kodFWwVxT0NXuT8x6Wi4QPZx5TEo7embkNnYhZLkqlONpb1Z/wz
        5883QhwCw4Uzn1SRWflWZonuMg==
X-Google-Smtp-Source: AMrXdXvhuOTSVIVG4TGZTo4fZC4E470tM06O66vurlp8EVhJ4shdZuEGn/93xrjjXnc5xBIFnQJ+oQ==
X-Received: by 2002:a05:600c:3b83:b0:3d3:864a:116e with SMTP id n3-20020a05600c3b8300b003d3864a116emr2565423wms.26.1671653122511;
        Wed, 21 Dec 2022 12:05:22 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:3a9d:700a:1a4b:216a])
        by smtp.gmail.com with ESMTPSA id u18-20020adfeb52000000b002423dc3b1a9sm15943228wrn.52.2022.12.21.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 12:05:21 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     peter.ujfalusi@gmail.com, nm@ti.com, ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        grygorii.strashko@ti.com, khilman@baylibre.com,
        mkorpershoek@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH] soc: ti: k3-ringacc: Add try_module_get() to k3_dmaring_request_dual_ring()
Date:   Wed, 21 Dec 2022 21:05:13 +0100
Message-Id: <20221221200513.676744-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the k3 ring accelerator driver has been modified to add module build
support, try_module_get() and module_put() have been added to update the
module refcnt. One code path has not been updated and it has introduced
an issue where the refcnt is decremented by module_put() in 
k3_ringacc_ring_free() without being incremented previously.
Adding try_module_get() to k3_dmaring_request_dual_ring() ensures the
refcnt is kept up to date.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 drivers/soc/ti/k3-ringacc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index e01e4d815230a..8f131368a7586 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -406,6 +406,11 @@ static int k3_dmaring_request_dual_ring(struct k3_ringacc *ringacc, int fwd_id,
 
 	mutex_lock(&ringacc->req_lock);
 
+	if (!try_module_get(ringacc->dev->driver->owner)) {
+		ret = -EINVAL;
+		goto err_module_get;
+	}
+
 	if (test_bit(fwd_id, ringacc->rings_inuse)) {
 		ret = -EBUSY;
 		goto error;
@@ -421,6 +426,8 @@ static int k3_dmaring_request_dual_ring(struct k3_ringacc *ringacc, int fwd_id,
 	return 0;
 
 error:
+	module_put(ringacc->dev->driver->owner);
+err_module_get:
 	mutex_unlock(&ringacc->req_lock);
 	return ret;
 }
-- 
2.25.1

