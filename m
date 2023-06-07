Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F09172538D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjFGFk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjFGFkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:40:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8AC1BD3;
        Tue,  6 Jun 2023 22:40:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so6382312a12.2;
        Tue, 06 Jun 2023 22:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686116405; x=1688708405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCWFiUFPUn5eTTeVEYVaJy8+YMLW+6inCvkAAvBu/yM=;
        b=ZoVD7remziHgcihW3SoqS7YUcNOA1w0Hz6BAAVNweCU4IabFTQ6bb9bZbLZynoc37r
         1IC0xUllVyeZ7IyH0hCkoFwmfsfQ0wT1j0lwis9bfB9SQAARPxw/gePiydJTTZi7/wUY
         QskOw1hq+jk+lQgMGUwv1zYPjypDQTZXowUgAT754i93VjCc1lI/56LykVYsr+jl37Il
         aNohwCi80aI+YZdFpii/v6MRGHRouyz7jKiphklI/oWoTB2jlGPm8lUHZtKUau/9rJ/K
         EqUaIBDFU4vmQD1vNPgAG8uOnPfR3EhMTo0ISX7CHq+vPJNXUH6u7HWnMNMMNeRyAwT+
         xFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686116405; x=1688708405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCWFiUFPUn5eTTeVEYVaJy8+YMLW+6inCvkAAvBu/yM=;
        b=RGWAJ0iQjOX2mKcC9XfKxWQMUnKO1nbapQrlFMv6ubD551wanE27dbnL3braPAlwFY
         B5My79g3k1KsQyImFNPRe0EhXxlSlSqpZcSbFZi1iPALrWWW1fUBiFAdEX4y+31n6+Cv
         RKjQ/+xtwuY9oNMUJpGSdAftjVRmawx4bnQS9WsllyPz1gkqowh2SWYerIUAX1SQMktq
         S6+tydbxhaXDvF1agodW62sS1Sk7qjcLOqHeJGBpcPidzw2waVearL3ak7faBrvUHURF
         eCjaBIk0I5djAPj0SY43psUeFAbDoDXONx5qoNoKr0xxjz4UeevVAIweOKK1Iv2PlOvT
         V4Sw==
X-Gm-Message-State: AC+VfDx1nN499H6xfFnRuy+JIY4zmpwQbR71Elhcc4vPrtLX5Iv330Bz
        aHw3eAcW5PB+QtXJbEeS7So=
X-Google-Smtp-Source: ACHHUZ4dKn4gtyOqiaxD//vhrhPFtbxwNUIsEVbHCEHCMNldaX5c/0l+jxJj7iztIwby5kdxD44a/w==
X-Received: by 2002:a05:6a20:6a03:b0:117:428d:f983 with SMTP id p3-20020a056a206a0300b00117428df983mr2569550pzk.1.1686116405474;
        Tue, 06 Jun 2023 22:40:05 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id q26-20020a62e11a000000b00657fbf81ffbsm4960598pfh.80.2023.06.06.22.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:40:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8F34A1044ED; Wed,  7 Jun 2023 12:39:59 +0700 (WIB)
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
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 3/8] crypto: drbg: Convert dual BSD 3-Clause/GPL-1.0 license boilerplate to SPDX identifier
Date:   Wed,  7 Jun 2023 12:39:44 +0700
Message-ID: <20230607053940.39078-13-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607053940.39078-10-bagasdotme@gmail.com>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2787; i=bagasdotme@gmail.com; h=from:subject; bh=CMhqFfpL0Ha26FzgmqI+vIPR5sC4x/nvpsvCP+iQTxQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkNErIWnxc2xDuK7fc/kzXV7aGWv+rShPJpUrJX1u9ep MXjXTyto5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABNxr2Zk2LZbXMU8QE+kSdxc Qed8nahYzT/Zotq0ybFdm2N4FFXuMjK8uT53l5k2l+ymyAXlXk/FTbUPMB5o1v+0mKM+7MyGyxZ MAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the boilerplate with corresponding SPDX tag. Since there is no
explicit GPL version, assume GPL 1.0+.

Cc: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 crypto/drbg.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index ff4ebbc68efab1..f797deaf3952ef 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-1.0+
 /*
  * DRBG: Deterministic Random Bits Generator
  *       Based on NIST Recommended DRBG from NIST SP800-90A with the following
@@ -9,38 +10,6 @@
  *
  * Copyright Stephan Mueller <smueller@chronox.de>, 2014
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
- * the GNU General Public License, in which case the provisions of the GPL are
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
- *
  * DRBG Usage
  * ==========
  * The SP 800-90A DRBG allows the user to specify a personalization string
-- 
An old man doll... just what I always wanted! - Clara

