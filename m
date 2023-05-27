Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627D07131D8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 04:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjE0CJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 22:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjE0CJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 22:09:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30A7134
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:09:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d2467d640so1860139b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685153376; x=1687745376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c++cIpJx1f5qzSfXzzcmil49fI/6fMOTY+nB6uBIMCc=;
        b=N8VoHGMl6BimJpRAvc5OIu4wxUqZEPrio+S4hfMVyQ6AE5UzLj9woYk9IvO0XhPay4
         gE7pV+7KmaDxpei2rn4C4sUJ8bwcZZz2KEYsXnPcnz4O3LX35qZ0Xx6msDm6iL5NXsmH
         hiaLPnRxO3z0pAPKEDV4TI10hALPue1P46wVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685153376; x=1687745376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c++cIpJx1f5qzSfXzzcmil49fI/6fMOTY+nB6uBIMCc=;
        b=FUQrA4X11ipG3ofdovnjyZY0ZNlfTMKDtmsd+uSBvDYWaFW0MxovlxLg9m+wZF3pIk
         wJBjUWgIzoTDnm2THgbtJ0+OmjcM/mtq0F0uj99b86s5UsjN6gqmuPU+iCxolwez4I4D
         /GPNZYUmUmLpL5LYdUaCZENpwixYhP3Rb38qUVd27qFd8ymqKwuD2ET/POATM5TdCeCN
         A7l8ku7Xrg+LycC47FrVF1X/E1TvcxlqK8lY6e3RUALAfenjE0j13iqLAvSnWMj3B4mL
         JHl8G3u9/wJruEk4IU7Uqkjq7EpuUpybj6Qzo205sVRXTF2d5pu/Wao/FvQqQeiqHlWK
         TiyA==
X-Gm-Message-State: AC+VfDyVA4NFDQqmUebtRnsRwcgJxen+8oPd4n3yE3MdO01pIV6T0pnW
        ByDjOPW+csGC5WcfhfSEicPwvg==
X-Google-Smtp-Source: ACHHUZ7RuGzeZfjSbChocjTMUr3JMZAgWU0i8TgxNktsr3sCaIQ7KWhcUY5eSBp9cqkQpqpF+j9iSQ==
X-Received: by 2002:a05:6a00:179c:b0:64d:277c:77c3 with SMTP id s28-20020a056a00179c00b0064d277c77c3mr6369519pfg.23.1685153376435;
        Fri, 26 May 2023 19:09:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s132-20020a63778a000000b00502fd70b0bdsm3353650pgc.52.2023.05.26.19.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 19:09:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3] checkpatch: Check for 0-length and 1-element arrays
Date:   Fri, 26 May 2023 19:09:33 -0700
Message-Id: <20230527020929.give.261-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; h=from:subject:message-id; bh=vKqvnzCM5SpLhQ8O+O/Nc6PmehDuOz4jt6QWnE/7V4E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkcWZdfT13jXdTYW+YFPsyIvGfnteQWoLDO4dhFPss qBm+SHuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZHFmXQAKCRCJcvTf3G3AJkVZD/ 0Rh075LZZ+5TArpoiQ9NIMQ8hrVZMIQWSNd7X2pVW2zd7g4KRKRfzPLfFZpVR8WwNO91nooz7xfitf qZJStfcgTJQB+FwhBKYzbpUEZIAr/qxDz7fjqlx14dMP0ixcvy03IIPMkhLciK2zX6xreKSzOrUWlH MHk62NGFTV5FTehb+TtzP+z8FcjoylmV0wNaEI2D8OG6q4mclwRF6RU58zLsClEslHslmIm62F7Ost deBOc5xG2dPknpwbX7QJIyv/f9NSEyjE91Xsg74Js1HfNNDVuU5/W+to1tjE81ef3ZnoQMngHXsQqE /cLpu3JO8aFCKjwkp4nx342CwvrWv0/UhFchOa4zy0Y6zmIFxlneWlwDbQy77QiOwcuuSzysU71xAV VX6qG+VX6BtqyALZ8Z+A2G/UrpREs9DoS5ZItyeln4+LRrS8rIxv4hS6Thn+5MNAJFlqI2wwTwo3au CEPSCuO3ZLoPhxHx93VKr1M+reU0pFxUUmchylgqOcndsEiiswy0/g65jixuPNWcmsmUm73wVWwh15 sZN4QoTF3VK2koBB52kJz9m/vgQTTe+1WnXIdbKAzPWH5CKv/fN5DgfX/vfPOmJ2tKK/zk9KhTKYpC XcCazGtX/QKZ+A7F97AOPhNcAi+diKaRdXCtmvLdaSmHtVQtC5nKi1EmkSdA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
v3:
 - Switch to ERROR from WARN
 - drop needless struct/union/enum prefix (joe)
 - fix $fixed regs (joe)
v2: https://lore.kernel.org/lkml/20230526173921.gonna.349-kees@kernel.org
v1: https://lore.kernel.org/lkml/20230517204530.never.151-kees@kernel.org
---
 scripts/checkpatch.pl | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 30b0b4fdb3bf..5307c85b93d8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7430,6 +7430,21 @@ sub process {
 			}
 		}
 
+# check for array definition/declarations that should use flexible arrays instead
+		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
+		    $prevline =~ /^\+\s*(?:\}|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
+			if ($1 == '0') {
+				if (ERROR("ZERO_LENGTH_ARRAY",
+					  "Use C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $hereprev) &&
+				    $fix) {
+					$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
+				}
+			} else {
+				ERROR("ONE_ELEMENT_ARRAY",
+				      "Use C99 flexible arrays instead of one-element arrays - see https://github.com/KSPP/linux/issues/79\n" . $hereprev);
+			}
+		}
+
 # nested likely/unlikely calls
 		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
 			WARN("LIKELY_MISUSE",
-- 
2.34.1

