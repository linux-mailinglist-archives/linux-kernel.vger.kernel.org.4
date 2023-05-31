Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4577717283
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjEaAep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjEaAel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:34:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100F2192
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:34:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d3491609fso3746321b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685493257; x=1688085257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjzJiAVnsEiyQDbH42BBgOLAQff4KMyAHDpgZ0nAe7A=;
        b=Fr1wpaLPOjycQDUz0I9FHQixf/hJgEHVJn5kf6MreLAFhTSbQL71WkdzM+ox20m0tx
         C9HD+G6BDZUZRour51+FuDaoOjUA+JDaMDVLCuZ/cchVzGaQUwr1O3F3Pnm/3pHE5i9M
         4pv+/gMbxwXjlbDM+j8gKlrLMcWr+hcNB3Bxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493257; x=1688085257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjzJiAVnsEiyQDbH42BBgOLAQff4KMyAHDpgZ0nAe7A=;
        b=QswJX4liARpCd9w6kmLeXj5bevdSj28BzXlqoxQrIkTm1e78x4Cr2u2H+n4kmZz2CU
         4hCPp9c3xxEj8iFxHo6jPoUaYzw1BnNHpDUi8zoVKvj//duikqHFmYLV6MeVpBX4aeP8
         oxryJ1OvlfSi2VmYwwsqJWwXrb/FeItx/Jr2GbT3F9gJc81K3uJovy9tuJxygnI7gpUW
         W0uO8iB+0Od47weo5OnJKF4xTCCFg4L2QEM4z5Fd0cjTz5HgPXXR8OqBFjeq16CW924X
         fpQ0NMIc8eKuhld3QBUR6GBspNoj9MXIOs8tijx0im4cKs/m6VTmg7jfSA18YGgHnC7m
         UmJg==
X-Gm-Message-State: AC+VfDxq4BC0IgrCCV80FSGfMLT4TQL/iMbMc34DwParFrNAnkkdaNCT
        RAelfLPPDqdM+Pn0HiU/bt4d+w==
X-Google-Smtp-Source: ACHHUZ4X5qDGSuairtVKxDG2yKgUqeM7zao1Gk6IXDkD8LZrD8OgZtIsp8e/0KbWuh7KyootktePNQ==
X-Received: by 2002:a05:6a20:6f05:b0:10b:a9ca:97bf with SMTP id gt5-20020a056a206f0500b0010ba9ca97bfmr4168184pzb.24.1685493257498;
        Tue, 30 May 2023 17:34:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j9-20020aa783c9000000b00640defda6d2sm2122043pfn.207.2023.05.30.17.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:34:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] s390/purgatory: Do not use fortified string functions
Date:   Tue, 30 May 2023 17:34:15 -0700
Message-Id: <20230531003414.never.050-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; h=from:subject:message-id; bh=3fzKBd1zujjv+SG6w7I7Y4v19AUyPzbSQe4ghFml234=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkdpYGW+0BpAnJwD3TP9pZ65CDHX9QrJD+lbCVA5TY Tzp9khaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZHaWBgAKCRCJcvTf3G3AJs0cEA CiZUiBN0H8c1+y8rgHJICYG74xR2GG2LajP/p9SrpbxhpissdlyzA57ENFt0LF87e87DBVNtNV0Iay E09uGdf/Zb5Dr8ikL26Vyeug7TXOeWjSV9gTC43wG4mg7o4R1G2/SzQ83HJG71ey9w4eyINCv+2Yg4 zDbI6pTvlGUAqkH6bW+lxWZJcIGXHrP4rBB05IAw9lA8KVr+wCznrYPz+tEufVcLywElmC0WqsFHzr rs+VuthL0YG+s97qw3qexp6w4YHh7V1wIls0cHvOto/y3kT5PlyKijuqG+7f6BsHMRH7giF7x5C5un sgOEOY0v3OCHXNIqwm8wwNsWI3JOky0PRo+Sz8Vsh3dDJHk1JZLAj0K5/RWrh47BpmmgjjhI0Uq2zL g/WcmyITo50/UayP+VSE6XtCK8496iNV7lXQ7Xr7AbY6MG+XsILyCKHpv/kyKN8BcKc58UFQGOlq5D pwCuncOlx3OK2bbrCaYZeTAF8cjyJOYRDV4s9cShT/AnE0+dQ3H9krl+o5hjHWk5XTW95ztSVoY92v afgzazipmjg3I+bkS06U/i/J6cwWw6K1TjS+4QUTEYZw2dtPTN3iw9rEtTII+8FFqvVDmsKwE9u75b QO9CYHiDZ+eElpDqrzjXP7bj1IUfjpU1+3FFH2H4o6++IWEeJ31XoEjgzgRQ==
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

With the addition of -fstrict-flex-arrays=3, struct sha256_state's
trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:

struct sha256_state {
        u32 state[SHA256_DIGEST_SIZE / 4];
        u64 count;
        u8 buf[SHA256_BLOCK_SIZE];
};

This means that the memcpy() calls with "buf" as a destination in
sha256.c's code will attempt to perform run-time bounds checking, which
could lead to calling missing functions, specifically a potential
WARN_ONCE, which isn't callable from purgatory.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/lkml/175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info/
Bisected-by: "Joan Bruguera Micó" <joanbrugueram@gmail.com>
Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kernel Functional Testing <lkft@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 32573b4f9bd2..cf14740abd1c 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -10,7 +10,7 @@ PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-CFLAGS_sha256.o := -D__DISABLE_EXPORTS
+CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
-- 
2.34.1

