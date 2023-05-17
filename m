Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63847072D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjEQUOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEQUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:14:14 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C212F83F2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:13:57 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-52867360efcso798424a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684354436; x=1686946436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BqECuYQi/BexhqCaWU6Yoz79CpBk7jbeernIWMF7QVk=;
        b=aTbdQjslnWdSGECP6mJqlAZ/Gg2G/B3kd3iA/yGWBHRGfay9ONe8auaJb2FbjuQMbo
         M7OS7Rmk2yfSIDs3kqLO+CSw9KxgF3ZUEImxiI1ux+vi48iZS9VWmDCVqZyZkfNtJnMe
         WQMgIFq6UDNiFHt4e82ee7xDZgFg5ES+WBjAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354436; x=1686946436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqECuYQi/BexhqCaWU6Yoz79CpBk7jbeernIWMF7QVk=;
        b=jGpK2JPE2BHxsE7cQe3xQBI6GDOkU61jM2hsN2AdKj344I8Y+RnWC+oSIfoD6XPwmt
         kRBDj+2yTcdMAKH1Pz4zE642pepdOhoc1kwVsrN1RIDLVP7e9eZ/6HtT+HufwKCuNwfK
         V93Pys2av30RvJf0oq1RkjNE0IzGR3olhEtxCJICGNlEcbtkTgBxWnArHUVdkfehfS2p
         F6tcvlMW0RO38dlR6003A9VkUFZvcX9AOkTpAuv5VSFNMyymT6ANjFmH5SjWG0Luc6eP
         /bsov21sxPOIENp7K0Bo0Q2NsIHbOsKHRooniov14ptLUADupMVM9nR+L2p5AJLo2Ocn
         vyTw==
X-Gm-Message-State: AC+VfDzrnY/YEw298GK1FS9LpjmhP6ySlczj3b85vWGDXWPWmSCDog3n
        eL2jyBn78Cvao23yGRK6mNIhsQ==
X-Google-Smtp-Source: ACHHUZ78ijEMOnSmHFC1MzanWEh3cChgLp/bfufsYxMsApF2gCkUFBYXcs5MoxmSiDTcLkWiXntQIw==
X-Received: by 2002:a17:90a:950c:b0:252:8593:3f1d with SMTP id t12-20020a17090a950c00b0025285933f1dmr77162pjo.13.1684354436524;
        Wed, 17 May 2023 13:13:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090a899400b0025356cce0e4sm442303pjn.24.2023.05.17.13.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:13:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] checkpatch: Check for strcpy and strncpy too
Date:   Wed, 17 May 2023 13:13:52 -0700
Message-Id: <20230517201349.never.582-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; h=from:subject:message-id; bh=rEuHsrlOEVpdJxK4L3u/zAvRu1BId4xaiF0CnFr2c+Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkZTWAMsKYAhVvTuYu7xCHxHTcQxNX1TgY3Gp2tXHa NPtUBteJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZGU1gAAKCRCJcvTf3G3AJkBLD/ 95rgKeSIVrYE4jBce1O2Im8HeVkYK2k7zzsuDge8SqoyQM5P2sNAO6F+xw5C06r7x8pJnsUUYhxfjl su8+cSlwwl2StnZ0Mw/OoL3GWl1pUcfQ3Lf0BWqKB7klycO/7KlPJU/GY8Iw9yRoPO8k7x77iOoV0/ Na47QCoHfG7odtxN6/nauCMxPnQDnGnuGV11SAM7B2+5AHYuv+3jAJwV22YsnZlHUi/okWoCs6/kM0 Ws87TmUOgPRdNbzuSJmiRhKDKiFzZT/udluEEinMwhazaJSEKuws3TVGBSe30gHxvYxl21uxAMRA5z mN6NHAtW1vGuAySzB4WxMTWNRlRcLHMXhkLgfpWnbLrFFtXxC8VJvrfT70eNW2T5Vv8ZkfxDu+O9Xq /C+Wahj3cNpQBbTVwfPWi3w3UoySz47yqQ0TuymaRkHT5TKOC9yai7wgLJPWsjpcoP78IdngvER3KH XkXfwaI7FvSlZP8pajhRvRpY6J8hNAQizi8Iq1kNZ6JthxxAuOs76Qw9qnDTicK1CcBPlCVLbRMb2r 7d7LFvkQjxj9A33SuZWKnsUSg7ArKAqsTDksJU+xJiA9+jQquRNAhT3S1dOoCEjhSmXdSXFV4isgkD DsE3CTSHHg6kO40vHAptv0QwqcGXdOJ3AvdJVxzYmuC8ZkV1X3PUmii7Fnow==
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

Warn about strcpy(), strncpy(), and strlcpy(). Suggest strscpy() and
include pointers to the open KSPP issues for each, which has further
details and replacement procedures.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/checkpatch.pl | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b30114d637c4..a90e0ede53ad 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6997,10 +6997,22 @@ sub process {
 #			}
 #		}
 
+# strcpy uses that should likely be strscpy
+		if ($line =~ /\bstrcpy\s*\(/) {
+			WARN("STRCPY",
+			     "Use of strcpy has been replaced with strscpy - see: https://github.com/KSPP/linux/issues/88\n" . $herecurr);
+		}
+
 # strlcpy uses that should likely be strscpy
 		if ($line =~ /\bstrlcpy\s*\(/) {
 			WARN("STRLCPY",
-			     "Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw\@mail.gmail.com/\n" . $herecurr);
+			     "Use of strlcpy has been replaced with strscpy - see: https://github.com/KSPP/linux/issues/89\n" . $herecurr);
+		}
+
+# strncpy uses that should likely be strscpy or strscpy_pad
+		if ($line =~ /\bstrncpy\s*\(/) {
+			WARN("STRNCPY",
+			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
 # typecasts on min/max could be min_t/max_t
-- 
2.34.1

