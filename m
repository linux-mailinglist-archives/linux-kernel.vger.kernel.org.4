Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEB8725389
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjFGFkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjFGFkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:40:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6761BCE;
        Tue,  6 Jun 2023 22:40:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so6382310a12.2;
        Tue, 06 Jun 2023 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686116405; x=1688708405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+8UPp0cZHZIddVOMxW5nsY5DBDHJWP3+5gafJdKjQI=;
        b=YovnA9P62qNMyWJjBcA9I69J6z5SjieW+klJnmPS2c0NJ+9bPaZHJmktJ1JXckJVVv
         SN4LdeRvIFES24Qc2/s6GRXWPWW5y7sCRGTtLKgmNsIb2IDTjf3OWSPgKgm0ETeCjEm8
         89rC96pa7SM4wFXEncmDC2KAyqKlsNeyADRy5wnxTUiTSEauVnuhOchS5p4ZOAHLe+pj
         JXCKPsWhlBi5QKQy3FHmG5RlSHQdMA2N+H+oHaCA9oA5yCzRd4X8EEld3q4DqZJZyT0D
         3XJliktDnlgLZ2RaBJKM76we4c/X3i/RRz/cajZFQyh0cBahVK5TuwEyKMjNUoKmc8oX
         Sw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686116405; x=1688708405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+8UPp0cZHZIddVOMxW5nsY5DBDHJWP3+5gafJdKjQI=;
        b=dyWELoc+GDO3VqKPweyJjE13sB7OglyrxhRR5BLX9Zdb+PVdM41Cy6ogMawy5EAuqA
         1eFKprU6zXFyfDwR6n8E1ywF1efkj/Z2A1ZpWO/1+mCcmlu7lA7giNG6TGIwlSRzCr4q
         3bT1eFh1sl/jUK86WQg3oMNCm5ccCtmv0cvpiJhViAiyNw6DnGUMrxzHhIaZWyYjwQSR
         BmVf9sie09GY0M02L/fhtH0riDDJr+ASSVb4+i2arULpPf4dkQbJFi3xrJ6hPb8c2rb8
         ox0T6U4gqyob3hyMzybsjf/B5xBCwsHR7iENqsMIv4ZXgQWTbLeWat5bbDJOHb15lM9m
         mrdA==
X-Gm-Message-State: AC+VfDw7kFPXdiTDxw1ZlludY0fZ0huT9AkfiEeEUswdxjDHem2Q6r6Y
        SEYrgXTgMCCwLpWQODnk4EM=
X-Google-Smtp-Source: ACHHUZ5KDCaSA69ynZiyIKoO8lR256jraZo4SDPJo1wNlaDfijTQdbJgkTXjTJ63OEWwV+43YurifA==
X-Received: by 2002:a05:6a20:a20d:b0:118:520:765a with SMTP id u13-20020a056a20a20d00b001180520765amr1468885pzk.61.1686116405227;
        Tue, 06 Jun 2023 22:40:05 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id ev21-20020a17090aead500b00256833cd9a4sm468624pjb.54.2023.06.06.22.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:40:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5A2421069B8; Wed,  7 Jun 2023 12:39:59 +0700 (WIB)
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
        Vitaly Chikunov <vt@altlinux.org>,
        Salvatore Benedetto <salvatore.benedetto@intel.com>
Subject: [PATCH 4/8] crypto: ecc: Replace BSD 2-Clause license boilerplate with SPDX identifier
Date:   Wed,  7 Jun 2023 12:39:45 +0700
Message-ID: <20230607053940.39078-14-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607053940.39078-10-bagasdotme@gmail.com>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; i=bagasdotme@gmail.com; h=from:subject; bh=AgbqCTOFLAEDWxVOnLceuGG2uLpV5xnB9bcU418E8tM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkNErKe+jbPV5RnR7h9Y642mcvvtjVr08Uzanlz5rWcP fSI5/y7jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExEQ4rhn02+w8l2HgH7hebt Dm7SH24Fsb+aPeffxoaf7jvTF/jFP2P4w/OU+WSvw82b155qCcmrHPrq4HDJQX7rGTtXC8krm6Z ocgIA
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

Convert boilerplate text for BSD 2-Clause to corresponding SPDX license
identifier.

Cc: Vitaly Chikunov <vt@altlinux.org>
Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 crypto/ecc.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index f53fb4d6af992b..9d86db24ca748c 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1,27 +1,8 @@
+// SPDX-License-Identifier: BSD-2-Clause
 /*
  * Copyright (c) 2013, 2014 Kenneth MacKay. All rights reserved.
  * Copyright (c) 2019 Vitaly Chikunov <vt@altlinux.org>
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are
- * met:
- *  * Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- *  * Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #include <crypto/ecc_curve.h>
-- 
An old man doll... just what I always wanted! - Clara

