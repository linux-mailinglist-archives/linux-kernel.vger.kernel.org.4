Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621196C9326
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjCZIug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 04:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZIud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 04:50:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8CF7EF9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:50:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so24108600ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679820629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HelX9TaRrTL0/uXiqpcAS3IoL+rsoXCQpE6cEfXOz3Q=;
        b=nXcN4xbgt18TOtDZK8uFwr6TCqdGFizMpBb60AEuO2T1D7SdGye5fAK2tnOgtiPdqD
         KXW+wCu1mbIxx9N0wmgaPehuUvS9wSxPrp3IMO6+DHgJHbJhWWpA8qXAkDkn6+WKLURl
         G2d9p1C5vukiSUC60DDr5HVzabzC6Ox6VYyRdrqJiDZ6DKENKSbzhdHUdf2LJEgVFl4g
         Xai5ZzXgZICPwmAlUxBnuaeUNniM9TgxCQoHbyoceebfbvIzaAeai1TUioBgN94k+NfY
         hUXpGw5h3Ax0rh1S1V3Zy1HdfUNbUkqdCoAoijqHn7TfRvUEND0m0CVbT8KpZf4/Imkc
         o5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679820629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HelX9TaRrTL0/uXiqpcAS3IoL+rsoXCQpE6cEfXOz3Q=;
        b=RWjJxgnJoe2uUSgbnWgJyZdZuMvgkzi5GsS61ttcjsjIwESaWYQLvprFkj7GTv1KEW
         Wke8pgz8z/UB7BbFSQHuO5dEL2Jnd+oX5YKCVaiSNYt+b/5HjiQk48EHdMF+7B1+5LHU
         d7rhSv39PPI5yM3FoJm563470wyKKhr+8WixjBaoqTdgmc9aJF+i4+6XHJq2g08yWKE4
         pRVTppwPMdLe8B779v0ZR/G4Pk1zAE55N/T/Rw0TYh1ntNyswiW++zC5/C1BybNHYAEy
         ylNZ2X6d9vXeG0dOjnmuqAQpOEo+Qp1pvsjFqLnNhPqKLU1iQykEFyaO+G+VOHZb3sSv
         FN9w==
X-Gm-Message-State: AAQBX9cJ9KFAhI3tEjYMzC2kJf0yK1gLO8X1IaQrmunn5WZ88PmQk3Vl
        qltzvVhbmYQdbnPWhzcB8JFL4ltD4h4DgaJL7U0=
X-Google-Smtp-Source: AKy350YURsee9IcVUspqIlMZJZ9hVHOq3HCdxcN5vA+XRdkAfAqpR6f3zs4y1LtjXTb6+g3+KaxoHw==
X-Received: by 2002:a17:906:ce26:b0:932:dac6:3e46 with SMTP id sd6-20020a170906ce2600b00932dac63e46mr10147737ejb.7.1679820629549;
        Sun, 26 Mar 2023 01:50:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id be8-20020a1709070a4800b0093f822321fesm1683165ejc.137.2023.03.26.01.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 01:50:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] crypto - img-hash: Depend on OF and silence compile test warning
Date:   Sun, 26 Mar 2023 10:50:27 +0200
Message-Id: <20230326085027.4759-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is specific to OF platforms (can match only via OF table),
thus add dependency on CONFIG_OF.  Mark the of_device_id table as
unused.  This also fixes W=1 warning:

  drivers/crypto/img-hash.c:930:34: error: ‘img_hash_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Do not allow compile testing without OF.

Changes since v1:
1. Rework - depend on OF and add maybe_unused.
---
 drivers/crypto/Kconfig    | 1 +
 drivers/crypto/img-hash.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 3b2516d1433f..c636fbeb2144 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -647,6 +647,7 @@ source "drivers/crypto/vmx/Kconfig"
 config CRYPTO_DEV_IMGTEC_HASH
 	tristate "Imagination Technologies hardware hash accelerator"
 	depends on MIPS || COMPILE_TEST
+	depends on OF
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
diff --git a/drivers/crypto/img-hash.c b/drivers/crypto/img-hash.c
index fe93d19e3044..2be364d9f592 100644
--- a/drivers/crypto/img-hash.c
+++ b/drivers/crypto/img-hash.c
@@ -927,7 +927,7 @@ static void img_hash_done_task(unsigned long data)
 	img_hash_finish_req(hdev->req, err);
 }
 
-static const struct of_device_id img_hash_match[] = {
+static const struct of_device_id img_hash_match[] __maybe_unused = {
 	{ .compatible = "img,hash-accelerator" },
 	{}
 };
-- 
2.34.1

