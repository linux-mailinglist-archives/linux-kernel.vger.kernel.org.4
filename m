Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5D072538E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjFGFkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjFGFkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:40:14 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E811BDC;
        Tue,  6 Jun 2023 22:40:08 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b2041315a5so2024234a34.0;
        Tue, 06 Jun 2023 22:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686116408; x=1688708408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wydK3CwztY8WGZmDLKnIHSNUUittxpAep0EjIDXFXjY=;
        b=CesD+ICRzyvqAssgHdIongt8Jmy/0FhyMzJ0wigDQV82fZEh3l3kmV+Z9lYB6n8rH7
         R8VQbE8T5/eZkdQdJrFEY/pn0mv0I/7D4/SJ0UzHCf/ba3RKkcwu3LOT+t7935Ps+Xgi
         GOFgWKPYM/uOdaaKCvK8cyIhl20EpcmyBgi8wK+Y8qEd/XIVxJmGwxg4g8f+dOxEMdYt
         3JLeKbTlV7vcCa/j6XTGoU3Q9z3zqDPJ1N11IpIIHFToGjNE99t0uU1xTyaJLID3RP9n
         Sgp/zccl0IDERmkVGgvbcXrzM/3W4ifZezlVtRb6D32Kiz2FpgYmYBtvwgVdamj8BwqK
         9v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686116408; x=1688708408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wydK3CwztY8WGZmDLKnIHSNUUittxpAep0EjIDXFXjY=;
        b=E1XbYM5SEwyaokZaqhNvDr+mawNnq5+MdMy6/yfId27S80CFG3MYtOK49S8apogdds
         N0zTV8qRSd5Hd2tE0lwM7ixPYlkxAHwh3l85FS6sxZo111rLcvBJ5a++DI5Ce2xp+6oa
         Sn0WwiVbtG6pasDnqXpDMYqEP2aX6bt+PniMV0e66d/flwPMloLECcd7fT29ep1lWhUb
         5vHlajRxht2gM21cR5+hM9uZadlKE1Y2WALNj0kpg55GUsIuE5XjDL9UoWr81J7ZV9vq
         RST7Q6Af6PjZdl+MxkXRpqC6cvU7+sRPe+ZcbCGOhpgUh1CdHbuY5Qfd9YuDL9CpJvvr
         DyEA==
X-Gm-Message-State: AC+VfDwDVcI495ITHt0G5z0c1w+ZRzDpykqWplZx7i5/TiTRdEvawCCF
        U7JCH7xzFLsaukjTn1NZzEMX9Qoq4Do=
X-Google-Smtp-Source: ACHHUZ7PaoC1qZYBeei0GVEApxz0Zv8+id1JFOxBWs1GKuz0xYbnhkVMj8G1ShF0uzCqwxSE210QMg==
X-Received: by 2002:a05:6830:1bd4:b0:6af:8743:daac with SMTP id v20-20020a0568301bd400b006af8743daacmr4168372ota.36.1686116407700;
        Tue, 06 Jun 2023 22:40:07 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b0065ccd867923sm3781553pfa.12.2023.06.06.22.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:40:07 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8DED91069EC; Wed,  7 Jun 2023 12:39:59 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Linux Crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alexey Degtyarev <alexey@renatasystems.org>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH 5/8] crypto: streebog_generic: Correct SPDX license identifier
Date:   Wed,  7 Jun 2023 12:39:46 +0700
Message-ID: <20230607053940.39078-15-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607053940.39078-10-bagasdotme@gmail.com>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=bagasdotme@gmail.com; h=from:subject; bh=DU3W9+DKhaZRScsTkm8rgBF3OAAfXNjRmU2s4naxbqo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkNErLrPk9sYJhbknN4b5fKu1dPb2TvW5hTJ5oRrrunr 1Hv9faejlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExkAwPD/0zW4Kn2p9VOLRPa fvz6zCJxiY+J+Yvywh0Mcot2Kl/udWP4H8dlUjMjRMLzTuFKHj41pZXMM36vPh8w6YCYsuehxxF XeAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
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

Streebog hash function implementation (crypto/streebog_generic.c) have
GPL 2.0+ license boilerplate, but its SPDX identifier is mistagged
as dual BSD/GPL. Correct the tag, while also removing the boilerplate.

Fixes: e18957e8e87403 ("crypto: streebog - add Streebog hash function")
Cc: Alexey Degtyarev <alexey@renatasystems.org>
Cc: Vitaly Chikunov <vt@altlinux.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 crypto/streebog_generic.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/crypto/streebog_generic.c b/crypto/streebog_generic.c
index dc625ffc54ad7f..65d0e6bf5e1992 100644
--- a/crypto/streebog_generic.c
+++ b/crypto/streebog_generic.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+ OR BSD-2-Clause
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Streebog hash function as specified by GOST R 34.11-2012 and
  * described at https://tools.ietf.org/html/rfc6986
@@ -6,10 +6,6 @@
  * Copyright (c) 2013 Alexey Degtyarev <alexey@renatasystems.org>
  * Copyright (c) 2018 Vitaly Chikunov <vt@altlinux.org>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  */
 
 #include <crypto/internal/hash.h>
-- 
An old man doll... just what I always wanted! - Clara

