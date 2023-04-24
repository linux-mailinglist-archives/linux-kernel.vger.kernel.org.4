Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4288C6ED36E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjDXRUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDXRUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:20:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB86196;
        Mon, 24 Apr 2023 10:20:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24781e23c27so4357472a91.0;
        Mon, 24 Apr 2023 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682356831; x=1684948831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bz4PPwCaKOw0TaRok5nu1KAg7hjKr3ZGu5Hk6jWlZ5U=;
        b=ivIyFPrOSWQu1Q30hx8qM2Ryi8ZSyvMGSoP2WJ9ULnKKubdgVQOBOQ/aBXWwypZnYL
         trkP9n5E9WcgXyL25jJXKI+ED0O/HEJ8sCaF530uDwNQb3EH8PXzemD+PNAyFy5rWA9r
         +64dWSL9JUrTqFb0OJwfeULwgLz04q1neKzi/enDMfkNMvTFuFjVrxKAvqCo2ObHSg6j
         cfkqV+w/moZJiP9J32Q6w3T7QOjN1LwPl6rm0IHjSo9uZwrM99qblFOc+/UPvKmuqkpj
         9kVwwPmf+/Tss1VG4mptiA238DewxED5svaxQSoWlzxlXTIqrRu0mgEBDU8njuZNSJyK
         /fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682356831; x=1684948831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bz4PPwCaKOw0TaRok5nu1KAg7hjKr3ZGu5Hk6jWlZ5U=;
        b=N5vNUqjKnbs60ubl6DpJx1r2BwmcSeCuixeuXaWdL1qq6HtYx3+SF11LsgrmIJWuVs
         Dy6zFI3dfccxzFIca2e7FxtzuGBRJ1eoLyZUV+ulezqXkzT5wPzzmqhcHTpNKR4IMIk0
         57QzUqKvCC6T5CGwUbgc+XhuDT2PVeumTQDEFx/KYAjgM+mtlvVFIrAUhLVm8iUNkuID
         ilBUPULNuXWrxHlZO2qGNm/DKM3qshHArYgvtkXCVzvvFithR94WQVsJZBY3Wx4e37WT
         OlBnWbyH34Pjf5Vw1o7kvMBAwLqnz/Py0sE2xYYp2iDCIYJsIj6dUqFF4VhyrP+5DfFu
         dQ4g==
X-Gm-Message-State: AAQBX9dHsPuSQTjQHAD5CON1Zi3/0V+5KbySIqYOgnor4CmE9544iTEn
        QadPfFZOuocOIEyfXtrhezr9U5GaOzgBsOB9
X-Google-Smtp-Source: AKy350bQ6dnJrRGMpphf90z2NAgv+5SCDicWmPUv54KlvPgZ+A9vBkaaJSuhtUAebVx5uiPXNxcWqQ==
X-Received: by 2002:a17:90b:1bc8:b0:249:897b:fac with SMTP id oa8-20020a17090b1bc800b00249897b0facmr14080342pjb.39.1682356830727;
        Mon, 24 Apr 2023 10:20:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902a5c500b001a4fecf79e4sm6829605plq.49.2023.04.24.10.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 10:20:30 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] crypto: engine - Fix struct crypto_engine_op doc
Date:   Tue, 25 Apr 2023 01:20:21 +0800
Message-Id: <20230424172021.2893856-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

Remove redundant underscore and fix some grammar in prepare_request doc.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2: fix description too
v3: remove inappropriate commit tags
 include/crypto/engine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/engine.h b/include/crypto/engine.h
index ae133e98d813..2038764b30c2 100644
--- a/include/crypto/engine.h
+++ b/include/crypto/engine.h
@@ -78,7 +78,7 @@ struct crypto_engine {
 
 /*
  * struct crypto_engine_op - crypto hardware engine operations
- * @prepare__request: do some prepare if need before handle the current request
+ * @prepare_request: do some preparation if needed before handling the current request
  * @unprepare_request: undo any work done by prepare_request()
  * @do_one_request: do encryption for current request
  */
-- 
2.39.2

