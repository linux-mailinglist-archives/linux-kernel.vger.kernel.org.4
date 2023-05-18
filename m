Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68DC708547
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjERPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjERPrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:47:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F41FB
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso21395785e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684424825; x=1687016825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ve/cpik81IfQFwwxkwJiJ7Zs8fZIBEq6Wc7Ue2fBls=;
        b=lsI2DSrHa9zC8aT9c+6eXVcxX7o6d2X/z+wHVjoR66sJWgSYB8wQumEIgyVQUvJpck
         Y7xyVZAfewScZhSCGi3v259JkOJ63Z6Vb7Eonv2cXBfFsS7EFDNAnEToLYJDDJi0pOnR
         9o3qSzc4z9WMdD07UgGX3gbyXHjLfy+oiW52tFbZdJv9nhPksKo89tERGReqtkpJ6tkm
         ObNWsU6gmtY3euSvKGRLS2/pJU38eGVy1fHGi0NIOLOtZY4hA2/A5MiBCRVrya4SleGl
         4YiFcPPoX9pALrP77/LTs2eKo4favTnw9gKnvppkSEex2ayIwI9Y/7tBZUdPyAOvEg6/
         ZrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684424825; x=1687016825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ve/cpik81IfQFwwxkwJiJ7Zs8fZIBEq6Wc7Ue2fBls=;
        b=MdMDDhh4vD7d8B4R89qnx7KWgpkYCE9vnlBwUvEzb+8TxKETBgBMUOz8ybLsEbxpCY
         bNLW7/KToCxTL65nBcLN4NiK6hIS86M9dD2feyW5EKtp79p6kVIJpVBpt4PwzYR00ySK
         eJQbOQfnwXGdToec28Iu8ZQkPgHAOYly5/Mjt0DH6ZqF/r17AblZvngl6QcT2d96mUSE
         IO9Gho4N8JN3JMki7iuo6WAA3pKKgUpb7e+D8QENLXGbwWyEZpUm1wime0uNCaPClWY9
         qQfDpnG7DURXf2IKzoMOE6ACvpoEZ/Q8Zvtnvii//h0iWN8ux7G78nuctvu95z+r/day
         z4Pg==
X-Gm-Message-State: AC+VfDyDq0MXcrRBvjybjtGKE/S8Brl/aQIUJeMJo385XFioPi9AMKW1
        gwiay/4NfnX0J9Lh56zjt5wx60Zmwg==
X-Google-Smtp-Source: ACHHUZ5M/hXP+2MH76iOMvjgjFaRsDYIXxuENwPaFV0UX0lhNnY+4piAZeZiupRYAhFn2JpWV1vKsA==
X-Received: by 2002:a7b:c5cb:0:b0:3f4:2415:617c with SMTP id n11-20020a7bc5cb000000b003f42415617cmr1900235wmk.6.1684424824877;
        Thu, 18 May 2023 08:47:04 -0700 (PDT)
Received: from p183.Dlink ([46.53.250.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003f421979398sm5671769wmb.26.2023.05.18.08.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:47:04 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 4/8] auto: promote DIV64_U64_ROUND_UP macro to function
Date:   Thu, 18 May 2023 18:46:45 +0300
Message-Id: <20230518154648.581643-4-adobriyan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518154648.581643-1-adobriyan@gmail.com>
References: <20230518154648.581643-1-adobriyan@gmail.com>
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

so that people don't convert it to "auto".

Second argument is cast to u64:

	u64 _tmp = (d);

so it's safe to make it function argument of type u64.

First argument is used like this:

	(ll) + _tmp - 1

which is

	typeof(ll) + u64 - int

If u64 is "unsigned long long" then everything will be promoted to it,
so making promotion earlier in function argument is OK.

If u64 is "unsigned long" and typeof(ll) is ranked lower than
"unsigned long" then it will be promoted to "unsigned long",
then it is OK to promote to u64 earlier as function argument.

If u64 is "unsigned long" and typeof(ll) is "long long" or
"unsigned long long" then expression will be promoted to typeof(ll)
but then everything will be truncated to "u64" when passed to
div64_u64(). Thus having type wider that "u64" doesn't really matter.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 include/linux/math64.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 8b9191a2849e..7e0e2625dc35 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -298,8 +298,10 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
  *
  * Return: dividend / divisor rounded up
  */
-#define DIV64_U64_ROUND_UP(ll, d)	\
-	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
+static inline u64 DIV64_U64_ROUND_UP(u64 ll, u64 d)
+{
+	return div64_u64(ll + d - 1, d);
+}
 
 /**
  * DIV64_U64_ROUND_CLOSEST - unsigned 64bit divide with 64bit divisor rounded to nearest integer
-- 
2.40.1

