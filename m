Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7327D72A130
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjFIRZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFIRZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:25:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1168BBF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:25:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-652328c18d5so1623265b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686331519; x=1688923519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r5rJBBk6g7dPavT51/fSEgNYpuC/HIxKt0os+wkL1Is=;
        b=aPTQvorEkZAwVLlcAvgu7D3EofNcOAZudralCCqyDf4lbbe+Mz+tEb7N1HZ7qkyzUw
         zMCVVfhP+eBgPZzIgwg8bvY5582MnjTew8F77x3mYB307GLEkhma/pZ9zsz7ETiDIa6Z
         rVUnCAOQUfwxF0K6pMpQLOcyjYNtNdXbJtzTZsA1+lvAVx4EJ+qtroGxMOz/rUdMRtH/
         4E8UFgEaa+nCMgnB/EluKc64/o+pwXMHDXMCn4s3FpV/J/07xaoFbifiA7mljSjxjhp+
         PP0w/dgRiODnR4BSz00li59/jSHwJD/seCTCRkj3MznWDpLKHO3nE+PAMLOoM2qkwbmv
         SJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686331519; x=1688923519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5rJBBk6g7dPavT51/fSEgNYpuC/HIxKt0os+wkL1Is=;
        b=Sz4h56YH0ptbD0GKekKvzQ2VhIxpnpKJ1/Cyo18xveWTML+dJc/fCu4fO6NIvoDsaY
         yn7uIjdfZzXqGjgEMo6Bgh515uTwfePRAYJXVbpNi0PSv5mae40Kwm6+xs7KWpKvkFZS
         dCcQvXksSi8BAp7MjRmaVTwi+iF36LKd5SavODWI244zml71tTT7ptFsAnDHu+CzlX+k
         RBwi6+m4AiudOP2KFFCNOwrasCifB4dtTq+fpc2Ms46jj4L/TXdkaxMrqwsXDtraZ+X7
         C2YrWBeiyfQSJdl5mSRd+bmznlH2/RJIFH1fgiX7m8eS/prHjmydimjH/5lfcc9KsHwu
         ug3w==
X-Gm-Message-State: AC+VfDy74uVv8UoS6/nTQiSUmwQPgmVGNXb1BXzszGkzs85VKepUKVsl
        JcMt70n9LnBcasfqN+5yLo+DzOIJAVc=
X-Google-Smtp-Source: ACHHUZ6YhOddAdXr3ojY/T5gMg+pwkGyZYpfKkIO3+0AXEDYWjvOC0+2is6z4NSCropWFWT30mEAgg==
X-Received: by 2002:a05:6a00:2d88:b0:652:bf4c:b5de with SMTP id fb8-20020a056a002d8800b00652bf4cb5demr1896465pfb.20.1686331519275;
        Fri, 09 Jun 2023 10:25:19 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:1bc3:5645:d3d:e4be])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7929a000000b0064b0326494asm2886423pfa.150.2023.06.09.10.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:25:18 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] xtensa: drop bcopy implementation
Date:   Fri,  9 Jun 2023 10:25:10 -0700
Message-Id: <20230609172510.1944039-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcopy is not exported and there's no in-tree users of this function.
Drop it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- also remove __HAVE_ARCH_BCOPY macro definition drom string.h

 arch/xtensa/include/asm/string.h |  3 ---
 arch/xtensa/lib/memcopy.S        | 15 ---------------
 2 files changed, 18 deletions(-)

diff --git a/arch/xtensa/include/asm/string.h b/arch/xtensa/include/asm/string.h
index 89b51a0c752f..ffce43513fa2 100644
--- a/arch/xtensa/include/asm/string.h
+++ b/arch/xtensa/include/asm/string.h
@@ -118,9 +118,6 @@ extern void *__memcpy(void *__to, __const__ void *__from, size_t __n);
 extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
 extern void *__memmove(void *__dest, __const__ void *__src, size_t __n);
 
-/* Don't build bcopy at all ...  */
-#define __HAVE_ARCH_BCOPY
-
 #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
 
 /*
diff --git a/arch/xtensa/lib/memcopy.S b/arch/xtensa/lib/memcopy.S
index b20d206bcb71..98c3662bed8c 100644
--- a/arch/xtensa/lib/memcopy.S
+++ b/arch/xtensa/lib/memcopy.S
@@ -274,21 +274,6 @@ WEAK(memcpy)
 
 ENDPROC(__memcpy)
 
-/*
- * void bcopy(const void *src, void *dest, size_t n);
- */
-
-ENTRY(bcopy)
-
-	abi_entry_default
-	# a2=src, a3=dst, a4=len
-	mov	a5, a3
-	mov	a3, a2
-	mov	a2, a5
-	j	.Lmovecommon	# go to common code for memmove+bcopy
-
-ENDPROC(bcopy)
-
 /*
  * void *memmove(void *dst, const void *src, size_t len);
  *
-- 
2.30.2

