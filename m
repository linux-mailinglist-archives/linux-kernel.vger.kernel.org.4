Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA3D724F88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbjFFWYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbjFFWYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:24:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E331717
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:24:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-256531ad335so5500947a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686090289; x=1688682289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmYAsitdtMiuxTmfa+3Zf9OT+yKEDPZiNHHq5YozUWI=;
        b=ROVGk+6F+Jqwoek6VhTyqEeBcpsOecTn6Zn92661yUpP1HszcaLVvP3nhcHLfyDZE/
         jtnAbjb2WSwGOUjNCZaNLx5EuhcMuYKFv7BXoD9kY7qguYSaS4fJpbLUU9ybovI8LKAh
         msStxmrKPdoBhGmM4yB1blT9H8kphUHuNtHH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090289; x=1688682289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmYAsitdtMiuxTmfa+3Zf9OT+yKEDPZiNHHq5YozUWI=;
        b=IWPSeNvll4LEKg304DcpBTjxllQsXU4T0PMBEXcpmFyGmbbXhMu/wRUnUDyKT19BaL
         KsEOMWjEkLSV+Xv+N/xv6TcJjtnTTUhiPMBpkZmvWuwqExSQZUlTq7+HXjfUr8w1Echn
         4Nj5kwzdRGoaI/i8w1dhAeWTB7yYmLY3aJMGUruCZERvHtok/0g72zyhzbn9aZnGmI7l
         l+0hirvZ4SYPWD1VpPqUHrJqd3bPvZ8OP2AYwznjiNFx8HKip+0B/r1CoDgCU6y0+awH
         AbM5asndus8U7q69gvNQOqXDND+/2xJFOK5bCjUt3WcXAPxnvZBgHRYM2D/bWl4R/kzs
         UrHQ==
X-Gm-Message-State: AC+VfDxTi25epgyPLVtquWKJfiMcSp1agkUpNk64C61jMTphqc/DPU6Z
        3kSYVJBksKUMiLc1bkkydTYRWg==
X-Google-Smtp-Source: ACHHUZ4zPusBCkS+Jt6n18avQIJZKgOsH8rs4RswtrWTkv8F/W9fguJ2MfX39FjUb8AgvAw6Q2QiHA==
X-Received: by 2002:a17:90a:3e09:b0:252:75ed:eff5 with SMTP id j9-20020a17090a3e0900b0025275edeff5mr2928439pjc.30.1686090289275;
        Tue, 06 Jun 2023 15:24:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a19db00b0024c1ac09394sm46493pjj.19.2023.06.06.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:24:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-um@lists.infradead.org, stable@vger.kernel.org,
        Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] um: Use HOST_DIR for mrproper
Date:   Tue,  6 Jun 2023 15:24:45 -0700
Message-Id: <20230606222442.never.807-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; h=from:subject:message-id; bh=ogdQalFf0y8pKF+gFHpZjTpG30jr8bbKm5s3B8PiBPc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkf7ItfCmLvYSeW8Q0gwGur9gz7W1IjcA39mfgRnT3 Y2VehlGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZH+yLQAKCRCJcvTf3G3AJpg0EA CojcAOCPQ4kzRxyVY2zE9OQL7dtTvYou3N2RGCBrrY6XKQMNwVof1zv1P2XR9bBnJSIIqotgDPPX9a aZ8XklK5ixysMuMgS45QPl32SnitUOCrARbo0/4DCDFd27VE3mlJvTAhXoRNKftEjdyXhpsDS3I9/H cmD37lTsNrro9oVy5xIO7DoOujmzYspW1oNtNGk/gDgjIiW0po7I8PO/n7Mqj3mKAfV2ljoWW0uvK/ pNQ+Zw4to8OaupHJaowdB3UtJ4zU7MgSG8xaZiWI/EY0QxcgIn6FmEeCJ0Md7ka8TviLNU4IXCk8Yx ReSSRAaVMHAg0hy+WEVNwpAQ2iWYf7gJk+EXMKZVgR9GYXiIbK8fMTzCdmtwg7xMCZpch0YItprXg5 aN875T/ca4liv+bOWM7IDM5ewm82F6RSLstr5xi2nLAHOKAo02TZ/0XH2LeJKEv5kWcXM8dmYILIQM X5PsdWPO9MHzP5MRwn+3fYyjRJPLzSCf6rFDlY2PbB3xYAq8QNXeGGSKJsqUKYtH3KY3WcgpitgeFq 8m7TPtzspglG6NewHGgkpx0PkMNe+eKOvZfArtuI7lWMTglwyBHgvnSqufzPWHsidotD7knjuTgFea vIrkaOavqki2VfIW/X986U8J3Ws6mrSVudV9sXnLm3j+CZ3aIJKxk4hIr3yw==
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

When HEADER_ARCH was introduced, the MRPROPER_FILES (then MRPROPER_DIRS)
list wasn't adjusted, leaving SUBARCH as part of the path argument.
This resulted in the "mrproper" target not cleaning up arch/x86/... when
SUBARCH was specified. Since HOST_DIR is arch/$(HEADER_ARCH), use it
instead to get the correct path.

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-um@lists.infradead.org
Fixes: 7bbe7204e937 ("um: merge Makefile-{i386,x86_64}")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 8186d4761bda..da4d5256af2f 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -149,7 +149,7 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_FILES += arch/$(SUBARCH)/include/generated
+MRPROPER_FILES += $(HOST_DIR)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
-- 
2.34.1

