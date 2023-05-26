Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D697C712843
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbjEZObJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbjEZObG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:31:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B15D187;
        Fri, 26 May 2023 07:31:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510eb3dbaaeso1353382a12.1;
        Fri, 26 May 2023 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685111462; x=1687703462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+9f25ca4rz+2FZ8Gemnn0XEwiBdFXDfccTa66p6xkM=;
        b=KNPC1AAbof+1iiPmBhT4VAQevOf5BP8bYKrBgPD0zSvHenFGnDLyuZDzoRiPscc6Ny
         3oPhDzs1Zcddh03E+0AkwklXkxiAnIaP57MSrI6zw+N1kLO7Qwf2odJ2KsV4+V1o5DBZ
         gf7UMaQBtIRtPR8f7FZUg7kV/GHnoyE8DpU60QaAHUf1Hnff9c0qrM85gDouFrn7w84j
         Pj6fgYg1419Vhq5bJwq44Uvzr5DXGBndclQ6j57KWvgVUwvaO1oAGw/6DuJHlf365E6A
         cqlHAC3hUq3TOi1/lBx+dhSnunC2a2FgTogOuaYI2O29ySPiQftuYqjOuzJV72uxwoRD
         a8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685111462; x=1687703462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+9f25ca4rz+2FZ8Gemnn0XEwiBdFXDfccTa66p6xkM=;
        b=SvywFLEjB/LlhvCB2MtnmglD1IKm1xAhxJac14W4Oh9h1jRiQYjXPijCLdtecUJ5fj
         LIHFsa/9hfgZXEULmJa000bHHQD28FHGWTCOEQ5+eujc6frrYX81Bo5jjQp1DqAi+4lw
         fA+SlunXhZocgdl4Nwd/+yyAKQrPToXeN3vu6TAmxd4euy7VjzCUCeGwF9T0vXLGc4SU
         vPBmU5L4wJlkcU+SzOdTh49+reDQuYXMfD69ehNfUp0aCcOG45znVC5ESfaqpKnyD7F0
         5edXKJ0KUz6e1PAUHwk4+13iD5dQu7GTfImOnIgqSYeqeZd3pnCa+r+VHne2XyK3PlgE
         aEbA==
X-Gm-Message-State: AC+VfDwzz5pUdEC7dPDdBlUvjVp/gS/QGP83kyyizLLG8iomr+BdIKmH
        OTRYnadI3xK7uCQdhxF/vyM=
X-Google-Smtp-Source: ACHHUZ44eMNxumGoSGIAJfj7Ubh3UF5ZH9bZm/J4yM1+thT3WbJ0yEwb1aMxQRFYAYobbkQz1Vdrug==
X-Received: by 2002:a17:906:7310:b0:966:1fef:22d8 with SMTP id di16-20020a170906731000b009661fef22d8mr2487662ejc.7.1685111462538;
        Fri, 26 May 2023 07:31:02 -0700 (PDT)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b0094e7d196aa4sm2157023ejb.160.2023.05.26.07.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 07:31:02 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v4 2/7] iio: accel: kionix-kx022a: Remove blank lines
Date:   Fri, 26 May 2023 16:30:43 +0200
Message-Id: <40c033bc4c139fe450d8785c327f500f6f3ca965.1685109507.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1685109507.git.mehdi.djait.k@gmail.com>
References: <cover.1685109507.git.mehdi.djait.k@gmail.com>
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

Remove blank lines pointed out by the checkpatch script.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v4:
- no changes

v3:
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index f98393d74666..ff8aa7b9568e 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -341,7 +341,6 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
 		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
 
 	return ret;
-
 }
 
 static int kx022a_turn_off_lock(struct kx022a_data *data)
@@ -1121,7 +1120,6 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret)
 		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
 
-
 	ret = devm_iio_trigger_register(dev, indio_trig);
 	if (ret)
 		return dev_err_probe(data->dev, ret,
-- 
2.30.2

