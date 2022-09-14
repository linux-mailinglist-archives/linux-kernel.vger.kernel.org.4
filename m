Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433DA5B8329
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiINIit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiINIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:38:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F44969F60;
        Wed, 14 Sep 2022 01:38:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bj12so32942913ejb.13;
        Wed, 14 Sep 2022 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vRIXtyTmWownFPoHUEyYMg55UWu8236uAKX0IFKlDfI=;
        b=ZlZqs6tGVRAPqWhtFBjp/MupoITqNBY8GWNFakDNSbXUwHRI/rGEnvBfcglXpeHr5W
         /vets45BV7kNsS2rSe4CKwOOPKsYSFU5XUiO+SOMtG6TKR/TMeCIm46DRtk4ygg1Xnyx
         OyKjeSUPOyxFJyqkFoDZghQEx0n8gf6ZLguqVsSBHwMg44jrldTKlBc8Uw4DJmn0R5Z3
         /fCt5QuL/dHwgKeURkJef0MomxvRMvnjhvSS5WSggNZNUqvzuKOcyWfuTa2o6XzTXrK7
         NJqHtKYM/XkXq6O9DxEw6zereqP2JcdclBY1G5zBGt4IfrnTKaTZhUu4nhdEvtztS0MY
         XecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vRIXtyTmWownFPoHUEyYMg55UWu8236uAKX0IFKlDfI=;
        b=xKeVhh0161YLlqxzdXbnytLUTMChxTRKI0Em8z3Ob0xfQ8/XKVzNEl0+Xj8lYyzuGn
         SNw2TDh2OwvRb4rtfHTxgeMaNZQeXbXO7rlRFvwECiYTCBxiD2wvse9/L18OPaQC2q6E
         1C9tRk3fvCpUQEG7uY9pYNCh9Ou+1I7TZKShYjCtaDGeY/tZeB3Q8LgPamW4AJQYL4GQ
         f42/kQu7LmUF552MfspEXzIF02I+tbCcOeHGqFL98CjgTq1NxVXf2KKW2kDBa34mAs1h
         gd71nyRtVehKJm3DUGCfKjNNrciyn69e793vs5lcNr+8Ssq6p44/PxzeQ/f0wDpKeblX
         C4Fw==
X-Gm-Message-State: ACgBeo2vsqkBOl1U0wq1SZOaxPemTYoMGBNzY0rUrwmQU7SVy3F7sOo+
        +OUXHg3njYZrs8widcumVbU=
X-Google-Smtp-Source: AA6agR6NoCoUBVVgLFuXZW+2TPPz5cRhlmSs2W9X96yYw2SOOBC10J9HwDzoucb2UQVILw8CYYrlYA==
X-Received: by 2002:a17:907:629b:b0:74f:94f3:786 with SMTP id nd27-20020a170907629b00b0074f94f30786mr25056899ejc.606.1663144713486;
        Wed, 14 Sep 2022 01:38:33 -0700 (PDT)
Received: from felia.fritz.box (200116b826cf470059b9799edefde240.dip.versatel-1u1.de. [2001:16b8:26cf:4700:59b9:799e:defd:e240])
        by smtp.gmail.com with ESMTPSA id o15-20020a170906768f00b0077826b92d99sm7434978ejm.12.2022.09.14.01.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 01:38:32 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] crypto: revert unintended config addition of CRYPTO_BLAKE2S
Date:   Wed, 14 Sep 2022 10:38:27 +0200
Message-Id: <20220914083827.18939-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2d16803c562e ("crypto: blake2s - remove shash module") removes the
config CRYPTO_BLAKE2S.

Commit 3f342a23257d ("crypto: Kconfig - simplify hash entries") makes
various changes to the config descriptions as part of some consolidation
and clean-up, but among all those changes, it also accidently adds back
CRYPTO_BLAKE2S after its removal due to the original patch being based on
a state before the CRYPTO_BLAKE2S removal.

See Link for the author's confirmation of this happening accidently.

Link: https://lore.kernel.org/all/MW5PR84MB18424AB8C095BFC041AE33FDAB479@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 crypto/Kconfig | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 1dfe0583f302..df4a29905ab0 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -917,27 +917,6 @@ config CRYPTO_BLAKE2B
 
 	  See https://blake2.net for further information.
 
- config CRYPTO_BLAKE2S
-	tristate "BLAKE2s"
-        select CRYPTO_LIB_BLAKE2S_GENERIC
-        select CRYPTO_HASH
-        help
-	  BLAKE2s cryptographic hash function (RFC 7693)
-
-	  BLAKE2s is optimized for 8 to 32-bit platforms and can produce
-	  digests of any size between 1 and 32 bytes. The keyed hash is
-	  also implemented.
-
-	  This module provides the following algorithms:
-          - blake2s-128
-          - blake2s-160
-          - blake2s-224
-          - blake2s-256
-
-	  Used by Wireguard.
-
-          See https://blake2.net for further information.
-
 config CRYPTO_CMAC
 	tristate "CMAC (Cipher-based MAC)"
 	select CRYPTO_HASH
-- 
2.17.1

