Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CDB72539D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjFGFkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjFGFkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:40:25 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF51E19BA;
        Tue,  6 Jun 2023 22:40:09 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba81ded8d3eso8380200276.3;
        Tue, 06 Jun 2023 22:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686116409; x=1688708409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdM99WYdQelOMGpMu+7j5o3NWZCSKwsXsFleMdKpHBQ=;
        b=kl0HVpuG3bIsZZjUIhRHkDK9g56N+CpBPVg4yZIv0LFNmYpe6Eow4gleIygxXi7HtV
         qaUkRbqfJt+Kw3r5/bn39/gCvV4PrmARyoO9dG85C/xW0Yqwfy32rFEog0BPU2L3ViWC
         sC02bhS55fHUODgV90yXpG35Y0taOj+nGerWR63nmIKgiX09+k02akS1s9IVKK/7jKpA
         0Qiq+tCWl7XTEzNFKKcFl3xFMXCgpasmy/t46BiM6+3FbDt58jr1VKXEpOQDJg+ovxzp
         7ZmzYgzfRtEqIRTFRRYYORh9a6+1nclVqNBvNn7rMHw7Hy0Q0FlkzCOKkSa8pS+5Y3i5
         eXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686116409; x=1688708409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdM99WYdQelOMGpMu+7j5o3NWZCSKwsXsFleMdKpHBQ=;
        b=dFvIIFGLHj5cNtH48/oaB3ZQelLt9f1DXsmCTy68v9dnd7ZxY+FgbGugzNCtGCC5n/
         rBsUwYMe/PrvbHfvkW7pV/3mU+Sc46kKt19ol+rtGzAhF62waEh2EuuSeGZKxsDLvMw6
         eJ2HH2QBGIQkGNDyN+7dT6osSys+0zYdjmZUopJuQs4S/DCIQwMKeCxH+efXPX13TKxk
         yHaJmBpLE7Bh/0QHwXDJTJIeISXQnLeyzaCkHjKQMaCZjFEHEvT4J9fjFSBzIQjVOmGz
         31gOim9svZAyxZQIylSRLk8gGyepVM7fgwO82J1u0sOxnupv4OxuLcWXvwquGg95pDfG
         W9Uw==
X-Gm-Message-State: AC+VfDxWUXPdlPKM1X89TaAoJl6U/frc/iybFYnQQFucI12/VANPiV4t
        zYpif3t/bvrao2uPuO8a98U=
X-Google-Smtp-Source: ACHHUZ4mCB3LsFvodVihfPVbGPUZtGL4+R7FasXounRJVMbq1AgF37C39CFk3Jq/lhG0KTzjGFbLUA==
X-Received: by 2002:a25:1087:0:b0:bb3:ae54:9fcd with SMTP id 129-20020a251087000000b00bb3ae549fcdmr3584173ybq.23.1686116408773;
        Tue, 06 Jun 2023 22:40:08 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id bd5-20020a170902830500b001b06361a38dsm9419509plb.116.2023.06.06.22.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:40:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E009D1069FD; Wed,  7 Jun 2023 12:40:00 +0700 (WIB)
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
Subject: [PATCH 8/8] crypto: cts: Convert MIT boilerplate to corresponding SPDX license identifier
Date:   Wed,  7 Jun 2023 12:39:49 +0700
Message-ID: <20230607053940.39078-18-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607053940.39078-10-bagasdotme@gmail.com>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2001; i=bagasdotme@gmail.com; h=from:subject; bh=EyrSqctQWk7uvoCz1uQF3lpzs3d6S+Uv5OFoI1+90Dk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkNEnI3Xwi2X+f7qSJ0aF5rB7vNi2+XFxqwzFhi9WpLk Le674eVHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiIzFeG/wlZxRE3Q1fm6aal 7Ilca5ZTrrRg/uQ65oNX+mMivwVP3MrI8O/o7lXfVQR53lrfzTJnETgeKSOR/cr8fkXGedHyuGn mrAA=
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

License boilerplate in CTS mode implementation (crypto/cts.c) looks like
MIT license with advertising clause. Replace it with correspondig
SPDX tag.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 crypto/cts.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/crypto/cts.c b/crypto/cts.c
index 8f604f6554b1c3..9ec7e9787c0f6a 100644
--- a/crypto/cts.c
+++ b/crypto/cts.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * CTS: Cipher Text Stealing mode
  *
@@ -5,29 +6,6 @@
  * The Regents of the University of Michigan
  * ALL RIGHTS RESERVED
  *
- * Permission is granted to use, copy, create derivative works
- * and redistribute this software and such derivative works
- * for any purpose, so long as the name of The University of
- * Michigan is not used in any advertising or publicity
- * pertaining to the use of distribution of this software
- * without specific, written prior authorization.  If the
- * above copyright notice or any other identification of the
- * University of Michigan is included in any copy of any
- * portion of this software, then the disclaimer below must
- * also be included.
- *
- * THIS SOFTWARE IS PROVIDED AS IS, WITHOUT REPRESENTATION
- * FROM THE UNIVERSITY OF MICHIGAN AS TO ITS FITNESS FOR ANY
- * PURPOSE, AND WITHOUT WARRANTY BY THE UNIVERSITY OF
- * MICHIGAN OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING
- * WITHOUT LIMITATION THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
- * REGENTS OF THE UNIVERSITY OF MICHIGAN SHALL NOT BE LIABLE
- * FOR ANY DAMAGES, INCLUDING SPECIAL, INDIRECT, INCIDENTAL, OR
- * CONSEQUENTIAL DAMAGES, WITH RESPECT TO ANY CLAIM ARISING
- * OUT OF OR IN CONNECTION WITH THE USE OF THE SOFTWARE, EVEN
- * IF IT HAS BEEN OR IS HEREAFTER ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGES.
  */
 
 /* Derived from various:
-- 
An old man doll... just what I always wanted! - Clara

