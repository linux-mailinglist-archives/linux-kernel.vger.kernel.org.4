Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAF6724079
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbjFFLEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjFFLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:03:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACC110E5;
        Tue,  6 Jun 2023 04:03:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977cf86aae5so392491366b.0;
        Tue, 06 Jun 2023 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686049409; x=1688641409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLJjLTW16hmNcMoYy+dcT/Da1eHMITmiB6Cn5sB+zWg=;
        b=byHapCDzMAqDp+rL1zGcdj9FtVtBaXKwgeLv9H+ME6Fjjqtca1X9j3019nCzGg1gAT
         1bWQA6o0dnIcmx17qFaGxVOy7tFLAp8Hy6eSHlVe/vj0vqAaMwu3fwRGX0hI6YRLfohb
         IzTtroAiOUSNqDGlBTmBiZCqkk3omHqN227TnyNAA0uB8z1m4f2C/NhZWI45EGn213PG
         Anx7xsuZIyKtmxVUVGVK4/Den72btZ4GK6WA5NNNvP8eFKd58nrxRm8GQF3AIy7jpWwv
         htLRPm5ii/cct5dY85Yov2Rm06qQ9lbyb5j1iKCGgd8wEmC0BqEEseBTJJV2wclZfUaE
         QQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049409; x=1688641409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLJjLTW16hmNcMoYy+dcT/Da1eHMITmiB6Cn5sB+zWg=;
        b=N0Cg8ugSzPzDApxy6S0hIpv4g4mHqn9S8yy/V/u+wNblOvqO9njVkHixkSt9P2Vphs
         LpNE090Z3SlXkAKOpDm46QLu9QMpOoaMXdeKMRXd0zBMVZDUVMOUDOgIv1vBEJHiFL8V
         0y0D9bk5MOG6EHCeUxDda7miOk+xVd07zwjd4dz/qLzxJIZeFbOYDOMYVCaT68b+n/o2
         5DeqcdC0/Yg0UQOwG7qQhMerihQmfDPojv7vqQ21UnWK8W44AWVaww9L/I9gXtS1EU8d
         fxc5WWK827Bxa1V9Fmu67sB9f9z+6dyV15T87ySwct4OxIcm36cVBQdPMb6YcOyPE3Ol
         426Q==
X-Gm-Message-State: AC+VfDyfUFEfjgwmLWmOsl25W71i5bKPyUOIhRUTvKJ7gi5HrUIUZ1se
        do3u3+ttiSJ/YkpV9gXVXRiqckUKrk90GA==
X-Google-Smtp-Source: ACHHUZ6c7IEq2q5ff+8tswCLLhUYEw7lV3GOL4mDUapyxzKh3584IcVcmBgmotv1Su7lavI2p3UevA==
X-Received: by 2002:a17:907:6088:b0:96a:411a:1cc4 with SMTP id ht8-20020a170907608800b0096a411a1cc4mr2108061ejc.66.1686049408991;
        Tue, 06 Jun 2023 04:03:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:7ce9:cf23:e2e1:1e2e])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709065fd000b00977db7d08cbsm2279665ejv.74.2023.06.06.04.03.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Jun 2023 04:03:28 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH] crypto: crct10dif_common Add SPDX-License-Identifier tag
Date:   Tue,  6 Jun 2023 13:03:22 +0200
Message-Id: <20230606110322.96290-1-franziska.naepelt@gmail.com>
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

Fix the following checkpatch warning:
- WARNING: Missing or malformed SPDX-License-Identifier tag

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 crypto/crct10dif_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/crct10dif_common.c b/crypto/crct10dif_common.c
index b2fab366f518..134553bf0d60 100644
--- a/crypto/crct10dif_common.c
+++ b/crypto/crct10dif_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Cryptographic API.
  *

base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
-- 
2.39.2 (Apple Git-143)

