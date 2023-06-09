Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2EA729E80
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbjFIP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjFIP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:29:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4841FF3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:29:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-662b85f4640so1630782b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686324582; x=1688916582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=et8Ws7B3acbpPzo7auZr7wKhP3b7lPieKwoaFqDLj+k=;
        b=nxzAB1kXI35/M5zZ2PdqwpNcsPZ3r7J/y6MIKxhsYmC84eplpnsI/ondRdeJmU4Txd
         qQ1MGgoDsgk4LyGvG+bUMeK+uTiZDQ0vXPLhMI58SIXhxhe0pql6GtT39hk4NaDwZTf+
         OKT1ApoCgVXrFdz1Ev6fvzPN/3pOIpLMHNjmJzQZeU51e+C/Aulh8dAQguaEp1GytVxA
         S6WAz279Nejnow9DbtTLAQFhUDld1+tpxV903WOW6wT5PYkYF56HwkFEt/d4Q3b6FmUL
         lrwc1ECjLhWEGxEseqQKPVhrMlJPvDNff+LRZt5URh8BdJJUldTyAmm3e2a4ZEqT+GrU
         ZG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324582; x=1688916582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=et8Ws7B3acbpPzo7auZr7wKhP3b7lPieKwoaFqDLj+k=;
        b=Ey49MTERoBSo6zvLAVW+7SpCBgjunv1igC2z4jacgVhhRRlFFf7mI+rzCzhce0GrDn
         k0Y7d4nkB5xg5mi+mEdw4WeeEG0OgQO89NvU9eZGsRkiCo1YXZ/3SX5D59LR46LHFOlt
         m4lj/WGGW393qJrUm20itaMizsm4Y7C5Mx00uo7BBAyKqM0xb21F5SktafHHzboM0rw3
         6Q/g2JRW7rL5ZyhEi7aBUWjf0HqsBeEuKv1hKXM4A7uPBYirYZTOsIIWghU4t1j/byLo
         AczU8DP5aeHN9i4tjitOBcEMo6EZaC9CKi/cxcztvsQhS9XmR8kUxPRpxiz0LP/6m8cv
         0sDg==
X-Gm-Message-State: AC+VfDygtCQiRMapXvEk6C6iGKPSIlxzB6ltRYLKkuwieHbpVm/Q9S17
        1738iETmm6TVQ7Zw4MB+pOC+0s0AIGQ=
X-Google-Smtp-Source: ACHHUZ5WBt60j99XqHkzH1Lwruk56COSSkFjPFB24bfHlu3XTfwZWjYuZdIYcwAcBPBtYdZc/Va2cA==
X-Received: by 2002:a05:6a20:3d20:b0:115:e834:7bc1 with SMTP id y32-20020a056a203d2000b00115e8347bc1mr1466949pzi.30.1686324581791;
        Fri, 09 Jun 2023 08:29:41 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:1bc3:5645:d3d:e4be])
        by smtp.gmail.com with ESMTPSA id c37-20020a634e25000000b0051eff0a70d7sm3012161pgb.94.2023.06.09.08.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:29:41 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: drop EXPORT_SYMBOL for common_exception_return
Date:   Fri,  9 Jun 2023 08:29:33 -0700
Message-Id: <20230609152933.1911296-1-jcmvbkbc@gmail.com>
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

common_exception_return used to be referenced from the oprofile code,
but since oprofile support removal in the commit
a848bf1d9ef1 ("arch: xtensa: Remove CONFIG_OPROFILE support")
it is no longer supposed to be used by modules.
Drop EXPORT_SYMBOL for common_exception_return.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/xtensa_ksyms.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index 17a7ef86fd0d..a9aa90c995cd 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -110,9 +110,6 @@ EXPORT_SYMBOL(__invalidate_icache_range);
 // FIXME EXPORT_SYMBOL(screen_info);
 #endif
 
-extern long common_exception_return;
-EXPORT_SYMBOL(common_exception_return);
-
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(_mcount);
 #endif
-- 
2.30.2

