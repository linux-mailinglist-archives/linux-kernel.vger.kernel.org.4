Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2AA731C90
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345217AbjFOP11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345170AbjFOP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:26:48 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2932613E;
        Thu, 15 Jun 2023 08:26:47 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686842805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3aG9CCDrNQunLX6B2n6+DpdxX01wVb/HqBiIu8Vpkig=;
        b=D9nSqMvhhwyfLsaCRe3WKTBe/Omao6njjpCO0ZUme+SHNQNXEvMIcdBcpY2pXpjuqKC+pZ
        29lnniLwkxpMjPB9DLB+/7jMuLWl5JNnuCyCqxc9lyHjKy6B+feF7FOxvY7VSwZJSq3Vee
        ulGIdOuzqlASl5xhPhkC7aBYzYOtjzpvICVxXHnjivYhoKYChY6L+wSYlTsi4i5Ng43x07
        YkBBnm+59abt+OL5KtklcJ37yG5egnwhEFOALu0VX0r1Q3Mx0J9Q30TflOO6UPKlHz7yyC
        pYyzMVMZOkFGhjEnrnis4/fME5XTCplGfL7ADMEaYP2PnZbLCbyBqD1M0zN4FQ==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 72A26FF80E;
        Thu, 15 Jun 2023 15:26:44 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 06/13] iio: inkern: Fix headers inclusion order
Date:   Thu, 15 Jun 2023 17:26:24 +0200
Message-Id: <20230615152631.224529-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615152631.224529-1-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the mutex.h inclusion order as it seems to be the only one
misplaces.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index ce537b4ca6ca..71d0424383b6 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -5,9 +5,9 @@
  */
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
-#include <linux/mutex.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/iio-opaque.h>
-- 
2.40.1

