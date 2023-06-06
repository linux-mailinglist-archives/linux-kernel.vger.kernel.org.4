Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B6872408E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjFFLL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjFFLLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:11:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0449E;
        Tue,  6 Jun 2023 04:11:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977ed383b8aso222912466b.3;
        Tue, 06 Jun 2023 04:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686049881; x=1688641881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6t2//VxeuXac+D3CtDXHHtOEiYVaPdfCbZwpL+Sh+X0=;
        b=jY2Jp9PmjpXxBEpmLQ+YoPVYhkFKPIAtr1YnXtU72Sz2S7HvjLI2sae/qVjBPMw0Jj
         1mIjydGVpfXV3/aaaFqCB0WX5fmt1qTwEIFKolS8RleU+CYT+lHxCMPu3Ko3fDWNhuQS
         YhMxGzHcqoVCbxIlFAEwbmNCAK7BNqyBMvijNNvcPEncI2xb0nU/O+wDWYxVgotySaEF
         CkTU/bYMV3hQoWGuCYSuX31hC/JWko9byjD6Mxf4pfOWCHkxOMTUAxoUBRtZnxG1Aov1
         CC1qDp0xHw9GZBckGFI97hx2JlSuI0LXux7cGQ4B0F8tMEbgjwxYWlQhZBHKWuFQ06z0
         VwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049881; x=1688641881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6t2//VxeuXac+D3CtDXHHtOEiYVaPdfCbZwpL+Sh+X0=;
        b=X7Uvao+p8UO4owCT7fJ/otIdEclA4hiVr6/f89OSArlkRKY1CNcT+A9NfrrBtdTAeq
         WyuFZ5+2bSbffCn1CjI0QnJ5GCKAi7DxAZJwNy9OQVv15IJ0XJUtaOYnFyj8LBKH8QNx
         Le4WMxeY4g9phn9+gltkZoqvTR+gLbexOyx7jS1KUymF6YEExOghUXU9s+G6g4/LEnpS
         MMBvXLhqhVz+1HRpnJO3C+LZuw0HTW30aPWUSd9Qx3WBNHowwaT/joOlVcWIJmdeAlxi
         Oetd1AAhtBAskt8Jo5mT7dBkfriUeUwaky4p9muVOm9J4xg0svXmMi4C9dAHrBeixx1Z
         oVYw==
X-Gm-Message-State: AC+VfDzFxk9D1jbhBPCO3KctMgObFGyf8ZNaYhirQw3QPMmN58V0b6uB
        5NiD33AoNB1IBQ8EVEWHVGcRCbNVQzRtaA==
X-Google-Smtp-Source: ACHHUZ4JmVpt6jPZqJ5mAaxDwYQ9uekupNzZwkjIRAPKb/r2DQGSHpfSK2Fjp4HZz5rhw/JuX0ShzQ==
X-Received: by 2002:a17:906:974b:b0:973:df9c:b1aa with SMTP id o11-20020a170906974b00b00973df9cb1aamr2040856ejy.71.1686049881264;
        Tue, 06 Jun 2023 04:11:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:7ce9:cf23:e2e1:1e2e])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906504400b0095342bfb701sm5608364ejk.16.2023.06.06.04.11.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Jun 2023 04:11:20 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH] crypto: frcypt Fix checkpatch warnings
Date:   Tue,  6 Jun 2023 13:10:42 +0200
Message-Id: <20230606111042.96855-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
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

The following checkpatch warnings have been fixed:
- WARNING: Missing or malformed SPDX-License-Identifier tag
- WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 crypto/fcrypt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/fcrypt.c b/crypto/fcrypt.c
index 95a16e88899b..d81d65489c41 100644
--- a/crypto/fcrypt.c
+++ b/crypto/fcrypt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* FCrypt encryption algorithm
  *
  * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
@@ -303,7 +304,8 @@ static int fcrypt_setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int key
 
 #if BITS_PER_LONG == 64  /* the 64-bit version can also be used for 32-bit
 			  * kernels - it seems to be faster but the code is
-			  * larger */
+			  * larger
+			  */
 
 	u64 k;	/* k holds all 56 non-parity bits */
 

base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
-- 
2.39.2 (Apple Git-143)

