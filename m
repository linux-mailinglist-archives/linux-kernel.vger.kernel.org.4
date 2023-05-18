Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBE7708549
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjERPrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjERPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:47:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880A6135
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f4449fa085so14078425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684424827; x=1687016827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEZKMKV3a30xjKrkkWxSisXiqQtt0sbU7lcbWPA7pl4=;
        b=nleAiPCGTsiSqeXbC+uTlkoBeZpbHGS9vCgo5sq4Naz8KDLyD7RB40k9BHL9XLDQ9t
         9oyDpy+g2sd39bOGg4YljSFV59hiqTX0wNNqjhN0KWXGPvVn2Mc7ue7HGcEz0G1H0px+
         fKcS0ycFSf7rDjTvd7GUu+zpxODCjjiGd0i8negXwzcAxZHvGlgX92InvgpRYlVaQ3ls
         HBvk7pvcef/z2QNT/Ynfi1QU3oVK3wbaoZXbnrA0cs9QzDITQcDSB/uoIRB4r57l/YtC
         Fx1/wZMcRzwAgmpw7W7YVBPn83pJdb2OmeoMzjLChZMHmL33n85/XDNGbhSgyJC6y1HG
         73Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684424827; x=1687016827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEZKMKV3a30xjKrkkWxSisXiqQtt0sbU7lcbWPA7pl4=;
        b=X8BcUbsKgKZVqEJv6CN4FoWx50Tc7fLqmbtrElctrLnt5QjhKZijZjljidbiMInNyI
         +4v5H3aO/mk3wo4ypAPJ7Xjx4U1s7aenv35E8ZqS7mYEok98BMBCuM+QZtwXciVOzcW1
         qFdUhX+EzuD6GtRCY8//K6wdAtznwtOPGDnxOQISFjtyOcXArqzfHYsNk1V9k6fVIO3B
         KkmBtXeLHuHUTCmM1Sb23fHxb4DaNhy7Wy+GeIsXJ0TUGpFQXL5pxvfazqE/D3UwOaJb
         818IURfl7S5aNaIf5EDCA5aUNGidrQJ0YmCmDBGH6Td9HMOIfS6DWDT62kRzstO6a1oB
         dwBw==
X-Gm-Message-State: AC+VfDzxNelouCM7R7HIEODTPUHYPFEH3V4oxo2qy+ofRNYlDeIhu41G
        afZt7PBLSoj+CPYlJMeETsdnLOIIhg==
X-Google-Smtp-Source: ACHHUZ7GUP+yca5L+6C1h7qrEeCjJZctko8yoihfj0SZaxAhHNsojfHnQfANkhuKysOHHNYj9Zo21A==
X-Received: by 2002:a1c:f413:0:b0:3f4:298b:d925 with SMTP id z19-20020a1cf413000000b003f4298bd925mr1540626wma.41.1684424826922;
        Thu, 18 May 2023 08:47:06 -0700 (PDT)
Received: from p183.Dlink ([46.53.250.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003f421979398sm5671769wmb.26.2023.05.18.08.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:47:06 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 7/8] auto: promote DIV_S64_ROUND_CLOSEST macro to function
Date:   Thu, 18 May 2023 18:46:48 +0300
Message-Id: <20230518154648.581643-7-adobriyan@gmail.com>
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

so that people don't use "auto" in it.

Both arguments are cast to specific types so it's OK to move them
to function arguments:

	s64 __x = (dividend);
	s32 __d = (divisor);

Delete useless () while I'm at it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 include/linux/math64.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 3ab235c8a94c..7ecae251b0f4 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -335,21 +335,20 @@ static inline u64 DIV_U64_ROUND_CLOSEST(u64 dividend, u32 divisor)
 
 /**
  * DIV_S64_ROUND_CLOSEST - signed 64bit divide with 32bit divisor rounded to nearest integer
- * @dividend: signed 64bit dividend
- * @divisor: signed 32bit divisor
+ * @x: signed 64bit dividend
+ * @d: signed 32bit divisor
  *
  * Divide signed 64bit dividend by signed 32bit divisor
  * and round to closest integer.
  *
  * Return: dividend / divisor rounded to nearest integer
  */
-#define DIV_S64_ROUND_CLOSEST(dividend, divisor)(	\
-{							\
-	s64 __x = (dividend);				\
-	s32 __d = (divisor);				\
-	((__x > 0) == (__d > 0)) ?			\
-		div_s64((__x + (__d / 2)), __d) :	\
-		div_s64((__x - (__d / 2)), __d);	\
-}							\
-)
+static inline s64 DIV_S64_ROUND_CLOSEST(s64 x, s32 d)
+{
+	if ((x > 0) == (d > 0)) {
+		return div_s64(x + d / 2, d);
+	} else {
+		return div_s64(x - d / 2, d);
+	}
+}
 #endif /* _LINUX_MATH64_H */
-- 
2.40.1

