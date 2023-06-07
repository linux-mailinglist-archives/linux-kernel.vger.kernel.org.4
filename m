Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD0D725388
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjFGFkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjFGFkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:40:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CA21BC9;
        Tue,  6 Jun 2023 22:40:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-25669acf1b0so6001654a91.0;
        Tue, 06 Jun 2023 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686116405; x=1688708405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/Rzvp7nuogI5Ectr3FY2yXKUolZXQo8yN+TgASj1xc=;
        b=MRdW5VFR6T30zctQdM6ToETADfjr+NIYOTbXzxRMTnkXkJnGTAKDUX8DYwKWJz31MT
         IMWgL378x/sh0JVf0p/3cwfdC4T/J+337WiXTKrEU663M9fmQZDMLJG0lG4zMVkZaPoi
         uvaxht7Hrt0VDtTvzbRbKlF07audtIoM9/TfGPnardXUX2VJxWKwKd/Yt/TqybjN4Nu4
         z1Vw0Z137dmhbRuTLajHHRupMJwctKjh5jp2egBgRwOnM7mQhc+XGdBbd7HvQn0j0D7g
         LQ/pYoQEUWPiNxNCjWlMWbAGt16KyvanCJSPjgfWInHfWM9aCr8Bkh5L5IOLhAPs3Scv
         l+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686116405; x=1688708405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/Rzvp7nuogI5Ectr3FY2yXKUolZXQo8yN+TgASj1xc=;
        b=RTgk27F+zZ5C8L+JfQ9QEh5Z1zw/RtNW1MtSlitxq69lW0aDcpuuPxa4bAOCmenwf9
         ZcR061EBbSo2yAgl12QMn5vfycBZtEbuSf91itLBxNotIwtGyujDjbxgZ5UA8nJ4MFgc
         r7ipWDhmbWM620RcvK/Ibz7s0RM5SSrw6Jpk0aNu4qY3lZ1lBbZupzJXNS/iyQxymLBh
         yFcCxb9YEBryhGKXHLQFeiijSvq9S8VS+RM6BQLAxtTrl48TVz9qWR8VKfsAA4BGPMGV
         xnPHT0RsOn6hpozsgjNvpTAk5aZckrZl4h2n0IvP0jMzB6nTV2U1ewpS0ENBDxo8oM3r
         xEgg==
X-Gm-Message-State: AC+VfDziC60uqw+PTV5WP/umUis5osdJBzUgMWdvEqBPxhPnQYlpdP11
        afwb10ELags2dkuwt4HKoVI=
X-Google-Smtp-Source: ACHHUZ5mhizpDI1GSpP3Pe8ZLSwtX30DWzdzw/ugaG/JesMxJWpE7LEHYCiF048V2NzngDt/CM3F8A==
X-Received: by 2002:a17:90a:50:b0:256:35f0:a2b0 with SMTP id 16-20020a17090a005000b0025635f0a2b0mr4167122pjb.0.1686116404968;
        Tue, 06 Jun 2023 22:40:04 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902989800b001b03b7f8adfsm887243plp.246.2023.06.06.22.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:40:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E96DA1069BF; Wed,  7 Jun 2023 12:39:59 +0700 (WIB)
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
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/8] crypto: fcrypt: Replace dual BSD 3-Clause/GPL 2.0+ boilerplate with SPDX identifier
Date:   Wed,  7 Jun 2023 12:39:43 +0700
Message-ID: <20230607053940.39078-12-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607053940.39078-10-bagasdotme@gmail.com>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010; i=bagasdotme@gmail.com; h=from:subject; bh=unGm1pNbGyn58qqwh1tYYYzr9eXLpvqklZLnWANRr3c=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkNErKuC54tXHCL7aHmg5/TT/aalBxOWmyw3Xnesbub7 8wumMrC3lHKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJ+LEzMtwqqZ7R935636ag WddOsIf+fjX3D7f8Mrb/uncO3u35lneP4b9LcvOaXv1Tb35MffZsYagNk4O8QDlfhGzfscoGaZu GVbwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
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

fcrypt implementation (crypto/fcrypt.c) have license boilerplate
for GPL 2.0+ (as implemented in the kernel) and BSD 3-Clause
(from original Royal Institute of Technology code). Replace the
boilerplate text with corresponding SPDX license tag. As there
is no wording that allows using either license alternatively,
use AND operator.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 crypto/fcrypt.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/crypto/fcrypt.c b/crypto/fcrypt.c
index 95a16e88899baf..ecbd29d0deba6b 100644
--- a/crypto/fcrypt.c
+++ b/crypto/fcrypt.c
@@ -1,45 +1,15 @@
+// SPDX-License-Identifier: BSD-3-Clause AND GPL-2.0-or-later
 /* FCrypt encryption algorithm
  *
  * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
  * Based on code:
  *
  * Copyright (c) 1995 - 2000 Kungliga Tekniska Högskolan
  * (Royal Institute of Technology, Stockholm, Sweden).
  * All rights reserved.
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * 3. Neither the name of the Institute nor the names of its contributors
- *    may be used to endorse or promote products derived from this software
- *    without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE INSTITUTE AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE INSTITUTE OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
  */
 
 #include <asm/byteorder.h>
-- 
An old man doll... just what I always wanted! - Clara

