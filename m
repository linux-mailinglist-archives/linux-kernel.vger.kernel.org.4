Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04704707181
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjEQTI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEQTI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:08:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64871FFE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:08:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae4e49727eso12886485ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350535; x=1686942535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0VPi5GJ7kmLjbS0ChDvxnSbO/WFZryCQHS1zNojC1Jg=;
        b=QAoKvlkXZAxsNAT7iJlbWuQC5CZ9lAmg+vD8qn89JEKx3i+Chbwjy34BBTAw3HenUM
         95QJL8FLlicZ+roKErcDYlYs7dqg9pbjkYn1D++vPhog1nPSZ7JNL26LZYK2Jsy39vRj
         K1OI4iaGO9d4YxchHs9cUQJDIpoyX0EpIlE3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350535; x=1686942535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0VPi5GJ7kmLjbS0ChDvxnSbO/WFZryCQHS1zNojC1Jg=;
        b=bkPyLR5kCb//g0c3OX5kaL23JibQEjQOTIGC/YqFLppXAlVAA5a5znqh+g6ARCXHd8
         x/dzR55Sqv5uTw+g+2W9KUkWRfmdfeawIUN5usyo5mLENgJEw5sgjDbpvDIJuKEcWXI5
         VptK+67BHHFynQ+OSopiesXSPG6WPmz/vpxtaqCupbaTU+e0Lu3IF538G9SBuiZGkA+A
         7AESQq+IM/vf9/BY/2YVX1hqgCIf2/fVWkDlMnGwwtKVoGBG7vf8Mbv4H4JSCOTf3o5U
         jNncMfQJIt1z4bkAvGdCKpAYuk0GGjqlWEIqCwnEnrgeikgjF6AZf0EGpC0Y1QAZKrqr
         2nCQ==
X-Gm-Message-State: AC+VfDzRmhHEwLXiG8SBvPITHyimwxcNzzvP7SWWZORiByeHKQpZLqUq
        Rw3LJGuSjqOoneMILF6orLRSvg==
X-Google-Smtp-Source: ACHHUZ4X5CjhFGFsKy9pS738nZl7R3AuPDeJNfdDh/ABCbUMCY6EEuqWdvHd5p+s0M+DHCZFWQDnHw==
X-Received: by 2002:a17:903:d2:b0:1aa:fe40:6f96 with SMTP id x18-20020a17090300d200b001aafe406f96mr39969648plc.23.1684350535344;
        Wed, 17 May 2023 12:08:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bh3-20020a170902a98300b00192aa53a7d5sm18013091plb.8.2023.05.17.12.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:08:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Bill Wendling <morbo@google.com>,
        Qing Zhao <qing.zhao@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] Compiler Attributes: Add __counted_by macro
Date:   Wed, 17 May 2023 12:08:44 -0700
Message-Id: <20230517190841.gonna.796-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2258; h=from:subject:message-id; bh=yahvJN5DCdafW0sbh3khm99IcP//ArMckUf9/Rm/k1Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkZSY8EEJAxM5wyI9gvstGb7zmJRvApBqEZyE9Udmr DyS5k9aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZGUmPAAKCRCJcvTf3G3AJrhjEA CHmN+3SQXNK++1nQr083pwerk7hnyxY/0CHVs/nd+VRVNIU4kbvdO/H/Hm3bs4+9THF5BAibH4f22f AF+mFhiS3xb8ADoFbZkKr9/fKhBnysCjg1A9p0ROOYVmQfGWe598FWh50dGb8yYBII2RRdKBtQ6C/I kcWGtEQhSY5BsRtfvEJJInQvoXaevjSM47tB9Re+tcHIG6S33Uba/07ek+0lVm3oydR/eumHn1HST/ /4VSivqreIggJen6dDe23s4U01qDbepY2T99mfcZs61U/DdONRUEzPdGo9jJLowtrVWpMOp3Qrrkay 4RiE9k0M+czZH3LIRANnchCZjRomfHUe6W8MwnZssrx8AY02Hf4z3g2ocsNVVWYlq0JaQiA2tjCJsk 0Cl53x+UTS1QGilWJQ+V6z2FzJVlYx0bfEp4nU375D3evPtqos0j7Z153C7igMkSJWwJdFQ/vfD4dO x51qKGl9f1x54XLlKVjOfKkh3h6Qx2mIXVYg5lzH/xxNunuphL24QBTI47jeMxmwg8ABMu6FamxKkf RhpsdZL2sGJtmiunsxqalimFqKyYWAtLl2V5ly+YNRtfhS8MgUud4SHAXFkO03Umx6rme9CqhA4tVS VUuPd+ULbQylFUrp/1QFDtTZvhtxg8byb3pEwkg22LzzulBTtz9JvDQ6CLLw==
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

In an effort to annotate all flexible array members with their run-time
size information, the "element_count" attribute is being introduced by
Clang[1] and GCC[2] in future releases. This annotation will provide
the CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE features the ability
to perform run-time bounds checking on otherwise unknown-size flexible
arrays.

Even though the attribute is under development, we can start the
annotation process in the kernel. This requires defining a macro for
it, even if we have to change the name of the actual attribute later.
Since it is likely that this attribute may change its name to "counted_by"
in the future (to better align with a future total bytes "sized_by"
attribute), name the wrapper macro "__counted_by", which also reads more
clearly (and concisely) in structure definitions.

[1] https://reviews.llvm.org/D148381
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Qing Zhao <qing.zhao@oracle.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: - update "Optional" comments
v1: https://lore.kernel.org/all/20230504181636.never.222-kees@kernel.org/
---
 include/linux/compiler_attributes.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index e659cb6fded3..a92d8887e8f0 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -123,6 +123,19 @@
 # define __designated_init
 #endif
 
+/*
+ * Optional: only supported since gcc >= 14
+ * Optional: only supported since clang >= 17
+ *
+ *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
+ * clang: https://reviews.llvm.org/D148381
+ */
+#if __has_attribute(__element_count__)
+# define __counted_by(member)		__attribute__((__element_count__(member)))
+#else
+# define __counted_by(member)
+#endif
+
 /*
  * Optional: only supported since clang >= 14.0
  *
-- 
2.34.1

