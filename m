Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1710B66377D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjAJCsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjAJCsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:48:31 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA1233D42;
        Mon,  9 Jan 2023 18:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673318910;
  x=1704854910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=84Qqs7Rp9uTa2WHYoGwl6hURVvefJF0UiJ4y5h0kg4I=;
  b=i8YcfZdT7SGq1DiJiJIWcZLkEgJPDrYdffkrbQKfvRyYiLH03Oeyd0bu
   B5jXZziLcjANmWuyntnUHknD9QzTPwVf+MK9t0DS+SG4k4hXh/0i08x+R
   X7H8V1XHqCUXz2MAjdtf3QZW8EjKHPdMg2ein9k5AwS/ttV5KXgZZRsRY
   ujVjPTegd+Eg30Vh/hYWX+rUnxIqdTce68o/XXUjYskIRhFWSgXfailMR
   qMsaTpuLuQtQ0v35ckBeYhiKVG1KH7kmEBRjkeqPfbFnu46U09JMBT/OA
   z3sKRbgPp7IkCdKGSRJytM3G6fCk0Nv2qlUrP1ZZnh6lBWKBHOgMRAFlL
   Q==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] power: supply: bq256xx: Init ichg/vbat value with chip default value
Date:   Tue, 10 Jan 2023 10:47:46 +0800
Message-ID: <20230110024746.2701738-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init the ichg/vbat reg with chip default value instead of the max value
used now. The max value set in driver will result an unsafe case (e.g.
battery is over charging when in a hot environment) if no user space
update the value later.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---

Notes:
    V2

 drivers/power/supply/bq256xx_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 01ad84fd147c..6b5435bf2ed4 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1563,7 +1563,7 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
 		return ret;
 
 	ret = bq->chip_info->bq256xx_set_ichg(bq,
-				bat_info->constant_charge_current_max_ua);
+				bq->chip_info->bq256xx_def_ichg);
 	if (ret)
 		return ret;
 
@@ -1573,7 +1573,7 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
 		return ret;
 
 	ret = bq->chip_info->bq256xx_set_vbatreg(bq,
-				bat_info->constant_charge_voltage_max_uv);
+				bq->chip_info->bq256xx_def_vbatreg);
 	if (ret)
 		return ret;
 
-- 
2.30.2

