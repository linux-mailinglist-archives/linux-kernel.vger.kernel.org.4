Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA795B34B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIIJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIIJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:58:22 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157BF12897C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:58:21 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id w17-20020a056402269100b0043da2189b71so899812edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=kCUum3/Q0kMRGABgSdJa++Yx/m9FJ7EZUjHqNypROSw=;
        b=P3JahIbVpkXfXsADRpve4JTx7jId2xVWFPXYOH82WLKc5va0xx+X5STtLxX8OVqrfN
         EJm+A8hqB2/z3VQn+VtPImzXbrqr0jPAPwlq16X9VkLN96Mt3QJuxRia+lAzX8EAeQHh
         kFLoNt8MJhjeeCQRR4LOMNdAd2+RNY+Z9yAdxU5OKCAK2aURMwlCR2UfWhZ8tma0gpBb
         kdjcRR8QoM2RmC1s7QHHYJzU86JsjeJxR8RE8LBuK5FcctojzJi9lIEJNl3NG+3/mSC1
         MrtaPhT24WuhUEdDQQn3nLIvnDjtXVCn41ZN1LNLoKtdiq177+GOQpy7aCcQnfJaABb4
         XFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=kCUum3/Q0kMRGABgSdJa++Yx/m9FJ7EZUjHqNypROSw=;
        b=Qmm2HS1S+DFIlJdJ54Zt/dNky5msh2CWWLYnA1K5Cebe1obxOK90BP2Pm/2Vg5p93S
         36PpWPaDbIyqwZbvoycFCt5iw64+Sa8P5XVv9PoDtsNr0bDSgmCU06AGMEOrvIUpyC1y
         JtfoiMkyVN2MpiNKEmFuA4Nat6TasO2xhny/FMgbQygqXE80isBNosWVukDE+gDb8TVR
         PMVO3dVMZROknUJrAoP9EV/BYEJh4DaNUBTZyXZDQwKLPW4FsXkgR4vD48mseGyK7GQe
         O1hk6LMcBZzBUqwYLwYZWrjTH1Dx1fS/M5M6ft35rkBZdG7XsBCguFtAm4UlQ8TduXa5
         FMSg==
X-Gm-Message-State: ACgBeo1s+954/EYBB697LX0f8QO0hEYDxVqW9PtVkc+f5wgyq4Vt5ZYw
        fTA1949IoJuj9A7PTkLkM5OirhaQBLo=
X-Google-Smtp-Source: AA6agR5AZ7lsTIN+wX/bYUcoT5/o9+gSgZoAysLoufNMyGicwV2HoH62TmxnJD614NfbcWF+/PHAhUW2M+g=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:eaa4:a143:fbdd:a2d1])
 (user=glider job=sendgmr) by 2002:a05:6402:550c:b0:443:7d15:d57f with SMTP id
 fi12-20020a056402550c00b004437d15d57fmr10666201edb.147.1662717499654; Fri, 09
 Sep 2022 02:58:19 -0700 (PDT)
Date:   Fri,  9 Sep 2022 11:58:11 +0200
In-Reply-To: <20220909095811.2166073-1-glider@google.com>
Mime-Version: 1.0
References: <20220909095811.2166073-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220909095811.2166073-2-glider@google.com>
Subject: [PATCH -next 2/2] crypto: x86: kmsan: disable accelerated configs in
 KMSAN builds
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Robert Elliott <elliott@hpe.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN is unable to understand when initialized values come from assembly.
Disable accelerated configs in KMSAN builds to prevent false positive
reports.

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Robert Elliott <elliott@hpe.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org
---
 crypto/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 40423a14f86f5..4a2915bd40d1f 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1430,7 +1430,9 @@ endif
 if SPARC
 source "arch/sparc/crypto/Kconfig"
 endif
-if X86
+# KMSAN is unable to understand when initialized values come from assembly.
+# Disable accelerated configs to prevent false positive reports.
+if X86 && !KMSAN
 source "arch/x86/crypto/Kconfig"
 endif
 
-- 
2.37.2.789.g6183377224-goog

