Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C372DF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbjFMKXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbjFMKW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:22:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA0A1730;
        Tue, 13 Jun 2023 03:22:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977c72b116fso809454866b.3;
        Tue, 13 Jun 2023 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686651773; x=1689243773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugxj97KqvKg74XeLgz0gW9mH+nULVCdroOF8FezjP+o=;
        b=ClYMJ7wjN47BDN3IHaUU9Q0zRcArOSJ2FwiV76gBzW2bU+h8o/IoMV5gK7ok+Z55I7
         SIwlTOP1vj5SMW2hQAwFN7Hcv8ufeuLVtiYvSJ1uNcMOmNzU/fvdpFEIubjr8EvfK2qf
         Sy1W5wDMZjRlcZxit0FFYHY0++vkp3kwh5fmh6p4IbRGQgPG7WSNk0oVUzP6FDel6FhU
         1AToeHnzrGq+P4dMfRcmRZGPeO4ivbUmsOyZKP1OfXdU9Tp9QizMu3m1nK3g8bhOVC5b
         qKaonsEB3CHda52oLcoriElCkeTvjmIPnI4txTL7t0SP0oUudgF3FKx3SynsTPT4KLXt
         tKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651773; x=1689243773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugxj97KqvKg74XeLgz0gW9mH+nULVCdroOF8FezjP+o=;
        b=Wcnutd1bNB6r1FNrsS8TLAcOlLgvi/BkVlpbvX4i3BZp5kjXk3/OopYrvPOQMolHCH
         YVM7l0KUdEdJimDnmwP9C97Hf+jGft1uL187qP0fThmiEPvVhpXhAvWljEhXFRnu+x6S
         kd5Ft6rOQvWavP1G8KtBArlYLCUADPRxQEJlWdhEygX9T3xZLhSL/FFfGAwrOAsKzFBO
         A3JOaJ+v3Ic6w21q7ZrIcVhd3Nt7Hu8Su+5FN74zKAuiCwIO8CLPPrVgGKN6Ct6zMLzw
         yfLSOgG9fpF76u11YHbzlxBAesaJVKNT2v15+wbfI4eXHmiMVfd1sb7WDWuz+4yYHPHs
         I06w==
X-Gm-Message-State: AC+VfDw4I237SgNw7WVNaKUw3aE2b4gJCIW1PG9I5zyDDLtgcwppoZok
        tH//ZIT17BEVTXXslRAdTHs=
X-Google-Smtp-Source: ACHHUZ6TJeNJaRDThGWXHr3lWrbhfkhbUd8SJZ8350KmV6xffnkDYAgBstCykzPKmgGCjYc8ITi0WA==
X-Received: by 2002:a17:906:5d0a:b0:975:63f4:46 with SMTP id g10-20020a1709065d0a00b0097563f40046mr12032960ejt.57.1686651773602;
        Tue, 13 Jun 2023 03:22:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::298a])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906038700b009787b18c253sm6492493eja.181.2023.06.13.03.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:22:53 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v6 2/7] iio: accel: kionix-kx022a: Remove blank lines
Date:   Tue, 13 Jun 2023 12:22:35 +0200
Message-Id: <b1809c807b0638c9a171ac56e99e9773531610be.1686651032.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1686651032.git.mehdi.djait.k@gmail.com>
References: <cover.1686651032.git.mehdi.djait.k@gmail.com>
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

Remove blank lines pointed out by the checkpatch script

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v6:
v5:
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

