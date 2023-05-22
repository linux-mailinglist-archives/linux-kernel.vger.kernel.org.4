Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EF370C2BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjEVPxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjEVPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:53:10 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28D4ED;
        Mon, 22 May 2023 08:53:09 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-76c7dfc2e8dso91830139f.0;
        Mon, 22 May 2023 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684770789; x=1687362789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLmTrczoZ4J6h066r40/h6RRWtVqrmn9y6L7z99mhDA=;
        b=lpf/KCk2o5YuPZx1QBrkgf1w2q7/f7AMacPCaayBzf0ydgnri8mN4UPzfhfTEkoH9g
         Hiv8S4T5u3nWXvti74xZiSj5Up4Q7GDop3mGqtiO87mKHzrWX5WznpPrPp0r0ynzZXZz
         pqMa/67Z5Nxj8aYsAeweBTxyes/LbbbPrjbZd1KRBcxwidCrTVz3vWow0avbSOsknIFt
         cwu/wuM2Oimy1eKg2Ksa3NHd0csEdRQClR+WZ769yhGOk8d2Top9MW544F3qyyD+ccqh
         IefbqvVrMmrA5hnsUsFyQD1toOeR0mtOHtCyg3npZWsab1uH3/2IZbhmh0NEjwyT9+qk
         KZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770789; x=1687362789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLmTrczoZ4J6h066r40/h6RRWtVqrmn9y6L7z99mhDA=;
        b=WE1/F4g9zwveR79mnMCMmF/QWhpdArEOaLz6Oq6kj5ikAG0YOp8D0qyCls59wNP+Lx
         bQuP40pXRgNST1K8OzIBeP3roQFgrp3l//RBRcYtOLBQ8des3OdN1fKiU9CnqUSpyZb0
         Uri9j2mPJfSndecW3wpo7kwKQE14gv4dwY7YCat4UgAX6f5gwxXZD419Edvyge4392iz
         trwLPGOgsWsEjDVn+dsvwlyGZF+IJ/aDst9TzBi5+NRajMwAPnc04928Ho5xeRcCGq+K
         EM2huuxd2vavD41H7eUb9WQwyoN02BnM1XmGWIoo/G8Vu+pR4dA2ePIshgMDb3qhGH5z
         0cbA==
X-Gm-Message-State: AC+VfDwF1/scIZU9EnM9mgAaq/TscvGjTXon1Hp/DCMK9wqNOlYnV6Y0
        v5NtXqdLqik2YW8AOxcZYm9Sc/L2SWUGyg==
X-Google-Smtp-Source: ACHHUZ7Oyjj1q6eLDUndWseC7ayiIC4Ona7A2tWc3SNYqjyQ+KripQZ9DB1twIxrC82af0kBQVhI2w==
X-Received: by 2002:a5d:8ac8:0:b0:763:a8a0:c7c0 with SMTP id e8-20020a5d8ac8000000b00763a8a0c7c0mr7033861iot.10.1684770788928;
        Mon, 22 May 2023 08:53:08 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id a1-20020a6b6601000000b007596db3874dsm2016483ioc.35.2023.05.22.08.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:53:08 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm/mediatek: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 15:53:06 +0000
Message-ID: <20230522155306.2336889-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
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

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
index 2fc9214ffa82..4d39ea0a05ca 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
@@ -295,7 +295,7 @@ static int mtk_hdmi_ddc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	strlcpy(ddc->adap.name, "mediatek-hdmi-ddc", sizeof(ddc->adap.name));
+	strscpy(ddc->adap.name, "mediatek-hdmi-ddc", sizeof(ddc->adap.name));
 	ddc->adap.owner = THIS_MODULE;
 	ddc->adap.class = I2C_CLASS_DDC;
 	ddc->adap.algo = &mtk_hdmi_ddc_algorithm;

