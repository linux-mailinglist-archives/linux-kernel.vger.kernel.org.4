Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBBA70734D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjEQUpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEQUpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:45:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1772B2D77
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:45:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ae3a5dfa42so10218115ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684356340; x=1686948340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDECabSrlFrISxM7rzu+fquYe681wwwMcqhoZr9uvCQ=;
        b=loXJM53z+mT9FjhlIlIAH3qAWpB+9SSZWL1UxRYK1N2oFnx9nBVQ6wtp87rMMM4zUU
         klGyPgo0kCBZXItxWFmAgeLwJjRZ7m5ijD++n4TG2vfzIKoE196B9DBP9VQG73anx14J
         ZG5zf/7qp0b98W0vR4fDK5oGmilKXXaC8zM9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684356340; x=1686948340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDECabSrlFrISxM7rzu+fquYe681wwwMcqhoZr9uvCQ=;
        b=jKZfqBKbPkXDcWlKfVxwO6UKbcJw1Q+zsp51xiApcJpBvY4wToYnO+xzVDxp3O73NK
         ftC2ZTUoQtcBAH9EG61ABxb/7HVWm7n6e6TPKOPot/19kFx2Bm+33+k6N8vmaHH7fYMp
         K4oL5tZZhW5tIrR0uUXOKp4CbUQVNsVK1B/ZZmNdK/kxEfVl6wKkc1hn/QSBX14MNVO6
         E77cQ2Yo+CIYfF6wDD4CXm5Cykg826e+a9l1xFdBDg4F/U1hrkkQ5KSweF6ulGYSjTEw
         GyNTA+lNKrG4wGupQ0+JrpC/jmFFrhK2Wpwq84eYLuL0kcqQG4LBFBagWYqPe2zEOn5Q
         Qxsg==
X-Gm-Message-State: AC+VfDzturlM/GXsjkQtX3vwbDP6B6/KvlxoB7ywK6Udc1rMbQ4btv2P
        t1ubvIVmxp+8rshNk4S+b/z+EA==
X-Google-Smtp-Source: ACHHUZ7umzAmc2jWBWxRqCVn5foFmDBvI8oVj5ZZk5xU9y3TjJ/wMcw9kPfQx2ZzKgAlTTsTdanQlg==
X-Received: by 2002:a17:902:f549:b0:1ae:5916:9f12 with SMTP id h9-20020a170902f54900b001ae59169f12mr158021plf.13.1684356340432;
        Wed, 17 May 2023 13:45:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902ec9200b001a1adbe215asm18025692plg.142.2023.05.17.13.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:45:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] checkpatch: Warn about 0-length and 1-element arrays
Date:   Wed, 17 May 2023 13:45:37 -0700
Message-Id: <20230517204530.never.151-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; h=from:subject:message-id; bh=wDO9y45sse31MEdYIydw4XH9ecDLDywEI1HGqDEAzbA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkZTzwka7oUmX4SrSDPpzLH4sMs1bbjbwsMLh7XkFM h5/6rrWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZGU88AAKCRCJcvTf3G3AJlgXD/ 4pLGAMOWzwS+SRPL9pn4fWTCBfkJaDNQzU78cJLlM7S8iRB4Ao5U8AZOqEbtawN9Nw7pQBmfk1V4k/ RCmBb+mX0fzmvlHuuh8+oLrlG9mO8tyzLKPXjJKVSPTjxDxhk93mdp4Tcep+iyLAcgPz4YUnNdh0hJ Kk/FfYTQQ51FYb/1MkMN0d+rHC13S4OnwsXraM+te0EP3lfUxzqdbxYIzULB4lHZpb2qZjpptY/XOg 2Q4Iwm5VfNWDukJhnoJJbaTJNhzQAY0Mcy0Bza2hwtk+VQkgMRQZKFWrfXpIS/i8pMyYlXyTp6Ysnz k7ji2c01QhNrC6ToNk1Sl6pZcwo64YozFnEmtM4Q8UpuuRZfvZlvE/nHo4Henp9jR5ob1O2SP2y+pl eWmY/G1Ko89W1o+yYeL2EnB+zYvr9sWvSR/KzDq79nUtKsWGJy/T8uPOzrKTLMPumDkPJN7ee3LSUu T9iQnkr/Nb4cl9DhXAE264muZC22Hunk/j37IdFwTqDkr03YNcQDSuXz4KouZbF5mN6UWV+/zZz8bX 7neSV1XMDo01vETxu7XnCLkAjKOHw3JzLgBipzbCoioFx/In8VabdQlfn0iOhTbPIGc5tqFLQwoTHI sD2CORtcVHmEqd3oTHbdviI2JhLsmtvOOhyxpAOvA9V+PBnR7HJYusaMr/xA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fake flexible arrays have been deprecated since last millennium. Proper
C99 flexible arrays must be used throughout the kernel so
CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
bounds checking.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I couldn't find a better way to figure out if a patch line is part of
a structure definition. I'm open to ideas! e.g. this would have
caught commit f5823fe6897c.
---
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a90e0ede53ad..415b3c14589b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7430,6 +7430,20 @@ sub process {
 			}
 		}
 
+# check for fake flexible array declarations (i.e. not in function scope)
+		if (!defined($context_function)) {
+			if ($line =~ /^\+\s*((struct|union|enum)\s+$Ident|$Type|})\s+$Ident\s*\[0\][^;]*;/) {
+				if (WARN("ZERO_LENGTH_ARRAY",
+				     "Use C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $herecurr) && $fix) {
+					$fixed[$fixlinenr] =~ s/\[0\]/[]/g;
+				}
+			}
+			if ($line =~ /^\+\s*((struct|union|enum)\s+$Ident|$Type|})\s+$Ident\s*\[1\][^;]*;/) {
+				WARN("ONE_ELEMENT_ARRAY",
+				     "Use C99 flexible arrays instead of one-element arrays - see https://github.com/KSPP/linux/issues/79\n" . $herecurr);
+			}
+		}
+
 # nested likely/unlikely calls
 		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
 			WARN("LIKELY_MISUSE",
-- 
2.34.1

