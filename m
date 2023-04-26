Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF36EFD05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbjDZWEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjDZWEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:04:24 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCF6F2;
        Wed, 26 Apr 2023 15:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=86/z7JpBpTFJ3jh7x1UT3ZNWieULbXEuuoLuCk5wHYw=; b=64SS/vsfibe+zAHrgDLhZlAsXj
        U8+gqmgFqWYI1epMZKCjf9D22GK6u+mxEoiG9Pr+SDEdrhQQi9iXAkmX/w54J1ivTyqeXzzLnwAnT
        BfdKNXmlJTB6xLSus6ywuS7nTCOGClKPvRfOFfCWZz4f1/KDT6pFlxycF9S1ZhKjUDCxShEnMZr0k
        RM4fWp2iHBuHQWewNdXIvJckrf2zYnOupyQs7/ZfDcSwHcSZAWuv3pl3AG163JTiLd2xRoYKZ1ft8
        tA6hFYdoJUWbXPPjHFZ+kNpqTMnAKfIDezroJPiG1Jl8+o/7qgHRJUSs/jVSIbAuiD93iinx5TUnf
        cpVqBOgw==;
Received: from p200300ccff09c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff09:c200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1prnFE-0008HC-AR; Thu, 27 Apr 2023 00:04:12 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1prnFD-001o20-2v;
        Thu, 27 Apr 2023 00:04:11 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        christophe.leroy@csgroup.eu, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ": Tony Lindgren" <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] gpiolib: fix allocation of mixed dynamic/static GPIOs
Date:   Thu, 27 Apr 2023 00:03:38 +0200
Message-Id: <20230426220338.430638-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If static allocation and dynamic allocation GPIOs are present,
dynamic allocation pollutes the numberspace for static allocation,
causing static allocation to fail.
Enfore dynamic allocation above GPIO_DYNAMIC_BASE.

Seen on a GTA04 when omap-gpio (static) and twl-gpio (dynamic)
raced.
On that device it is fixed invasively by
commit 92bf78b33b0b4 ("gpio: omap: use dynamic allocation of base")
but lets also fix that for devices where there is still
a mixture of static and dynamic allocation.

Fixes: 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS")
Suggested-by: andy.shevchenko@gmail.com
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpio/gpiolib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 19bd23044b017..18b68d0aec7db 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -188,6 +188,10 @@ static int gpiochip_find_base(int ngpio)
 	int base = GPIO_DYNAMIC_BASE;
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
+		/* do not pollute area for static allocation */
+		if (gdev->base < GPIO_DYNAMIC_BASE)
+			continue;
+
 		/* found a free space? */
 		if (gdev->base >= base + ngpio)
 			break;
-- 
2.39.2

