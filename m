Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB57172BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjEaAtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjEaAth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:49:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AF1A0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:49:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso3894692b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685494176; x=1688086176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BPd2wyhAkJ3YpAxbQZ8ec8dh+1Dyphp7NWb1XFVf7wI=;
        b=WTADF+8ozE5wQEi8qcNO0PrWAPOAPAuNFYF0z/kGb3DV6REuux6tsP26CjIqmR6TTo
         QElBuAOLQD2AxZa/enpBVgup4LGMFXEe4RN3JUSxG/7YPADZ3ZvYemVWq6A1QduR5mJW
         wKi+00F/Dnzxv0tmwGb4JV3luyBNbU5TneTpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685494176; x=1688086176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPd2wyhAkJ3YpAxbQZ8ec8dh+1Dyphp7NWb1XFVf7wI=;
        b=TWkCdw8isecmZuSL6REv0dSmA1dww2r6iRpCj+wiCqK3PdmpqQfQvD95DiBEQ3xyMb
         T6pLlKYBECP8witvFqD7lGTFiVmmrtxO4TnhAEtVb5zF9R2AOA08mAGRAGmC1rR7B4fr
         PHRC3iPomHPlSY4XY518c7duh5regF8C+nnLPax0hkW1It6Y1icG468hQ3XfW2jfg/7i
         d7qaK8+GQqZExrVsZFBXaliqzybxYtVBxR6XlAPOIH8fzy7W3q/lD2N/b2wU7im1l9zy
         21I2ZkvV9wXJTqeM/qvYCxiAsrZsjIBtq+edtiFT6g2liIO3y9xynD5RE0QznzERWVCX
         gmAQ==
X-Gm-Message-State: AC+VfDzlMYWmHvOfnGgqb893qvAwkXDA24OuPB8+8DPSLDGxtyYrLMn0
        aboTHXqpl8XMh5lo3JadDMKFiw0Q0IZglhPkRkA=
X-Google-Smtp-Source: ACHHUZ49GdfBCckWeF+aIJZlU6nfDm5RqPdtw15ZUoPOaiLu9XfgLdDKJvGH0ie0FlxYU9qSUpn+sQ==
X-Received: by 2002:a05:6a20:6a25:b0:106:4197:b7ff with SMTP id p37-20020a056a206a2500b001064197b7ffmr4699373pzk.30.1685494175985;
        Tue, 30 May 2023 17:49:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z5-20020aa791c5000000b0064fabbc047dsm2225131pfa.55.2023.05.30.17.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:49:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4] checkpatch: Check for 0-length and 1-element arrays
Date:   Tue, 30 May 2023 17:49:32 -0700
Message-Id: <20230531004929.you.436-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; h=from:subject:message-id; bh=GEL21VHX48Hc+3Yj+QiYsS2aI6hXB6UbODJ0k2u5hZU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkdpmcAHbDJqm8gmIbZ6eiJbOuoOVyek8OiALo7epp v8CgkPiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZHaZnAAKCRCJcvTf3G3AJsz/D/ 9UfeZNwPnNevZIHxAWOgNFu4kL49PAOf+nK0hZ2LpSWUM2mQQwbPwRGVz8PnWRRuzoN1lnwg7Zvhli DA+iwi8jdhznEBiOk5MWeQsWDuUOCKrBRfsy5JMbAx/8+7m6nGF6GosRv2974fVJ37rDSiWB/vSFm7 YwIaRUjSqXWMiGHovT0yrFbZlSwvvWIGYHtrdw1yQQ8s7Fisp1q7qKJm/LTAuZs8KMO1NLqhvZkNck o3pgcN/94V6g5p13xW99fABw44AlXSZ/mJD+gyQuxzdqO6QNZxT9t2vLLBSOP32IPWdRl+fWxWuycG aW4d5tGX3wGCQIsKcF5pRTq2vakex5WyTZx7/4XwKcNiWB7dGwR3nQ/TbyAMV7+nGcOLYSADMYY3Ti lU899gVrqYiRCki4W/HEzs2magklp8/hzFIEjlycXo0gL5p4Js0kZPAXUvfg9dKZwAWcu6+kxpi5eM 3hQkrl2I3+kzFv8lKvpESHebqYVRULZNUCRfa/VQ2rUeWhcAuj/gtprlSrCZHToWIfNxI8AGWz6ulV L1vNk8tSBFa+ES3UmTtpvu2kuZKjvbO8GmJG+jg8/slxuM3YZzAyML6QTb9zRHgrL6X1hrJeIPOxoZ v9O9MUvSq1pwmkXL3GaczkgNd+D5rEM9TENWvwU5HTF7QG6troisOg3bDf/Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Link: https://lore.kernel.org/r/20230517204530.never.151-kees@kernel.org
---
v4:
 - combine errors (joe)
 - switch to kerndoc url (joe)
 - add __packed for struct matching (joe)
v3: https://lore.kernel.org/r/20230527020929.give.261-kees@kernel.org
v2: https://lore.kernel.org/lkml/20230526173921.gonna.349-kees@kernel.org
v1: https://lore.kernel.org/lkml/20230517204530.never.151-kees@kernel.org
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 30b0b4fdb3bf..64d21b6aa6df 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7430,6 +7430,16 @@ sub process {
 			}
 		}
 
+# check for array definition/declarations that should use flexible arrays instead
+		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
+		    $prevline =~ /^\+\s*(?:\}(?:\s*__packed\s*)?|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
+			if (ERROR("FLEXIBLE_ARRAY",
+				  "Use C99 flexible arrays - see https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays\n" . $hereprev) &&
+			    $1 == '0' && $fix) {
+				$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
+			}
+		}
+
 # nested likely/unlikely calls
 		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
 			WARN("LIKELY_MISUSE",
-- 
2.34.1

