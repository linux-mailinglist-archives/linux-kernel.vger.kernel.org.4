Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB16570BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 00:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiL0XEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 18:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiL0XEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 18:04:22 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD2DDF92
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 15:04:20 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s25so15076944lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 15:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALCXqoODJG4Fl1tVrTYiR0YIC0rXIReKhT1lUtG3hdA=;
        b=yUVecZ76fCB6IvA+Cy8N88tPkw06p37lZ0KXjxTx3ZHIslky5t2WXlZV9KZb/ZaFPK
         26aLSaHZwMTeKto5N5oUi4HW12FrVrdFD8umOH9DB8DoPdV3MIL7bsFbWfGkoP0hxs98
         A3267hW+oerZP6yQzyh2Gn/JaxqbCm8XCBJ+q4M3H+jOIPsQae5d1TEuD0BUiFkp376H
         iY1LUWlWKCFJGekC4nxaq5WJczPk5sUoAFpX/DZC9cT8Plmy3MCkuutHjcmfNnPMxiJw
         fW3RrTjPpbINPMFi26xnHCtSRItCjMSvKI10Ew9AnhUQzNFoBTVYD4WHjeh3WLLPGBr4
         3LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALCXqoODJG4Fl1tVrTYiR0YIC0rXIReKhT1lUtG3hdA=;
        b=0o/cCR22siZIgy+cO2CO6neZ4c/ilpxMMZS/5O3ppf1SvYZm38jKLH8U2DLyp48mYu
         Q+SJAyiDOwPXYyNgR+7Qg7/gmPECM3zP35RcTUbm1u8LETgdG28k9/QlDa6c28rfJ+fN
         VTG4DFpK0UphiASwatwRU+xEzNkGiY6CyeFMab+iTJXHEvWp4vEAkZmymomph1XoVtxr
         K78kVNBFV6JIqhO3Z6H/WAe0uUnQMv+MjMVFOdqehmz8/MzjgisulQOrCeA50CBvrw2I
         7Go1IyvaHzJYcMPDF9phr1Yzm9alVsx7ESNqX+1TX29910TrO59BL9XvGCvRhJn4F8nu
         4Hmw==
X-Gm-Message-State: AFqh2kpszWN6r8W7G8riDbv84l6EEXpUNBDbL6xu66EwS+HiQJG5X9A3
        WC42zctfEUwP8H2XQEj/NbsPaLLl8iw7mQCwEHc=
X-Google-Smtp-Source: AMrXdXuLm80d+XZDJHjvTajcZdy9zM+KujZjLg2FBDMAjQSW+sWpH+i5cLf5CJvpjqnCzwbw8l2iiA==
X-Received: by 2002:a2e:b0d0:0:b0:27f:8b85:4098 with SMTP id g16-20020a2eb0d0000000b0027f8b854098mr6719151ljl.52.1672182260250;
        Tue, 27 Dec 2022 15:04:20 -0800 (PST)
Received: from Fecusia.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05651c0b9900b0027fbd4ee003sm876925ljb.124.2022.12.27.15.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 15:04:15 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Dec 2022 00:03:37 +0100
Subject: [PATCH 5/7] crypto: stm32/hash: Wait for idle before final CPU xmit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221227-ux500-stm32-hash-v1-5-b637ac4cda01@linaro.org>
References: <20221227-ux500-stm32-hash-v1-0-b637ac4cda01@linaro.org>
In-Reply-To: <20221227-ux500-stm32-hash-v1-0-b637ac4cda01@linaro.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calculating the hash using the CPU, right before the final
hash calculation, heavy testing on Ux500 reveals that it is wise
to wait for the hardware to go idle before calculating the
final hash.

The default test vectors mostlt worked fine, but when I used the
extensive tests and stress the hardware I ran into this problem.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/crypto/stm32/stm32-hash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 5f03be121787..92b2d55d6e93 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -362,6 +362,9 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 		stm32_hash_write(hdev, HASH_DIN, buffer[count]);
 
 	if (final) {
+		if (stm32_hash_wait_busy(hdev))
+			return -ETIMEDOUT;
+
 		stm32_hash_set_nblw(hdev, length);
 		reg = stm32_hash_read(hdev, HASH_STR);
 		reg |= HASH_STR_DCAL;

-- 
2.38.1
