Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDA96FFFA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbjELE2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjELE2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:28:19 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BB449DA
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:28:17 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 55A4C2C011D;
        Fri, 12 May 2023 16:28:10 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1683865690;
        bh=GagT8hvc6P+NCio8S5NQPhJe5E1qdikT/egb1xEX7Sk=;
        h=From:To:Cc:Subject:Date:From;
        b=iehmeGg+iFi+wZL1fXyiIkGnqAASLqWP88gDMMd6xXVOPJH0zWZXsjyUiij/jToF0
         DR4rtOGrd6YIUqTqn1GJ/23h9JVBEnCvfns3jFpn/hCxx1jZ/Q5EGoHFwjy0eqq4hb
         Dp40EgewMLMfyc2IOlhDfItqpJaYVxHzH/f2QxqwYIo06rJACovWCrVeMtRxiodZO+
         FIEuJeUC3C45mN0hOztXTUtJ8fWTiVg6Z9Tc0hu7FVVIFpJGNvM2IrHDwi7f7pGqMS
         KwQPqNyFeij49xYPxr2z/93GK/H+t9YGvrq214lyfzRFvaNapvu6AsdMdntzNXusAe
         bCPa4A2PYJ58w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B645dc0590000>; Fri, 12 May 2023 16:28:09 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id F01DF13ED95;
        Fri, 12 May 2023 16:28:09 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id EB5B3283899; Fri, 12 May 2023 16:28:09 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, johan@kernel.org,
        andy.shevchenko@gmail.com, maz@kernel.org,
        Ben Brown <ben.brown@alliedtelesis.co.nz>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Date:   Fri, 12 May 2023 16:28:06 +1200
Message-Id: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=P0xRbXHiH_UA:10 a=VwQbUJbxAAAA:8 a=Op8SjpqLE0gF3w78xgEA:9 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling gpiod_to_irq() creates an irq_desc for the GPIO. This is not
something that should happen when just exporting the GPIO via sysfs. The
effect of this was observed as triggering a warning in
gpiochip_disable_irq() when kexec()ing after exporting a GPIO.

Remove the call to gpiod_to_irq() from gpio_is_visible(). The actual
intended creation of the irq_desc comes via edge_store() when requested
by the user.

Fixes: ebbeba120ab2 ("gpio: sysfs: fix gpio attribute-creation race")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    This is technically a v2 of
    https://lore.kernel.org/lkml/20230510001151.3946931-1-chris.packham@a=
lliedtelesis.co.nz/
    but the solution is so different it's probably best to treat it as a =
new
    patch.

 drivers/gpio/gpiolib-sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 530dfd19d7b5..f859dcd1cbf3 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -362,8 +362,6 @@ static umode_t gpio_is_visible(struct kobject *kobj, =
struct attribute *attr,
 		if (!show_direction)
 			mode =3D 0;
 	} else if (attr =3D=3D &dev_attr_edge.attr) {
-		if (gpiod_to_irq(desc) < 0)
-			mode =3D 0;
 		if (!show_direction && test_bit(FLAG_IS_OUT, &desc->flags))
 			mode =3D 0;
 	}
--=20
2.40.1

