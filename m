Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8667C6027DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJRJDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiJRJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:03:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E81A927F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:03:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so16714524pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PCPU7pjQsz2sISTfhiNbNnCu1P7dpEEV5lOobjZTacw=;
        b=gZGBjepH5r2X+kIH//9LW2XXDTFAYAsaVgXEYEJK60U8oTCCVoxBMnaYlbtC9+tU6J
         XkHOloaO+NzRJd6URyy702ekQTbvE4YcYM/hIXgfgmb5Wa5L6BKj8ftW/974Z5oeZxtB
         bYeSUZGddQ2ZQcyNnHg59O6hqF7mUHWYr4c5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCPU7pjQsz2sISTfhiNbNnCu1P7dpEEV5lOobjZTacw=;
        b=FeiwPmXJiL/vnBue0uLEgxeYJwNZwh8QK1mtrX+AeDr8mlWmQuds0IAa9L85qQgGA5
         19K7F2xKGoFgQZ0VXbPA833A3bsz/4rBOjxT1bp1uM8hbQTvLW6umkFsVuFIHAb0GwHR
         fCYZ1MUFGDaVVmVHjNdH+sMD0BroYaGFaXx0agkIW3nwWOWrJH6MEYq7DIebGONXxka3
         XHC/xXYyC9/liLsAeFBCnDVh6VhjiPoyzzJ2HlL6TmNnr5f+zvZadKqr7iDnF4sWMgVV
         v+yHJdRpAgeyPFugfFe42HaA2LfFHsvoe9GyqMmTCB/jDk7YjtLZpq66txwN8ud8KJ7G
         Vafw==
X-Gm-Message-State: ACrzQf1q+IyCv08uaaTimrDfW1azAtdq2jbKzTPMeMAYq3urd5Ub0p0p
        3TNUZDFzBekJ72LZmpsx/HuEbOmmJZ0QrA==
X-Google-Smtp-Source: AMsMyM5Tl9lIxuUj+N7gpJfouylM1Fk3M8j58mbVynyHz69C5+DaYz5jhwd5MS8ldzPFdZ+TWZRM3g==
X-Received: by 2002:a17:903:22c1:b0:184:983f:11b2 with SMTP id y1-20020a17090322c100b00184983f11b2mr2253510plg.40.1666083811925;
        Tue, 18 Oct 2022 02:03:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 185-20020a6206c2000000b00562677968aesm8643891pfg.72.2022.10.18.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:03:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] mempool: Use kmalloc_size_roundup() to match ksize() usage
Date:   Tue, 18 Oct 2022 02:03:29 -0700
Message-Id: <20221018090323.never.897-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; h=from:subject:message-id; bh=1Gas3SCsMDWgBChil0VwFgY9Fr6zuZgi/zbZ+v/amZU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTmvhvbPT002El9aaoLE6dlJ1BcKpLWc+O7EYysMd Ev7i92uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05r4QAKCRCJcvTf3G3AJogxD/ 9d7YYM6vgBMsPh9pT1fJNW7vfocSmAMT8F3ueYojz9WVnJcdTz4G6UTlzKEPMXnTFQ+Ikut04037AM NUphveN6gJG094sCiDV2QDpK0kSqR6i7v6d6JeEajHqk5ivmQuvl9Xxk5BIJiPOmxHyNojFSxrbbKN e+iRyuL5xpsUHfuXFiVK0dMJ/+9l3C80nyNzHE/HuonrrNoDkxZgc2J+fAq0Ash3kPcaXvhVvIXUju nP4346E5t2mcJcm6cR52lLSW/eTUcB6UiGgAIcsnXGFXO9NSn8gUnQFuQhQ1mrSrxWLvco/+1mp3cU V+KrcVbRpWH2rtSgi8OU6xC1Api7QyYLEyq6a9VTlimKmoIlM75cXkj4tARmB4UueSbM/ARefUaCG1 6PWRHihJ/gxr8+HP+Q1FlPGSHxjZxnDsDP2uXwL0tpQnXxsR4aASftsIDiqAgek3isv+EW/3JwfxNa B3hLlwkMxfNlFx78NJJUJgdWYarJnoEAwlhdTBKZhIR1A5sNolKb4rYi15jpco36fD0UwkE4PRujGx gdztNv0oTxBVRojBwTlF5bdFd21CMoDhzP46Yr84bu9hTWmmu7QADa563bPM4L8LcFHkBdsoeGOoO8 0YrAD3OFWESSnxBCgesvoy18zdneTz5LKHqQN/Tu7YHczc0sxrLOnwSVXuWw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Round up allocations with kmalloc_size_roundup() so that mempool's use
of ksize() is always accurate and no special handling of the memory is
needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/mempool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 96488b13a1ef..0f3107b28e6b 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -526,7 +526,7 @@ EXPORT_SYMBOL(mempool_free_slab);
  */
 void *mempool_kmalloc(gfp_t gfp_mask, void *pool_data)
 {
-	size_t size = (size_t)pool_data;
+	size_t size = kmalloc_size_roundup((size_t)pool_data);
 	return kmalloc(size, gfp_mask);
 }
 EXPORT_SYMBOL(mempool_kmalloc);
-- 
2.34.1

