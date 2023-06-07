Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D83725397
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjFGFki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjFGFkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:40:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC041BDD;
        Tue,  6 Jun 2023 22:40:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d24136685so183806b3a.1;
        Tue, 06 Jun 2023 22:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686116408; x=1688708408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppkNBQmxuYcx/PbkAqfMSVxZ68/cT5Kv/2fTrtmlqEk=;
        b=B4O5lOCOB3yCh5moxDOr4Jg/b1HnKTE7stRyg3RjipYE83c4pVXan25fygnE67yDsY
         wnASV+/gFFtNLVKn4jONYOdjqn3q1QuOFSwxJ/9lPMRxWDRR09N3ijPkjwWWaaJG67T/
         oQ2VPhl9Jg81TjuGZQqDUvktRIs2e+9w8EntXDaKRtAcP8Zl2jFDOFJ5zcYVWytOM+qd
         2emKvR+rzQgMRAWZ9wuHmcBO9+nsUzm++KfEERLUAGdnGxt4Cfp+I4vi+DXFp9mpy1bx
         mJ+aD38mwQV1bucup+5SwMxE8GK6Gug6CCAifkZkuvNOFm4hXcU4S3jk9EFVYhC8GtPW
         wCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686116408; x=1688708408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppkNBQmxuYcx/PbkAqfMSVxZ68/cT5Kv/2fTrtmlqEk=;
        b=RD5+MZjrrb85WA+vW5cf3erKtfAjtHGYV8eahJbbgzEEh5uUrzfuj69XmBKDhRrVfA
         gLXN8uS4fcZsjmf99xPtPyqb8hiYmpxPL8GFkfm9vxRk4XeJc4Nrc8Ea1pqiwUcbpUh/
         TC1s35nCFn7FRIDYfIPov1jHjA8L9mP03dX0X0n+eRqV4XPY1+VFuvJlSv5K0hGb0Ine
         bVgKbllYkTH6N63KHVJDKvUkyAooHECwROwT13yve6/+fUK0C7NrQU404zdEhVG0owmt
         L9gEr8q6R3/CpQQp7RKP0hNbAdxbMRJt607Q47DbMDgg4HbKu7yrXnn3RkNe0U4tpDp0
         wpEA==
X-Gm-Message-State: AC+VfDyKccLm/+uJKCRsFFvhSyqJkfhlIAacw0luyG6Wo/Kvfez3Oj1Y
        SsmsCiYA7OBbIoc/+GusA3c=
X-Google-Smtp-Source: ACHHUZ5MEl6/JLOskdIYCk20E2uKFLC2K7IVvzzE6m5WKXMFfIfCOxC7ypOQnS/Q1FHTzr88oSRUOw==
X-Received: by 2002:a05:6a00:230b:b0:659:f4ed:42bc with SMTP id h11-20020a056a00230b00b00659f4ed42bcmr5029604pfh.4.1686116407965;
        Tue, 06 Jun 2023 22:40:07 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id v6-20020a62a506000000b0065007825f51sm7582619pfm.79.2023.06.06.22.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:40:07 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A6D9D1069F0; Wed,  7 Jun 2023 12:39:59 +0700 (WIB)
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
        Aaron Grothe <ajgrothe@yahoo.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        James Morris <jmorris@intercode.com.au>
Subject: [PATCH 6/8] crypto: Replace GPL 2.0 boilerplate with SPDX license identifier
Date:   Wed,  7 Jun 2023 12:39:47 +0700
Message-ID: <20230607053940.39078-16-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607053940.39078-10-bagasdotme@gmail.com>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8338; i=bagasdotme@gmail.com; h=from:subject; bh=HaKi76264HutMA3mSn1u8pzgQiTvHlhgbaB3QdLtb8A=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkNEnJCv5N+hrcdubc74/2MsnL1kNnNcZOTNhwNMdRS0 53gMUWmo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABO5VMXwT8W0jrO6SurFzmgW Fh9et3XOk5b++XYlPjgmuNjV0kzpMCPDqVv7nnZff959arpKZ8P3Y3+im2XjFm/92uTH0hriYpT DBwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the license boilerplate text with appropriate SPDX tag.

Cc: Aaron Grothe <ajgrothe@yahoo.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: James Morris <jmorris@intercode.com.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 crypto/anubis.c            |  6 +-----
 crypto/crct10dif_common.c  | 15 +--------------
 crypto/crct10dif_generic.c | 15 +--------------
 crypto/khazad.c            |  6 +-----
 crypto/md4.c               |  6 +-----
 crypto/md5.c               |  6 +-----
 crypto/poly1305_generic.c  |  5 +----
 crypto/vmac.c              | 13 +------------
 crypto/wp512.c             |  6 +-----
 9 files changed, 9 insertions(+), 69 deletions(-)

diff --git a/crypto/anubis.c b/crypto/anubis.c
index 9f0cf61bbc6e26..c3ca6d87b8a0aa 100644
--- a/crypto/anubis.c
+++ b/crypto/anubis.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Cryptographic API.
  *
@@ -22,11 +23,6 @@
  *
  * By Aaron Grothe ajgrothe@yahoo.com, October 28, 2004
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  */
 
 #include <crypto/algapi.h>
diff --git a/crypto/crct10dif_common.c b/crypto/crct10dif_common.c
index b2fab366f518bc..0eac9fa1d0088e 100644
--- a/crypto/crct10dif_common.c
+++ b/crypto/crct10dif_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Cryptographic API.
  *
@@ -8,20 +9,6 @@
  * Copyright (C) 2013 Intel Corporation
  * Author: Tim Chen <tim.c.chen@linux.intel.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- *
  */
 
 #include <linux/crc-t10dif.h>
diff --git a/crypto/crct10dif_generic.c b/crypto/crct10dif_generic.c
index e843982073bb58..aef86b2c7a1e36 100644
--- a/crypto/crct10dif_generic.c
+++ b/crypto/crct10dif_generic.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Cryptographic API.
  *
@@ -8,20 +9,6 @@
  * Copyright (C) 2013 Intel Corporation
  * Author: Tim Chen <tim.c.chen@linux.intel.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- *
  */
 
 #include <linux/module.h>
diff --git a/crypto/khazad.c b/crypto/khazad.c
index 70cafe73f97405..42c2ac2603f7d2 100644
--- a/crypto/khazad.c
+++ b/crypto/khazad.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Cryptographic API.
  *
@@ -12,11 +13,6 @@
  *
  * By Aaron Grothe ajgrothe@yahoo.com, August 1, 2004
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  */
 
 #include <crypto/algapi.h>
diff --git a/crypto/md4.c b/crypto/md4.c
index 2e7f2f319f9503..0ba32634088bd3 100644
--- a/crypto/md4.c
+++ b/crypto/md4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* 
  * Cryptographic API.
  *
@@ -14,11 +15,6 @@
  * Copyright (c) 2002 David S. Miller (davem@redhat.com)
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  */
 #include <crypto/internal/hash.h>
 #include <linux/init.h>
diff --git a/crypto/md5.c b/crypto/md5.c
index 72c0c46fb5eea2..d17cc0180f699f 100644
--- a/crypto/md5.c
+++ b/crypto/md5.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* 
  * Cryptographic API.
  *
@@ -9,11 +10,6 @@
  * Copyright (c) Cryptoapi developers.
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
  * 
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option) 
- * any later version.
- *
  */
 #include <crypto/internal/hash.h>
 #include <crypto/md5.h>
diff --git a/crypto/poly1305_generic.c b/crypto/poly1305_generic.c
index 94af47eb6fa699..9cd51b6d7d892d 100644
--- a/crypto/poly1305_generic.c
+++ b/crypto/poly1305_generic.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Poly1305 authenticator algorithm, RFC7539
  *
@@ -5,10 +6,6 @@
  *
  * Based on public domain code by Andrew Moon and Daniel J. Bernstein.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <crypto/algapi.h>
diff --git a/crypto/vmac.c b/crypto/vmac.c
index 4633b2dda1e0a5..0052c32c3f11b3 100644
--- a/crypto/vmac.c
+++ b/crypto/vmac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * VMAC: Message Authentication Code using Universal Hashing
  *
@@ -6,18 +7,6 @@
  * Copyright (c) 2009, Intel Corporation.
  * Copyright (c) 2018, Google Inc.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
- * Place - Suite 330, Boston, MA 02111-1307 USA.
  */
 
 /*
diff --git a/crypto/wp512.c b/crypto/wp512.c
index 07994e5ebf4ef2..31040492c98175 100644
--- a/crypto/wp512.c
+++ b/crypto/wp512.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Cryptographic API.
  *
@@ -13,11 +14,6 @@
  *
  * By Aaron Grothe ajgrothe@yahoo.com, August 23, 2004
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  */
 #include <crypto/internal/hash.h>
 #include <linux/init.h>
-- 
An old man doll... just what I always wanted! - Clara

