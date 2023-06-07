Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08F3725382
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjFGFkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjFGFkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:40:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B9D19B9;
        Tue,  6 Jun 2023 22:40:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b039168ba0so60143445ad.3;
        Tue, 06 Jun 2023 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686116404; x=1688708404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QnIpKHGIOTbO5xF+lSKDonxY4sTlRVD/4+u6L5lQYbA=;
        b=pN46dgI2PiEML1SQ/upye3FTeKtmsdFjs4ymIH98J4xJVVtG0E3W6jzi/90/52kJHq
         yKsQq7ENvxbAW0eBpoEddSsxykHlkCiYkqgP0BHaKlzZLnzT4TnU2YXCf7UzUeuxWhNR
         hxXecBImGxDie8cVQOXQLDChledSJrgqQWyNzkc01rJa46pv8n2/oVDGN3hBkC6gXeH6
         c4XNT5AobXAM17Avu5Ye9otWrf5lBj4ZtejY2JPqlqK9mURM0Tg/Er7xWvoNIsxNlQ2u
         OSHK1KeEtjipAFcWvR7g0RRMRGJOh5zhaUSwyqeqfJseIK4LUU7GKFDrh3w8OO6W0WU8
         johw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686116404; x=1688708404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnIpKHGIOTbO5xF+lSKDonxY4sTlRVD/4+u6L5lQYbA=;
        b=Xt86Tq3WuqEFTFpMKGg+3JJTABl5k0nNZUHxty0n9ZtwMbGVZ1MzWhUfO10tAcQGgM
         s9I5sEvE5/+BjMkaRncfX2EiFN0dp0PmjglGKxI9LlPIivTb1Rd78CgVXxl6V8kDRqHF
         iJD5GIS1nxt9gaJnwTfFnQcqvgW5t22ne5uqZDMDzpN21lHxrC8HS8mqXKGQkY/dxTyL
         YsYK0+R8GGdlkkbcqqJdGi+tQdOTw5lHlGmwHmN63FPbWn+LbSbEFAgbMiHkft2ifDWp
         APBbU8O/Qwcl+NgsL2NVnvJ8ieqGujftMsKCnO9uL2M0XmX4PgZV1NoCPcVIyeAQUqVJ
         XblA==
X-Gm-Message-State: AC+VfDyNP1y2vhdpopmuhabr9+DjWJPtjhwkjYUKN6quCz/hbHGXTiiM
        egjuDa5d17EXOTNFwSX8u7k=
X-Google-Smtp-Source: ACHHUZ4WH3qatIHs9fnjT2MhOeHKHI6b15dSEKZ0JxD/EdjNDZ9cGjxJG70ofJMixeqnWYSLy4hq3g==
X-Received: by 2002:a17:903:2284:b0:1b0:75e1:3949 with SMTP id b4-20020a170903228400b001b075e13949mr5486659plh.37.1686116404421;
        Tue, 06 Jun 2023 22:40:04 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id bc3-20020a170902930300b001a505f04a06sm9472196plb.190.2023.06.06.22.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:40:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3865E1069B9; Wed,  7 Jun 2023 12:39:59 +0700 (WIB)
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
Subject: [PATCH 0/8] SPDX conversion for cryptographic algorithms
Date:   Wed,  7 Jun 2023 12:39:41 +0700
Message-ID: <20230607053940.39078-10-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422; i=bagasdotme@gmail.com; h=from:subject; bh=WDj4BEWJrXIL/c7Y0+Vf4YWvX5xVaNlCUhPBw+xl3tI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkNEjLN4R7t19w950n41kqxveHbebXfsSP6v/q0Lws6D nZy/jjQUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIkYfmP478k3fV5BbOMh04vK dc/usBZoJX87Zi95XWfT5EWTNpt2azL8d5SNZ1qlbWu/XVzpn9wu1bykNxkCtZOOpWY5ealNqeT nBQA=
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

I prompted to create this series when reviewing trivial,
checkpatch-fixing patches from Franziska Naepelt [1]. When
reviewing crypto ones and looking on SPDX changes, I felt that
these could be better sent as separate patch series covering
whole crypto/ directory instead. So here is the series and
happy reviewing!

[1]: https://lore.kernel.org/all/?q=f%3A%22bagasdotme%40gmail.com%22+AND+tc%3A%22Franziska+Naepelt+%3Cfranziska.naepelt%40googlemail.com%3E%22 

Bagas Sanjaya (8):
  crypto: Convert dual BSD 3-Clause/GPL 2.0 boilerplate to SPDX
    identifier
  crypto: fcrypt: Replace dual BSD 3-Clause/GPL 2.0+ boilerplate with
    SPDX identifier
  crypto: drbg: Convert dual BSD 3-Clause/GPL-1.0 license boilerplate to
    SPDX identifier
  crypto: ecc: Replace BSD 2-Clause license boilerplate with SPDX
    identifier
  crypto: streebog_generic: Correct SPDX license identifier
  crypto: Replace GPL 2.0 boilerplate with SPDX license identifier
  crypto: ecrdsa: Remove GPL 2.0+ boilerplate
  crypto: cts: Convert MIT boilerplate to corresponding SPDX license
    identifier

 crypto/aes_generic.c         | 31 +------------------------------
 crypto/algif_rng.c           | 33 +--------------------------------
 crypto/anubis.c              |  6 +-----
 crypto/crct10dif_common.c    | 15 +--------------
 crypto/crct10dif_generic.c   | 15 +--------------
 crypto/cts.c                 | 24 +-----------------------
 crypto/drbg.c                | 33 +--------------------------------
 crypto/ecc.c                 | 21 +--------------------
 crypto/ecrdsa.c              |  4 ----
 crypto/ecrdsa_defs.h         |  4 ----
 crypto/fcrypt.c              | 32 +-------------------------------
 crypto/jitterentropy-kcapi.c | 32 +-------------------------------
 crypto/jitterentropy.c       | 35 +----------------------------------
 crypto/keywrap.c             | 32 +-------------------------------
 crypto/khazad.c              |  6 +-----
 crypto/md4.c                 |  6 +-----
 crypto/md5.c                 |  6 +-----
 crypto/poly1305_generic.c    |  5 +----
 crypto/streebog_generic.c    |  6 +-----
 crypto/vmac.c                | 13 +------------
 crypto/wp512.c               |  6 +-----
 21 files changed, 19 insertions(+), 346 deletions(-)


base-commit: 134e0dc6b73ab7e99464182356a8b3fa4ea3b499
-- 
An old man doll... just what I always wanted! - Clara

