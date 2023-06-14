Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862C472F3C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbjFNEwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFNEw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:52:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A3E183
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:52:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3d8aa2c17so15801295ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686718344; x=1689310344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FulhVEhNpgfCsNB5OSDOju9ICmBQY+Gxi28mpx6VJCw=;
        b=OOuNLK6YyThTUcwakap3WAuddmLrp02i1QJxCPts/TtJZm+X6kxsHz2AfPBhSuCPwy
         vd+G35pGrtwiFx1eBmfziFzW+UsVhi3pX8JeDHjfX0S7jX/WGcUcxKtKgzOCohWw0bOj
         xq70p5LPAknA2/z/ia8VQ+d+3DyShd/6PgxRZIV2scoQk8zmdD2wRHhHUqzmtYM4i97Q
         MHTLTczfFsD0SwsxxSnXDQFtKYagpW0hK0gsrWlc8ZYsqa/l5Z+AmWUdaaih64ytmodV
         Vq+WCuROxSClr5AcnrRVOlxVh4SOQ+OF3Um7z7SzPmVEwG5rme/REUNbvJ30AvPKbaFQ
         bonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686718344; x=1689310344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FulhVEhNpgfCsNB5OSDOju9ICmBQY+Gxi28mpx6VJCw=;
        b=EOWY/GyDX4RP6QQi7Mgk7t/M/4l+NlfUY86lB9WZtx+tq0H2ggccOKmO0IKtCfO4rt
         e71LNBaI1UTQqwUbq4yG1829Di7MSHOQcRiNEDXUOkmFPUH9ky5WBGT26/QpFU01i7Yw
         LGHxT5jw2sSp9pSd2FHPg5qRMfDeavnytyAm8nalw9eNSzVb+drLpyaKbLWSalg7p/3t
         8keeZrkLELlQAIuu+8yCmokIgkrVNFDVy4UNkssaERGOtjnVnKneGG9nRFT/x5/7ApXB
         EDSZaTMQvX4t7v+sKh/wzW166RKeQS/yHeVp+zBVRVFAb0c0dScT6bG83XgEVLjx8qxl
         /0hw==
X-Gm-Message-State: AC+VfDxVIMTOQdwxMho/r0cMKGO0mZGwooTXzqyXWFmcIN5e8Fzc3+B2
        /MmYkVXaTLuVYAbL/6kigSTdtbwtaAM=
X-Google-Smtp-Source: ACHHUZ4eGndc+7QdI9mskaHBuTlC2cF2BI7Zf5TnziUkyKw+U7yNdG/ZaF4y2VrXs8Vh5aZHLLRslw==
X-Received: by 2002:a17:903:187:b0:1b3:f8db:6f0e with SMTP id z7-20020a170903018700b001b3f8db6f0emr2192157plg.43.1686718343714;
        Tue, 13 Jun 2023 21:52:23 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:bf5f:2e99:78f2:6007])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001acad86ebc5sm11089790plg.33.2023.06.13.21.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 21:52:23 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/4] xtensa: always install slow handler for unaligned access exception
Date:   Tue, 13 Jun 2023 21:52:10 -0700
Message-Id: <20230614045212.2534746-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230614045212.2534746-1-jcmvbkbc@gmail.com>
References: <20230614045212.2534746-1-jcmvbkbc@gmail.com>
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

Currently slow handler for unaligned access exception is not installed
when CPU has hardware support for unaligned access. However some opcodes
(e.g. l32ai, s32ri, s32c1i) would still raise unaligned access exception
even on such CPUs. In that case instead of SIGBUS and a diagnostic entry
in the kernel log the faulting process would receive SIGILL.
Always install slow handler for unaligned access exception to fix that.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/traps.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index a92c8593d4f1..f447262468c5 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -54,9 +54,7 @@ static void do_interrupt(struct pt_regs *regs);
 #if XTENSA_FAKE_NMI
 static void do_nmi(struct pt_regs *regs);
 #endif
-#if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
 static void do_unaligned_user(struct pt_regs *regs);
-#endif
 static void do_multihit(struct pt_regs *regs);
 #if XTENSA_HAVE_COPROCESSORS
 static void do_coprocessor(struct pt_regs *regs);
@@ -102,9 +100,9 @@ static dispatch_init_table_t __initdata dispatch_init_table[] = {
 #ifdef CONFIG_XTENSA_UNALIGNED_USER
 { EXCCAUSE_UNALIGNED,		USER,	   fast_unaligned },
 #endif
-{ EXCCAUSE_UNALIGNED,		0,	   do_unaligned_user },
 { EXCCAUSE_UNALIGNED,		KRNL,	   fast_unaligned },
 #endif
+{ EXCCAUSE_UNALIGNED,		0,	   do_unaligned_user },
 #ifdef CONFIG_MMU
 { EXCCAUSE_ITLB_MISS,			0,	   do_page_fault },
 { EXCCAUSE_ITLB_MISS,			USER|KRNL, fast_second_level_miss},
@@ -363,7 +361,6 @@ static void do_div0(struct pt_regs *regs)
  * accesses causes from user space.
  */
 
-#if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
 static void do_unaligned_user(struct pt_regs *regs)
 {
 	__die_if_kernel("Unhandled unaligned exception in kernel",
@@ -375,7 +372,6 @@ static void do_unaligned_user(struct pt_regs *regs)
 			    task_pid_nr(current), regs->pc);
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void *) regs->excvaddr);
 }
-#endif
 
 #if XTENSA_HAVE_COPROCESSORS
 static void do_coprocessor(struct pt_regs *regs)
-- 
2.30.2

