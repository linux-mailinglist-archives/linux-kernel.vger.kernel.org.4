Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DA65B8A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiINOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiINOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:14:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413E2B49B;
        Wed, 14 Sep 2022 07:14:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so9690846pjk.4;
        Wed, 14 Sep 2022 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=D7Rv1WZZo0HfxpirDtBnZT8VvHiByqEzO0fGerdexis=;
        b=C5W9glDC9i54iFxt/XgUUYpTCA96hecmSGt+OGqz8QrgL9VvSY/dHxSJH9IJU6pZ/d
         eilImrNNfSmg/C7//uO8LyFjLe82OfL5it2nIgsYnFLZkCnO+LQfR946ANsHUTwYZvFo
         pP3HsIxSFCQ9TweMY1ToFF1Gx4LdH1LPflkjwitUwmvFTnH4/ec7NxO84sJgtUVWATvo
         UqOIV499d/FEfXl1v1Wn+X/HvCqo0eM+pS+WIoaTs5Zx1QHqJ3p6maytSvGVynLaZKD0
         Ce6dutPPsc6PY+f5LzTEzrnR3NiONDn69HsZpnsQ+79NXSl3l7pAup7cPaVH/3085bGg
         dLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=D7Rv1WZZo0HfxpirDtBnZT8VvHiByqEzO0fGerdexis=;
        b=aQRRRr/63gvWZxJXc/ghLI4OkBBdMGgKLt/bhEAAc48iuKIfOBdxRLBFZun8C4DteS
         GEB+kfBG1cKncTfMrdvz5YVIp/fUuDc4MuVppxZwwctLL25xTH0zatd6lWV9xtwZdIv9
         a542tJxEteDA4kCrMgtU1Vd3LHXXxe2Uv1eXWdtf5l8YQAqLn5qi24CEzdRra5TEXWlH
         AC2mHKGRqfpkQ2Y8y+lRguM1Mv0L2HrIdv/ZU8KXDlCxGDJpWmyEQW4lsajQGKMw0Xlj
         qYWb9OdQq2RNnl2xv7eZqhTcOcFp7aYvWJyQ0taEDa19t8Q6JJO6fgBHy3RGKlbGVqGA
         aoAw==
X-Gm-Message-State: ACrzQf218fANxRJXEJAmPzZiiJ9wc5WMtjQ81aFOUr8T7Nw7y1P7VNme
        ObEQYVG3peftaH8oBJQMI6o=
X-Google-Smtp-Source: AMsMyM5op+DAcF+r4ir1DqOBWr/RDD1128G+uL2B0ZElCjhUleZy9UShq90ly+85T0O/4G6Puze6xA==
X-Received: by 2002:a17:90b:224a:b0:203:d20:b92b with SMTP id hk10-20020a17090b224a00b002030d20b92bmr5024339pjb.17.1663164878385;
        Wed, 14 Sep 2022 07:14:38 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:2f68:fe7:a2e6:7595])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0017839e5abfasm6480624plh.263.2022.09.14.07.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:14:38 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] dt-bindings: input: auo-pixcir-ts: fix gpio and interrupt properties
Date:   Wed, 14 Sep 2022 07:14:28 -0700
Message-Id: <20220914141428.2201784-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
References: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper interrupt trigger and gpio polarity data to the binding example.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/auo_pixcir_ts.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/auo_pixcir_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/auo_pixcir_ts.txt
index f40f21c642b9..b8db975e9f77 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/auo_pixcir_ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/auo_pixcir_ts.txt
@@ -17,10 +17,10 @@ Example:
 		auo_pixcir_ts@5c {
 			compatible = "auo,auo_pixcir_ts";
 			reg = <0x5c>;
-			interrupts = <2 0>;
+			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
 
-			gpios = <&gpf 2 0 2>, /* INT */
-				<&gpf 5 1 0>; /* RST */
+			gpios = <&gpf 2 0 GPIO_LEVEL_HIGH>, /* INT */
+				<&gpf 5 1 GPIO_LEVEL_LOW>; /* RST */
 
 			x-size = <800>;
 			y-size = <600>;
-- 
2.37.2.789.g6183377224-goog

