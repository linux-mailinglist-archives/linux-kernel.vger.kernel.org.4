Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF43F6ED7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjDXWWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjDXWWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:22:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596A96197;
        Mon, 24 Apr 2023 15:22:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94f910ea993so738593066b.3;
        Mon, 24 Apr 2023 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682374959; x=1684966959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pg4ja8Vo564OHJ2nBAkxQ4Tcp7wmH+DSj4m2QDUk50=;
        b=hW+z0i4aZs255609oxDWH5bElZO/63bgaoa1ZQwCVmL4mSYzyT12RawDUxYWjZDqBZ
         eff2y7SEqxJ06VZO4SLEHHkRDNz5KaII7YfxM+10zMrfUFikzJ4NiqvGc484uf6/zXNA
         cNMzp0WGBVke0VhKwj/WEz+KfEaCVC9mT12MRbBFCERlBohfiIAaP3DRhNOJUBUp1WdR
         SowK201WfvyckpOP+3DlPx9iDJ+2zvitVqz2Ypf7+hZT8KiVRNHxMuYM83ja0/iKFP6J
         C7cKhiRTZO7f72usF+SKr42CxHnKQvtknL8B2ARGh+Shyk69H2PO664ZB+ARkHjnlfyA
         b0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374959; x=1684966959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pg4ja8Vo564OHJ2nBAkxQ4Tcp7wmH+DSj4m2QDUk50=;
        b=Lp+DHIQYg8XjxTs6khoqbrVazBZSblnHocHJts0qQpvOkaW+swlB2aPdg9sRMDRGU1
         9b4cmPvajwq8xKQWpwlnksJ1hKE+L/7iQgIuoFxT1mVa7f9h4a/ePVxoS3qb03k0lsY6
         u8jx0855rtBic1VbF/H6wZp//aJSGIqEKWArWJGX+qrRv+Qb7cv75zlw++uMPrHfAoDp
         YqsZ7wVouoAbaLlOV0eQTizxaZT3GIlkkjygk2A/D/9DDex6aiQ34qeAlASouznWbUWp
         NOItHoFVNcf2cJ+W5Aq5OG35KX/DckEMqAEuNLLH/Tf+8vjiWBogNQ9jEAbtd+Kodn4t
         mDqw==
X-Gm-Message-State: AAQBX9fOLMKgWqRMu/xoeuJMHMEZGSPfWzo+e636izPuuBvGRWAjk9QC
        8IsgVk8G1e+hP/RShOLwiws=
X-Google-Smtp-Source: AKy350YCpi1U5IpXjqvjPogreU7FKXJtmmPwQP6dX9FMAQp18ryka83ycovdAI9ChkzcUt5wvWvhtw==
X-Received: by 2002:a17:907:2d92:b0:94a:5361:d447 with SMTP id gt18-20020a1709072d9200b0094a5361d447mr10276716ejc.73.1682374958743;
        Mon, 24 Apr 2023 15:22:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::2fd0])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906539500b0094efdfe60dcsm5870886ejo.206.2023.04.24.15.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:22:38 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v3 2/7] iio: accel: kionix-kx022a: Remove blank lines
Date:   Tue, 25 Apr 2023 00:22:22 +0200
Message-Id: <40c033bc4c139fe450d8785c327f500f6f3ca965.1682373451.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1682373451.git.mehdi.djait.k@gmail.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
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

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
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

