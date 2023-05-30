Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BC6716988
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjE3Qbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjE3QbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:31:17 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B538D102;
        Tue, 30 May 2023 09:30:46 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3360a95c0a1so6350415ab.0;
        Tue, 30 May 2023 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685464244; x=1688056244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iLnzBlwd4R6Xah7NSEk7Gqbfnuy0fx7IzR6wWPi2abY=;
        b=ZrBmmyjdqwAUMrQ0s1MT6bcQHlkw9VOKADCoct8GsAUr1nE4RCwwN5o/W71+uSJFYa
         jhEFyLRZZh8JsKtJ87D/B5VWtVaJm0GRri631dez2iYRwMkuQGq12ecIFu3Q1fed0GTx
         UjO6Ql+YxfHp3FY9pYI27aWHPTZSjaAVEcrGDHCC3mkeOjoUlMOX8IapM2wlEOl1nJi/
         LyuPi27B99capG2hZahRtiHU+74lQfFpFocCQQ62uhK+iJ6XByVMbKpUPSAy/+zs0mp9
         FQaLM3LYgmLy8tEYOqhBIkgvBOIsjcz1tNonw9v3PPvU0KemzJEELmI5hOeqKMaz7FY4
         lx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464244; x=1688056244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLnzBlwd4R6Xah7NSEk7Gqbfnuy0fx7IzR6wWPi2abY=;
        b=ZXQ5zFAY3qkdrlSzkElNH0ZV3yXaNcz38fd1xSFG6NVNpE0swimmkpm/dfdfFaKJsO
         P+5WVNeueAOwFnJPYs2o+p00Ax7GBUr8RwNx5W1QZmFD0d2vTEZoktbHEXkdyvxb3QN7
         MNqTAAp2OuUVa6vfQ4/6pTwiGMwUwr5NWLM5neJvgVNbIdzngxlSha8qJlRqHLy861PE
         sy4poaYBiI/sFHrsp/D+hW4n/oRqcx6qn5cxGmm04oTodNmLP/9cHkYycwsOxmHNZrv2
         jgL7vfl0V249tRm2r19brbePoqJpKNR8NuKrA+qj1VnZY00jjnXXZrPf3J7Fbexarp2Y
         jtXA==
X-Gm-Message-State: AC+VfDxYDJn0jVGtsHggORgF2oV1pzq1UirCEDGT4JP/PUdFQSDsZJGG
        BeivZiPpFFkl6+1s8BM37kw=
X-Google-Smtp-Source: ACHHUZ4x1Pt5L6exVrp0MlOS69Vf+DlbzGnXtN4/qVqrVNqTZ3F69SALBs4ZMhHtGUr32ghaP/Vp4g==
X-Received: by 2002:a92:d203:0:b0:335:56cb:a3a with SMTP id y3-20020a92d203000000b0033556cb0a3amr74431ily.16.1685464244493;
        Tue, 30 May 2023 09:30:44 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id a4-20020a92a304000000b0033af84e6321sm2543982ili.64.2023.05.30.09.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:30:44 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sh: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:30:41 +0000
Message-ID: <20230530163041.985456-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 arch/sh/drivers/dma/dma-api.c |    2 +-
 arch/sh/kernel/setup.c        |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index ab9170494dcc..89cd4a3b4cca 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -198,7 +198,7 @@ int request_dma(unsigned int chan, const char *dev_id)
 	if (atomic_xchg(&channel->busy, 1))
 		return -EBUSY;
 
-	strlcpy(channel->dev_id, dev_id, sizeof(channel->dev_id));
+	strscpy(channel->dev_id, dev_id, sizeof(channel->dev_id));
 
 	if (info->ops->request) {
 		result = info->ops->request(channel);
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index af977ec4ca5e..e4f0f9a1d355 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -304,9 +304,9 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.end = virt_to_phys(__bss_stop)-1;
 
 #ifdef CONFIG_CMDLINE_OVERWRITE
-	strlcpy(command_line, CONFIG_CMDLINE, sizeof(command_line));
+	strscpy(command_line, CONFIG_CMDLINE, sizeof(command_line));
 #else
-	strlcpy(command_line, COMMAND_LINE, sizeof(command_line));
+	strscpy(command_line, COMMAND_LINE, sizeof(command_line));
 #ifdef CONFIG_CMDLINE_EXTEND
 	strlcat(command_line, " ", sizeof(command_line));
 	strlcat(command_line, CONFIG_CMDLINE, sizeof(command_line));

