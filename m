Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669E760BE11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiJXXBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiJXXA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:00:29 -0400
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10844816A0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:22:40 -0700 (PDT)
Received: by mail-lf1-x149.google.com with SMTP id w2-20020ac24422000000b004a299d12364so3126639lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1brEJBipb7gPKmBCB4iwvDw2G6SbkIMFGPFK60cCqY=;
        b=QrB2Fv9LJDXRdkYo1W6sAUZYFUSBeG66/qzzdNhF4QszBRYGVKofytU+Xl1qy6Rz4I
         I8Yiy0O6Aibk99xbAG3sK5grh6C8aHbcfosiscsjIQNfEklGhC3c96zp/HDNoYLx9+KJ
         hPMWl1sJhW2LUnPXauuud99OpqjZJBiwQMEQL9D2FwX4DgKLGzq9iGY0t0D9opbdb5+D
         zWvcc8t93kpL3shnq/n4C9Q8SmbywVo6gn4tT2ZCdtPTJK9UyQd08jpWSQ/e2t74qO1G
         KyFnztlBqXN3ZwWi/fNbkJaHHAQkZtBZZXoMgXzgEHtGas2KrLoVoiZza/P/b5smYnEl
         soPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1brEJBipb7gPKmBCB4iwvDw2G6SbkIMFGPFK60cCqY=;
        b=Q8dnk/Dr3lcSA//1dHuzLN04YPUl54QRQUQCvogQBVjVYzzRd+YulIPIGN+Rb+voTB
         z5e/H5sieX8dU/jmRDU9o3YsThKaRVo0id8bZUzygkyrporLCIFGdFXZAqHD5E7xE/0c
         uT2AjZmef7WGqs5MW+4Lu5qwZGn17Itb+bkLPtRzUm4+R4XxytW6Hr4DHkhh0Q+bJ8SF
         1meie1tttHM9Sn3ewwkfgwtFT3TwKCbHwJgAo7HSljeMMon8vEUlZ+Cz4EmLaBHoymmO
         99C9P/cAHynreOS1ph9jS1xdduXIYegpSShaudNAxIgtDEiOpiBsWnUPFWTqsdfGwmqY
         8Utg==
X-Gm-Message-State: ACrzQf1QbN+OMVL/s6RQfXZwKEvCKE5Ru81FKisYWooE+BiQlI6VGn2D
        Q/N9CE4A3eK2813HajFwL20Z5ymPLQ8=
X-Google-Smtp-Source: AMsMyM71innvLamIkBMpwiwhUw/yYthw7zM8NGpJq9LhH+G7pZpYkhGY54RKQfT1VYVKSQ9sih3hlGce8Og=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:8695:7c88:66ed:f9d1])
 (user=glider job=sendgmr) by 2002:a05:6512:3c8b:b0:4a2:6e64:7049 with SMTP id
 h11-20020a0565123c8b00b004a26e647049mr13241229lfv.196.1666646517702; Mon, 24
 Oct 2022 14:21:57 -0700 (PDT)
Date:   Mon, 24 Oct 2022 23:21:41 +0200
In-Reply-To: <20221024212144.2852069-1-glider@google.com>
Mime-Version: 1.0
References: <20221024212144.2852069-1-glider@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221024212144.2852069-2-glider@google.com>
Subject: [PATCH 2/5] x86/purgatory: disable KMSAN instrumentation
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stand-alone purgatory.ro does not contain the KMSAN runtime,
therefore it can't be built with KMSAN compiler instrumentation.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
Link: https://github.com/google/kmsan/issues/89
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 58a200dc762d6..17f09dc263811 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -26,6 +26,7 @@ GCOV_PROFILE	:= n
 KASAN_SANITIZE	:= n
 UBSAN_SANITIZE	:= n
 KCSAN_SANITIZE	:= n
+KMSAN_SANITIZE	:= n
 KCOV_INSTRUMENT := n
 
 # These are adjustments to the compiler flags used for objects that
-- 
2.38.0.135.g90850a2211-goog

