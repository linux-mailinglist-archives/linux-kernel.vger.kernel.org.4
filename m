Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D8A72539E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjFGFk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbjFGFkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:40:33 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837F81BD9;
        Tue,  6 Jun 2023 22:40:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b28fc7a6dcso2027076a34.0;
        Tue, 06 Jun 2023 22:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686116406; x=1688708406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI1ycIqHoKnexGdlh2o5GfDSY8FILvsQd+bsdPeolfw=;
        b=nJbs4DvuwBu7Kp2b5WhBiL86TiBxZwGvvQDUoyuoV97Lti0Qj6gV+wVxweVS4FGtam
         WKb/2g54ueC+0YYgp/bwJx7LNRm4r/bJAsD3nHQO44W+NdtEGYo+/ndnOXnRi6cPlYYQ
         621Ty+vxt5eHYeDtk5A/w6ANDuMQK6yUcR2+VIHvPPH47T/EuE6t4izY3+T9DOQJQEEw
         b7bNS2ES+sheL2tUlt69noySV+9SBl9OhQCFx+CJ0LHpF7clmatiCSItg9HQyMp7oVzl
         up4zJkAzXAtKUo1Zbjm5gtvqgJS7T/h+mEsNxziOa57QuC6bJFAcOp9KjBgPGsdxyF6n
         0RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686116406; x=1688708406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI1ycIqHoKnexGdlh2o5GfDSY8FILvsQd+bsdPeolfw=;
        b=cvbOPh0riRTtILh3ls+sFLoHXi35N2yV2lMoqVOsU0DAl5cYEOB/PwTulpfjdZKlFM
         ifI535n8leMt+RwDuJwgI7VUcJB5RvD9DEAVafpkhG3dccx1shz0Oq/Wq9pIvYa61ljA
         EQE62FrSfBzLlFkNbkjh4fCNvEkTp+qtn4l/R0UOMhnmQacu2XBupHNE+d2UGY6NxFk9
         7NFbEod6el48ANNWk+n5y9uH4RMP72bbSiFwEF2CbiDCYzxg1y845n9k7INromHG8Dhg
         poZfMVh/mGAZjr6LYrima46p/X2xVAustteBIcTPOHHAP0CdC6TO4p+sVnpDKnMQm5cz
         9hUg==
X-Gm-Message-State: AC+VfDye8YPfuJVxm8ltUVdimIzNL4ZRzCFU/XutrhWiI/sb0V9/YzLX
        Gamz2tGyVkDzMeoIzJCCFxU=
X-Google-Smtp-Source: ACHHUZ7i/C3qvTrVTqIx5gK3POrOua+3W5+/C7L+eaUPwl4Jsy7NoCk/iX68/iEOiyvSfZ0ts77kug==
X-Received: by 2002:a05:6358:c09b:b0:129:d05d:691e with SMTP id fa27-20020a056358c09b00b00129d05d691emr2701521rwb.19.1686116405772;
        Tue, 06 Jun 2023 22:40:05 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090a474b00b00250d670306esm470827pjg.35.2023.06.06.22.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:40:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1E3B11069BB; Wed,  7 Jun 2023 12:39:59 +0700 (WIB)
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
        Alexander Kjeldaas <astor@fast.no>,
        Herbert Valerio Riedel <hvr@hvrlab.org>,
        Kyle McMartin <kyle@debian.org>,
        "Adam J . Richter" <adam@yggdrasil.com>,
        Dr Brian Gladman <brg@gladman.me.uk>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 1/8] crypto: Convert dual BSD 3-Clause/GPL 2.0 boilerplate to SPDX identifier
Date:   Wed,  7 Jun 2023 12:39:42 +0700
Message-ID: <20230607053940.39078-11-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607053940.39078-10-bagasdotme@gmail.com>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12265; i=bagasdotme@gmail.com; h=from:subject; bh=zunGFpf+o9LHHfcgeq3K0XbT2pkfIf201354tPEgDJk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkNEjIctS4ReexPdZ7yvXn8Yt3W0Lp1+eHtLytcOyr+V iz0NzrXUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIm4RTEy/DQ6G2LO/LaZ79Kz fZfj9J5UN1a2xa5kenN0x+NPnhpbNjAyvHl8S0V1kXndHqdpRZHMjyX6dbVKzgddULY19eOOZOd gAQA=
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

Replace license boilerplate for dual BSD-3-Clause/GPL 2.0 (only or
later) with corresponding SPDX license identifier.

Cc: Alexander Kjeldaas <astor@fast.no>
Cc: Herbert Valerio Riedel <hvr@hvrlab.org>
Cc: Kyle McMartin <kyle@debian.org>
Cc: Adam J. Richter <adam@yggdrasil.com>
Cc: Dr Brian Gladman <brg@gladman.me.uk>
Cc: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 crypto/aes_generic.c         | 31 +------------------------------
 crypto/algif_rng.c           | 33 +--------------------------------
 crypto/jitterentropy-kcapi.c | 32 +-------------------------------
 crypto/jitterentropy.c       | 35 +----------------------------------
 crypto/keywrap.c             | 32 +-------------------------------
 5 files changed, 5 insertions(+), 158 deletions(-)

diff --git a/crypto/aes_generic.c b/crypto/aes_generic.c
index 666474b81c6aa5..2e042bd306f9c5 100644
--- a/crypto/aes_generic.c
+++ b/crypto/aes_generic.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-or-later
 /*
  * Cryptographic API.
  *
@@ -11,39 +12,9 @@
  *  Kyle McMartin <kyle@debian.org>
  *  Adam J. Richter <adam@yggdrasil.com> (conversion to 2.5 API).
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  * ---------------------------------------------------------------------------
  * Copyright (c) 2002, Dr Brian Gladman <brg@gladman.me.uk>, Worcester, UK.
  * All rights reserved.
- *
- * LICENSE TERMS
- *
- * The free distribution and use of this software in both source and binary
- * form is allowed (with or without changes) provided that:
- *
- *   1. distributions of this source code include the above copyright
- *      notice, this list of conditions and the following disclaimer;
- *
- *   2. distributions in binary form include the above copyright
- *      notice, this list of conditions and the following disclaimer
- *      in the documentation and/or other associated materials;
- *
- *   3. the copyright holder's name is not used to endorse products
- *      built using this software without specific written permission.
- *
- * ALTERNATIVELY, provided that this notice is retained in full, this product
- * may be distributed under the terms of the GNU General Public License (GPL),
- * in which case the provisions of the GPL apply INSTEAD OF those given above.
- *
- * DISCLAIMER
- *
- * This software is provided 'as is' with no explicit or implied warranties
- * in respect of its properties, including, but not limited to, correctness
- * and/or fitness for purpose.
  * ---------------------------------------------------------------------------
  */
 
diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index 407408c437308f..4d4b9e60f72c19 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -1,41 +1,10 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only
 /*
  * algif_rng: User-space interface for random number generators
  *
  * This file provides the user-space API for random number generators.
  *
  * Copyright (C) 2014, Stephan Mueller <smueller@chronox.de>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, and the entire permission notice in its entirety,
- *    including the disclaimer of warranties.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The name of the author may not be used to endorse or promote
- *    products derived from this software without specific prior
- *    written permission.
- *
- * ALTERNATIVELY, this product may be distributed under the terms of
- * the GNU General Public License, in which case the provisions of the GPL2
- * are required INSTEAD OF the above restrictions.  (This clause is
- * necessary due to a potential bad interaction between the GPL and
- * the restrictions contained in a BSD-style copyright.)
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
- * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
- * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
- * DAMAGE.
  */
 
 #include <linux/capability.h>
diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index 7d1463a1562acb..78230ce74fc840 100644
--- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -1,40 +1,10 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only
 /*
  * Non-physical true random number generator based on timing jitter --
  * Linux Kernel Crypto API specific code
  *
  * Copyright Stephan Mueller <smueller@chronox.de>, 2015 - 2023
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, and the entire permission notice in its entirety,
- *    including the disclaimer of warranties.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The name of the author may not be used to endorse or promote
- *    products derived from this software without specific prior
- *    written permission.
- *
- * ALTERNATIVELY, this product may be distributed under the terms of
- * the GNU General Public License, in which case the provisions of the GPL2 are
- * required INSTEAD OF the above restrictions.  (This clause is
- * necessary due to a potential bad interaction between the GPL and
- * the restrictions contained in a BSD-style copyright.)
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
- * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
- * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
- * DAMAGE.
  */
 
 #include <crypto/hash.h>
diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index c7d7f2caa7793b..c8437bd20dc903 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only
 /*
  * Non-physical true random number generator based on timing jitter --
  * Jitter RNG standalone code.
@@ -9,40 +10,6 @@
  *
  * See https://www.chronox.de/jent.html
  *
- * License
- * =======
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, and the entire permission notice in its entirety,
- *    including the disclaimer of warranties.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The name of the author may not be used to endorse or promote
- *    products derived from this software without specific prior
- *    written permission.
- *
- * ALTERNATIVELY, this product may be distributed under the terms of
- * the GNU General Public License, in which case the provisions of the GPL2 are
- * required INSTEAD OF the above restrictions.  (This clause is
- * necessary due to a potential bad interaction between the GPL and
- * the restrictions contained in a BSD-style copyright.)
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
- * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
- * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
- * DAMAGE.
  */
 
 /*
diff --git a/crypto/keywrap.c b/crypto/keywrap.c
index 054d9a216fc9f3..8c51235a91a9ae 100644
--- a/crypto/keywrap.c
+++ b/crypto/keywrap.c
@@ -1,39 +1,9 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only
 /*
  * Key Wrapping: RFC3394 / NIST SP800-38F
  *
  * Copyright (C) 2015, Stephan Mueller <smueller@chronox.de>
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, and the entire permission notice in its entirety,
- *    including the disclaimer of warranties.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The name of the author may not be used to endorse or promote
- *    products derived from this software without specific prior
- *    written permission.
- *
- * ALTERNATIVELY, this product may be distributed under the terms of
- * the GNU General Public License, in which case the provisions of the GPL2
- * are required INSTEAD OF the above restrictions.  (This clause is
- * necessary due to a potential bad interaction between the GPL and
- * the restrictions contained in a BSD-style copyright.)
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
- * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
- * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
- * DAMAGE.
  */
 
 /*
-- 
An old man doll... just what I always wanted! - Clara

