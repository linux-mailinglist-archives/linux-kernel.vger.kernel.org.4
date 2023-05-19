Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8C2708F29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 07:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjESFHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 01:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESFHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 01:07:22 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200C419C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 22:07:18 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7FBD12C01D8;
        Fri, 19 May 2023 17:07:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684472825;
        bh=32gSY5w+PANxi1B/B+/bHMGQXs4kLuI5sUqJUzM4hx8=;
        h=From:To:Cc:Subject:Date:From;
        b=j9oZFf/dluAWoTYulElN+w8l9fvAQUkGal799tiCONo1/vUAPfFO4ctkMWEg4Y8Ys
         03Fcou3vxiU6I4OBtjwjdQG3UURU07meQI3ORqxtj1sKtwphzNbVpnS/hHSdyyZqYb
         d4CJrKJFsyJW3XILr4HhOspau1qxtbQ4+kKdpFhzu8lDia8AL5Q1GZIzpRGBEpWewB
         v5bkn4Sf9ZoPJkan60Ru2u5erpGfrEJREuYZ6HPWJ3DqYCLFEczFbHp33c8zKubHxw
         QthnIoYe7fApSt2aj8VUXkcNETlpsb8RgoMP8oSL8f3ea+Brn2CMWntFGMJbtsmDQn
         RpddfrO9Ev/LQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B646703f90000>; Fri, 19 May 2023 17:07:05 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 4AB3513EDAE;
        Fri, 19 May 2023 17:07:05 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4731B28DACC; Fri, 19 May 2023 17:07:05 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy.shevchenko@gmail.com,
        johan@kernel.org, maz@kernel.org, warthog618@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2] gpiolib: Avoid side effects in gpio_is_visible()
Date:   Fri, 19 May 2023 17:07:02 +1200
Message-Id: <20230519050702.3681791-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=P0xRbXHiH_UA:10 a=Op8SjpqLE0gF3w78xgEA:9
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

On a system with pca9555 GPIOs that have been exported via sysfs the
following warning could be triggered on kexec().

  WARNING: CPU: 0 PID: 265 at drivers/gpio/gpiolib.c:3411 gpiochip_disabl=
e_irq
  Call trace:
   gpiochip_disable_irq
   machine_crash_shutdown
   __crash_kexec
   panic
   sysrq_reset_seq_param_set
   __handle_sysrq
   write_sysrq_trigger

The warning is triggered because there is an irq_desc for the GPIO but
it does not have the FLAG_USED_AS_IRQ set. This is because when the GPIO
is exported via gpiod_export(), gpio_is_visible() is used to determine
if the "edge" attribute should be provided but in doing so it ends up
calling gpiochip_to_irq() which creates the irq_desc.

Remove the call to gpiod_to_irq() from gpio_is_visible(). The actual
intended creation of the irq_desc comes via edge_store() when requested
by the user.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - expand commit message to (hopefully) better describe the problem an=
d
      solution
    - drop the inaccurate fixes tag

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

