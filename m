Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8906316C1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 23:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKTWMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 17:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiKTWMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 17:12:24 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B5426120;
        Sun, 20 Nov 2022 14:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pDEjgpvsAu6uo2RIiSHglP99uNky2FjdyFx/KtLLazk=; b=IxzGs5ZhUOEIHUlFdwn0Wyo2Xs
        m3qcQQ63QDBfNlGDIabucsa0v3CaZbqT3aTByV1rcN/aFRzTXNylVxhJX3Ezk6yGF0efrwvhyuSdL
        nDzxBo6s3wx9+YQuGfVvC+o3WHr3yJtmtYDzAXy0nVsDebLo8YOg8O+emZ0jjnVoNF5fqdZO5KXNJ
        McVuTLq0q92tr/nCEJBfWLC0JHuSk+PZA62anYfytJ6lm3vnM0yPyuqo83k827IjNg95KqkRYCUlI
        0/y52qgFJGa5DoPGbfA4FIBMBCzJx64ObnjmjaoUnUFKIf1J3ePg3IeIc97muspivY3CJNToAFsDz
        a4cLt6BQ==;
Received: from p200300ccff43b2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff43:b200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1owsXv-00068x-5h; Sun, 20 Nov 2022 23:12:15 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1owsXu-00Cypj-8V; Sun, 20 Nov 2022 23:12:14 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org,
        Nicolae_Rosia@mentor.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/2] regulator: twl6030: re-add TWL6032_SUBCLASS
Date:   Sun, 20 Nov 2022 23:12:07 +0100
Message-Id: <20221120221208.3093727-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120221208.3093727-1-andreas@kemnade.info>
References: <20221120221208.3093727-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In former times, info->feature was populated via the parent driver
by pdata/regulator_init_data->driver_data for all regulators when
USB_PRODUCT_ID_LSB indicates a TWL6032.
Today, the information is not set, so re-add it at the regulator
definitions.

Fixes: 25d82337705e2 ("regulator: twl: make driver DT only")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/regulator/twl6030-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 430265c404d6..7c7e3648ea4b 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -530,6 +530,7 @@ static const struct twlreg_info TWL6030_INFO_##label = { \
 #define TWL6032_ADJUSTABLE_LDO(label, offset) \
 static const struct twlreg_info TWL6032_INFO_##label = { \
 	.base = offset, \
+	.features = TWL6032_SUBCLASS, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6032_REG_##label, \
@@ -562,6 +563,7 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 #define TWL6032_ADJUSTABLE_SMPS(label, offset) \
 static const struct twlreg_info TWLSMPS_INFO_##label = { \
 	.base = offset, \
+	.features = TWL6032_SUBCLASS, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6032_REG_##label, \
-- 
2.30.2

