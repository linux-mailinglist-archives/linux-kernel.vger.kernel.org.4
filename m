Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C3F6C0277
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjCSOov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCSOot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:44:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417151CBC6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:44:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er8so25873664edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679237085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wW0qmeq/XE/BS6QmstxltBCzT+Jl3DqWsgHErkJk2t4=;
        b=ZhlRshRBEeF/ffBl7mjoVExBy1LfUW86EngFn+0SoXLDONYnFeB0RjOhvD740DDdAq
         JiSAJjwb4kJ2Gg1MNMAr7Yyt/P8un0+y6PgqLhYkF4y5G4XC5Yl+O2vLHkHJ1NsiuEi6
         m3+E+ocdJ7X3Q0VM1iCfXmtc1F0YNyXt29IMQEL9VlQ58NeLCQfKJ8HRcfugC3lphXKO
         97ZOsbKI5k93f1iaVtpSgV3eu+AgDvQycjzPYCR4rZnsEGkIFfNuTAnnZS3EIyFUDF7k
         Q+QzYf8F08tq7D5hITFBmi11FLRyGxJgEQOxrK0mjWV14KpUzoADlhh8h71votf0T5ud
         4EZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679237085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wW0qmeq/XE/BS6QmstxltBCzT+Jl3DqWsgHErkJk2t4=;
        b=IECJ9ZAwzMASD4+TLZPVHQWRTS9NqUmHSPHdAJWaUyNiy3x7guZjv78BWEI74iBocJ
         WDqfOSf3KAjMLyjZ5HFdpFT7BprBaNQc8mf7xqf08dO9ji73dK1Cr8n4gi9GyPAnWTlA
         D8LcxlFVTxoMrjAq1QssRY9beim1tA06bbL7ktRs9h/gT41WR1nKw/GFAU/Vy65zwFUn
         ZmaMj+1oy0EcocEPwyDYKSDgKmlNDbBQKkhw0jZdfM9IljzweS5ldOo9eL6CP81Dwvjv
         m7NJCWItYoxu1Llko2/NDDqy+jcuV2XGYUbqvjo8AcSthhCO5TV5DAOxMPIENymlI6Xb
         vugQ==
X-Gm-Message-State: AO0yUKUfAa5dA5bT8IKfpfsPYPU27PIKdzMJXtoOeEryK0Ypmc1pGEgd
        SHIQwjq6p/r4FIK8L8L2WC85vbcpSVUElL2+e9A=
X-Google-Smtp-Source: AK7set/pmi9WCvGGmALTUjSWYkn5du0UgMhSPpbj8Do3+1D2jofLLlk23MQcoCW8cchbqZBOkChFpw==
X-Received: by 2002:a17:906:b349:b0:878:6b39:6d2a with SMTP id cd9-20020a170906b34900b008786b396d2amr6835060ejb.46.1679237084757;
        Sun, 19 Mar 2023 07:44:44 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id t14-20020a508d4e000000b004d8287c775fsm3583165edt.8.2023.03.19.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 07:44:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] crypto - img-hash: Depend on OF and silence compile test warning
Date:   Sun, 19 Mar 2023 15:44:39 +0100
Message-Id: <20230319144439.31399-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v1:
1. Rework - depend on OF and add maybe_unused.
---
 drivers/crypto/Kconfig    | 1 +
 drivers/crypto/img-hash.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 3b2516d1433f..4a4aff8b16f0 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -647,6 +647,7 @@ source "drivers/crypto/vmx/Kconfig"
 config CRYPTO_DEV_IMGTEC_HASH
 	tristate "Imagination Technologies hardware hash accelerator"
 	depends on MIPS || COMPILE_TEST
+	depends on OF || COMPILE_TEST
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

