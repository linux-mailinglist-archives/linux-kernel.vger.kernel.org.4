Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962EF6C6A27
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjCWN6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWN56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:57:58 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AE39001;
        Thu, 23 Mar 2023 06:57:57 -0700 (PDT)
Received: from koko.localdomain ([89.1.213.94]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mlf8e-1qO42W3fCk-00iiuN; Thu, 23 Mar 2023 14:52:46 +0100
From:   Maximilian Weigand <mweigand@mweigand.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 4/6] Input: cyttsp5: properly initialize the device as a pm wakeup device
Date:   Thu, 23 Mar 2023 14:52:03 +0100
Message-Id: <20230323135205.1160879-5-mweigand@mweigand.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323135205.1160879-1-mweigand@mweigand.net>
References: <20230323135205.1160879-1-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IukSdTMfV9ZkGrQVT2rC0B+Y/Pto+OPq5ITXNsFzFMoMUaCEDL1
 LHmLGD0PnlwCPvPp6BhuEBKAgQ438yVOcZz0TG43belz6St65TbsbPtpmQeZrWtRqOongCN
 3O8ALtKjxXrm30JqIt5O1CS9gyCRiUMQfGn4SqNsRZvK1Mkn4GWW5qYsX9jadAFjCizveWV
 KE2HZk3Om4rjmvLWj0zEA==
UI-OutboundReport: notjunk:1;M01:P0:AbOjXQs477k=;CWtsoK34/JP8HKzCFveKNB0Zb+z
 8h2cWw4QIgwsiqqCrLBA8GtoMYk91276u94KXw514ZjoHf+MJFHz+5VVjxUPFM9zpD0SOOdWg
 mxXYF2caE8zrn22f/JRTL7GdrRaFL2vHjuHiI5xmPH7Tfk0Hq97AJHeB/CoKmd4YbPMB1ftPg
 jP1kq5ViAHwudtOi/uUVtD2Bk9ltCGSFsk3ZGgVFmt0/XMi7WZP6q5u1IAvlhYvwL8OrX0grr
 SQCxB/7GToId9/7rOE1myZnkkckLVYHYqnm+MAaFwCa0ym6eGKkXq9B46nnQow62lleYRDskr
 oeew8eH1wGxWH0/UffJBJcUVO7VQW/BmfzsLV1GweKs5dwA6pjetZT73whRZKl2k8VqZSSi0c
 SWxPvLXu0/kTjkIvyN1iAh+Kz/74ZS+TTw0HRD78ByPA8MvTNGxyxQciVwpiGlK6BMrW/QZ/l
 rJPVFPHgndAMCnOuPShiG+jRRscPM4IRurb0qTp5hlGqxJBQupqPm6xFkxypWCa/NMIWa6sl2
 RYjgvYeUR/yL62TBou84SBWt5oGz2tVwTy5HPgOsRhp8IAJCn1aN2c5tohw9iae5LswK8sq9s
 NooqeAi2N2J/d7WWtnpAPFnry/5UNIrJ0g+T2KuxxYg3iqkyxNpDqKfGoWlpfr0TGKnMW7b4X
 BX3umrEawAFezN31QgEdBm9+NMTUThlscyxjUp8ySA==
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When used as a wakeup source the driver should be properly registered
with the pm system using device_init_wakeup.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/input/touchscreen/cyttsp5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 8b0c6975c6ec..01dd10a596ab 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -830,6 +830,9 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 		return error;
 	}
 
+	if (device_property_read_bool(dev, "wakeup-source"))
+		device_init_wakeup(dev, true);
+
 	error = cyttsp5_startup(ts);
 	if (error) {
 		dev_err(ts->dev, "Fail initial startup r=%d\n", error);
-- 
2.39.2

