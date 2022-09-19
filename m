Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6282B5BC2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiISGD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiISGDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:03:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B671A3B2;
        Sun, 18 Sep 2022 23:03:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z2so3712708edi.1;
        Sun, 18 Sep 2022 23:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hNkWjE/9Kwd5ORgfArcfRMKxkmzooXQeBJ1ffgMnYrI=;
        b=ONSPNefHyAbPuD0lt0We4tBQj5e0H1KXH7cf8n6tNI7HVbmeCZpjuVw6CSegwcHzLh
         8RFHC7yjGrsBthhRORjBz5pJ1YpiA0L2X+r+i6uuwoxX6HuucZ88n7PVU3sXRoLhsP15
         FH2HZdrsWreeQfe+XAKn0AZCtqlx0e1utY6Gs3dJB4WRGcmQ4zpZ6lY+hBWEJ/Az2oSn
         IS3lliUBaTEyOCVX4Q8YvbH1EucjcBBd6IQK2vH3Qu6ufwG/s3NBJz+48mJVZdibrSr+
         6WVAVZF/andqDFI09HQZNN4PJSjPJYkDfhN831Iu6av/Q1qcNlTjnO4VCTd60RtagdSQ
         p1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hNkWjE/9Kwd5ORgfArcfRMKxkmzooXQeBJ1ffgMnYrI=;
        b=N2RUDptZ9Ux+qjcdxWP6ZIzj0B6MPG6wWCgyEN82pvpWodfwgTDy2bD4iYw7ZwNuC5
         +N17+lvznt9nKMLNELgNHpl0QlUXTmbcbDuUNqB/dy1mMluiuqkL3BBlADlMBCtiTAS3
         9tSlmVEWxMlc73G8zT7m0h9mDEroavIc851Z8w/I2a/2JwivNBvBARZV+Wm5tH/RSO0t
         hzfyS0j7m/UfC1zLDbttv7xiPbA+QHD1J1g3v1FiiQF2EWDlczKQOIfVCZL/k2VpghGO
         zkZpry9sZPFWr51f+paeG/iqIDngGIZTFRC7VjGgXlOJKBicZV5zuPBjox96w8FCTr+u
         YCjg==
X-Gm-Message-State: ACrzQf1fgSCLHLwh5mFDP+ybkQehayiYLA1btoFrDFhnQ7xhfI+3IL8X
        TokEDLD3M4Ybv7t2aNwGf3M=
X-Google-Smtp-Source: AMsMyM7LNV2tIc76VxxWIejr7nctP8TLuA3LfJ87Rjz8csTkkDMHaoqsEi6/ROZnZk1S5Rho1xoqrA==
X-Received: by 2002:a05:6402:440d:b0:450:de54:3fcf with SMTP id y13-20020a056402440d00b00450de543fcfmr14018826eda.312.1663567433443;
        Sun, 18 Sep 2022 23:03:53 -0700 (PDT)
Received: from felia.fritz.box (200116b826812b0018444688cfe72784.dip.versatel-1u1.de. [2001:16b8:2681:2b00:1844:4688:cfe7:2784])
        by smtp.gmail.com with ESMTPSA id k22-20020a17090632d600b00780982d77d1sm5639168ejk.154.2022.09.18.23.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 23:03:53 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] crypto: add rsize config to .config only if lib_poly1305 is set
Date:   Mon, 19 Sep 2022 08:03:42 +0200
Message-Id: <20220919060342.26400-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config CRYPTO_LIB_POLY1305_RSIZE should only be part of a kernel
build configuration (.config file) when config CRYPTO_LIB_POLY1305 is set.

Add a suitable dependency for CONFIG_CRYPTO_LIB_POLY1305_RSIZE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 lib/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 7e9683e9f5c6..71b90952e496 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -84,6 +84,7 @@ config CRYPTO_LIB_DES
 
 config CRYPTO_LIB_POLY1305_RSIZE
 	int
+	depends on CRYPTO_LIB_POLY1305
 	default 2 if MIPS
 	default 11 if X86_64
 	default 9 if ARM || ARM64
-- 
2.17.1

