Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2188A6DE64D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjDKVR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDKVRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:17:21 -0400
X-Greylist: delayed 259 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Apr 2023 14:17:20 PDT
Received: from mail.hrdl.eu (mail.hrdl.eu [193.31.26.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6629F55AB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:17:20 -0700 (PDT)
From:   hrdl <git@hrdl.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hrdl.eu; s=mail;
        t=1681247833; bh=+DuBYPKSy4J8nHk/s/G6sZBEUzxszmwy5VNNS20ybWc=;
        h=From:To:Cc:Subject:Date;
        b=MOjyZ0H8ZliQN0PSm9KKM+YzY99Fii9SepE2W/mKTiuKtsF0A7saa1dzd3nuPsaSr
         3GPVy26mL7q4vm87BeZEEeDonIxBU7GjAyNNMMPI8KfZr8VQuyH3pooMbAo2xdCHBz
         f6l3XbiVGpV70LpxNdmrcFFmBdm/kfhvZs9kablk=
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>, hrdl <git@hrdl.eu>
Subject: [PATCH] Input: cyttsp5 - fix sensing configuration data structure
Date:   Tue, 11 Apr 2023 23:16:51 +0200
Message-Id: <20230411211651.3791304-1-git@hrdl.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this patch, the sensing configuration data was not parsed
correctly, breaking detection of max_tch. The vendor driver includes
this field. This change informs the driver about the correct maximum
number of simultaneous touch inputs.

Tested on a Pine64 PineNote with a modified touch screen controller
firmware.

Signed-off-by: hrdl <git@hrdl.eu>
---
 drivers/input/touchscreen/cyttsp5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 16caffa35dd9..30102cb80fac 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -111,6 +111,7 @@ struct cyttsp5_sensing_conf_data_dev {
 	__le16 max_z;
 	u8 origin_x;
 	u8 origin_y;
+	u8 panel_id;
 	u8 btn;
 	u8 scan_mode;
 	u8 max_num_of_tch_per_refresh_cycle;
-- 
2.39.2

