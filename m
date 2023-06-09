Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D42729E82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbjFIPaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241062AbjFIPaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:30:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5093130FD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:29:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-651e298be3fso1978691b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686324598; x=1688916598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fB2fmYwjeBEzgHhGMKyLim2Kinmsb7/CriYVOtBrJtc=;
        b=UtHiXAaEJVIWUBi+BYSITdRwNqfqVz64IlopGTa5YQv8tqQidY9jRujq/YE8Y7v4vH
         N5j3PDPWJFlgSFS0Bmb4rxkdEnyrje4200zIgVIjrWsdTpz4l/tSemumSROpepIQVsL/
         71AHl35LJ5W5MsgmO8leILqMV7s+eI1inabwUY+tMpCuWUsag9kJf6UZNGiGCrqO/p5N
         DIjoYTz/lLm0wdV0uGDYXmWHbvP+IF9SL6T6FTdRNcylzOTb00/QChiFwqA6JCs0O9u6
         jgR6ZWbSeUuMQe7oUnVpSirhUH4mymm57RXP0WLjPQhB4fk/711eQdxhu6CTghGXkl+v
         yLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324598; x=1688916598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fB2fmYwjeBEzgHhGMKyLim2Kinmsb7/CriYVOtBrJtc=;
        b=IVMuVuY7qUMxUAMiITqFJRRGoa91y1P0YcwjbJn2wWxed8WWsiasi/AuPxrsool/VY
         x/Uph8ZqAf4XFaLhnOIFJKjTpmFvl4dDMZCdWP25ymV+RcOxcU7ImKfKVhTqfytmkBem
         mvsrAGHxLVjP6eRS3i5YCEHBP7KGaLqSE/rYAAjFh3JJP90zzRjK1EtipxBSYiZy3/YL
         H/nSYEWjcIjFgAWK50QUDgLpt66xRospLG/jhR6F1hZHVVrMg2eaoSvYvlESNjAlJUd2
         C/bt8YydF7zLee4wGntjWZL2adXZ+KlqPXyq/ioxDUUewt5/ncw05h4Ne/nEap3wt9KD
         Z/HA==
X-Gm-Message-State: AC+VfDyvKGDjNEWD6RjZG5/7nLpxNVYMeYLoizpUsL1ozv5I/V2XJSl/
        D9nPc9v9en5dPVNCDtCqQytXlk5qGNo=
X-Google-Smtp-Source: ACHHUZ42bYEtby8G+IXDax5uHCshw6L8eS9LDPPASlEQEM5oN6uBOsB0l1h6Q6XYuooN9/IBo5lhbw==
X-Received: by 2002:a05:6a20:728d:b0:10c:2349:459d with SMTP id o13-20020a056a20728d00b0010c2349459dmr1876207pzk.11.1686324598413;
        Fri, 09 Jun 2023 08:29:58 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:1bc3:5645:d3d:e4be])
        by smtp.gmail.com with ESMTPSA id j13-20020a63cf0d000000b004fab4455748sm3072054pgg.75.2023.06.09.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:29:58 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: drop bcopy implementation
Date:   Fri,  9 Jun 2023 08:29:49 -0700
Message-Id: <20230609152949.1911349-1-jcmvbkbc@gmail.com>
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
 arch/xtensa/lib/memcopy.S | 15 ---------------
 1 file changed, 15 deletions(-)

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

