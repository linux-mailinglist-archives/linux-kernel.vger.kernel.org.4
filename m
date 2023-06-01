Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379D371F656
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjFAXCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjFAXCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:02:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A873513D;
        Thu,  1 Jun 2023 16:02:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2565a9107d2so1168598a91.0;
        Thu, 01 Jun 2023 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685660526; x=1688252526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akyKWVKyPkLNxMRzqWTgHJvGDhTUQ+cKpoqfMEuES1s=;
        b=Z1TldImGdHh5WKKakOd8SqXgjXij3ti28t3rDoa98vhzDHwdekhc//euUT4Q++ou69
         /IgEU2iq54entM15v7jvboFkHct1q+9uSj0IxduCSrPyHjNVR11oTn6lFwljfv96hZCA
         46pEEJ2XFy1WCQt1YZh/R0lxdWF4Ok2bGb9lpqLoBUKVfBM065dSfMW5g7eeI8lJ5lUy
         d7cHEolgX8zxiVjK7YJf/+1qS9kaCwMrI9IdnR0HLr8f6qvXCnNPZ3+qkxHRj1cm1kaa
         PmanXr8QVTO/cZjvD2fMfI1wwSMyMte5Zqls7uAJIaM7uaQ05ATwHD3oudzAChbLTSuC
         OzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685660526; x=1688252526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akyKWVKyPkLNxMRzqWTgHJvGDhTUQ+cKpoqfMEuES1s=;
        b=fbb69JgyCkDyL8wzCNADJnSCg5GJnGGi+pXHwD/6/TpP9Ai0gALjMpHFlOnpWtcuRn
         5mLUoFdwzVx8Qym5jw4hOx+VOFYHLM5pybg8nah2558grmDCu8Vvv8g6EZQPgbrMmMZT
         tKYBJC4CNQ38H6PJWeH+QQ+B4t+xd1N/4DShUe18kQFEQrtW+9xGtLPk7+h4iFHeJV2y
         1qdTxqlp1PnUiJ8AKMPutbCoRmLMBAuUxEnfWaBg1kV1FKiJ01m+5vK6UNHjqmTnqltW
         MMBh4i6qe7J3uJZEgTn4s68bMRDV1JkpTc0CoRm/++0Y95PM5dH5SRsgsUKcK39fxOo0
         Bzhg==
X-Gm-Message-State: AC+VfDybR84k/972HfmExSiKAkz8b1JmsiPBVvGGN0CNvghYY+M+v/rR
        WFj3DXsFS0Y64MMiE31siZE=
X-Google-Smtp-Source: ACHHUZ6/gnPmL2tIRTv+0dxsIHyj8zqa7pkfBP26gcDxqk6VPGK66clmxdjguCxUmn95SaPHfxRH8w==
X-Received: by 2002:a17:90a:598b:b0:255:9038:fe0d with SMTP id l11-20020a17090a598b00b002559038fe0dmr624958pji.38.1685660526088;
        Thu, 01 Jun 2023 16:02:06 -0700 (PDT)
Received: from babbage.. (162-227-164-7.lightspeed.sntcca.sbcglobal.net. [162.227.164.7])
        by smtp.gmail.com with ESMTPSA id lr4-20020a17090b4b8400b002467717fa60sm23957pjb.16.2023.06.01.16.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 16:02:05 -0700 (PDT)
From:   msmulski2@gmail.com
To:     linus.walleij@linaro.org
Cc:     brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Smulski <michal.smulski@ooma.com>
Subject: [PATCH v2 1/1] gpio: mpc8xxx: latch GPIOs state on module load when configured as output
Date:   Thu,  1 Jun 2023 16:02:00 -0700
Message-Id: <20230601230200.6128-2-msmulski2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601230200.6128-1-msmulski2@gmail.com>
References: <20230601230200.6128-1-msmulski2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Smulski <michal.smulski@ooma.com>

Qoriq and related devices allow reading out state of GPIO set as output.
However, currently on driver's init, all outputs are configured as driven
low. So, any changes to GPIO confiuration will drive all pins (configured
as output) as output-low.
This patch latches state of output GPIOs before any GPIO configuration
takes place. This preserves any output settings done prior to loading
the driver (for example, by u-boot).

Signed-off-by: Michal Smulski <michal.smulski@ooma.com>
---
 drivers/gpio/gpio-mpc8xxx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 3eb08cd1fdc0..6340e738c912 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -375,8 +375,12 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "fsl,qoriq-gpio") ||
 	    of_device_is_compatible(np, "fsl,ls1028a-gpio") ||
 	    of_device_is_compatible(np, "fsl,ls1088a-gpio") ||
-	    is_acpi_node(fwnode))
+	    is_acpi_node(fwnode)) {
 		gc->write_reg(mpc8xxx_gc->regs + GPIO_IBE, 0xffffffff);
+		/* Also, latch state of GPIOs configured as output by bootloader. */
+		gc->bgpio_data = gc->read_reg(mpc8xxx_gc->regs + GPIO_DAT) &
+			gc->read_reg(mpc8xxx_gc->regs + GPIO_DIR);
+	}
 
 	ret = devm_gpiochip_add_data(&pdev->dev, gc, mpc8xxx_gc);
 	if (ret) {
-- 
2.34.1

