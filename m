Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4407972539C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjFGFko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjFGFkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:40:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CDD19BB;
        Tue,  6 Jun 2023 22:40:09 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-544c0d768b9so93241a12.0;
        Tue, 06 Jun 2023 22:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686116408; x=1688708408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lXzDlIRubHlhy/CsxVW+JbBC++SnpeBdmdg3V9XuAw=;
        b=M0N4V9J5qABc4z4kI0dI186KV3jIeQwuP4SGu26BZ22qK/+FZhuEZCP7v4j7ddJOKG
         IZKZAO15I9Nou6XZnEnsiJvEl+MYuhOtmz/ZVj8A5bFHRyZk+LUnMRUxzSShH00yz0qi
         mycXfAybcYzdZ0yqk38otmG6raH0aMtqZkd1XXouqu149JwDZtGn+eSC4VBwm5vVYvJ/
         WolsNVhIDBSBvVD+R/uRMApuni9GHClpPvCwpZ3vfRkjnTrD+mfumyHfTCuYD3i+OQU6
         Vom0z93+t4gIl0iUg1PLDS5gak6f+aOeTSxPn3nkUx88wxwgFdf1gzgefEVX/J5Mg8uz
         cQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686116408; x=1688708408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lXzDlIRubHlhy/CsxVW+JbBC++SnpeBdmdg3V9XuAw=;
        b=bipW1fNBw22Ei5Zx1vEh2HjA7SZVusQe5ru7KipQQrpiJ4a0clsWIGxhQ2Ci+4UQcw
         x7vDUo67zayAvuI6leeXyxSP3JrngZ4bVtQpW8OcWFAMoTvuhNad7iwcJ8sQ/zPHizPU
         GHwKlXdTV7RHkyyxhWfsidQpimvob9gpy7WHh+BdDgKi7epkGiuPSGgORbbqb8edLAP6
         ZEgylbJlSwOd6gtUf36RYpyN6qkvaQxj9913+X0bw1uEgPbOGv82+Jh7Wum5qTmTpmh2
         mFvG2zbT9ZzqGhy/GEThdDL7WIPcxV7jyvskNWzineoW0rNohCqsAP4ONgSih0Amp06b
         VaTg==
X-Gm-Message-State: AC+VfDwFefRbz7J/NAG5crYD+VHioKAsAZo91bgLLnTzq/2mv6fDzpPf
        i+t0n5SCmG8ia/3APny0OUU=
X-Google-Smtp-Source: ACHHUZ7rnAnMjbTZRqpRUpotHxykkdBK1oSH9hASXDkotGIhtyJB8nawn+ESJVt5ltBjR5eRfNLLlg==
X-Received: by 2002:a17:90b:1916:b0:256:c3dc:dae6 with SMTP id mp22-20020a17090b191600b00256c3dcdae6mr4002355pjb.31.1686116408510;
        Tue, 06 Jun 2023 22:40:08 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id mv21-20020a17090b199500b00253311d508esm486877pjb.27.2023.06.06.22.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:40:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CCCF31069F2; Wed,  7 Jun 2023 12:40:00 +0700 (WIB)
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
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH 7/8] crypto: ecrdsa: Remove GPL 2.0+ boilerplate
Date:   Wed,  7 Jun 2023 12:39:48 +0700
Message-ID: <20230607053940.39078-17-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607053940.39078-10-bagasdotme@gmail.com>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=bagasdotme@gmail.com; h=from:subject; bh=NJRi3h9oW9raGN/AaB5tvEhQzCjkBkn8/eUkhYzaXRY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkNEnLTWL5/miDzZ+KE1bvPnfzr8tGqe067r3Lg9R+Fa 8qyP6z36ChlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEhM8yMhy/KtZ38W5khLJI eN66L7pFrGHq585YL7FX2e1v+q78xTpGhjVL7y72bk7+37qqdA1Pbvy5CY8DLrblGy9zWG7eaXj ejAsA
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

Remove the unnecessary license notice since there is already matching
SPDX license identifier which does the same job.

Cc: Vitaly Chikunov <vt@altlinux.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 crypto/ecrdsa.c      | 4 ----
 crypto/ecrdsa_defs.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/crypto/ecrdsa.c b/crypto/ecrdsa.c
index f3c6b5e15e75ba..4a08ef48e95c5e 100644
--- a/crypto/ecrdsa.c
+++ b/crypto/ecrdsa.c
@@ -10,10 +10,6 @@
  * Historical references:
  * GOST R 34.10-2001, RFC 4357, ISO/IEC 14888-3:2006/Amd 1:2010.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  */
 
 #include <linux/module.h>
diff --git a/crypto/ecrdsa_defs.h b/crypto/ecrdsa_defs.h
index 0056335b9d03a1..82d4229ea879b6 100644
--- a/crypto/ecrdsa_defs.h
+++ b/crypto/ecrdsa_defs.h
@@ -4,10 +4,6 @@
  *
  * Copyright (c) 2019 Vitaly Chikunov <vt@altlinux.org>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  */
 
 #ifndef _CRYTO_ECRDSA_DEFS_H
-- 
An old man doll... just what I always wanted! - Clara

