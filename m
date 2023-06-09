Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D99729E83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbjFIPaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbjFIPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:30:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23D9359A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:30:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-652a6bf4e6aso1576167b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686324614; x=1688916614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B+BbmFxDtu9xvH6p+HuP5r+26x7/a6qi1ZnvCjgaCuU=;
        b=pG4Z5kjO6WszzBHcttx+lhvAD4M7pCMfl1UIuz9EYl2nfLVkrbCrWyPUoLp9vU699w
         8j1Z0R2BZJhuoesfF3y5cIqECrJZ6EmRHeBA61Z76FTXBsjn0B6loloyCXgOPUB9dRPG
         h6LjM05eWz5XvT8am2cwVDsahnmFzPlKKFGW+pIXs1ffXgSt+OIGZl7qzTgBwIzSE2n9
         /3vPZlc4dTCjzhOnTHzuGNKL6QUwOehFbiriFz7CxWPCvt7trsVRySqblRAfTI8ZnmSf
         4RMeL0DN1BJlAva77JlkPT8ea4ZrlGzg8FYrgi0UkZdd/5XeNgI3ndcCfY/G1UnQObUa
         TDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324614; x=1688916614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+BbmFxDtu9xvH6p+HuP5r+26x7/a6qi1ZnvCjgaCuU=;
        b=ktjjHJOAOL//6gZUGYfvw/btNCGClKbmeF8CSdRVP4kWSBKMumKrCLp68Mo7EQO4Qo
         pMjbQoPCOOKaq6NfL6N2YWlhoucC4+DZnWsg8Gmvp8B+r5SsJVcVOOXtJlcS7bm1en8u
         SmHUZxWu+h6H3daC+/b5GMX1cHXFok+OCmsVp++bYXNDWlGZ5oKc9wMPyVfiJQttbOdc
         I7yVoMLtFdjkbXQAwc8k9K12jvKKDPvL3QgbuOVEPfiz2kq3Hz+DIZjKYmBN1NezuQfK
         qyzxXO0X+T1tLO0mUrfzjitEFPq2C+DpPGbb8ii/lnOLr3eqR/Lgpg5z8suDz323vxyD
         +Ikg==
X-Gm-Message-State: AC+VfDxQc2+dEy2QenVjhWASrn13gkkgc6ArJTx8L8VNfrpQK5JsqNaI
        nVhDTmK6AYE0pk/6q4QyOk6mtP+nGss=
X-Google-Smtp-Source: ACHHUZ6FqEKYYWFJilZwWtJNRoDpXiRlqz23Ly4rHK0kiOT8kcjArN5lOr3g7UP402D1CsOEhd1PHg==
X-Received: by 2002:a17:903:234b:b0:1ac:a02f:c9a4 with SMTP id c11-20020a170903234b00b001aca02fc9a4mr1417022plh.4.1686324613912;
        Fri, 09 Jun 2023 08:30:13 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:1bc3:5645:d3d:e4be])
        by smtp.gmail.com with ESMTPSA id jj15-20020a170903048f00b001ae5d21e95csm3434648plb.117.2023.06.09.08.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:30:13 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: only build __strncpy_user with CONFIG_ARCH_HAS_STRNCPY_FROM_USER
Date:   Fri,  9 Jun 2023 08:30:06 -0700
Message-Id: <20230609153006.1911402-1-jcmvbkbc@gmail.com>
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

__strncpy_user is only used when CONFIG_ARCH_HAS_STRNCPY_FROM_USER is
enabled so don't build the source when it's off.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/lib/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/lib/Makefile b/arch/xtensa/lib/Makefile
index c9c2614188f7..6e5b2232668c 100644
--- a/arch/xtensa/lib/Makefile
+++ b/arch/xtensa/lib/Makefile
@@ -6,7 +6,8 @@
 lib-y	+= memcopy.o memset.o checksum.o \
 	   ashldi3.o ashrdi3.o bswapdi2.o bswapsi2.o lshrdi3.o \
 	   divsi3.o udivsi3.o modsi3.o umodsi3.o mulsi3.o umulsidi3.o \
-	   usercopy.o strncpy_user.o strnlen_user.o
+	   usercopy.o strnlen_user.o
+lib-$(CONFIG_ARCH_HAS_STRNCPY_FROM_USER) += strncpy_user.o
 lib-$(CONFIG_PCI) += pci-auto.o
 lib-$(CONFIG_KCSAN) += kcsan-stubs.o
 KCSAN_SANITIZE_kcsan-stubs.o := n
-- 
2.30.2

