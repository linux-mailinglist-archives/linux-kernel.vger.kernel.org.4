Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC847162E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjE3OA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjE3OAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1FF102
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685455199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4RT388VnQCYZW3nYzowL+p8Lhxi1vKrwW2Bk6UlbFw4=;
        b=Z7VTn20EPNBCk53OdY36uSxPUSvPssusziFlEkLwY90m488hKgu0orCzPcWqKvcz2nnzVc
        Cu2/z/8UaNpG85WZJR2LbuuBWqGJU1sM58CUAdJNIW6CXlOmtc9sRMlPZ6sb4TJVqzLDeR
        jjccIvsmqyFnKWt1AL2yVkknLMDiLRg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-5Yew0_XIM4yxJKnArzf8vQ-1; Tue, 30 May 2023 09:59:58 -0400
X-MC-Unique: 5Yew0_XIM4yxJKnArzf8vQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75b012668d3so608172485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685455198; x=1688047198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RT388VnQCYZW3nYzowL+p8Lhxi1vKrwW2Bk6UlbFw4=;
        b=OwfJBov7NiCEKAyfuoUAgiDIYqA8KKbJ8i64emZl0vvzvFprAx1lacaLKy09/W/gPx
         zEL1LYOBaGfO+i3mRwsuLEHgjaIh0h4PKdoNvEyn71laCb01j/J6zFHWqcz2+9jmvrrC
         TfT33dfv4/YHa/KdZYZEJwsaNMA8wz9VoHbsex6qFdhJer923rrsQ07x8d1E/IHPqm/A
         oFfqzkvAUaiUFrzpX/xaRTu/40SEyv3+/KTh/IZncf1uVP28bWpBujGfZWXZgnqxTg6b
         GB2R2OnTiWeLjxG5efroSlwNIs5DK4fRSVgfYVt3u5XHtWBd3I6WTbm8R6FZ09bAKmDi
         g4Kg==
X-Gm-Message-State: AC+VfDzUhCwV0cl8Cc1UyOdvkmCe1Zex9Bywz7PnK8WO/m2qaETB3P5J
        8y4j2S1OwkeEWBr0TwBXPv3IhaAXZ3vqm0U+H0TxqvoVmG5cOsoUvg0sj7Y91ooFg9a3r+Jfvf/
        MBFCBWjxYcv2ffD3klG7Z8/2J
X-Received: by 2002:a05:620a:1b96:b0:75b:23a1:456 with SMTP id dv22-20020a05620a1b9600b0075b23a10456mr2095114qkb.28.1685455197830;
        Tue, 30 May 2023 06:59:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4KhIBZdP1fPs6CXWxZOvyl5jXEFHI2OcLhwSX183uedbOKNfq0+qZi8wwa+CtWgI+VJcheRg==
X-Received: by 2002:a05:620a:1b96:b0:75b:23a1:456 with SMTP id dv22-20020a05620a1b9600b0075b23a10456mr2095096qkb.28.1685455197619;
        Tue, 30 May 2023 06:59:57 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a12ac00b0075cdad9648dsm2179295qki.25.2023.05.30.06.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:59:57 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nathan@kernel.org,
        ndesaulniers@google.com, goldstein.w.n@gmail.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] x86/csum: Move csum_tail result parameter to a local variable.
Date:   Tue, 30 May 2023 09:59:53 -0400
Message-Id: <20230530135953.3341174-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
arch/x86/lib/csum-partial_64.c:74:20: error: variable
  'result' is uninitialized when used here [-Werror,-Wuninitialized]
                return csum_tail(result, temp64, odd);
                                 ^~~~~~
This is a false positive, but there is never an intermediate value
of result to pass into csum_trail, so move the parameter result to
a local variable.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/lib/csum-partial_64.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index fe5861951b15..cea25ca8b8cf 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -21,8 +21,10 @@ static inline unsigned short from32to16(unsigned a)
 	return b;
 }
 
-static inline __wsum csum_tail(unsigned int result, u64 temp64, int odd)
+static inline __wsum csum_tail(u64 temp64, int odd)
 {
+	unsigned int result;
+
 	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
 	if (unlikely(odd)) {
 		result = from32to16(result);
@@ -45,7 +47,7 @@ static inline __wsum csum_tail(unsigned int result, u64 temp64, int odd)
 __wsum csum_partial(const void *buff, int len, __wsum sum)
 {
 	u64 temp64 = (__force u64)sum;
-	unsigned odd, result;
+	unsigned odd;
 
 	odd = 1 & (unsigned long) buff;
 	if (unlikely(odd)) {
@@ -71,7 +73,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    "adcq $0,%[res]"
 		    : [res] "+r"(temp64)
 		    : [src] "r"(buff), "m"(*(const char(*)[40])buff));
-		return csum_tail(result, temp64, odd);
+		return csum_tail(temp64, odd);
 	}
 	if (unlikely(len >= 64)) {
 		/*
@@ -141,7 +143,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    : [res] "+r"(temp64)
 		    : [trail] "r"(trail));
 	}
-	return csum_tail(result, temp64, odd);
+	return csum_tail(temp64, odd);
 }
 EXPORT_SYMBOL(csum_partial);
 
-- 
2.27.0

