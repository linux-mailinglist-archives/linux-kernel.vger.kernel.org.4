Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00987712BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbjEZRji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbjEZRjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:39:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE8F7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:39:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d41d8bc63so1026369b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685122771; x=1687714771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o79nhnQo+hUrTMqjZpIy7ZO+PnsNxJCksQpWFLMmxlk=;
        b=jvEkYRgx1BemY1NhbiBFhJgiLZxEXFMJfyXV8WlpeT6oPj3WJwTWCF/hQv6mowS5f8
         /OhZLFHz53IIkZT7NtWqC1WB1UsxInh+8vPOTKPTUh9/GLiCH8fzcglyMpOq0JwpfLEf
         eOjE67kLvHoz4UzaD+7UQlCbvtX95/wBTeKiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685122771; x=1687714771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o79nhnQo+hUrTMqjZpIy7ZO+PnsNxJCksQpWFLMmxlk=;
        b=eUe2UZf6kPLeSr8ZUULvJzzUNq5HwL/90CLhIWaKWNmrKLWo13fh5C6wwLdS4wqK7a
         vt7YB6VwxglmeE7Hj6LCvDXANfyYIH6IWpxpkaxcXHLBKIP6ch4QuAisr2azenOgwgAu
         RQDLwnt9K5IO/0wvoVv+x2onDfWHqLGy4gZA0rkr6vqFyghE9FUf3kRAsvllPNfqQigy
         Cxj8Q/H55rbatouZp8rfTIOBUBxCrZ8Um0KQNRnIblMpRzShl6Bczq87NRhsf8mYy+m1
         B4WOGFd86ziFJoQmGwnIEiEepsJcDBXrwrDBMLV9SQMzc4YDJ7eSF+ga/zeS4Iycx/3B
         isAw==
X-Gm-Message-State: AC+VfDx8r2s6Yez87xYhsSPaPOEkyqX52iIF3mgFC9+bGj0y1HfV0msV
        4PHoSnjiT9K3EunHbZlOQkzxjg==
X-Google-Smtp-Source: ACHHUZ7GjPwpiPwuZJ6kmEyqvFkfWPF7XGQ8VcoTDa/e+6n2SbgelgyQ4QUY98++vnykyWW1+YwvKQ==
X-Received: by 2002:a05:6a20:258e:b0:10b:acb4:6249 with SMTP id k14-20020a056a20258e00b0010bacb46249mr160332pzd.8.1685122771609;
        Fri, 26 May 2023 10:39:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h34-20020a632122000000b004ff6b744248sm2998600pgh.48.2023.05.26.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:39:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] checkpatch: Warn about 0-length and 1-element arrays
Date:   Fri, 26 May 2023 10:39:25 -0700
Message-Id: <20230526173921.gonna.349-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; h=from:subject:message-id; bh=xoKLuCFIv9y+FYOg2UR/amJ+LviFKArIMjSHFHtcaJ8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkcO7NUpebbU/fx3h47+3DnzldZWsr5ugjv+XvFebK ZZocCXKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZHDuzQAKCRCJcvTf3G3AJtyaD/ wOFVwpPR+IQvmaBiyddDAF4ZSyms+o7Wo+0nUac6wLqS9dD3e4WWti9VDUMQuxdfan66/uAKtjPrYI aDmpgHAksb2vUlwTmkOQyHOcMuxpSkT2UF35UQCqDjbg6ePSujhGRiBlPKRejTT2iee384Ms9zouiQ zoo6xVeWQUluTQh2dj/FSk0+IDQgzjWiuXWrHNIKt3ryvseu6ziqbDETLWWw7zqESroekLIBIazEIN qTcRNrn2S916RB8Z93canqqkRvuq8ctZ7CCMJCWF7mwyfkeca8AeCBAN8hQIrIAckMwhuiIkR+YuF0 n+dMmyZjEYf/O9hKjKUMiEPJ6wGD1v5wW9UlbUszCFAs0mjsKCJITQHs/js3Jsp7XYZm0PwNgClK04 dzUcoAncJ+7DiAw50HwuiqiqV7CJfUye6aQ7fO5ax58huxiatzCCQjrsbqL7HHucAp3ED4N8XKJKYY eoOavdMBlezThS9UsDbCVMy9dyV+qbzv+tnzPE6PZxRFU+fFkK8IDELh/HDLjFj3lNQUw0VqaHCyfS uYOqZR+ssXGutesObByb+Cc2I7FtLDG1yK6LrRRsOcM38gFY3lLTYPeycvudhDfEj62NxWmTDmtW6G lhYnyC/7+2t3BmGvHXXZrv6fTc/17HX18+K3QBkSaLFHxR5YR6PzGRgjfb2g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Fixed-by: Joe Perches <joe@perches.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230517204530.never.151-kees@kernel.org
---
v2: find using "end of struct" marking instead of $context_function (joe)
v1: https://lore.kernel.org/all/20230517204530.never.151-kees@kernel.org/
---
 scripts/checkpatch.pl | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 30b0b4fdb3bf..cfa19bfc857c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7430,6 +7430,21 @@ sub process {
 			}
 		}
 
+# check for array definition/declarations that should use flexible arrays instead
+		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
+		    $prevline =~ /^\+\s*(?:(?:struct|union|enum)\s+$Ident|\}|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
+			if ($1 == '0') {
+				if (WARN("ZERO_LENGTH_ARRAY",
+					 "Use C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $hereprev) &&
+				    $fix) {
+					$fixed[$fixlinenr - 1] =~ s/\[0\]/[]/g;
+				}
+			} else {
+				WARN("ONE_ELEMENT_ARRAY",
+				     "Use C99 flexible arrays instead of one-element arrays - see https://github.com/KSPP/linux/issues/79\n" . $hereprev);
+			}
+		}
+
 # nested likely/unlikely calls
 		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
 			WARN("LIKELY_MISUSE",
-- 
2.34.1

