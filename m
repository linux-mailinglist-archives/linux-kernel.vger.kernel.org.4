Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1346B5B14
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCKLUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCKLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:19:52 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B6FE061B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:17:09 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id er25so2611382edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeJqWZmIWIQYf/vyLenHeQ0JsQ8pjtOGtaM4WzEFmbc=;
        b=K4PlKgk6vphG7B8A+tKgwgLYu/eve2VtLYCEGfkUgVLwaOgCPb7AYrJKKgc58vohjO
         rzTftPa2ZxcY1mI64stQAL5MZ+JQPxTaEr1Y9AxaQYrbXROSwSQp5n05Z9wTPZYRFpmx
         Bx3zHVIcTIzCEjsajZ9GXEVo76iXFDZjOIW2qT5m5hbGmWcJdF+q6Sc+llFTkWrO6/9V
         duhkPfdmrunbmk+l25R3ueAi1TwDW72GfXGvCgamBE9c2PG9Rg1A0BPHsQOdMTqKJ21u
         X5qwUSuCcnDZb4uy/0MbHeF50kr+hbPu17toFAd8eu2Mm/u8Rj3Fbv+gwMYWmhA/wgTN
         7xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeJqWZmIWIQYf/vyLenHeQ0JsQ8pjtOGtaM4WzEFmbc=;
        b=sfl9XyaoVOYgYROKeChiAbq5U2LGB3ABgAVCFsmffwyaMqFby/kKL2Ej39AcRZ1Geq
         /Qct4BPj1EIOrHsfScDoblI2cBoOll4Xsxo/C45gKTnvnbWhioNMBXEBOvS2B26BILhY
         f5zFHoJavAZsCT4bvOS5rczbpHyRsTDBquZO6/i/vb9s/wN4CBEfX+GIkIelZEUXzUcx
         I1HeUomnVCW/DFH4OqM7lqCPCIlYBmYhMLi/H7nAViQ5KNbsDca7bs2/e9ywR/A+KKim
         GYTFr8pUu5aO9CGQisFM+qGRVqS14zuIgKi9ssmK74j0Os97qA40a9d+5/fjrVWEGPc2
         0BhA==
X-Gm-Message-State: AO0yUKVH+cQRSmSLDgtfyVvmcl/Qgrx5qV40pAVkvbZWw/b98d4BmXAk
        bgFcJkLsxQ5I3CM+wVC1aAmvaw==
X-Google-Smtp-Source: AK7set9OSxnoFK3vtZqGbIpUURfI1SqkV0jUsrsq7RgkKMadcVINTomgv4XfMX5TfGl07OS2xYV+hA==
X-Received: by 2002:a17:906:b88c:b0:8cf:fda0:5b9b with SMTP id hb12-20020a170906b88c00b008cffda05b9bmr5146168ejb.22.1678533423260;
        Sat, 11 Mar 2023 03:17:03 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id mp27-20020a1709071b1b00b008d398a4e687sm973975ejc.158.2023.03.11.03.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:17:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Qii Wang <qii.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-i2c@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-actions@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/5] i2c: xiic: hide OF related data for COMPILE_TEST
Date:   Sat, 11 Mar 2023 12:16:56 +0100
Message-Id: <20230311111658.251951-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111658.251951-1-krzysztof.kozlowski@linaro.org>
References: <20230311111658.251951-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/i2c/busses/i2c-xiic.c:1202:39: error: ‘xiic_2_00’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/i2c/busses/i2c-xiic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index dbb792fc197e..806b447055fb 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1199,11 +1199,11 @@ static const struct i2c_adapter xiic_adapter = {
 	.algo = &xiic_algorithm,
 };
 
+#if defined(CONFIG_OF)
 static const struct xiic_version_data xiic_2_00 = {
 	.quirks = DYNAMIC_MODE_READ_BROKEN_BIT,
 };
 
-#if defined(CONFIG_OF)
 static const struct of_device_id xiic_of_match[] = {
 	{ .compatible = "xlnx,xps-iic-2.00.a", .data = &xiic_2_00 },
 	{ .compatible = "xlnx,axi-iic-2.1", },
-- 
2.34.1

