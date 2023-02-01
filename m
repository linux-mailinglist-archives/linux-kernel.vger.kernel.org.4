Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C642686C6D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjBARHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBARHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:07:49 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CAF751BE;
        Wed,  1 Feb 2023 09:07:46 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D9309CD5F1;
        Wed,  1 Feb 2023 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675271235; bh=irj9IbvoRsw66nkVg8fECEY8qTjAkErYN2bE/CDzO1k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=AIHR0LAX2GCZa7AqZ0Ti2SMxSU/cE8GePFBaImWEszsTPAi4h24Rm9Kzuze2h1DjP
         deucvASgC8kjCMV4v4a66gODrZCh23arpDbBgGPw4DFrgghfl9ls7M0kxwM2kXalSg
         qlVK/JDrA3nJFEwiYMMpRB7HZbggi+si+9+3XPIU=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 01 Feb 2023 18:06:59 +0100
Subject: [PATCH v2 2/4] media: i2c: ov2685: Add print for power on write
 failed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v2-2-210400f2b63e@z3ntu.xyz>
References: <20230129-ov2685-improvements-v2-0-210400f2b63e@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v2-0-210400f2b63e@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=irj9IbvoRsw66nkVg8fECEY8qTjAkErYN2bE/CDzO1k=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj2pxAsZR3upyzyoEiKg3AO7AyD0lBdOly7HaeOIFc
 BV3KvH6JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY9qcQAAKCRBy2EO4nU3XVn16D/
 4ppyzkdy2azwUaBozrFRetdxhmkT29cWTgaiYzDZS8dJCXnRiD/6VJeMUYtGzt27eH9lGqvJTuRiDB
 7chgAeNMjiSLbdbeJmS9YycrUMI5uEpCGifFhkrJ5pCUO5ForyHZwCl2av704XzWbGRDqtB/nk2oIh
 Gtw6SaCHYSC/O1zgwlz3mYMp7ZhwvGYFKJfsf79owOGI6wDSIn3hNgtpAg8RzK204VdyGO6DIYj6ZI
 9PFKz4T2U+I8jAXvhFR+U7jKt213oVnbX8f9FDXFUnJn0GPkVTCYmNbiwuZ0Q7KoZnXCPAhbksw4sV
 DCcP5CrX0U6FabYWp+K8NgXyM5bjuYPGrluc1FlnAWfHRYCADaxaybgxVh+3L7+idpJRYBQ5tqHaMr
 l88SqyxVBtHyrTKhPuUWvZPDcdS1h2uYsLeZHchb00QtdOmB9dXVwkJh7RqebR+iP54zDY2CK/3qGr
 QJY+5g1qPeCPe6xKe3dXZEJ5HAysNVaFhiA4LMF95xJDh+hbr+Z4q7nWfx0r2/29R6ees+QZV03meM
 mV/9vzJpqWNYV13bLQ28ie/+22xn/v+lymCB9HgZVK75k8uQ0mxEgGE9vzkcPG/QzTezFqpsyQmj6+
 u0W6ZG9qAc5cQcOl+hvdOS7OkRXubTHxXXPH7/8MhN4JoKjOQWL32jvKKcuA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the sensor doens't power up correctly, for example due to incorrect
devicetree description, the power up i2c writes will fail.

Add an error print for this situation.

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/media/i2c/ov2685.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index a422f4c8a2eb..844a91dbc8e5 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -419,8 +419,10 @@ static int __ov2685_power_on(struct ov2685 *ov2685)
 	 * writing register before .s_stream() as a workaround
 	 */
 	ret = ov2685_write_array(ov2685->client, ov2685->cur_mode->reg_list);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "Failed to set regs for power on\n");
 		goto disable_supplies;
+	}
 
 	return 0;
 

-- 
2.39.1

