Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33C7240B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjFFLR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjFFLRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:17:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629789E;
        Tue,  6 Jun 2023 04:17:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977c89c47bdso536078066b.2;
        Tue, 06 Jun 2023 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686050272; x=1688642272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbQFn5Jj14cFrW5DQfIo4/7M5wSQ9mF1+GYFKFZYsk0=;
        b=OrsWOkZzbCk4hb8xGy5UGIOaelac5zPAwYF8OL/37XsNwsUkCGEz682EP4V519o0q4
         WlPyh2CrL3ONCtqovn3j8sI3b4wtkm83Atm20SbSLdLlSI/az7FUNiMDYPKVmKPheMjB
         HSQZ1YV2TQErX1AGWG6ZaQE48svNRANXS6NIVaeldl06IrUsNhFkqFPuaka5J/dFqueF
         EFdvTrqvObOWT3VzBEE2xgHGHKQQ9jhNKjvgKKIMvDSRq9C2SYz68Vg8EL+hTyfyOAag
         pCUVPMS7iDoT1+Bgk4XooO4q6UUCLqLXFKo35rtUJDQNXUtgkMX97tqcbPsKDJgFX1Y8
         IqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686050272; x=1688642272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbQFn5Jj14cFrW5DQfIo4/7M5wSQ9mF1+GYFKFZYsk0=;
        b=IHm/DSlvvw16sBsQUVOENPLqys4IIqE5Nx1pTnZBP1Rx7lfw6h7Eto5Xs0cHJKolKp
         viJWSrz+bec/l/+86KYPx2wfKUGBFZtePP8twrSsM+n0MEjQwQ5d/T9/KFam0cu02MxN
         YUXSoyhPN2VF0wB7eo9oi32gsOsimQyE5P96OZ4qb7oN5+KzwoARIGrdiujPb6xEvyEQ
         KrSIk9eufIrpGS8n9Ozj54MXJA44lv7lbwGlVgwU9helAefd4Brt5DO8qw6Lrey8nTz/
         sk38ZtlWEc9B0LFsq5qFYfaQRi/0yT5qX4eUOBQgSbTUIvF6qpeSF7q0XVFGT7eTd0ys
         iSVQ==
X-Gm-Message-State: AC+VfDy0skwyxgTic+lmuxt+YGSK+lDtyvlRgSEgTHGQqwSsApQgAxcO
        84iJ457CAS247Dmv7Yu8g9I+2oTUhRiVvA==
X-Google-Smtp-Source: ACHHUZ5A8QtpPqPJKBMBVDuYU0qIFO7YJ9uxc+T3X7EIO7diL7bcUZItA8H4dJ7u425JtT09P5hp3w==
X-Received: by 2002:a17:907:6d8a:b0:96f:4db5:df69 with SMTP id sb10-20020a1709076d8a00b0096f4db5df69mr2221794ejc.23.1686050272515;
        Tue, 06 Jun 2023 04:17:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:7ce9:cf23:e2e1:1e2e])
        by smtp.gmail.com with ESMTPSA id lz11-20020a170906fb0b00b00977da9d4ef9sm2454483ejb.18.2023.06.06.04.17.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Jun 2023 04:17:52 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH] crypto: hmac: Fix missing blank line
Date:   Tue,  6 Jun 2023 13:17:49 +0200
Message-Id: <20230606111749.97469-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following checkpatch warning has been fixed:
- WARNING: Missing a blank line after declarations

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 crypto/hmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/hmac.c b/crypto/hmac.c
index 09a7872b4060..ea93f4c55f25 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -177,6 +177,7 @@ static int hmac_clone_tfm(struct crypto_shash *dst, struct crypto_shash *src)
 static void hmac_exit_tfm(struct crypto_shash *parent)
 {
 	struct hmac_ctx *ctx = hmac_ctx(parent);
+
 	crypto_free_shash(ctx->hash);
 }


base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
--
2.39.2 (Apple Git-143)

