Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5626170A08C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjESUZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESUZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:25:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED6102
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:24:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-309553c5417so1084929f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684527897; x=1687119897;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ip/4xPkpTBx2G+b4cQROiLf32EA1DGXtHtMtqI6ZZUw=;
        b=I7tW7DWG9caQ2bkDJa4MGSBCByIHkfGdAK5ObUMKKabXj/fS35qCfH6ORRJnVBmzva
         YkNd4AvHU89gJrNrFidCzOoazyKAkpQjApuxVFrLSKxAaKGzKWOoUCHj+HEG85yQ754r
         yvxFr/0ybbn5RfAmckC821wziERgFwBPUqJGb6giZqxeZXS36JFJryLLeubzXZPmCKUL
         96+3dwStSghu1qBqgfz+cOvy53K38evxsNd16gSd1gOy+F290PvDoaBIX0F7QNGM0ktH
         x6I+q44pCF617/azZlvrOoCvbJAinHGkta0aao73EH4l33eytahjnR3ZnZne9UpZC7/Y
         mmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684527897; x=1687119897;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip/4xPkpTBx2G+b4cQROiLf32EA1DGXtHtMtqI6ZZUw=;
        b=X2gBYrTNog1OtVJ4Rpt527A91+NNTBO9auDEghrqmNJpn3p+6TpZwstLZ2HCE5fqob
         us1j5SgY7rlItegd8pmWGPYfElSbJVYtF+Am7Z5YHzV8H6A60kKMRZDm7lazqYY0mK7u
         Zv9zKHEtXBTQ8KpYVAbxIoJVMooOX0pFaiTrQncR/YZFL/q+cYpBu1TYPgzvQU979SpT
         wqH1JWWXGKQOYO4KQx+hvD/PAeuBwVYHG1I3lnGJJnvY9AAZPKFXYOSV6uJnqK+dZYze
         8jHDbiIxWieQC4oCI0d0DaokpVtJQbp6VCRixxmDK0/oZRLVcHB5BKqh3qzqipWoCSUR
         RJxg==
X-Gm-Message-State: AC+VfDzskNvDcsxbqAmn/HS0j6dYkyHv+1Dx0HKXjHUROzrJHU9LWNJH
        gMzsbZ4PKKZ+ydoY31iq2EWfyRCezA==
X-Google-Smtp-Source: ACHHUZ6My60WkN1pF7k26ll5wlz3+CWf/QzKDXkbtj8L1DbwAOXH9pK2ZFY6fG0An+qKOfqFNa1sWw==
X-Received: by 2002:a5d:4d51:0:b0:2f3:e981:f183 with SMTP id a17-20020a5d4d51000000b002f3e981f183mr2600518wru.10.1684527897243;
        Fri, 19 May 2023 13:24:57 -0700 (PDT)
Received: from p183 ([46.53.249.116])
        by smtp.gmail.com with ESMTPSA id l2-20020adfe582000000b0030632833e74sm6314248wrm.11.2023.05.19.13.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:24:56 -0700 (PDT)
Date:   Fri, 19 May 2023 23:24:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] fix mult_frac() multiple argument evaluation bug
Message-ID: <f522ad25-f899-4526-abc4-da35868b6a8b@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
+	typeof(x) q = x_ / d_;	\
+	typeof(x) r = x_ % d_;	\
+	q * n_ + r * n_ / d_;	\
+})
 
 #define sector_div(a, b) do_div(a, b)
 
