Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA270AA5D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjETS2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjETS1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:27:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807161BE1
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:26:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f42769a0c1so44811055e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684607121; x=1687199121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GBfAShbL2IFJ1lSCZxPc0Karf4RuFXcjGgcsz2VTYqI=;
        b=eoW6hNH8Hog/G7dZuz4VVN4Xzi9iExHiFG7RVEeDXHwQvdZtvj0r+chEb/6bgUbhaU
         0jMgaX17rfZ7FhIZerDUY8UgVnKETfjoWAbw9+04QvFrtOP9ezYeRd93lBsfS0VXeosC
         Rf+MNqwoSWbK6FjUffCZYevrsme3ACluQeY4OMske15vBECHVKOgnTxFVw9GlxZCv1yp
         5PgmsZf5+kXFVLSIlWS5uZ2fE9iyIDh5NaRs8to/hmpBeXMPU3pV/eHTfeDj+Wo7iJ0I
         NSTGDbd5liPQC1q6iMOZc5aAVArL9Yz6jVSaLefRytunh6w6a8rzx+PIufKvEM045m8W
         iMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684607121; x=1687199121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBfAShbL2IFJ1lSCZxPc0Karf4RuFXcjGgcsz2VTYqI=;
        b=AZw0vsTqmiw+xAaOpoZIAjjrbcHKKxGaugFAaoG06eLub8mbh0C3bUZZC9SKwIYe+g
         T1yT6FhaR+dEJjdgqz+bV7GT8nb57GBI9uA35ZS3+4uaS99c6H+YbL2w7bVf2G+uGFpf
         AsOox5onymPMV1biWAO37jq7i4zYpBWm3JNunK04+wkhPPwbkKk5colhlQbAOGMHrcDT
         TnWDzwI7N+DdosahHxBBez5oCVWcUAqn1GEiywENGeM5z2E2NRU+Ao5KH4GhHTNYj40C
         mvHdrDTgJMyvoJWm3wdGTEw3pAneIqvSw7LzylyGu74FEZusfNtTbR0mR11U4r1SoJsn
         KJKg==
X-Gm-Message-State: AC+VfDwJzP2X+x7Qq2/Min9ykLVC5X7ZJu7ONtvfSScY2HLBqoSFSMLj
        QZmNZEzTCq1dPyY7U98QdDTW9/7nkQ==
X-Google-Smtp-Source: ACHHUZ4u3LT2iINGZEWbqgw88KTI3RuqWORHfxsR71f5E1vzz1uF2eo+O+SeeE1ps9F4ouef35c6mQ==
X-Received: by 2002:adf:ee49:0:b0:306:3b78:fe33 with SMTP id w9-20020adfee49000000b003063b78fe33mr4620791wro.32.1684607121387;
        Sat, 20 May 2023 11:25:21 -0700 (PDT)
Received: from p183 ([46.53.251.140])
        by smtp.gmail.com with ESMTPSA id n1-20020adfe781000000b002c54c9bd71fsm2575661wrm.93.2023.05.20.11.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 11:25:21 -0700 (PDT)
Date:   Sat, 20 May 2023 21:25:19 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] fix mult_frac() multiple argument evaluation bug
Message-ID: <f9f9fdbb-ec8e-4f5e-a998-2a58627a1a43@p183>
References: <f522ad25-f899-4526-abc4-da35868b6a8b@p183>
 <20230519153622.f95f74819ecf467c5291de7d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230519153622.f95f74819ecf467c5291de7d@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mult_frac() evaluates _all_ arguments multiple times in the body.

Clarify comment while I'm at it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/math.h |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -118,17 +118,17 @@ __STRUCT_FRACT(s32)
 __STRUCT_FRACT(u32)
 #undef __STRUCT_FRACT
 
-/*
- * Multiplies an integer by a fraction, while avoiding unnecessary
- * overflow or loss of precision.
- */
-#define mult_frac(x, numer, denom)(			\
-{							\
-	typeof(x) quot = (x) / (denom);			\
-	typeof(x) rem  = (x) % (denom);			\
-	(quot * (numer)) + ((rem * (numer)) / (denom));	\
-}							\
-)
+/* Calculate "x * n / d" without unnecessary overflow or loss of precision. */
+#define mult_frac(x, n, d)	\
+({				\
+	typeof(x) x_ = (x);	\
+	typeof(n) n_ = (n);	\
+	typeof(d) d_ = (d);	\
+				\
+	typeof(x_) q = x_ / d_;	\
+	typeof(x_) r = x_ % d_;	\
+	q * n_ + r * n_ / d_;	\
+})
 
 #define sector_div(a, b) do_div(a, b)
 
